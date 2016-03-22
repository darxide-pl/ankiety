<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="ie6"> <![endif]-->
<!--[if IE 7]>         <html class="ie7"> <![endif]-->
<!--[if IE 8]>         <html class="ie8"> <![endif]-->
<!--[if gt IE 8]><!--> <html> <!--<![endif]-->
<head> 
        
    <meta charset="utf-8" />
	
	<title>Badania internetowe</title>
     <script type="text/javascript" defer async>
      WebFontConfig = {
        google: { families: [ 'Open+Sans:400,300,600,800,700:latin,latin-ext' ] }
      };
      (function() {
        var wf = document.createElement('script');
        wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
          '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
        wf.type = 'text/javascript';
        wf.async = 'true';
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(wf, s);
      })(); 

    function on(callback) {
      if (window.attachEvent) {
        window.attachEvent('onload', callback);
      } else {
        if (window.onload) {
          var curronload = window.onload;
          var newonload = function () {
            curronload();
            callback();
          };
          window.onload = newonload;
        } else {
          window.onload = callback;
        }
      }
    }</script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  	<meta name="description" content="<?php echo Hp::Get('description') ?>" />
  	<meta name="keywords" content="<?php echo Hp::Get('keywords') ?>" />
  	<meta name="robots" content="INDEX, FOLLOW" />	
  	<meta name="viewport" content="width=device-width" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="format-detection" content="telephone=no">
    <style type="text/css">
    	<?php echo file_get_contents(APPLICATION_PATH.'/assets/css/bootstrap.min.css'); ?>
      <?php echo file_get_contents(APPLICATION_PATH. '/assets/fonts/fa/css/font-awesome.min.css') ?>
      <?php echo file_get_contents(APPLICATION_PATH.'/assets/css/style.css'); ?>
    </style>
    <link rel="icon" href="<?php echo BASE_DIR ?>asd.ico" type="image/x-icon"/>
    
	<?php Modules_Handler::loadCss() ?> 
	
	<script type="text/javascript">
	
	var CFG = {
		cookie_info_expire: <?php echo (int)Config::get('cookie_info.expire') ?>,
		facebook_likebox_width: <?php echo (int)Config::get('facebook.likebox_width') ?>
	};
	 
	</script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-75130370-1', 'auto');
  ga('send', 'pageview');
</script>  
</head>
<body>

<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '1584397665215529',
      xfbml      : true,
      version    : 'v2.5'
    });
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>

<div class="top-bar">
  <div class="wrapper">
    <div class="header">
      <div class="left-header">
        <a href="/">
          <img src="<?php echo BASE_DIR ?>/assets/img/logo.svg" />
        </a>
      </div>
      <div class="right-header">
        

      <?php if(isset($_GET['dev'])): ?>

<script>

on(function() {


})

  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    // console.log('statusChangeCallback');
    // console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'zaloguj się ' +
        'do aplikacji.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      document.getElementById('status').innerHTML = 'Zaloguj się ' +
        'przez Facebook.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);

      // console.log(response)

    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '1584397665215529',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.5' // use graph api version 2.5
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {

    FB.api('/me', {
        locale: 'pl_PL',
        fields: 'first_name, last_name , name , email' 
      } , function(response) {

        // console.log(response)
        document.getElementById('status').innerHTML =
        'Zalogowany jako: ' + response.name + '!';

        FBRegister(response.email,response.first_name,response.last_name)

        showLogout()
        hideLogin()

    });
  }

function FBLogout()
{
    FB.getLoginStatus(function(response) {
        if (response.status === 'connected') {
            FB.logout(function(response) {
                // this part just clears the $_SESSION var
                // replace with your own code
                $.post("/logout").done(function() {
                    $('#status').html('<p>Wylogowano pomyślnie.</p>');
                });
            });
        }
    });

    hideLogout()
    showLogin()
}

on(function() {
    $('#logout').on('click' , function() {
      FBLogout()
    })

    hideLogout()

})

</script>

<fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
</fb:login-button>

<div id="status" style="display: inline-block;font-size: 12px">
</div>



        <a href="#" id="logout" class="btn-contact hidden-xs btn-facebook-login">
          <i class="fa fa-facebook"></i>&nbsp;wyloguj
        </a>

      <?php endif; ?>

        <a href="http://cati.ecrf.biz.pl/login/panel" class="btn-contact hidden-xs">zaloguj się</a>
        <a href="<?php echo (strlen($_SERVER['REQUEST_URI']) > 2) ? '/' : '' ?>#kontakt" class="anchor hidden-xs">kontakt</a>
        <span class="menu-trigger">
          <i class="fa fa-bars"></i> <span>MENU</span> 
        </span>
      </div>
    </div>
  </div>
</div>

<div class="fixed-menu">
  <div class="wrapper">
    <div class="fixed-menu__list">
      <a href="http://catidev.ecrf.biz.pl/login/panel" class="hidden-lg hidden-md hidden-sm">Zaloguj się</a>

      <?php if(isset($_GET['dev'])): ?>

        <a href="http://catidev.ecrf.biz.pl/login/panel" class="hidden-lg hidden-md hidden-sm">Zaloguj się</a>

      <?php endif; ?>

      <a href="<?php echo (strlen($_SERVER['REQUEST_URI']) > 2) ? '/' : '' ?>#getting-started" class="anchor">Jak zacząć</a>
      <a href="/badania-internetowe">Badania internetowe</a>
      <a href="<?php echo (strlen($_SERVER['REQUEST_URI']) > 2) ? '/' : '' ?>#kontakt" class="anchor">Kontakt</a>
      <a href="/faq">FAQ</a>
      <a href="/onas">O nas</a>
      <a href="/regulamin">Regulamin</a>
      <a href="/polityka-prywatnosci">Polityka prywatności</a>
    </div>
  </div>
</div>


	<?php echo $this->getMessages() ?>

	<?php $this->display(); ?>


<div class="footer">
  <div class="wrapper">
    <div class="col-md-4">
      <a href="">
        <img style="width: 103px;" src="<?php echo BASE_DIR ?>/assets/img/logo-white.svg" />
      </a>
    </div>
    <div class="col-md-4">
      <a href="http://www.cati-system.pl" target="_blank"> 
       <img style="width: 82px;" src="<?php echo BASE_DIR ?>/assets/img/cati-white.svg" />
       </a>
    </div>
    <div class="col-md-4">
      <a href="http://www.biostat.com.pl" target="_blank">
        <img style="width: 143px;margin-top: 12px;" src="<?php echo BASE_DIR ?>/assets/img/biostat-white.svg" />
      </a>
    </div>
 </div>
</div>

<a class="fa fa-facebook-official" href="https://www.facebook.com/1badanieopinii/" target="_blank"></a>


	<script src="<?php echo BASE_DIR ?>/assets/js/jquery.js"></script>
    <script src="<?php echo BASE_DIR ?>/assets/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/waypoints/lib/noframework.waypoints.min.js"></script>
    <script src="<?php echo BASE_DIR ?>/assets/js/main.js"></script>
    <link rel="stylesheet" type="text/css" href="<?php echo BASE_DIR ?>/assets/css/font-awesome/css/font-awesome.min.css">
	<?php Modules_Handler::loadJs() ?>
	
	<?php if (Page_Controller::$_PAGE_CONFIG['debug'] && Auth::isSuperadmin()): ?>
	<?php include (DIR_INC_TPL.'_debug/bar.tpl') ?>
	<?php endif ?>

</body>
</html>