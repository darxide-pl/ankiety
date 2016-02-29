<script type="text/javascript">
//<!--//
function TestSMTPConnection(form) {
	form.find('input[name="page_action"]').attr('name','_page_action');
	form.find('.ajax_result').html('Test połączenia: Proszę czekać ... <img class="ajax-loader" align="top" src="<?php echo DIR_INC_IMAGES ?>ajax-loader.gif" alt="Proszę czekać ..." />');
	$.post("<?php echo $this->link->Build('/configuration/test_smtp_connection/'); ?>", form.serialize(), function(result){
	   form.find('.ajax_result').html(result);
	});
	form.find('input[name="page_action"]').attr('name','page_action');
}
//-->
</script>

<div class="container">
	<div class="col-md-3">
		<ul class="nav nav-pills nav-stacked" id="myTabs">
			<li class="active"><a href="#default" data-toggle="tab">Podstawowe</a></li>
			<li><a href="#email" data-toggle="tab">Główne konto e-mail</a></li>
		</ul>
	</div>
	
	<div class="col-md-7">
		<div class="tab-content">

			<div class="tab-pane active" id="default">
				
				<form action="" method="post" class="form-horizontal">

					<input type="hidden" name="page_action" value="<?php echo f_eas('Configurations|save') ?>" />

					<?php /*
					<legend>Sklep</legend>
					
					<div class="form-group">
						<label class="col-sm-4 control-label" for="store-tax_rate">Stawka VAT</label>
						<div class="col-sm-8"> 
							
							<input type="text" name="cfg[store][tax_rate]" id="store-tax_rate" value="<?php echo f_clear_price(Config::get('store.tax_rate')) ?>" class="form-control" />
							
						</div>
					</div>*/ ?>


					<legend>Formularz kontaktowy</legend>
					
					<div class="form-group">
						<label class="col-sm-4 control-label" for="default-contact_form_recipients">Wyślij zapytania kontaktowe do</label>
						<div class="col-sm-8"> 
							
							<textarea name="cfg[default][contact_form_recipients]" id="default-contact_form_recipients" value="" class="form-control"><?php echo Config::get('default.contact_form_recipients') ?></textarea>
							
						</div>
					</div>
					
					<legend>Informacja o ciasteczkach</legend>
					
					<div class="form-group">
						<label class="col-sm-4 control-label" for="cookie_info-show">Pokaż</label>
						<div class="col-sm-8"> 
							<label class="radio-inline">
								<input type="radio" name="cfg[cookie_info][show]" value="0" checked /> Nie
							</label>
							<label class="radio-inline">
								<input type="radio" name="cfg[cookie_info][show]" value="1" id="cookie_info-show" <?php echo Config::get('cookie_info.show') ? 'checked' : '' ?> /> Tak
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label" for="cookie_info-expire">Po zamknięciu ukryj na</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="cfg[cookie_info][expire]" value="<?php echo Config::Get('cookie_info.expire') ?>" id="cookie_info-expire" class="form-control"  />
								<div class="input-group-addon">dni</div>
							</div>
							<div class="help-block">Większość przeglądarek pozwala na przechowywanie ciasteczek maksymalnie 90 dni.</div>
						</div>
					</div>
					
					<legend>Facebook</legend>
					
					<div class="form-group">
						<label class="col-sm-4 control-label" for="facebook-likebox_show">Pokaż plugin</label>
						<div class="col-sm-8"> 
							<label class="radio-inline">
								<input type="radio" name="cfg[facebook][likebox_show]" value="0" checked /> Nie
							</label>
							<label class="radio-inline">
								<input type="radio" name="cfg[facebook][likebox_show]" value="1" id="facebook-likebox_show" <?php echo Config::get('facebook.likebox_show') ? 'checked' : '' ?> /> Tak
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label" for="facebook-url">Adres strony</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="cfg[facebook][url]" value="<?php echo Config::Get('facebook.url') ?>" id="facebook-url" class="form-control" onkeyup="$(this).next().find('a').attr('href',$(this).val());" />
								<div class="input-group-btn">
									<a href="<?php echo Config::Get('facebook.url') ?>" class="btn btn-default" target="_blank">Podgląd</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label" for="facebook-url">Szerokość pluginu</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" name="cfg[facebook][likebox_width]" value="<?php echo Config::Get('facebook.likebox_width') ?>" id="facebook-likebox_width" class="form-control" />
								<div class="input-group-addon">
									px
								</div>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-sm-8 col-sm-offset-4">
							<input type="button" class="btn btn-submit btn-primary" value="Zapisz zmiany" />
						</div>
					</div>
					
				</form>
				
			</div>
			
			<div class="tab-pane" id="email">
				
				<form action="" method="post" class="form-horizontal">

					<input type="hidden" name="page_action" value="<?php echo f_eas('Configurations|save') ?>" />
					<input type="hidden" name="group_key" value="email" />

					<div class="form-group">
						<label class="col-sm-4 control-label" for="email-sender_email">Adres e-mail</label>
						<div class="col-sm-8">
							<input type="text" name="cfg[email][sender_email]" value="<?php echo Config::Get('email.sender_email') ?>" id="email-sender_email" class="popover-trigger form-control" data-content="Adres e-mail wyświetlany jako nadawca w wiadomości." data-container="body" data-placement="bottom" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label" for="email-sender_name">Nadawca</label>
						<div class="col-sm-8">
							<input type="text" name="cfg[email][sender_name]" value="<?php echo Config::Get('email.sender_name') ?>" id="email-sender_name" class="popover-trigger form-control" data-content="Sugerowana warość: imię i nazwisko lub nazwa serwisu." data-container="body" data-placement="bottom" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label" for="email-transport">Metoda wysyłania</label>
						<div class="col-sm-8">
							<select name="cfg[email][transport]" id="email-transport" class="form-control popover-trigger" data-content="Dla lokalnego serwera poniższe pola nie są wymagane." data-container="body" data-placement="bottom" >
								<?php echo Html::SelectOptions(array(
									'mail' => 'Lokalny serwer poczty - php::mail()',
									'smtp' => 'Zewnętrzny serwer poczty SMTP (np. gmail)'
								), Config::Get('email.transport')) ?>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label" for="email-smtp_server">Serwer SMTP</label>
						<div class="col-sm-8">
							<input type="text" name="cfg[email][smtp_server]" value="<?php echo Config::Get('email.smtp_server') ?>" id="email-smtp_server" class="form-control" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label" for="email-smtp_login">Login</label>
						<div class="col-sm-8">
							<input type="text" name="cfg[email][smtp_login]" value="<?php echo Config::Get('email.smtp_login') ?>" id="email-smtp_login" class="form-control" autocomplete="off" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label" for="email-smtp_password">Hasło</label>
						<div class="col-sm-8">
							<input type="password" name="cfg[email][smtp_password]" value="<?php echo Config::Get('email.smtp_password') ?>" id="email-smtp_password" class="form-control" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label" for="email-smtp_port">Port</label>
						<div class="col-sm-8">
							<input type="text" name="cfg[email][smtp_port]" value="<?php echo Config::Get('email.smtp_port') ?>" id="email-smtp_port" class="popover-trigger form-control" data-content="25 - domyślny, 465 - tls/ssl szyfrowany" data-container="body" data-placement="bottom" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label" for="email-smtp_secure">Zabezpieczenie</label>
						<div class="col-sm-8">
							<select id="email-smtp_secure" name="cfg[email][smtp_secure]" class="form-control popover-trigger" data-container="body" data-placement="bottom" data-content="Np. gmail.com używa protokołu TLS.">
								<?php echo Html::SelectOptions(array('none'=>'Brak','ssl'=>'SSL','tls'=>'TLS'), Config::Get('email.smtp_secure')) ?>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-4 control-label" for="sendtest">Wyślij testowy e-mail</label>
						<div class="col-sm-8">
							<div class="input-group">
								<input type="text" class="form-control" id="sendtest" placeholder="Adres e-mail" name="testemail">
								<span class="input-group-btn">
									<button class="btn" id="btn-send-testemail" data-complete-text="Spróbuj ponownie" data-loading-text="Wysyłam ...">Wyślij testową wiadomość</button>
								</span>
							</div>
							<span class="help-inline" id="sendtest-msg"></span>
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-8 col-sm-offset-4">
							<input type="button" class="btn btn-submit btn-primary" value="Zapisz zmiany" />
						</div>
					</div>

				</form>

			</div>

		</div>
	</div>

