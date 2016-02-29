<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			Edycja produktu
			
			<?php if ($prev): ?>
			<a href="<?php echo $this->link->Build(array($this->name,$this->view,'oid'=>$prev)) ?>" class="text-info"><i class="glyphicon glyphicon-chevron-left"></i></a>
			<?php endif; ?>
			
			<?php if ($next): ?>
			<a href="<?php echo $this->link->Build(array($this->name,$this->view,'oid'=>$next)) ?>" class="text-info"><i class="glyphicon glyphicon-chevron-right"></i></a>
			<?php endif; ?>
			
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		
		<div class="panel-body">
			
			<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
				  class="form-horizontal" method="post" id="update_form" name="update_form">

				<input type="hidden" name="page_action" value="<?php echo f_eas('Products|save') ?>" />
				<input type="hidden" name="id" value="<?php echo $object->get('id') ?>" />

				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Nazwa</label>
					<div class="col-sm-9">
						<input type="text" name="name" id="name" value="<?php echo f_escape($object->get('name')) ?>" class="form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="category_id">Grupa</label>
					<div class="col-sm-9">
						<select name="category_id" class="form-control v-empty" id="category_id">
							<?php echo Html::SelectOptions($categories,$object->get('category_id')) ?>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="price">Cena brutto</label>
					<div class="col-sm-9">
						<input type="text" name="price" id="price" value="<?php echo f_clear_price($object->get('price')) ?>" class="form-control" />
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<label class="radio-inline">
							<input type="radio" name="active" value="1" checked="checked" /> Aktywne
						</label>
						<label class="radio-inline">
							<input type="radio" name="active" value="0" <?php echo $object->get('active') ? '' : 'checked="checked"' ?> /> Niektywne
						</label>
					</div>
				</div>
				
				<!-- Nav tabs -->
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab-description" data-toggle="tab">Opis </a></li>
					<li><a href="#tab-short" data-toggle="tab">Opis krótki</a></li>
					<li><a href="#tab-images" data-toggle="tab">Zdjęcia</a></li>
					<li><a href="#tab-movies" data-toggle="tab">Filmy</a></li>
					<li><a href="#tab-manual" data-toggle="tab">Konfiguracja</a></li>
					<li><a href="#tab-attributes" data-toggle="tab">Parametry</a></li>
					<li><a href="#tab-accessories" data-toggle="tab">Akcesoria <span class="badge"><?php echo sizeof($related) > 0 ? sizeof($related) : '' ?></span></a></li>
				  
				</ul>
				
				<!-- Tab panes -->
				<div class="tab-content">
					
					<div class="tab-pane" id="tab-images">

						<div id="uploader2" class="form-group">
							<div class="col-sm-3 text-right">
								<button id="pickfiles2" class="btn btn-default"><i class="glyphicon glyphicon-upload"></i> Zdjęcia produktu<br />1200x800 px</button>
								<div id="filelist2" class="uploadQueue"> 
									<div id="upload-unavailable2">W twojej przeglądarce brak obsługi Gears, HTML5, HTML 4, Flash oraz Silverlight.</div>
								</div>
							</div>
							<div class="col-sm-9 files-list row" id="images-list">
								<?php if ($images): foreach ($images as $v): ?>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 image" data-id="<?php echo $v['id'] ?>">
									<a class="thumbnail" target="_blank" title="<?php echo f_escape($v['title']) ?>" href="<?php echo BASE_DIR.'/upload/products/'.$object->get('id').'/'.$v['filename'] ?>">
										<span class="close">&times;</span>
										<img src="<?php echo BASE_DIR.'/upload/products/'.$object->get('id').'/'.$v['filename'] ?>" alt="" />
										<input type="hidden" name="main[<?php echo $v['id'] ?>][title]" value="<?php echo f_escape($v['title']) ?>" />
									</a>
								</div>
								<?php endforeach; else: ?>
								<?php endif; ?>
							</div>
						</div>
						
					</div><!-- #tab-images -->
					
					<div class="tab-pane" id="tab-movies">
						
						<div id="movies-list">
							<!-- List of existing movies -->
							<?php if ($movies): foreach ($movies as $aid => $a): ?>
							<div class="form-group exists">
								<label class="col-xs-6">
									<input type="text" name="mov[<?php echo $aid ?>][title]" value="<?php echo f_escape($a['title']) ?>" class="form-control" placeholder="Tytuł filmu" />
								</label>
								<div class="col-xs-6">
									<input type="text" name="mov[<?php echo $aid ?>][url]" value="<?php echo $a['url'] ?>" class="form-control" data-id="<?php echo $aid ?>" placeholder="Link do filmu" />
								</div>
							</div>
							<?php endforeach; endif; ?>

							<!-- List of new movies -->
						</div>

						<div class="form-group">
							<div class="col-sm-6" style="opacity:0.5">
								<div class="input-group" id="btn-add-movie">
									<span class="input-group-btn">
										<a href="#" class="btn btn-default btn-remove-movie"><i class="glyphicon glyphicon-plus"></i></a>
									</span>
									<input type="text" placeholder="Dodaj nowy film" class="form-control" />
								</div>
							</div>
						</div>
						
					</div><!-- #tab-movies -->
					
					<div class="tab-pane" id="tab-short">
						<textarea id="short" name="short"><?php echo $object->get('short') ?></textarea>
					</div><!-- #tab-short -->
					
					<div class="tab-pane active" id="tab-description">
						<textarea id="description" name="description"><?php echo $object->get('description') ?></textarea>
					</div><!-- #tab-description -->
					
					<div class="tab-pane" id="tab-functions">
						<textarea id="functions" name="functions"><?php echo $object->get('functions') ?></textarea>
					</div><!-- #tab-functions -->
					
					<div class="tab-pane" id="tab-manual">
						<textarea id="manual" name="manual"><?php echo $object->get('manual') ?></textarea>
					</div><!-- #tab-manual -->
					
					<div class="tab-pane" id="tab-attributes">
						
						<input type="hidden" name="save_positions" value="0" />

						<div id="attributes-list">
							
							<!-- List of existing attributes -->
							<?php if ($attributes): foreach ($attributes as $aid => $a): ?>
							<div class="form-group exists">
								<input type="hidden" name="pos[]" value="<?php echo $aid ?>" />
								<label class="col-sm-3">
									<div class="input-group">
										<span class="input-group-btn"><a href="" class="btn btn-default"><i class="glyphicon glyphicon-move"></i></a></span>
										<input type="text" name="at[<?php echo $aid ?>][name]" value="<?php echo f_escape($a['name']) ?>" class="form-control" placeholder="Atrybut" />
										<span class="input-group-addon">
											<input type="checkbox" name="at[<?php echo $aid ?>][allow_copy]" value="1" <?php echo $a['allow_copy'] ? 'checked="checked"' : '' ?> />
										</span>
									</div>
								</label>
								<div class="col-sm-9">
									<input type="text" name="at[<?php echo $aid ?>][value]" value="<?php echo isset($attributes_values[$aid]) ? f_escape($attributes_values[$aid]) : '' ?>" class="form-control typeahead-attribute" data-id="<?php echo $aid ?>" placeholder="Wartość" />
								</div>
							</div>
							<?php endforeach; endif; ?>

							<!-- List of new attributes -->
						</div>

						<div class="form-group">
							<div class="col-sm-9 col-sm-offset-3" style="opacity:0.5">
								<div class="input-group" id="btn-add-attribute">
									<span class="input-group-btn">
										<a href="#" class="btn btn-default btn-remove-attribute"><i class="glyphicon glyphicon-plus"></i></a>
									</span>
									<input type="text" placeholder="Dodaj nowy atrybut" class="form-control" />
								</div>
							</div>
						</div>
					</div><!-- #tab-attributes -->
					
					<div class="tab-pane" id="tab-accessories">
						
						<?php if ($accessories): ?>
						<div class="row">
							<?php foreach ($accessories as $a): ?>
							<div class="col-xs-6 col-sm-4" style="margin-bottom: 10px;">
								<div class="checkbox thumbnail text-center"><label>
										<img src="<?php echo BASE_DIR ?>/upload/products/<?php echo $a['id'] ?>/<?php echo $a['image_filename'] ?>" alt="" /><br />
										<input type="checkbox" name="accessories[]" value="<?php echo $a['id'] ?>" <?php echo isset($related[$a['id']]) ? 'checked="checked"' : '' ?> /> <?php echo $a['name'] ?></label></div>
							</div>
							<?php endforeach; ?>
						</div>
						<?php endif ?>
						
						
					</div><!-- #tab-accesories -->
				</div>

				<div class="form-group">
					<div class="col-sm-12">
						<input class="btn btn-primary" type="submit" value="Zapisz zmiany" />
						lub
						<a href="<?php echo $this->link->Build(array($this->name)) ?>">Porzuć zmiany i wróć do listy</a>
						<a class="confirm pull-right btn btn-default" title="Skopiować urządzenie?" href="<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Products|copy'),'id'=>$object->get('id'),)) ?>"><i class="glyphicon glyphicon-transfer"></i> &nbsp; Skopiuj produkt</a>
					</div>
				</div>

			</form>
		</div><!-- .panel-body -->
		
		<div class="panel-footer">
			<i class="glyphicon glyphicon-time"></i> <?php echo $object->get('update_date') > 0 ? $object->get('update_date') : $object->get('add_date') ?>
			
			<i class="glyphicon glyphicon-user"></i> <?php echo $object->get('update_user') ?>
		</div><!-- .panel-footer -->
		
	</div><!-- .panel -->
</div><!-- .container -->

<?php include DIR_INC_TPL.'/products/edit_scripts.tpl' ?>