<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			<i class="glyphicon glyphicon-envelope"></i> &nbsp; Edycja powiadomienia
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">
			<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
				  class="form-horizontal" method="post" id="update_form" name="update_form">

				<input type="hidden" name="page_action" value="<?php echo f_eas('System_Messages|save') ?>" />
				<input type="hidden" name="message_id" value="<?php echo $this->oid ?>" />
				<input type="hidden" name="action_id" value="<?php echo $object->Get('action_id') ?>" />

				<?php if ($langs): foreach ($langs as $lang => $lang_name): ?>
				<div class="form-group">
					<label class="col-sm-3 control-label" for=""><?php echo $lang_name ?></label>
					<div class="col-sm-9">
						<input type="text" name="d[<?php echo $lang ?>][title]" value="<?php echo f_escape($description[$lang]['title']) ?>" class="form-control" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label" for="">Treść</label>
					<div class="col-sm-9">
						<textarea id="editor" name="d[<?php echo $lang ?>][content]" rows="15" cols="1" class="form-control"><?php echo $description[$lang]['content'] ?></textarea>

						<?php if ($actions_vars):?>

							<span class="help-block">
								<strong>Dostępne zmienne:</strong>
							<?php foreach ($actions_vars as $var): ?> 
								<span class="tip-top" title="<?php echo $var->GetDesc() ?>">{<?php echo $var->GetName() ?>}</span>&nbsp;
							<?php endforeach;?>
							</span>
						<?php endif;?>
					</div>
				</div>
				<?php endforeach; endif; ?>
				
				<?php if (Auth::isSuperadmin()): ?>

				<div class="form-group">
					<label class="col-sm-3 control-label" for="action_name">Powiadomienie</label>
					<div class="col-sm-9">
						<input type="text" name="action_name" id="action_name" value="<?php echo $object->Get('System_Action.name');?>" class="form-control" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label" for="action_code">Kod akcji</label>
					<div class="col-sm-9">
						<input type="text" name="action_code" id="action_code" value="<?php echo $object->Get('System_Action.constant');?>" class="form-control" />
					</div>
				</div>

				<?php if ($actions_vars): foreach ($actions_vars as $k => $var): ?>
				<div class="form-group">
					<label class="col-xs-3 control-label" for="">Zmienna <?php echo $k+1 ?></label>
					<div class="col-xs-3">
						<input type="text" name="action_var[<?php echo $var->GetID() ?>][name]" value="<?php echo $var->get('name') ?>" class="form-control" />
					</div>
					<div class="col-xs-6">
						<input type="text" name="action_var[<?php echo $var->GetID() ?>][desc]" value="<?php echo $var->get('desc') ?>" class="form-control" />
					</div>
				</div>
				<?php endforeach; endif ?>

				<?php for($i=1+sizeof($actions_vars);$i<sizeof($actions_vars)+3;$i++): ?>
				<div class="form-group">
					<label class="col-xs-3 control-label" for="">Zmienna <?php echo $i ?></label>
					<div class="col-xs-3">
						<input type="text" name="action_var_new[<?php echo $i ?>][name]" value="" class="form-control" />
					</div>
					<div class="col-xs-6">
						<input type="text" name="action_var_new[<?php echo $i ?>][desc]" value="" class="form-control"  />
					</div>
				</div>
				<?php endfor ?>

				<?php endif ?>

				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<input class="btn btn-primary" type="submit" value="Zapisz zmiany" />
						lub
						<a href="<?php echo $this->link->Build(array($this->name)) ?>">Porzuć zmiany i wróć do listy</a>
					</div>
				</div>

			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
//<!--//

//CKEDITOR.config.height = 400;
CKEDITOR.replace( 'editor' );

$(document).ready(function(){
	var validate = new FormValidate('#add_form',{},{
		title: {
			'check': 'empty',
			'checkonblur': true
		}
	});
});

//-->
</script>
