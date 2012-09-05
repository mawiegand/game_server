#!/usr/bin/php5-cgi
<?php

/*
Copyright (c) <2011> Maximilian Hoegner, "leberwurscht" <leberwurscht@hoegners.de>
Copyright (c) <2005> LISSY Alexandre, "lissyx" <alexandrelissy@free.fr>

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software andassociated documentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to thefollowing conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

error_reporting(E_ALL);

$token = 'eyJ0b2tlbiI6eyJpZGVudGlmaWVyIjoiQk1lVUdqVkpGeXRTcUdqQSIsInNjb3BlIjpbIjVkZW50aXR5Iiwid2Fja2Fkb28iLCJwYXltZW50Il0sInRpbWVzdGFtcCI6IjIwMTItMDktMDVUMTM6Mzc6MTkrMDI6MDAifSwic2lnbmF0dXJlIjoiMzE4ZGJjYzgwOTkwMGY0OWE5MzJiM2U0NDA1OTgzYjc5MGRlODgxMCJ9';
$return = '';

    $fp = fsockopen("ssl://wack-a-doo.de", 443, $errno, $errstr, 30);
    if (!$fp) {
        echo "$errstr ($errno)<br />\n";
    } else {
        $out = "GET /game_server/fundamental/characters/self HTTP/1.1\r\n";
        $out .= "Host: wack-a-doo.de\r\n";
        $out .= "Accept: application/json\r\n";
        $out .= "Authorization: Bearer {$token}\r\n";
        $out .= "Connection: Close\r\n\r\n";
        fwrite($fp, $out);
        while (!feof($fp)) {
            $return .= fgets($fp, 128);
        }
        fclose($fp);
    }

    // Rückgabe in ein array() umwandeln.
    $res = str_replace("\r\n", "\n", $return);
    $res = str_replace("\r", "\n", $res);
    $res = str_replace("\t", ' ', $res);
    $res = explode("\n", $res);

    // Status Code getrennt auslesen.
    $status_code = explode(' ', array_shift($res), 3);

print_r($res);
die();

$auth = new JabberAuth();
$auth->botName = "service";
$auth->botPwd  = "P5Dda5eZmvCLFTw2";
$auth->play(); // We simply start process !

class JabberAuth {
  var $botName;
  var $botPwd;

	var $debug 	= false;		/* Debug mode */
	var $debugfile 	= "./log/wackadoo-debug.log";	/* Debug output */
	var $logging 	= true;		/* Do we log requests ? */
	var $logfile 	= "./log/wackadoo.log" ;	/* Log file ... */
	/*
	 * For both debug and logging, ejabberd have to be able to write.
	 */
	
	var $jabber_user;   /* This is the jabber user passed to the script. filled by $this->command() */
	var $jabber_pass;   /* This is the jabber user password passed to the script. filled by $this->command() */
	var $jabber_server; /* This is the jabber server passed to the script. filled by $this->command(). Useful for VirtualHosts */
	var $jid;           /* Simply the JID, if you need it, you have to fill. */
	var $data;          /* This is what SM component send to us. */
	
	var $dateformat = "M d H:i:s"; /* Check date() for string format. */
	var $command; /* This is the command sent ... */
	var $stdin;   /* stdin file pointer */
	var $stdout;  /* stdout file pointer */

	function __construct()
	{
		@openlog("pipe-auth", LOG_NDELAY, LOG_SYSLOG);
		
		if($this->debug) {
			@error_reporting(E_ALL);
			@ini_set("log_errors", "1");
			@ini_set("error_log", $this->debugfile);
		}
		$this->logg("Starting pipe-auth ..."); // We notice that it's starting ...
		$this->openstd();
	}

	function stop()
	{
		$this->logg("Shutting down ..."); // Sorry, have to go ...
		closelog();
		$this->closestd(); // Simply close files
		exit(0); // and exit cleanly
	}

	function openstd()
	{
		$this->stdout = @fopen("php://stdout", "w"); // We open STDOUT so we can read
		$this->stdin  = @fopen("php://stdin", "r"); // and STDIN so we can talk !
	}

	function readstdin()
	{
		$l      = @fgets($this->stdin, 3); // We take the length of string
		$length = @unpack("n", $l); // ejabberd give us something to play with ...
		$len    = $length["1"]; // and we now know how long to read.
		if($len > 0) { // if not, we'll fill logfile ... and disk full is just funny once
			$this->logg("Reading $len bytes ... "); // We notice ...
			$data   = @fgets($this->stdin, $len+1);
			// $data = iconv("UTF-8", "ISO-8859-15", $data); // To be tested, not sure if still needed.
			$this->data = $data; // We set what we got.
			$this->logg("IN: ".$data);
		}
	}
	
	function closestd()
	{
		@fclose($this->stdin); // We close everything ...
		@fclose($this->stdout);
	}
	
	function out($message)
	{
		@fwrite($this->stdout, $message); // We reply ...
		$dump = @unpack("nn", $message);
		$dump = $dump["n"];
		$this->logg("OUT: ". $dump);
	}
	
	function play()
	{
		do {
			$this->readstdin(); // get data
			$length = strlen($this->data); // compute data length
			if($length > 0 ) { // for debug mainly ...
				$this->logg("GO: ".$this->data);
				$this->logg("data length is : ".$length);
			}
			$ret = $this->command(); // play with data !
			$this->logg("RE: " . $ret); // this is what WE send.
			$this->out($ret); // send what we reply.
			$this->data = NULL; // more clean. ...
		} while (true);
	}
	
	function command()
	{
		$data = $this->splitcomm(); // This is an array, where each node is part of what SM sent to us :
		// 0 => the command,
		// and the others are arguments .. e.g. : user, server, password ...
		
    if(strlen($data[0]) > 0 ) {
      $this->logg("Command was : ".$data[0]);
    }
    switch($data[0]) {
      case "isuser": // this is the "isuser" command, used to check for user existance
          $this->jabber_user = $data[1];
          $parms = $data[1];  // only for logging purpose
          $return = $this->checkuser();
        break;
        
      case "auth": // check login, password
          $this->jabber_user = $data[1];
          $this->jabber_pass = $data[3];
          $parms = $data[1].":".$data[2].":".md5($data[3]); // only for logging purpose
          $return = $this->checkpass();
        break;

      case "setpass":
          $return = false; // We do not want jabber to be able to change password
        break;

      default:
          $this->stop(); // if it's not something known, we have to leave.
          // never had a problem with this using ejabberd, but might lead to problem ?
        break;
    }
    
    $return = ($return) ? 1 : 0;
    
    if(strlen($data[0]) > 0 && strlen($parms) > 0) {
      $this->logg("Command : ".$data[0].":".$parms." ==> ".$return." ");
    }
    return @pack("nn", 2, $return);
	}

	function checkpass()
	{
		$username = $this->jabber_user;
		$password = $this->jabber_pass;

    if ($username == $this->botName && $password == $this->botPwd) {
      return true;
    }

		$this->logg("try login with oauth for ".$username);

    // Aufbau der Verbindung zum WackADoo Server per ssl
    $fp = fsockopen("ssl://wack-a-doo.de", 443, $errno, $errstr, 30);
    if (!$fp) {
        echo "$errstr ($errno)<br />\n";
    } else {
        $out = "GET /game_server/fundamental/characters/self HTTP/1.1\r\n";
        $out .= "Host: wack-a-doo.de\r\n";
        $out .= "Accept: application/json\r\n";
        $out .= "Authorization: Bearer {$password}\r\n";
        $out .= "Connection: Close\r\n\r\n";
        fwrite($fp, $out);
        while (!feof($fp)) {
            $return .= fgets($fp, 128);
        }
        fclose($fp);
    }

    // Rückgabe in ein array() umwandeln.
    $res = str_replace("\r\n", "\n", $return);
    $res = str_replace("\r", "\n", $res);
    $res = str_replace("\t", ' ', $res);
    $res = explode("\n", $res);

    // Status Code getrennt auslesen.
    $status_code = explode(' ', array_shift($res), 3);

		if ($status_code[1] == 200) return true;

		$this->logg("login failed for ".$username);
		return false;
	}
	
	function checkuser()
	{
		$username = $this->jabber_user;

		$q = "SELECT 1 FROM Player WHERE name = '".mysql_real_escape_string($username)."'";
		$r = mysql_query($q);
		if (!$r) return false;
		if (mysql_num_rows($r)==0) return false;

		return true;
	}
	
	function splitcomm() // simply split command and arugments into an array.
	{
		return explode(":", $this->data);
	}
	
	function logg($message) // pretty simple, using syslog.
	// some says it doesn't work ? perhaps, but AFAIR, it was working.
	{
		if($this->logging) {
			@syslog(LOG_INFO, $message);
		}
	}
}

?>