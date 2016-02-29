<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<title>CMS - Biostat</title>

	<meta http-equiv="Content-type" content="<?php echo Config::Get('admin_page.meta_encoding');?>" />
	<meta http-equiv="Content-Language" content="<?php echo Config::Get('admin_page.meta_language');?>" />
	<meta name="DESCRIPTION" content="<?php echo Config::Get('admin_page.meta_description');?>" />
	<meta name="KEYWORDS" content="<?php echo Config::Get('admin_page.meta_keywords');?>" />
	<meta name="ROBOTS" content="<?php echo Config::Get('admin_page.meta_robots');?>" />

<?php

	$css = new CssRequestCollector('css_login_'.$this->session->get('language'), (int) Config::Get('cache.css_timeout'));
	$css->Add(DIR_INC.'tpl/style_admin.css');
	$css->Add(DIR_INC_PLUGINS.'jquery/ui/css/smoothness/jquery-ui-1.8.13.custom.css');
	$css->Build(); ?>
	<link rel="stylesheet" href="<?php echo $css->GetAbsolutePathToCollection() ?>" type="text/css" />

	<?php
	$js = new JsRequestCollector('js_login_'.$this->session->get('language'), (int) Config::Get('cache.js_timeout'));
	$js->Add(DIR_INC.'assets/js/jquery.js');
	$js->Add(DIR_INC.'assets/js/scripts.js');
	$js->Add(DIR_INC.'assets/js/js_form_validation.php');
	$js->Add(DIR_INC.'assets/js/jquery.form.validation.js');
	$js->Add(DIR_INC_PLUGINS.'jquery/ui/js/jquery-ui-1.8.13.custom.min.js');
	
	$js->Build(); ?>
	
	<script language="JavaScript" type="text/javascript" src="<?php echo $js->GetAbsolutePathToCollection() ?>"></script>
	
</head>

<body id="body-of-page">

	<div style=" width:1000px; margin: 0 auto; ">

		<center>

			<div class="tcenter" style="width: 320px; margin-top: 5%;">
				<?php echo $this->getMessages(); ?>
			</div>

			<div id="mod-content-border">
				<div id="mod-content" class="mod-content-without-menu">
				<?php echo $this->readOutput() ?>
				</div>
			</div>

		</center>

	</div>

	<!-- Blok służy do zarezerwowania miejsca dla okna komunikatów
	 - zwróconych przez skrypt js formularza -->

	<div id="form-error-box">

	<!-- Nie należy nic tutaj umieszczać -->

	</div>

</body>

</html>