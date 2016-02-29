<!-- Main area: START -->
<div id="main-position">				

	 <div id="main" class="float-break">
		<div class="overflow-fix">
			<div class="content-view-full">
				<div class="class-folder">

					<div class="attribute-title">
						<h1><?php echo $object->get('title') ?></h1>
					</div>

					<div class="attribute-byline float-break">
						<p class="author"></p>
						<p class="date"><?php echo Date::toString($object->get('add_date')) ?></p>
					</div>

					<?php if($object->get('lead')): ?>
					<div class="attribute-short">
						<p><?php echo $object->get('lead') ?></p>
					</div>
					<?php endif; ?>

					<?php if ($object->get('image_filename')): ?>
					<div class="">
						<div class="content-view-embed">
							<div class="class-image">
								<div class="attribute-image">
									<img src="<?php echo BASE_DIR ?>/upload/news/<?php echo $object->get('image_filename') ?>" style="border: 0px; max-width: 100%;" alt="" title="" />
								</div>
							</div>
						</div>
					</div>
					<?php endif ?>

					<div class="attribute-long">
						<?php echo $object->get('text') ?>
					</div>

				</div>

			</div>
		</div>
	</div>
</div>

<hr class="hide" />

<!-- Extra area: START -->
<div id="extrainfo-position">
	<div id="extrainfo" class="float-break">
		<div class="overflow-fix">

			<!-- Extra content: START -->
			<?php $boxes = Model_Box::LoadByPage(250) ?>
			
			<?php if ($boxes): foreach ($boxes as $box): ?>
			<?php echo Model_Box::Display($box) ?>
			<?php endforeach; endif; ?>
			<!-- Extra content: END -->

		</div>
	</div>
</div>
<!-- Extra area: END -->