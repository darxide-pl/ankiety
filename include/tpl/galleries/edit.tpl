<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			Edycja galerii fotografii
			
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

				<input type="hidden" name="page_action" value="<?php echo f_eas('Galleries|save') ?>" />
				<input type="hidden" name="id" value="<?php echo $object->get('id') ?>" />

				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Nazwa</label>
					<div class="col-sm-9">
						<input type="text" name="name" id="name" value="<?php echo f_escape($object->get('name')) ?>" class="form-control" />
					</div>
				</div>
				
				<!-- Nav tabs -->
				<ul class="nav nav-tabs">
				  <li><a href="#tab-description" data-toggle="tab">Opis </a></li>				  
				  <li class="active"><a href="#tab-images" data-toggle="tab">Zdjęcia <span class="badge"><?php echo sizeof($images) > 0 ? sizeof($images) : '' ?></span></a></li>
				  
				</ul>
				
				<!-- Tab panes -->
				<div class="tab-content">
					
					<div class="tab-pane " id="tab-description">
						<textarea id="description" name="description"><?php echo $object->get('description') ?></textarea>
					</div><!-- #tab-description -->
					
					<div class="tab-pane active" id="tab-images">
					
						<div id="uploader3" class="form-group">
							<div class="col-sm-3 text-right">
								<button id="pickfiles3" class="btn btn-default"><i class="glyphicon glyphicon-upload"></i> Zdjęcia 1000 x 1000px</button>
								<div id="filelist3" class="uploadQueue"> 
									<div id="upload-unavailable3">W twojej przeglądarce brak obsługi Gears, HTML5, HTML 4, Flash oraz Silverlight.</div>
								</div>
							</div>
							<div class="col-sm-9 files-list row" id="colors-list">
								<?php if ($images): foreach ($images as $v): ?>
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 image" data-id="<?php echo $v['id'] ?>">
									<div class="thumbnail" >
										<span class="close">&times;</span>
										<a target="_blank" title="<?php echo f_escape($v['title']) ?>" href="<?php echo BASE_DIR.'/upload/gallery/'.$object->get('id').'/d1000/'.$v['filename'] ?>">
											<img src="<?php echo BASE_DIR.'/upload/gallery/'.$object->get('id').'/'.$v['filename'] ?>" alt="" />
										</a>
										<input type="text" name="color[<?php echo $v['id'] ?>][title]" class="form-control input-sm" value="<?php echo f_escape($v['title']) ?>" />
									</div>
								</div>
								<?php endforeach; else: ?>
								<?php endif; ?>
							</div>
						</div>
					</div><!-- #tab-images -->

				</div>

				<div class="form-group">
					<div class="col-sm-12">
						<input class="btn btn-primary" type="submit" value="Zapisz zmiany" />
						lub
						<a href="<?php echo $this->link->Build(array($this->name)) ?>">Porzuć zmiany i wróć do listy</a>
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

<?php include DIR_INC_TPL.'/galleries/edit_scripts.tpl' ?>