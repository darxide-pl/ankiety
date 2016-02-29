<?php $o = $this->output['object'] ?>

<div class="container">
	
	<div class="panel panel-primary">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-user"></i> &nbsp; Edycja użytkownika
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
	
		<div class="panel-body">
			
			<form action="<?php echo $this->link->Build(array($this->name, $this->view));?>" method="post" id="edit_form" name="edit_form" enctype="multipart/form-data" 
				class="form-horizontal">

				<input type="hidden" name="page_action" value="<?php echo f_eas('Users|save');?>" />
				<input type="hidden" name="user_id" value="<?php echo $this->oid ?>" />

				<div class="form-group">
					<label class="col-sm-3" for="email">Adres e-mail / Login</label>
					<div class="col-sm-9">
						<input type="text" id="email" name="email" value="<?php echo f_escape($o->get('email')) ?>" class="form-control" placeholder="" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3" for="password">Hasło</label>
					<div class="col-sm-9">
						<input type="password" id="password" name="password" placeholder="" disabled="disabled" class="form-control" />
						<div class="checkbox">
							<label class=""><input type="checkbox" value="1" name="change_password" id="checkbox-change-password" /> zmień hasło</label>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3" for="name">Imię</label>
					<div class="col-sm-9">
						<input type="text" id="name" name="name" value="<?php echo f_escape($o->get('name')) ?>" placeholder="" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3" for="lastname">Nazwisko</label>
					<div class="col-sm-9">
						<input type="text" id="lastname" name="lastname" value="<?php echo f_escape($o->get('lastname')) ?>" placeholder="" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3" for="group_id">Grupa</label>
					<div class="col-sm-9">
						<select name="group_id" class="form-control">
							<?php echo Html::SelectOptions($groups, $o->Get('group_id')) ?>
						</select>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-sm-3" for="active">Status</label>
					<div class="col-sm-9 radio">
						<label class=""><input type="radio" name="active" value="1" checked="checked" id="active" /> Aktywny</label>
						<label class=""><input type="radio" name="active" value="0" <?php echo ! $o->IsActive() ? 'checked="checked"' : '';?> id="notactive" /> Zablokowany</label>
					</div>
				</div>

				<?php if ($modules): foreach ($modules as $module): ?>
				<div class="form-group">
					<label for="" class="control-label col-sm-3"><?php echo $module['title'] ?></label>
					<div class="col-sm-9">
						<div class="btn-group" data-toggle="buttons">

							<label class=" btn btn-default <?php echo isset($object->access_list[$module['access']]['read']) ? 'active' : '' ?>">
								<input type="checkbox" name="access_list[<?php echo $module['access'] ?>][read]" value="1" <?php echo isset($object->access_list[$module['access']]['read']) ? 'checked' : '' ?> />
								Odczyt
							</label>
						
							<label class=" btn btn-default <?php echo isset($object->access_list[$module['access']]['write']) ? 'active' : '' ?>">
								<input type="checkbox" name="access_list[<?php echo $module['access'] ?>][write]" value="1" <?php echo isset($object->access_list[$module['access']]['write']) ? 'checked' : '' ?> />
								Zapis
							</label>
						
							<label class=" btn btn-default <?php echo isset($object->access_list[$module['access']]['remove']) ? 'active' : '' ?>">
								<input type="checkbox" name="access_list[<?php echo $module['access'] ?>][remove]" value="1" <?php echo isset($object->access_list[$module['access']]['remove']) ? 'checked' : '' ?> />
								Usuwanie
							</label>
						</div>
					</div>
				</div>
				<?php endforeach; endif; ?>

				<div class="form-group">
					<label class="control-label col-sm-3">Stopka e-mail</label>
					<div class="col-sm-9">
						<textarea name="email_signature" id="email_signature" class="form-control textarea-expand"><?php echo $o->get('email_signature') ?></textarea>
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-9">
						<input type="submit" class="btn btn-primary" value="Zapisz zmiany">
						<a class="btn" href="<?php echo $this->link->Build(array($this->name)) ?>">Anuluj</a>
					</div>
				</div>

			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
//<!--//

$(document).ready(function(){
	
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

//-->
</script>