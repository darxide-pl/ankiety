<div class="page">
	
	<h1><?php echo $object->get('name') ?></h1>

	<div class="text">
		<?php echo $object->get('text') ?>
	</div>
	
	<div class="images">
		<?php if ($images): foreach ($images as $v): ?>
		<a href="<?php echo BASE_DIR ?>/upload/gallery/<?php echo $v['gallery_id'] ?>/d1000/<?php echo $v['filename'] ?>" class="image fancybox" rel="gallery[]" title="<?php echo f_escape($v['title']) ?>">
			<img src="<?php echo BASE_DIR ?>/upload/gallery/<?php echo $v['gallery_id'] ?>/<?php echo $v['filename'] ?>" alt="" title="<?php echo f_escape($v['title']) ?>" />
		</a>
		<?php endforeach; endif; ?>
	</div>
	
</div>

<script type="text/javascript">

$().ready(function(){
	$('.fancybox').fancybox();
});
</script>