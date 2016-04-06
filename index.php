<?php

# output buffer & gz compression
ob_start("ob_gzhandler");

# application
define('APPLICATION_NAMESPACE', 'CMS');
define('APPLICATION_PATH', realpath(dirname(__FILE__).'/'));

ini_set("log_errors" , "1");
ini_set("error_log" , APPLICATION_PATH."/tmp/log/".date('Ym').".txt");

include './include/config.php';
include './include/core.php';
include './include/functions.php';

/*
if (f_get_ip_address() != '10.246.0.9') {
	die();
}*/

Core::Install_Component('session',new Session(APPLICATION_NAMESPACE, null, DIR_CACHE_SESSION, BASE_DIR));

$db = Db::Instance();

$cfg = new Config();

Page_Controller::debug(false);

Routes::addRoute(array('pattern' => '/^search/',
	'vars' => array('page' => 'pages_index','subpage' => 'search')));

Routes::addRoute(array('pattern' => '/^g\/(?P<alias>[a-zA-Z0-9\.\-\_]+)\-(?P<oid>[0-9]+)$/',
	'vars' => array('page' => 'pages_index','subpage' => 'gallery')));

Routes::addRoute(array(
	'pattern' => '/^sklep\/koszyk\/$/',
	'vars' => array('page' => 'pages_index','subpage' => 'basket')));

Routes::addRoute(array(
	'pattern' => '/^sklep\/(?P<category_path>([a-zA-Z0-9\.\-\_]+\/)*)(?P<alias>[a-zA-Z0-9\.\-\_]+)\.html$/',
	'vars' => array('page' => 'pages_index','subpage' => 'product')));

Routes::addRoute(array(
	'pattern' => '/^sklep\/(?P<category_path>([a-zA-Z0-9\.\-\_]+\/)*)$/',
	'vars' => array('page' => 'pages_index','subpage' => 'category')));

Routes::addRoute(array(
	'pattern' => '/^sklep$/',
	'vars' => array('page' => 'pages_index','subpage' => 'category')));

Routes::addRoute(array('pattern' => '/^(?P<category_path>([a-zA-Z0-9\.\-\_]+\/)*)(?P<alias>[a-zA-Z0-9\.\-\_]+)$/',
	'vars' => array('page' => 'pages_index','subpage' => 'index')));

Page_Controller::parseUrl();

$page_controller = new Page_Controller(array(
	'default_page' 			=> 'pages_index',
	'default_language' 		=> 'pl',
	'page_encoding' 		=> 'UTF-8', // php encoding
	'page_default_timezone' => 'Europe/Warsaw',
	'allow_anonymous_login' => true
)); 

Core::Install_Component('cfg', $cfg);
Core::Install_Component('msg', Messages_Custom::Instance());
Core::Install_Component('language',new Language_Controller($page_controller->rv->get('language'), $page_controller->getPage()));
Core::Install_Component('auth', new Auth($page_controller->rv->get('auth_login', 'post'), $page_controller->rv->get('auth_password', 'post'), array(), false ));

if ($page_controller->auth->loadAction($page_controller->rv->Get('auth_action', 'request'))) {
	$page_controller->request->execute($page_controller->auth->redirect_params);
}

try {
	
	$bootstrap = new Bootstrap();
	$bootstrap->init();
	
	$page_controller->loadPage();
	$page_controller->loadTemplate('index');

} catch (Exception $e) {
	echo $e->getMessage();
}
