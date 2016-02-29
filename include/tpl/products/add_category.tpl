<div class="container">
	
	<div class="panel panel-success">
		
		<div class="panel-heading">
			<i class="glyphicon glyphicon-folder-open"></i> &nbsp; Nowa grupa urządzeń
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">

			<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
				  class="form-horizontal" method="post"
				  id="add_form" name="add_form">

				<input type="hidden" name="page_action" value="<?php echo f_eas('Products|add_category') ?>" />

				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Nazwa</label>
					<div class="col-sm-9">
						<input type="text" name="name" id="name" value="<?php echo f_escape($object->get('name')) ?>" class="form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
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
		empty: {
			check: 'empty',
			checkonblur: true
		}
	});
});

//-->
</script>