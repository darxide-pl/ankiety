<?php if (isset(Bootstrap::$pages[0][0])): ?>
<nav class="col-md-3 col-md-pull-9 sidebar">
	<ul class="nav nav-list nav-list-top">
		<?php foreach (Bootstrap::$pages[0][0] as $item): ?>
		<li <?php echo $item['id'] == $object->get('id') || in_array($item['id'], $parents_ids_list) ? 'class="active"' : '' ?>>
			<a href="<?php echo Model_Page::Build_Url($item) ?>"><?php echo f_strtoupper($item['title']) ?></a>
			<?php if (in_array($item['id'], $parents_ids_list) == true && isset(Bootstrap::$pages[0][$item['id']])): ?>
			<ul class="nav nav-list nav-list-sub">
				<?php foreach (Bootstrap::$pages[0][$item['id']] as $subitem): ?>
				<li <?php echo $subitem['id'] == $object->get('id') ? 'class="active"' : '' ?>>
					<a href="<?php echo Model_Page::Build_Url($subitem) ?>">
						<?php echo f_strtoupper($subitem['title']) ?>
					</a>
				</li>
				<?php endforeach; ?> 
			</ul>
			<?php endif; ?>
		</li>
		<?php endforeach; ?>
	</ul>
</nav>
<?php endif; ?>