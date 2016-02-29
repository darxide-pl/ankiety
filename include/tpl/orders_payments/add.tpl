<div class="container">
	
	<div class="panel panel-success">
		
		<div class="panel-heading">
			Nowa forma płatności
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">

			<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
				  class="form-horizontal" method="post"
				  id="add_form" name="add_form">

				<input type="hidden" name="page_action" value="<?php echo f_eas('Orders_Payments|add') ?>" />
				
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
					<label class="control-label col-sm-3" for="plugin">Rozszerzenie/Plugin</label>
					<div class="col-sm-9">
						<select name="plugin" id="plugin" class="form-control">
							<?php echo Html::SelectOptions(array(
								''=>'brak',
								'payu' => 'PayU'
							),$object->get('plugin')) ?>
						</select>
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
		</div>
	</div>
</div>

<script type="text/javascript">
//<!--//

//CKEDITOR.config.height = 400;
/*CKEDITOR.replace( 'content', {
	toolbar: 'Rich'
} );*/


$(document).ready(function(){
	var validate = new FormValidate('#add_form',{},{
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