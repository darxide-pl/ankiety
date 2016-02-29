<?php //f_print_r($profile); ?>

<div class="container">
	
	<div class="panel panel-default">
		
		<div class="panel-heading">
			<p class="panel-title"><i class="glyphicon glyphicon-user"></i> Mój profil</p>
		</div>
		
		<div class="panel-body">
			
			<form action="" method="post" class="form-horizontal" id="edit_form">
				
				<input type="hidden" name="page_action" value="<?php echo f_eas('Users|save_account') ?>" />
				
				<div class="form-group">
					<label class="control-label col-sm-3">Imię i nazwisko</label>
					<div class="col-sm-9">
						<p class="form-control-static"><?php echo $profile['name'].' '.$profile['lastname'] ?></p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3">Adres e-mail</label>
					<div class="col-sm-9">
						<p class="form-control-static"><a href="mailto:<?php echo $profile['email'] ?>"><?php echo $profile['email'] ?></a></p>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="password">Hasło</label>
					<div class="col-sm-9">
						<input type="password" id="password" name="password" placeholder="" disabled="disabled" class="form-control" />
						<label class="checkbox"><input type="checkbox" value="1" name="change_password" id="checkbox-change-password" /> zmień hasło</label>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3">Stopka e-mail</label>
					<div class="col-sm-9">
						<textarea name="email_signature" id="email_signature" class="form-control textarea-expand"><?php echo $profile['email_signature'] ?></textarea>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<input type="submit" class="btn btn-primary" value="Zapisz zmiany" />
					</div>
				</div>
				
			</form>
		</div>
		
		<div class="panel-footer">
			
		</div>
		
	</div>
	
</div>

<script type="text/javascript">
$().ready(function(){
	CKEDITOR.replace( 'email_signature' );
	
	var validate = new FormValidate('#edit_form',{},{
		empty: {
			'check': 'empty',
			'checkonblur': true,
			'condition': function(item){
				if (!$(item).is(':visible')) return false;
				return true;
			}
		},
		password: {
			'check': 'password',
			'checkonblur': true,
			'condition': function(item){
				if (!$(item).is(':visible')) return false;
				return true;
			}
		},
		email: {
			'check': 'email',
			'checkonblur': true,
			'condition': function(item){
				if (!$(item).is(':visible')) return false;
				return true;
			}
		}
	});
	
	$('#checkbox-change-password').change(function(){
		if ($(this).is(':checked')) {
			$('#password').attr('disabled',false);
		} else {
			$('#password').attr('disabled',true);
		}
	});
});
</script>