<div class="page-demo">

	<div class="breadcrumb-box">
		<div class="wrapper">
			<?php echo Breadcrumbs::build() ?>
		</div>
	</div>

	<div class="wrapper">

		<div class="text">
			<?php if ($this->auth->checkRight('admin|programers')): ?>
			<div id="editable" style="clear: both; overflow: hidden;">
				<?php echo $object->get('text') ?>
			</div>
			<?php else: ?>
			<?php echo $object->get('text') ?>
			<?php endif; ?>

			<?php if ($this->auth->checkRight('admin|programers')): ?>
			<div class="admin-page-toolbar">
				<a href="#" class="btn btn-success" id="btn-edit-page">Edytuj treść strony</a>
			</div>
			<?php endif; ?>
		</div>

	</div>

	
</div>