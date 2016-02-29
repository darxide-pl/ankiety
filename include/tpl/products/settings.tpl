<div class="container">

	<div class="panel panel-primary">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-folder-open"></i> &nbsp; Edycja kategorii
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>

		<div class="panel-body">
			
			<div class="row">
				<form action="" method="post" class="col-sm-6">
					<input type="hidden" name="page_action" value="<?php echo f_eas('Products|update_categories') ?>" />

					<ol class="sortable categories">

						<?php if ($categories[0]): foreach ($categories[0] as $k => $v): ?>
						<li data-id="<?php echo $v['id'] ?>">
							<div class="body">
								<i class="glyphicon glyphicon-move"></i>
								<?php echo $v['name'] ?>

								<span class="badge"><?php echo $v['products'] ? $v['products'] : '' ?></span>

								<div class="pull-right">						
									<a href="<?php echo $this->link->Build(array($this->name,'edit_category','oid'=>$v['id'])) ?>" class="btn btn-xs btn-info">Edytuj</a>
									<a href="<?php echo $this->link->Build(array($this->name,$this->view,'id'=>$v['id'],'page_action' => f_eas('Products|remove_category')))?>"
										title="Usunąć kategorię?" class="confirm btn btn-xs btn-danger"><i class="glyphicon glyphicon-remove"></i>
									</a>
								</div>
							</div>

							<ol><?php if ($categories[$v['id']]):?><?php foreach ($categories[$v['id']] as $v2): ?>
								<li data-id="<?php echo $v2['id'] ?>">
									<div class="body">
										<i class="glyphicon glyphicon-move"></i>
										<?php echo $v2['name'] ?>	

										<span class="badge"><?php echo $v2['products'] ? $v2['products'] : '' ?></span>

										<div class="pull-right">
											<a href="<?php echo $this->link->Build(array($this->name,'edit_category','oid'=>$v2['id'])) ?>" class="btn btn-xs btn-info">Edytuj</a>
											<a href="<?php echo $this->link->Build(array($this->name,$this->view,'id'=>$v2['id'],'page_action' => f_eas('Products|remove_category')))?>"
												title="Usunąć kategorię?" class="confirm btn btn-xs btn-danger"><i class="glyphicon glyphicon-remove"></i>
											</a>
										</div>
									</div>
								</li>
							<?php endforeach;?><?php endif; ?></ol>
						</li>

						<?php endforeach; else: ?>
						<?php endif ?>
					</ol>

				</form>
			</div>
			
			<a href="#myModal" class="btn btn-success" data-toggle="modal" data-modal="#myModal">
				<i class="glyphicon glyphicon-folder-open"></i> &nbsp; Nowa kategoria</a>

		</div>
	</div>
</div>

<div class="modal fade" id="myModal">
	<div class="modal-dialog">

		<div class="panel panel-success">

			<div class="panel-heading">
				<i class="glyphicon glyphicon-folder-open"></i> &nbsp; Nowa kategoria
				<a href="#" class="close" data-dismiss="modal" aria-hidden="true"><i class="glyphicon glyphicon-remove"></i></a>
			</div>
			<div class="panel-body">

				<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
					  class="form-horizontal" method="post"
					  id="add_form" name="add_form">

					<input type="hidden" name="page_action" value="<?php echo f_eas('Products|add_category') ?>" />

					<div class="form-group">
						<label class="control-label col-sm-3" for="name">Nazwa</label>
						<div class="col-sm-9">
							<input type="text" name="name" id="name" value="" class="form-control" />
						</div>
					</div>
					
					<div class="form-group">
						<label class="control-label col-sm-3" for="name">Dział</label>
						<div class="col-sm-9">
							<select name="parent_id" class="form-control">
								<option value="0">bez działu</option>
								<?php if ($categories[0]): foreach ($categories[0] as $c): ?>
								<option value="<?php echo $c['id'] ?>"><?php echo $c['name'] ?></option>
								<?php endforeach; endif; ?>
							</select>
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-9 col-sm-offset-3">
							<input class="btn btn-success" type="submit" value="Zapisz zmiany" />
						</div>
					</div>
				</form>
			</div>
		</div>

	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
$(function() {
	
	$('.btn-submit').click(function(e){
		e.preventDefault();
		$(this).closest('form').submit();
	});
	
	$('.popover-trigger').popover({trigger:'hover'});
	
	var categories = $('.sortable').sortable({
		onDrop: function (item, container, _super) {
		  var data = categories.sortable("serialize").get();

		  var jsonString = JSON.stringify(data, null, ' ');

		  $.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Products|update_categories'))) ?>',{order:jsonString},function(data){
			  
		  });
		  _super(item, container);
		}
	});
/*
	$("#sortable-groups").sortable({
		helper: fixHelper,
		handle: '.glyphicon-move',
		axis: 'y'
	});//.disableSelection();*/
});
</script>