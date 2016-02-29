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
			<div id="cart">
				<div class="tableScrollWrapper">
					<table cellpadding="0" cellspacing="0" class="cartProductsTable">
						<th>Produkty dodane do koszyka <img src="<?php echo BASE_DIR ?>/images/icon-shop-cart-top.png" alt=""></th>
						<table cellpadding="0" cellspacing="0" class="tableProductTop">
							<tr>
								<td width="40%">Produkt</td>
								<td width="13%">Wysyłka</td>
								<td width="13%">Ilość</td>
								<td width="13%">Cena</td>
								<td width="13%">Wartość</td>
								<td width="9%">Akcje</td>
							</tr>
						</table>
						<table cellpadding="0" cellspacing="0" class="tableProduct">
							<?php if ($basket->getItems()): foreach ($basket->getItems() as $k => $item): ?>
							<tr>
								<td width="10%">
									<?php if ($item->get('image_filename')): ?>
									<figure><img src="<?php echo BASE_DIR.'/upload/products/'.$item->get('product_id').'/'.$item->get('image_filename') ?>" alt=""></figure>
									<?php endif; ?>
								</td>
								<td width="30%" class="nameProductTable"><a href="<?php echo Model_Product::Build_Url($item) ?>"><?php echo $item->get('name') ?></a></td>
								<td width="13%">24 godziny</td>
								<td width="13%"><input type="text" value="<?php echo (int)$item->get('amount') ?>" class="amountProduct" data-before="<?php echo (int)$item->get('amount') ?>" data-id="<?php echo $item->get('id') ?>"> szt.</td>
								<td width="13%"><?php echo $item->get('price') ?> zł <br> brutto</td>
								<td width="13%"><?php echo $item->getSumBrutto() ?> zł <br> brutto</td>
								<td width="9%"><a href="?page_action=<?php echo f_eas('Basket|remove_item') ?>&amp;item_id=<?php echo $item->get('id') ?>"><img src="<?php echo BASE_DIR ?>/images/icon-delete-product.png" alt=""></a></td>
							</tr>
							<?php endforeach; else: ?>
							<tr>
								<td colspan="9999" class="nameProductTable" style="padding: 15px"><?php echo $this->t('brak produktów w koszyku','Aktualnie nie posiadaż żadnego produktu w koszyku.') ?></td>
							</tr>
							<?php endif; ?>

						</table>
						<table cellpadding="0" cellspacing="0" class="coastProduct">
							<tr>
								<td>Razem: <strong class="blueText"><?php echo $basket->getSumBrutto() ?> zł</strong></td>
							</tr>
						</table>
					</table>
				</div>
				<div class="tableScrollWrapper">
					<table cellpadding="0" cellspacing="0" class="deliveryTable">
						<tr>
							<th>Dostawa</th>
						</tr>
						
						<table cellpadding="0" cellspacing="0" class="optionTable">
							
							<?php if ($postages): foreach ($postages as $v): ?>
							<tr>
								<td width="80%">
									<label>
										<input name="delivery" type="radio" class="radio" value="<?php echo $v->get('id') ?>" <?php echo $this->get('basket_postage_id') == $v->get('id') ? 'checked' : '' ?> />
										<span class="selectTitle"><?php echo $v->get('name') ?></span> <br>
										<?php echo $v->get('description') ?>
									</label>
								</td>
								<td width="20%" style="text-align:right;font-size:14px;">Koszt: <strong><?php echo f_clear_price($v->get('price')) ?> zł</strong></td>
							</tr>
							<?php endforeach; else: ?>
							<tr><td colspan="9999"><h3><?php echo $this->t('brak form dostawy','Konfiguracja sklepu nie została ukończona, brakuje form dostawy.') ?></h3></td></tr>
							<?php endif; ?>
						</table>
					</table>
				</div>
				<div class="tableScrollWrapper">
					<table cellpadding="0" cellspacing="0" class="deliveryTable">
						<tr>
							<th>Płatność</th>
						</tr>
						<table cellpadding="0" cellspacing="0" class="optionTable">
							
							<?php if ($payments): foreach ($payments as $v): ?>
							<tr>
								<td>
									<label>
										<input name="payment" type="radio" class="radio" value="<?php echo $v->get('id') ?>" />
										<span class="selectTitle"><?php echo $v->get('name') ?></span> <br>
										<?php echo $v->get('description') ?>
									</label>
								</td>
							</tr>
							<?php endforeach; elseif(!$this->get('basket_postage_id')): ?>
							<tr><td colspan="9999"><h3><?php echo $this->t('wybierz formę dostawy','Najpierw proszę wybrać formę dostawy.') ?></h3></td></tr>
							<?php else: ?>
							<tr><td colspan="9999"><h3><?php echo $this->t('brak form dostawy','Konfiguracja sklepu nie została ukończona, brakuje form dostawy.') ?></h3></td></tr>
							<?php endif; ?>
							
						</table>
					</table>
				</div>
				<div class="tableScrollWrapper">
					<table cellpadding="0" cellspacing="0" class="summaryCost">
						<tr>
							<td>Do zapłaty: <strong class="blueText"><?php echo $basket->getSumBrutto() + ($postage ? $postage->get('price') : 0) ?> zł</strong></td>
						</tr>
					</table>
				</div>
				<div class="shopCartActions">
					<button class="btn darkBtn toLeft" onclick="location.href='<?php echo $this->link->Build(array('sklep')) ?>'"><img src="<?php echo BASE_DIR ?>/images/icon-button-continue.png" alt=""> Kontynuuj zakupy</button>
					<button class="btn toRight">Zamawiam <img src="<?php echo BASE_DIR ?>/images/icon-button-next.png" alt=""></button>
				</div>
			</div>

		</section>
	</div>
</div>