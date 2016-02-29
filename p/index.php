<?php
$url=@$_GET['url'];
$a =crawl($url ,false);
echo $a['content'];

print_r($_GET);

function crawl($url ,$proxy)
{
    $user_agent='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 

Firefox/42.0';

    if($proxy === false)
    {
        $proxy = '';
    }

    $options = array(

        CURLOPT_CUSTOMREQUEST  =>"GET",        //set request type post or get
        // CURLOPT_POST           =>false,        //set to GET
        // CURLOPT_USERAGENT      => $user_agent, //set user agent
        // CURLOPT_COOKIEFILE     =>"cookie.txt", //set cookie file
        // CURLOPT_COOKIEJAR      =>"cookie.txt", //set cookie jar
        CURLOPT_RETURNTRANSFER => true,     // return web page
        CURLOPT_HEADER         => false,    // don't return headers
        // CURLOPT_FOLLOWLOCATION => true,     // follow redirects
        CURLOPT_ENCODING       => "",       // handle all encodings
        CURLOPT_AUTOREFERER    => true,     // set referer on redirect
        // CURLOPT_CONNECTTIMEOUT => 120,      // timeout on connect
        // CURLOPT_TIMEOUT        => 120,      // timeout on response
        // CURLOPT_MAXREDIRS      => 10,       // stop after 10 redirects
        CURLOPT_PROXY           => $proxy
/*        CURLOPT_HTTPHEADER     => array(
                                    "REMOTE_ADDR: mt()",
                                    "X_FORWARDED_FOR: mt()"
                                    ) ,
        CURLOPT_POST => 1 ,
        CURLOPT_POSTFIELDS => "test=qwerty"
*/    );

    $ch      = curl_init( $url );
    curl_setopt_array( $ch, $options );
    $content = curl_exec( $ch );
    $err     = curl_errno( $ch );
    $errmsg  = curl_error( $ch );
    $header  = curl_getinfo( $ch );
    curl_close( $ch );

    $header['errno']   = $err;
    $header['errmsg']  = $errmsg;
    $header['content'] = $content;
    return $header;
}

?>