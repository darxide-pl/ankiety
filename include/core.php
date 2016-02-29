<?php

date_default_timezone_set('Europe/Warsaw');

/**
 * Paths definition
 */

if (!defined('INTERFACE_DIR')) {
	define('INTERFACE_DIR','');
}

define('BASE_DOMAIN',$_SERVER['HTTP_HOST']);
define('BASE_DIR', '');
define('INIT_DIR', BASE_DIR . INTERFACE_DIR); // domain/BASE_DIR/INTERFACE_DIR/$module/$view

/** 
 * Database connection settings
 */
 
define('DB_HOST','localhost');
define('DB_USER','ankiety');
define('DB_PASSWORD','3AvjJTfZdFDE2AnG');
define('DB_NAME','ankiety');
define('DB_PORT', 3305);
define('DB_PROTOCOL','mysqli');

/**
 * Encryption
 */
define('ENC_IV','09876543');
define('ENC_KEY','fsdfdf343fsd45');

/**
 * Other paths
 */

define('DEFAULT_HOST_ADDRESS', BASE_DOMAIN . INIT_DIR . LT);
define('DEFAULT_INDEX','index.php');
if (!defined('DEFAULT_PORT')) {
	define('DEFAULT_PORT','http');
}

define('ABSOLUTE_PATH',DEFAULT_PORT.'://'.DEFAULT_HOST_ADDRESS);
define('ABSOLUTE_HOME_PATH',DEFAULT_PORT.'://'.BASE_DOMAIN.BASE_DIR.LT);

define('DIR_INC', '');
define('DIR_INC_CLASS', DIR_INC.'class'.LT);

define('DIRS_INC_TPL_EXTENSION','.tpl');

define('DIRS_INC_DEFAULT_EXTENSION','.php');

define('DIR_INC_ACTIONS',DIR_INC.'actions'.LT);
define('DIR_INC_TEMPLATES',DIR_INC.'tpl'.LT);
define('DIR_INC_TPL',DIR_INC_TEMPLATES);
define('DIR_INC_PLUGINS',APPLICATION_PATH.'/include/plugins/');
define('DIR_INC_LANGUAGES',APPLICATION_PATH.'/include/languages/');

define('DIR_INC_BASE',BASE_DIR.LT.'include'.LT);
define('DIR_INC_STYLE_JS',DIR_INC_BASE.'tpl'.LT);
define('DIR_INC_PLUGINS_JS',DIR_INC_BASE.'plugins'.LT);
define('DIR_INC_IMAGES',BASE_DIR.LT.'images'.LT);
define('DIR_INC_JS',BASE_DIR.LT.'js'.LT);

define('DIR_INC_IMAGES_RELATIVE',APPLICATION_PATH.'/images/');

define('FILE_NO_IMAGE',DIR_INC_IMAGES.'no_image.png');

define('DIR_UPLOAD',APPLICATION_PATH.'/upload/');
define('DIR_UPLOAD_ABSOLUTE',DEFAULT_PORT.'://'.BASE_DOMAIN.BASE_DIR.LT.'upload'.LT);

define('DIR_CACHE',APPLICATION_PATH.'/include/cache/');
define('DIR_CACHE_RIGHTS',DIR_CACHE.'rights/');
define('DIR_CACHE_SESSION', dirname(__FILE__).'/cache/session');

define('IMG_SCALE_TO_WH', -1);
define('IMG_SCALE_RESIZE', 0);
define('IMG_SCALE_NONE_IF_SMALLER',-2);

$paths = array(
	APPLICATION_PATH.'/include',
	'.'
);

set_include_path(implode(PATH_SEPARATOR, $paths));
