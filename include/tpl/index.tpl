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
    ga('create', 'UA-70633607-1', 'auto');
    ga('send', 'pageview');
</script>
</head>
<body>

<div class="top-bar">
  <div class="wrapper">
    <div class="header">
      <div class="left-header">
        <a href="/">
          <img src="<?php echo BASE_DIR ?>/assets/img/logo.svg" />
        </a>
      </div>
      <div class="right-header">
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
      <a href="<?php echo (strlen($_SERVER['REQUEST_URI']) > 2) ? '/' : '' ?>#getting-started" class="anchor">Jak zacząć</a>
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