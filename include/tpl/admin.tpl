<!DOCTYPE html>
<html lang="pl">
  <head>
	  
    <meta charset="utf-8">
	
    <title>CRM</title>
	
    <meta name="viewport" content="width=device-width; initial-scale=1; maximum-scale=1.0; user-scalable=0;" />
    <meta name="author" content="Szymon Błąkała - vsemak@gmail.com" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	
	<link rel="shortcut icon" href="<?php echo BASE_DIR ?>/favicon.ico?time=12" />

	<link href="<?php echo BASE_DIR ?>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<?php echo BASE_DIR ?>/assets/css/bootstrap-datepicker.css" rel="stylesheet" type="text/css" />
	<link href="<?php echo BASE_DIR ?>/assets/css/chosen.min.css" rel="stylesheet" type="text/css" />
	<link href="<?php echo BASE_DIR ?>/include/tpl/style_admin.css" rel="stylesheet" type="text/css" />

	<?php Modules_Handler::loadCss() ?>
	
	<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/jquery.js"></script>
	<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/scripts.js"></script>
	<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/jquery.autosize.js"></script>
	<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/jquery.form.validation_new.js"></script>
	<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/bootstrap-datepicker.js"></script>

	<?php Modules_Handler::loadJs() ?>
	
</head>
    
<body>

	<?php if ($this->auth->isLoged() && $this->rv->get('subpage') != 'edit_data_html'): ?>
		<?php include APPLICATION_PATH.'/include/tpl/_plugins/menu_admin.tpl'; ?>
	<?php endif; ?>

	<?php echo $this->getMessages(); ?>
	
	<?php $this->display() ?>
	
	<?php if (Page_Controller::$_PAGE_CONFIG['debug']): ?>
	<?php include (DIR_INC_TPL.'_debug/bar.tpl') ?>
	<?php endif ?>
	
	<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/bootstrap-typeahead.js"></script>
	<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/chosen.jquery.min.js"></script>
	
</body>
</html>