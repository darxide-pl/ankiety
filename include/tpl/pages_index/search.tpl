<div class="container">
	<div class="row">

		<div class="col-xs-12">
			<?php echo Breadcrumbs::build() ?>
		</div>
		
		<section class="col-md-9 col-md-push-3" style="clear:both;">

			<h1 class="page-title">Wyszukiwanie "<?php echo $this->rv->get('query') ?>" zwróciło <?php echo $paginator->getAmount() ?> wyników</h1>

			<ul class="list-group">

				<?php if ($paginator->getPopulation()): foreach ($paginator->getPopulation() as $o): ?>
				<?php
				
				switch ($o['search_type']):
					case 'news': 
						$url = Model_News::Build_Url($o);
						break;
					case 'category':
						$url = Model_Category::Build_Url($o);
						break;
					case 'page':
						$url = Model_Page::Build_Url($o);
						break;
					case 'store':
						$url = Model_Store::Build_Url($o);
						break;
					default:
						$o ['category_id'] = $o['parent_id'];
						$url = Model_Product::Build_Url($o);
				endswitch;
				
				?>
				<li class="list-group-item">
					<a href="<?php echo $url ?>"><?php echo $o['title'] ?></a>
				</li>
		
				<?php endforeach; endif; ?>

			</ul>

			<?php $paginator->showPaginator(); ?>

		</section>

		<?php include APPLICATION_PATH.'/include/tpl/pages_index/plugins/menu.tpl' ?>

	</div>
</div>