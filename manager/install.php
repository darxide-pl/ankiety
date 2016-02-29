<?php

# output buffer & gz compression
ob_start("ob_gzhandler");

# application
define('APPLICATION_NAMESPACE','INSTALL');
define('APPLICATION_PATH', realpath(dirname(__FILE__).'/../'));

error_reporting(E_ALL ^ E_NOTICE ^ E_DEPRECATED);

ini_set("log_errors" , "1");
ini_set("error_log" , APPLICATION_PATH."/tmp/log/".date('Ym')."_install.txt");
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

$page = new Page_Controller(array(
	'default_page' 			=> 'install',
	'default_language' 		=> Config::Get('admin_page.default_language'),
	'page_encoding' 		=> Config::Get('admin_page.meta_encoding'),
	'page_default_timezone' => Config::Get('admin_page.default_time_zone'),
	'allow_anonymous_login' => true
));

Core::Install_Component('language',new Language_Controller($page->rv->get('language'), $page->getPage()));

try {
	$page->loadPage();
	$page->loadTemplate('install');
} catch (Exception $e) {
	echo $e->getMessage();
}