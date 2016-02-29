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
			
			<div class="productSheet">
				<figure class="toLeft">
	
					<?php if ($images): ?>
					<img src="<?php echo BASE_DIR.'/upload/products/'.$object->get('id').'/details/'.$images[0]['filename'] ?>" alt="">
					<?php endif; ?>
				</figure>
				<div class="productSheetDetails toRight">
					<!--figure class="logoProducent">
						<img src="images/cisco-logo.png" alt="">
					</figure-->
					<h3 class="smallerFont"><strong><?php echo $object->get('name') ?></strong></h3>
					<h3 class="smallerFont productPrizePC"><strong><?php echo $object->get('price') ?> PLN</strong></h3>         
					<p class="smallerFont">Cena netto: <?php echo f_get_price_netto($object->get('price')) ?> zł</p>
					<p class="smallerFont fontClear">
						Stan magazynowy: <span class="greenText"><strong>dostępny</strong></span><br>
						Kod produktu: <strong>#<?php echo $object->get('id') ?></strong>
					</p>
					<form action="<?php echo $this->link->Build('') ?>?page_action=<?php echo f_eas('Basket|add') ?>&amp;product_id=<?php echo $object->get('id') ?>" method="post">
						<button type="submit" class="btn"><img src="<?php echo BASE_DIR ?>/images/icon-add-to-cart.png" alt=""> Dodaj do koszyka</button>
					</form>
				</div>
			</div>
			<div class="productTabs">
				<ul>
					<li><a id="tabsLink1" href="#">Opis</a></li>
					<li><a id="tabsLink2" href="#">Specyfikacja</a></li>
					<!--li><a id="tabsLink3" href="#">Pliki do pobrania</a></li-->
					<li class="greyTab"><a id="tabsLink4" href="#">Konfiguracja</a></li>
				</ul>
				<div class="tabContent" id="tab1">
					<?php echo $object->get('description') ?>
				</div>
				<div class="tabContent" id="tab2">
					<div class="tableScrollWrapper">
						<table cellpadding="0" cellspacing="0" class="productTable">
							
							<tr>
								<td>Producent</td>
								<td>Cisco</td>
							</tr>
							<?php if ($attributes): foreach ($attributes as $k => $a): ?>
							<tr <?php echo $k%2 ? '' : 'class="whiteTr"' ?>>
								<td><?php echo $a['name'] ?></td>
								<td><?php echo $a['value'] ?></td>
							</tr>
							<?php endforeach; endif; ?>
						</table>
					</div>
				</div>
				<!--div class="tabContent" id="tab3">
					<ul class="downloadFiles">
						<li><a href="#"><img src="images/icon-file.png" alt=""> karta-produktu.pdf</a></li>
						<li><a href="#"><img src="images/icon-file.png" alt=""> specyfikacja-dzialania.doc</a></li>
						<li><a href="#"><img src="images/icon-file.png" alt=""> prezentacja-2d.psd</a></li>
					</ul>
				</div-->
				
				<div class="tabContent" id="tab4">
					<?php echo $object->get('manual') ?>
				</div>
			</div>
			
		</section>
	</div>
</div>