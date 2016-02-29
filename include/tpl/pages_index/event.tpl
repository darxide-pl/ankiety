
<div class="page">
	
	<h1><?php echo $object->get('name') ?></h1>
	
	<?php $months = f_get_months_to_array(); $days = f_get_days_to_array() ?>
	
	<p>Gdzie: <b><?php echo $object->get('where') ?></b><br />
		Kiedy:<b>
		<?php if ($object->get('to') != $object->get('from') && $object->get('to') > 0): ?>
		od:
			<?php echo $days[(int)Helper_Date::format($object->get('from'),'w')] ?>
		<?php echo (int)Helper_Date::format($object->get('from'),'d') ?>
		<?php echo $months[(int)Helper_Date::format($object->get('from'),'m')] ?>
		do:
		<?php echo $days[(int)Helper_Date::format($object->get('to'),'w')] ?>
		<?php echo (int)Helper_Date::format($object->get('to'),'d') ?>
		<?php echo $months[(int)Helper_Date::format($object->get('to'),'m')] ?>
		<?php else: ?>
		<?php echo $days[(int)Helper_Date::format($object->get('from'),'w')] ?>
		<?php echo (int)Helper_Date::format($object->get('from'),'d') ?>
		<?php echo $months[(int)Helper_Date::format($object->get('from'),'m')] ?>
		<?php endif; ?></b>
	</p>
	
	<div class="text">
		<?php echo $object->get('description') ?>
	</div>
	
	
	<?php if ($gallery_images): ?>
	
	<div class="images">
		<?php  foreach ($gallery_images as $v): ?>
		<a href="<?php echo BASE_DIR ?>/upload/gallery/<?php echo $v['gallery_id'] ?>/d1000/<?php echo $v['filename'] ?>" class="image fancybox" rel="gallery[]" title="<?php echo f_escape($v['title']) ?>">
			<img src="<?php echo BASE_DIR ?>/upload/gallery/<?php echo $v['gallery_id'] ?>/<?php echo $v['filename'] ?>" alt="" title="<?php echo f_escape($v['title']) ?>" />
		</a>
		<?php endforeach; ?>
	</div>
	
	<?php endif; ?>
</div>