</div>

<script type="text/javascript">
$(function() {
	
	$('.btn-submit').click(function(e){
		e.preventDefault();
		$(this).closest('form').submit();
	});
	
	$('.popover-trigger').popover({trigger:'hover'});
	
	$('#myTabs li:eq(<?php echo (int)$this->rv->get('tab') ?>) a').tab('show');
	
	$('.tab-pane form').submit(function(e){
		var index = $(this).parent().index();
		$(this).append('<input type="hidden" name="tab" value="'+index+'" />');
	});
	
	$('#btn-send-testemail').click(function(e){
		
		e.preventDefault();
		
		var btn = $(this);
		var form = btn.closest('form');
		var pa = form.find('input[name="page_action"]');
		
		btn.button('loading');

		pa.data('value',pa.val());
		pa.val('');
		
		$.post('<?php echo $this->link->Build(array($this->name,'test_smtp_connection')) ?>',form.serialize(),function(data){
			
			$('#sendtest-msg').html(data);
			
			btn.button('complete');
		});
		
		pa.val(pa.data('value'));
	});
	
	$('#btn-send-testemail1').click(function(e){
		
		e.preventDefault();
		
		var btn = $(this);
		var form = btn.closest('form');
		var pa = form.find('input[name="page_action"]');
		
		btn.button('loading');

		pa.data('value',pa.val());
		pa.val('');
		
		$.post('<?php echo $this->link->Build(array($this->name,'test_smtp_connection')) ?>',form.serialize(),function(data){
			
			$('#sendtest-msg').html(data);
			
			btn.button('complete');
		});
		
		pa.val(pa.data('value'));
	});
	
	$('#btn-send-testemail2').click(function(e){
		
		e.preventDefault();
		
		var btn = $(this);
		var form = btn.closest('form');
		var pa = form.find('input[name="page_action"]');
		
		btn.button('loading');

		pa.data('value',pa.val());
		pa.val('');
		
		$.post('<?php echo $this->link->Build(array($this->name,'test_smtp_connection')) ?>',form.serialize(),function(data){
			
			$('#sendtest-msg').html(data);
			
			btn.button('complete');
		});
		
		pa.val(pa.data('value'));
	});
});
</script>