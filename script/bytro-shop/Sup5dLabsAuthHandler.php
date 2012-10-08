<?php
require_once ( t3lib_extMgm::extPath('sup_games').'lib/modding/SupTitle.php' );
require_once(t3lib_extMgm::extPath('sup_games').'lib/partner/SupIPartnerUserInfoProvider.php');

/**
 * Class provided by 5d Lab.
 * 
 * Calls with apiKey wackadooShop have a custom 5d Lab hash parameter set.
 * This parameter gets decoded and validated against the 5d Lab server (using CURL) requesting the user parameters.
 * 
 * It implements SupIPartnerUserInfoProvider which delivers the user details needed to generate accounts in the Bytro Labs system.
 * 
 * @author Patrick Fox, Christopher
 * @ since Sep/2012
 * @version 0.1
 */
class Sup5dLabsAuthHandler extends SupDefaultAuthHandler implements SupIPartnerUserInfoProvider {

  protected $_key;
  protected $_secret;
  protected $_action;
  protected $_decodedData;
  protected $_partnerData;
  protected $_encodedData;
  protected $_hash;
  protected $_allowedActions;
  protected $_callbackHostnames = array('gs01',  'gs02',  'gs03',  'gs04',  'gs05',  'gs06',  'gs07',  'gs08',  'gs09',  'gs10', 
                                      'gs11',  'gs12',  'gs13',  'gs14',  'gs15',  'gs16',  'gs17',  'gs18',  'gs19',  'gs20',
                                      'test1', 'test2', 'test3', 'test4', 'test5', 'test6', 'test7', 'test8', 'test9');
  protected $_callbackBaseUrl = '.wack-a-doo.de/game_server/fundamental/characters/self';
  
  protected $_tokenExpiration = 28800;  // 8 hours
  //protected $_tokenExpiration = 828800;  // for debugging
  
  public function Sup5dLabsAuthHandler($data) {
    $this->_key = $data['key'];
    $this->_secret = $data['secret'];
    $this->_action = $data['action'];
    $this->_decodedData = $data['decodedData'];
    //t3lib_div::debug($data, 'data');
    $this->_encodedData = $data['encodedData'];
    $this->_hash = $data['hash'];
    $this->_allowedActions = $data['allowedActions'];
  }

  
  public function executeAction() {

    $token = json_decode(base64_decode($this->_hash), true);

    if (!is_array($token)) {
      // token not decodable
      $this->_resultCode = SupAPIClient::ERR_AUTHENTICATION_FAILED;
      return 'Invalid hash';
    }
    //t3lib_div::debug($token, 'wackadoo token');

    // TODO default timezone must be set, is it set by typo-engine?
//     date_default_timezone_set('UTC');
    //echo('Timestamp: '.$token['token']['timestamp'].' '.(time() - strtotime($token['token']['timestamp']))."\n");
    
    if (time() - strtotime($token['token']['timestamp']) > $this->_tokenExpiration) {
      // token too old
      $this->_resultCode = SupAPIClient::ERR_SESSION_EXPIRED;
      return '';
    }
    
    $callbackUrl = 'https://';
    
    if (in_array($this->_decodedData['hostname'], $this->_callbackHostnames)) {
    	$callbackUrl .= $this->_decodedData['hostname'] . $this->_callbackBaseUrl;
    }
    else {
    	$callbackUrl .= 'gs01' . $this->_callbackBaseUrl;
    	//protected $_callbackUrl = 'https://wack-a-doo.de/game_server/fundamental/characters/self';
    }
    //t3lib_div::debug($callbackUrl, 'callbackUrl');
    
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $callbackUrl);
    //curl_setopt($ch, CURLOPT_VERBOSE, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);    # required for https urls
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array (
      'Accept: application/json',
      'Authorization: Bearer {'.$this->_hash.'}'
    ));    
    $rawContent = curl_exec($ch);
    //echo "curl antwort: $rawContent\n";
    $response = curl_getinfo($ch);
    curl_close($ch);
    
    if ($response['http_code'] != 200) {
      // user not found on server
      $this->_resultCode = SupAPIClient::ERR_CALLBACK_FAILED;
      return false;
    }
    //for debugging
    //$rawContent = '{"alliance_id":null,"alliance_tag":null,"att":null,"base_location_id":53,"base_node_id":32,"base_region_id":6,"character_queue_research_unlock_count":0,"character_unlock_alliance_creation_count":0,"character_unlock_diplomacy_count":0,"created_at":"2012-09-11T15:30:52Z","def":null,"exp":null,"fortress_count":0,"health_max":null,"health_present":null,"health_updated_at":null,"id":93,"identifier":"RADpNcYHLAtWUEaE","last_login_at":"2012-09-14T12:05:32Z","last_request_at":"2012-09-14T12:05:32Z","locked":null,"locked_at":null,"locked_by":null,"login_count":127,"losses":null,"lvel":null,"max_conversion_state":null,"name":"qwewww","name_change_count":1,"npc":false,"premium_account":null,"premium_expiration":null,"score":72,"skill_points":null,"updated_at":"2012-09-14T12:05:32Z","wins":null}';
      
    $content = json_decode($rawContent, true);

    if (!is_array($content)) {
      // content json string not decodable
      $this->_resultCode = SupAPIClient::ERR_AUTHENTICATION_FAILED;
      return 'Invalid response from wack-a-doo server.';
    }

    if ($content['identifier'] != $token['token']['identifier']) {
      // identifiers from token and from game server callback don't match
      $this->_resultCode = SupAPIClient::ERR_AUTHENTICATION_FAILED;
      return 'Invalid identifier'; 
    }

    $this->_partnerData = $content;
    //echo nl2br(print_r($content, 1));
    
    //$data = 'username='.urlencode($content['name']).'&identifier='.urlencode($content['identifier']);
    //$this->_encodedData = base64_encode($data);
    return '';
  }

  public function getEncodedData() {
    return $this->_encodedData;
  }
  
  public function getHash() {
    return $this->_hash;
  }
  
  public function getUserID() {
  	//t3lib_div::debug($this->_partnerData, 'partnerData after callback');
  	return $this->_partnerData['identifier'];  	
  }
  
  public function getRegisterDate() {
  	return strtotime($this->_partnerData['created_at']);  	
  }
  
  public function getCountry() {
  	return 'DE';  	
  }
  
  public function getLanguage() {
  	return 'DE';  	
  }
  
}

// $testToken = 'eyJ0b2tlbiI6eyJpZGVudGlmaWVyIjoiUkFEcE5jWUhMQXRXVUVhRSIsInNjb3BlIjpbIjVkZW50aXR5Iiwid2Fja2Fkb28iLCJwYXltZW50Il0sInRpbWVzdGFtcCI6IjIwMTItMDktMTRUMTI6MjQ6NDgrMDI6MDAifSwic2lnbmF0dXJlIjoiZjRjY2I4Y2ZiYTgwMzNkZDcwYjQ4ZGM3MTAyOTYyM2M2MTQzNjIzZiJ9';

// $data = array(
//   'hash' => $testToken,
// );

// $handler = new Sup5dLabsAuthHandler($data);
// echo "verified: " . intval($handler->executeAction())."\n";
// echo(base64_decode($handler->getHash())."\n");
// echo(base64_decode($handler->getEncodedData())."\n");

?>