<div id="pdstContent">
	<div class="container">
		<div id="sideBar" class="toLeft">
			<nav class="sideBarMainMenu">
				<ul>
					<?php foreach (Bootstrap::$categories[0] as $c0): ?>
					<li>
						<a href="<?php echo Model_Category::Build_Url($c0) ?>" <?php echo $c0['id'] == $category['id'] || $c0['id'] == $category['parent_id'] ? 'class="active"' : '' ?>><?php echo $c0['name'] ?></a>
						<?php if (!$last_category && ($c0['id'] == $category['id'] || $c0['id'] == $category['parent_id'])): ?>
						<ul>
							<?php foreach ($categories as $c1): ?>
							<li>
								<a href="<?php echo Model_Category::Build_Url($c1) ?>"><?php echo $c1['name'] ?></a>
							</li>
							<?php endforeach; ?>
						</ul>
						<?php endif; ?>
					</li>

					<?php endforeach; ?>
				</ul>
			</nav>
		</div>

		<section id="mainContent" class="toRight"> 
			<div class="subSiteTitle">
				<h4 class="bold"><?php echo $category ? $category['name'] : $this->t('sklep','Sklep') ?></h4>
			</div>
			<div class="neutralTextPdst">
				<?php echo $category['description'] ?>
			</div>
			<?php if ($categories): ?>
			<ul class="subCategoryList">
				<?php foreach ($categories as $c): ?>
				<li>
					<a href="<?php echo Model_Category::Build_Url($c) ?>">
						<figure>
							<img src="<?php echo BASE_DIR ?>/upload/categories/<?php echo $c['image_filename'] ?>" alt="">
							<figcaption>
								<span><?php echo $c['name'] ?></span>
							</figcaption>
						</figure>
					</a>
				</li>
				<?php endforeach; ?>
			</ul>
			<hr>
			<?php endif; ?>
			<div class="sorting">
				Sortuj wg:
				<a href="?order_by=name&amp;order_dir=<?php echo $order_by == 'name' ? ($order_dir == 'ASC' ? 'DESC' : 'ASC') : 'ASC' ?>" class="<?php echo $order_by == 'name' ? 'sortingIcon '.($order_dir == 'ASC' ? 'down' : 'up') : '' ?>">Nazwa produktu</a>
				| <a href="?order_by=price&amp;order_dir=<?php echo $order_by == 'price' ? ($order_dir == 'ASC' ? 'DESC' : 'ASC') : 'ASC' ?>" class="<?php echo $order_by == 'price' ? 'sortingIcon '.($order_dir == 'ASC' ? 'down' : 'up') : '' ?>">Cena</a>
			</div>
			<div class="productsList">
				<?php if ($products): foreach ($products as $p): ?>
				<div class="productOnList">
					<figure>
						<a href="<?php echo Model_Product::Build_Url($p) ?>">
							<?php if ($p['image_filename']): ?>
							<img src="<?php echo BASE_DIR.'/upload/products/'.$p['id'].'/'.$p['image_filename'] ?>" alt="">
							<?php endif; ?>
						</a>
					</figure>
					<section class="productDetails">
						<h3 class="smallerFont">
							<a href="<?php echo Model_Product::Build_Url($p) ?>"><?php echo $p['name'] ?></a>
						</h3>
						<p class="smallerFont">
							<?php echo $p['short'] ?>
						</p>
						<p class="smallerFont">
							Stan magazynowy: <span class="greenText"><strong>dostępny</strong></span>
						</p>
					</section>
					<div class="productPrize toRight">
						<p class="smallerFont">Cena brutto:</p>
						<h2><strong><?php echo $p['price'] ?></strong> PLN</h2>
						<p class="smallerFont">Cena netto: <strong><?php echo f_get_price_netto($p['price']) ?> PLN</strong></p>
						<button class="btn" onclick="location.href='?page_action=<?php echo f_eas('Basket|add') ?>&product_id=<?php echo $p['id'] ?>'"><img src="<?php echo BASE_DIR ?>/images/icon-add-to-cart.png" alt=""> Do koszyka</button>
						<!--figure>
							<img src="images/list-product-producent.jpg" alt="">
						</figure-->
					</div>
				</div>
				<?php endforeach; else: ?>
				<h3><?php echo $this->t('brak produktów w katagorii','W kategorii nie ma żadnego produktu.') ?></h3>
				<?php endif; ?>

				<?php /*ul class="pagination">
					<li class="arrows"><a href="#"><img src="images/pagination-back.png" alt=""></a></li>
					<li class="pageNumber"><a href="#">1</a></li>
					<li class="pageNumber"><a href="#">2</a></li>
					<li class="pageNumber"><a href="#">3</a></li>
					<li class="arrows"><a href="#"><img src="images/pagination-next.png" alt=""></a></li>
				</ul*/ ?>
			</div>
		</section>
	</div>
</div>