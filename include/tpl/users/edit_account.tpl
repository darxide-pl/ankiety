<?php $o = $this->output['object'];?>
<?php $groups = $this->output['groups'];?>

<script type="text/javascript">
//<!--//
function SubmitForm() {
	var Form = new FormValidate('edit_form');
	Form.CheckField('name', 'Nazwa', 'empty');
	Form.CheckField('lastname', 'Nazwisko', 'empty');
	Form.CheckField('login', 'Login', 'empty');
	Form.CheckField('email', 'Adres e-mail', 'email');
	if (isChecked('change_password')) {
		Form.CheckField('password', 'Hasło', 'password');
	}
	Form.Execute();
}
function CancelForm() {
	location.href = '<?php echo $this->link->Build(array($this->name,'edit_account'));?>';
}
//-->
</script>

<form action="<?php echo $this->link->Build(array($this->name, $this->view));?>" method="post" id="edit_form" name="edit_form">
	
	<input type="hidden" name="page_action" value="<?php echo f_eas('Users|save_account');?>" />
	
	<?php echo f_html_box_open();?>
	<table class="form-table">
	<tr><th colspan="2" class="title">Edycja konta</th></tr>
	<tr><th>Imię</th><td><input type="text" name="name" value="<?php echo $o->Get('name');?>" id="name" size="30" maxlength="45" /></td></tr>
	<tr><th>Nazwisko</th><td><input type="text" name="lastname" value="<?php echo $o->Get('lastname');?>" id="lastname" size="30" maxlength="45" /></td></tr>
	<tr><th>Adres email</th><td><input type="text" name="email" value="<?php echo $o->Get('email');?>" id="email" size="50" maxlength="256" /></td></tr>
	<tr><th>Login</th><td><input type="text" name="login" value="<?php echo $o->Get('login');?>" id="login" size="30" maxlength="32" />
		<div class="subtitles">(login jest identyfikatorem użytkownika, przy jego pomocy użytkownik loguje się do systemu)</div></td></tr>
	<tr><th>Hasło</th>
		<td><input type="radio" name="change_password" id="change_password" value="1" onclick="showElement('password_div');" /> Zmiana
			<input type="radio" name="change_password" value="0" onclick="hideElement('password_div');" checked="checked" /> Pozostaw bez zmian
		</td></tr>
	<tr id="password_div" style="display: none;"><th></th><td>
		<input type="text" name="password" value="" id="password" size="25" maxlength="32" />
		<div class="subtitles">(hasło powinno składać się z conajmniej 5 znaków alfanumerycznych o różnych wielkościach)</div>
	</td></tr>
	</table>
	<?php echo f_html_box_close();?>
	
	<?php echo f_html_draw_button('submit_ok', TFB_UPDATE, 'SubmitForm();');?>
	<?php echo f_html_draw_button('submit', TFB_CANCEL, 'CancelForm();');?>
	
</form>