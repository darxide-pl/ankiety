<div id="content-right">
	<img src="<?php echo BASE_DIR ?>/assets/img/page/box-miasta.png" title="" align="right" />	
	<img src="<?php echo BASE_DIR ?>/assets/img/page/box-miastabg.jpg" title="" align="right" />	
	<img src="<?php echo BASE_DIR ?>/assets/img/page/box-film.jpg" title="" align="right" /> 
</div>

<div id="content-left">

	<div id="titles">
		
		<div class="title" id="title-news">
			<?php /* <a href="<?php echo $this->link->Build('aktualnosci') ?>">zobacz wszystkie &raquo;</a> */ ?>
		</div>
		
	</div>
	
	<h1><?php echo $object->get('title') ?></h1>

	<?php echo $object->get('text') ?>	
	
</div>