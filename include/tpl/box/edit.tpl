<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			Edycja boksu
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">
	
			<form action="" method="post" class="form-horizontal" id="submit-form">

				<input type="hidden" name="page_action" id="page-action" value="<?php echo f_eas('Box|'.($object->get('id')?'update':'add')) ?>" />
				<input type="hidden" name="id" value="<?php echo (int) $object->get('id') ?>" />

				<div class="form-group">
					<label class="col-xs-3 control-label">Tytuł</label>
					<div class="col-xs-9">
						<input type="text" name="title" class="form-control" value="<?php echo f_escape($object->get('title')) ?>" placeholder="Nagłówek boksu" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">Adres URL</label>
					<div class="col-xs-9">
						<input type="text" name="url" class="form-control" value="<?php echo f_escape($object->get('url')) ?>" placeholder="" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">Typ boksu</label>
					<div class="col-xs-9">
						<select name="type" class="form-control">
							<?php echo Html::SelectOptions(array(''=>'Ze zdjęciem','news'=>'Lista 5 aktualności'),$object->get('type')) ?>
						</select>
					</div>
				</div>

				<div class="image-controls" <?php echo $object->get('type') == '' ? '' : 'style="display: none;"' ?>>
					
					<div class="form-group">
						<label class="col-xs-3 control-label">Zdjęcie</label>
						<div class="col-sm-9">
							<div class="img-thumbnail" id="box-image">
								<?php if ($object->get('image_filename')): ?>
								<img src="<?php echo DIR_UPLOAD_ABSOLUTE ?>/box/<?php echo $object->get('image_filename') ?>" class="img-responsive" alt="" title="" />
								<?php endif ?>
							</div>
						</div>
					</div>

					<div id="uploader1" class="form-group">
						<div class="col-sm-9 col-sm-offset-3">
							<button id="pickfiles1" class="btn first last">Wybierz zdjęcie 300x300 px</button>
							lub <b id="drop-image-here">upuść tutaj</b>

							<div id="filelist1" class="uploadQueue"> 
								<div id="upload-unavailable1">W twojej przeglądarce prak obsługi Gears, HTML5, HTML 4, Flash oraz Silverlight.</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">Opis</label>
					<div class="col-xs-9">
						<textarea name="text" class="form-control"><?php echo ($object->get('text')) ?></textarea>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">Publikuj</label>
					<div class="col-sm-9"><select name="publish" class="form-control"><?php echo Html::SelectOptions(array(1=>'Publikuj',0=>'Nie publikuj'),(int)$object->get('publish')) ?></select></div>
				</div>

				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<input type="submit" class="btn btn-primary" value="Zapisz" />
						lub <a href="<?php echo $this->link->Build(array($this->name,'index','parent_id'=>$object->get('parent_id'))) ?>">Anuluj</a>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">Wyświetl na stronach</label>
					
					<div class="col-sm-9">
						<?php if ($pages): foreach ($pages as $v): ?>
						<div class="checkbox">
							<label style="margin-left: <?php echo $v->get('list.level') * 25 ?>px;">
								<input type="checkbox" <?php echo isset($page_box[$v->get('id')]) ? 'checked' : '' ?> <?php echo $v->get('homepage') || $v->get('fullwidth') ? 'style="visibility:hidden;"' : '' ?> name="p[]" value="<?php echo $v->get('id') ?>" /> <?php echo $v->get('title') ?>
							</label>
						</div>
						<?php endforeach; endif; ?>
						<div class="checkbox">
							<label>
								<input type="checkbox" <?php echo isset($page_box['-1']) ? 'checked' : '' ?> name="p[]" value="-1" /> <b>W stopce strony</b>
							</label>
						</div>
					</div>
				</div>

			</form>
		</div><!-- .panel-body -->
		
		<div class="panel-footer">
			<i class="glyphicon glyphicon-time"></i> <?php echo $object->get('add_date') ?>
			
			<?php if ($user): ?>
			<i class="glyphicon glyphicon-user"></i> <?php echo $user->get('name').' '.$user->get('lastname') ?>
			<?php endif; ?>
			
		</div><!-- .panel-footer -->
		
	</div><!-- .panel -->
</div><!-- .container -->

<?php if ($lock): ?>
<script type="text/javascript">
function lock_refresh() {
	$.get('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('System_Locks|lock'),'type'=>'box','object_id'=>$object->get('id'))) ?>',{},function(data){
		
	},'json');
}
$(document).ready(function(){
	
	$('select[name="type"]').change(function(){
		if ($(this).val() == '') {
			$('.image-controls').show();
		} else {
			$('.image-controls').hide();
		}
	});
	
	setInterval('lock_refresh()',<?php echo Model_System_Lock::LOCK_RATE * 1000 ?>);
});
</script>
<?php endif ?>

<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.js"></script>
<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.flash.js"></script>
<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.html4.js"></script>
<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.html5.js"></script>

<script type="text/javascript">
	var uploader = new plupload.Uploader({
		runtimes : 'html5,html4,flash',
		browse_button : 'pickfiles1',
		container: 'uploader1',
		max_file_size : '30mb',
		chunk_size : '50kb',
		unique_names : true,
		drop_element: 'drop-image-here',
		multi_selection: false,
		multipart: true,
		url : '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Box|upload_image'),'sid'=>session_id(),'id'=>$object->GetID())) ?>',
		flash_swf_url : '<?php echo BASE_DIR ?>/js/plupload/js/plupload.flash.swf',
		filters : [{title : "Zdjęcia", extensions : "jpg,png,gif,jpeg"}]
	});

	uploader.bind('Init', function(up, params) {
		$('#upload-unavailable1').remove();
		$('#filelist1').hide();
	});

	uploader.init();

	uploader.bind('FilesAdded', function(up, files) {
		for (var i in files) {
			$('#filelist1').show().append('<div id="' + files[i].id + '" class="uploadQueueItem">' + files[i].name + ' (' + plupload.formatSize(files[i].size) + ')<div class="uploadProgress"><div class="uploadProgressBar" style="width: 0%;"></div></div></div>');
		}
		uploader.start();
	});

	uploader.bind('FileUploaded',function(up, file, info) {
		
		var a = info.response;
		var date = new Date();
		
		// Called when a file has finished uploading
		$('#box-image').html('<img src="'+a+'?'+date.getTime()+'" alt="" class="img-polaroid" />');

		$('#'+file.id).slideUp(400,function(){
			$(this).remove();
		});
	});

	uploader.bind('UploadProgress', function(up, file) {

		$('#'+file.id+' .uploadProgress .uploadProgressBar').css('width', file.percent + "%");
		
		if (file.percent > 99) {
			$('#'+file.id).slideUp(400,function(){
				$(this).remove();
			})
		}
	});

	uploader.bind('UploadComplete', function(up, files) {
		$('#filelist1').slideUp();
	});
	
</script>