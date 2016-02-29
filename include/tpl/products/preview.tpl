
<div class="panel panel-primary">

	<div class="panel-heading">
		<i class="glyphicon glyphicon-user"></i> &nbsp; Podgląd urządenia
		<a href="#" class="close" data-dismiss="modal" aria-hidden="true"><i class="glyphicon glyphicon-remove"></i></a>
	</div>
	<div class="panel-body">

		<form class="form-horizontal" method="post" id="update_form" name="update_form">

			<div class="form-group">
				<label class="control-label col-sm-5" for="serial">ID Urządzenia</label>
				<div class="col-sm-7">
					<p class="form-control-static"><?php echo f_escape($object->get('serial')) ?></p>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-5" for="name">Nazwa</label>
				<div class="col-sm-7">
					<p class="form-control-static"><?php echo f_escape($object->get('name')) ?></p>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-5" for="category_id">Grupa</label>
				<div class="col-sm-7">
					<p class="form-control-static"><?php echo $categories[$object->get('category_id')] ?></p>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-5" for="company_name">Firma</label>
				<div class="col-sm-7">
					<p class="form-control-static"><?php echo $customers[$object->get('customer_id')] ?></p>
				</div>
			</div>
			
			<div class="form-group">
				<label class="control-label col-sm-5" for="teamviewer_id">TeamViewer ID</label>
				<div class="col-sm-7">
					<p class="form-control-static"><?php echo f_escape($object->get('teamviewer_id')) ?></p>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-7 col-sm-offset-5">
					<p class="form-control-static"><?php echo $object->get('active') ? '<span class="text-success">Aktywne</span>' : '<span class="text-danger">Nieaktywne</span>' ?></p>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-5" for="description">Opis</label>
				<div class="col-sm-7">
					<p class="form-control-static"><?php echo $object->get('description') ?></p>
				</div>
			</div>

			<div id="attributes-list">
				<?php if ($attributes): foreach ($attributes as $aid => $aname): ?>
				<div class="form-group exists">
					<input type="hidden" name="pos[]" value="<?php echo $aid ?>" />
					<label class="col-sm-5 control-label"><?php echo $aname ?></label>
					<div class="col-sm-7">
						<p class="form-control-static"><?php echo isset($attributes_values[$aid]) ? $attributes_values[$aid] : '<span class="text-muted">-</span>' ?></p>
					</div>
				</div>
				<?php endforeach; endif; ?>
			</div>

		</form>
	</div>
	
	<div class="panel-footer">
			
		<i class="glyphicon glyphicon-time"></i> <?php echo $object->get('update_date') > 0 ? $object->get('update_date') : $object->get('add_date') ?>
		<i class="glyphicon glyphicon-user"></i> <?php echo $object->get('update_user') ?>

	</div><!-- .panel-footer -->
</div>