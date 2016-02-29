<?php if (Config::get('cookie_info.show')): ?>
		
<?php

$cookie_allowed = $_COOKIE['cookie_allowed'];
$cookie_allow = (int)$_REQUEST['cookie_allow'];

if ($cookie_allow):
	Cookie_Handler::Create('cookie_allowed', 1, 3600 * 24 * Config::get('cookie_info.expire'));
endif;

if (!$cookie_allow && !$cookie_allowed): ?>
	<div id="cookie-info">
		<a class="close">&times;</a>
		<?php echo Model_Page_Data::display('cookie_info') ?>
	</div>
<?php endif; ?>

<?php endif;