<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			Edycja sklepu
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">
			
			<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
				  class="form-horizontal" method="post" id="update_form" name="update_form">

				<input type="hidden" name="page_action" value="<?php echo f_eas('Orders_Postages|save') ?>" />
				<input type="hidden" name="id" value="<?php echo $object->get('id') ?>" />

				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Nazwa</label>
					<div class="col-sm-9">
						<input type="text" name="name" id="name" value="<?php echo f_escape($object->get('name')) ?>" class="v-empty form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="description">Krótki opis</label>
					<div class="col-sm-9">
						<textarea name="description" id="description" rows="2" cols="1" class="form-control"><?php echo $object->get('description') ?></textarea>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="price">Cena brutto</label>
					<div class="col-sm-9">
						<input type="text" name="price" id="price" value="<?php echo f_escape($object->get('price')) ?>" class="v-empty form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="price">Przydziel płatności</label>
					<div class="col-sm-9">
						<?php if ($payments): foreach ($payments as $v):  ?>
						<div class="checkbox">
							<label>
								<input type="checkbox" name="payments[]" value="<?php echo $v['id'] ?>" <?php echo isset($postage_payments[$v['id']]) ? 'checked' : '' ?> />
								<?php echo $v['name'] ?> <?php if ($v['plugin']): ?>(<?php echo $v['plugin'] ?>)<?php endif; ?>
							</label>
						</div>
						<?php endforeach; endif; ?>
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<input class="btn btn-primary" type="submit" value="Zapisz zmiany" />
						lub
						<a href="<?php echo $this->link->Build(array($this->name)) ?>">Porzuć zmiany i wróć do listy</a>
					</div>
				</div>

			</form>
		</div><!-- .panel-body -->
	</div><!-- .panel -->
</div><!-- .container -->

<script type="text/javascript">
//<!--//

//CKEDITOR.config.height = 400;
/*CKEDITOR.replace( 'content', {
	toolbar: 'Rich'
} );*/


$(document).ready(function(){
	var validate = new FormValidate('#update_form',{},{
		empty: {
			check: 'empty',
			checkonblur: true
		},
		nip: {
			check: 'nip',
			checkonblur: true
		}
	});
	
	$('.datepicker').datetimepicker({
		pickTime: false
	});
});

//-->
</script>
