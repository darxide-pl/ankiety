<div class="container">
	
	<div class="panel panel-success">
		
		<div class="panel-heading">
			<i class="glyphicon glyphicon-envelope"></i> &nbsp; Nowe powiadomienie
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">

			<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
				  class="form-horizontal" method="post"
				  id="add_form" name="add_form">

				<input type="hidden" name="page_action" value="<?php echo f_eas('System_Messages|add') ?>" />

				<div class="form-group">
					<label class="control-label col-sm-3" for="action_name">Powiadomienie</label>
					<div class="col-sm-9">
						<input type="text" name="action_name" id="action_name" value="<?php echo $object->Get('System_Action.name');?>" class="form-control" />
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-3" for="action_code">Kod akcji</label>
					<div class="col-sm-9">
						<input type="text" name="action_code" id="action_code" value="<?php echo $object->Get('System_Action.constant');?>" class="form-control" />
					</div>
				</div>

				<?php for($i=1;$i<10;$i++): ?>
				<div class="form-group">
					<label class="control-label col-xs-3" for="">Zmienna <?php echo $i ?></label>
					<div class="col-xs-3">
						<input type="text" name="action_var[<?php echo $i ?>][name]" value="" class="form-control" />
					</div>
					<div class="col-xs-6">
						<input type="text" name="action_var[<?php echo $i ?>][desc]" value="" class="form-control" />
					</div>
				</div>
				<?php endfor ?>

				<?php if ($langs): foreach ($langs as $lang => $lang_name): ?>
				<div class="form-group">
					<label class="control-label col-sm-3" for=""><?php echo $lang_name ?></label>
					<div class="col-sm-9">
						<input type="text" name="d[<?php echo $lang ?>][title]" value="<?php echo f_escape($description[$lang]['title']) ?>" class="form-control" />
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-3" for="">Treść</label>
					<div class="col-sm-9">
						<textarea name="d[<?php echo $lang ?>][content]" rows="15" cols="1" class="form-control"><?php echo $description[$lang]['content'] ?></textarea>

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

				<div class="form-group">
					<div class="col-sm-9">
						<input class="btn btn-success" type="submit" value="Zapisz zmiany" />
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