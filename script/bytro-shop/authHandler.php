#!/usr/bin/php
<?php

/**
 * This is the default authentication handler that performs authentication for the API
 * requests based on a shared secret in server-2-server communication.
 * 
 * @author Christopher
 * @version 1
 * @since 12/Jan/2011 (externalized from SupAPIFactory) 
 */
class SupDefaultAuthHandler {

  protected $_key;
  protected $_secret;
  protected $_action;
  protected $_decodedData;
  protected $_encodedData;
  protected $_hash;
  protected $_allowedActions;
  
  /**
   * @param string $key - the api identification ID (typo3, vbulletin, mobile, ...)
   * @param string $secret - the secret key used for hash generation
   * @return SupAbstractAuthHandler
   */
  public function SupDefaultAuthHandler($data) {
    $this->_key = $data['key'];
    $this->_secret = $data['secret'];
    $this->_action = $data['action'];
    $this->_decodedData = $data['decodedData'];
    $this->_encodedData = $data['encodedData'];
    $this->_hash = $data['hash'];
    $this->_allowedActions = $data['allowedActions'];
  }
  
  /**
   * Performs the basic shared secret based authentication of the API request.
   * (non-PHPdoc)
   * @see SupAPIHandler::executeAction()
   */
  public function executeAction() {

    // move vars to class constants
    $url = 'https://uni.patrickfox.de/game_server/fundamental/characters/self'; // npc
    $expiration = 3600 * 8;
    
    $token = json_decode(base64_decode($this->_hash), true);

    if (json_last_error() != JSON_ERROR_NONE) {
      // token not decodable
      return false;
    }

    // TODO default timezone must be set, is it set by typo-engine?
    date_default_timezone_set('UTC');
    echo('Timestamp: '.$token['token']['timestamp'].' '.(time() - strtotime($token['token']['timestamp']))."\n");
    
    if (time() - strtotime($token['token']['timestamp']) > $expiration) {
      // token too old
      return false;
    }
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);    # required for https urls
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array (
      'Accept: application/json',
      'Authorization: Bearer {'.$this->_hash.'}'
    ));    
    $rawContent = curl_exec($ch);
    $response = curl_getinfo($ch);
    curl_close($ch);
    
    if ($response['http_code'] != 200) {
      // user not found
      return false;
    }
      
    $content = json_decode($rawContent, true);

    if (json_last_error() != JSON_ERROR_NONE) {
      // content json string not decodable
      return false;
    }

    if ($content['identifier'] != $token['token']['timestamp']) {
      // identifiers from token and from game server callback don't match 
      return false;
    }

    $data = 'username='.urlencode($content['name']).'&identifier='.urlencode($content['identifier']);
    $this->_encodedData = base64_encode($data);
    return true;
  }

  public function getEncodedData() {
    return $this->_encodedData;
  }
  
  public function getHash() {
    return $this->_hash;
  }
}

$testToken = 'eyJ0b2tlbiI6eyJpZGVudGlmaWVyIjoibVFSYUFrQVhDWlBCSkxmciIsInNjb3BlIjpbIjVkZW50aXR5Iiwid2Fja2Fkb28iLCJwYXltZW50Il0sInRpbWVzdGFtcCI6IjIwMTItMDktMTJUMTg6NDU6NTErMDI6MDAifSwic2lnbmF0dXJlIjoiMzhiMDYwMGJkOGFlNjEzNDg2MmEwYzUxY2JmYmQ3ZjYxYzM1YjljNCJ9';

$data = array(
  'hash' => $testToken,
);

$handler = new SupDefaultAuthHandler($data);
$handler->executeAction();
echo(base64_decode($handler->getHash())."\n");
echo(base64_decode($handler->getEncodedData())."\n");

?>