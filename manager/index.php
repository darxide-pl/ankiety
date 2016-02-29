<?php

# output buffer & gz compression
ob_start("ob_gzhandler");

# application
define('APPLICATION_NAMESPACE','CMS');
define('APPLICATION_PATH', realpath(dirname(__FILE__).'/../'));

error_reporting(E_ALL ^ E_NOTICE ^ E_DEPRECATED);

ini_set("log_errors" , "1");
ini_set("error_log" , APPLICATION_PATH."/tmp/log/".date('Ym')."_crm.txt");
ini_set("display_errors" , "1");

include './config.php';
include APPLICATION_PATH.'/include/core.php';
include APPLICATION_PATH.'/include/functions.php';
 
//echo (int)symlink(APPLICATION_PATH.'/assets', APPLICATION_PATH.'/crm/assets');
//symlink(APPLICATION_PATH.'/include', APPLICATION_PATH.'/crm/include');

# session component
Core::Install_Component('session',new Session(
	APPLICATION_NAMESPACE, null, DIR_CACHE_SESSION, BASE_DIR));

$db = Db::Instance();

$cfg = new Config();

Page_Controller::debug(false);
Page_Controller::parseUrl();

$page = new Page_Controller(array(
	'default_page' 			=> 'pages',
	'default_language' 		=> Config::Get('admin_page.default_language'),
	'page_encoding' 		=> Config::Get('admin_page.meta_encoding'),
	'page_default_timezone' => Config::Get('admin_page.default_time_zone'),
	'allow_anonymous_login' => false
));

Core::Install_Component('language',new Language_Controller($page->rv->get('language'), $page->getPage()));

# authorization component
Core::Install_Component('auth', new Auth($page->rv->get('auth_login', 'post'),
		$page->rv->get('auth_password', 'post'), array(), false ));

if ($page->auth->loadAction($page->rv->Get('auth_action', 'request'))) {
	$page->request->execute($page->auth->redirect_params);
}

if ($page->auth->isLoged()) {
	if ($page->getPage() == 'login') {
		$page->request->execute(ABSOLUTE_PATH);
	}
}

try {
	$page->loadPage();
	$page->loadTemplate('admin');
} catch (Exception $e) {
	echo $e->getMessage();
}