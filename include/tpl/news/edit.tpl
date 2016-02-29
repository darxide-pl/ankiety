<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			Edycja aktualności
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">
	
			<form action="" method="post" class="form-horizontal" id="submit-form">

				<input type="hidden" name="page_action" id="page-action" value="<?php echo f_eas('News|'.($object->get('id')?'update':'add')) ?>" />
				<input type="hidden" name="id" value="<?php echo (int) $object->get('id') ?>" />
				<input type="hidden" name="l" value="<?php echo $object->get('language') ?>" />
				<input type="hidden" name="preview" value="0" id="preview" />

				<div class="form-group">
					<div class="col-xs-12">
						<input type="text" name="title" class="form-control" value="<?php echo f_escape($object->get('title')) ?>" placeholder="Tytuł artykułu" />
					</div>
				</div>

				<div class="form-group">
					<div class="col-xs-12">
						Wstęp:
						<textarea name="lead" id="page-lead"><?php echo ($object->get('lead')) ?></textarea>
					</div>
				</div>

				<div class="form-group">
					<div class="col-xs-12">
						Treść:
						<textarea name="text" id="page-text"><?php echo ($object->get('text')) ?></textarea>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">Publikuj</label>
					<div class="col-sm-9"><select name="publish" class="form-control"><?php echo Html::SelectOptions(array(1=>'Publikuj',0=>'Nie publikuj'),(int)$object->get('publish')) ?></select></div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">Data</label>
					<div class="col-sm-9"><input type="text" name="add_date" class="form-control datepicker" value="<?php echo Date::onlyDate($object->get('add_date')) ?>" /></div>
				</div>

				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<div class="img-thumbnail" id="news-image">
							<?php if ($object->get('image_filename')): ?>
							<img src="<?php echo DIR_UPLOAD_ABSOLUTE ?>/news/min/<?php echo $object->get('image_filename') ?>" class="img-responsive" alt="" title="" />
							<?php endif ?>
						</div>
					</div>
				</div>

				<div id="uploader1" class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<button id="pickfiles1" class="btn first last">Wybierz zdjęcie</button>
						lub <b id="drop-image-here">upuść tutaj</b>

						<div id="filelist1" class="uploadQueue"> 
							<div id="upload-unavailable1">W twojej przeglądarce prak obsługi Gears, HTML5, HTML 4, Flash oraz Silverlight.</div>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">Tytuł SEO</label>
					<div class="col-sm-9"><input type="text" class="form-control" name="meta_title" value="<?php echo ($object->get('meta_title')) ?>" /></div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">Opis strony</label>
					<div class="col-sm-9"><textarea class="form-control" name="meta_description"><?php echo ($object->get('meta_description')) ?></textarea></div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">Słowa kluczowe</label>
					<div class="col-sm-9"><textarea class="form-control" name="meta_keywords"><?php echo ($object->get('meta_keywords')) ?></textarea></div>
				</div>

				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<input type="submit" class="btn btn-primary" value="Zapisz" />
						lub <a href="<?php echo $this->link->Build(array($this->name,'index','parent_id'=>$object->get('parent_id'))) ?>">Anuluj</a>
						<input type="button" class="btn pull-right btn-success" id="btn-preview" value="Podgląd" />
					</div>
				</div>

			</form>
		</div><!-- .panel-body -->
		
		<div class="panel-footer">
			<i class="glyphicon glyphicon-time"></i> <?php echo $object->get('modify_date') > 0 ? $object->get('modify_date') : $object->get('add_date') ?>
			
			<?php if ($user): ?>
			<i class="glyphicon glyphicon-user"></i> <?php echo $user->get('name').' '.$user->get('lastname') ?>
			<?php endif; ?>
			
		</div><!-- .panel-footer -->
		
	</div><!-- .panel -->
</div><!-- .container -->

<script type="text/javascript">
$(document).ready(function(){
	$('select[name="page_type"]').change(function(e){
		switch($(this).val()) {
			case '0':
				$('#redirect-field').addClass('hidden');
				$('#alias-field').removeClass('hidden');
				break;
			case '1':
			default:
				$('#alias-field').addClass('hidden');
				$('#redirect-field').removeClass('hidden');
		}
	});
	
	$('#btn-preview').click(function(e){

		$('#preview').val('1');
		$('#page-action').attr('name','_page_action');
		$('#submit-form').attr('target','_blank').attr('action','<?php echo $this->link->Build(array($this->name,'edit')) ?>').submit();

		$('#submit-form').attr('target','').attr('action','');
		$('#page-action').attr('name','page_action');
		$('#preview').val('0');
	});
	
	$('.datepicker').datepicker({})
		.bind('paste',function(){
			var $this = $(this);
			setTimeout(function(){
				var val = $this.val();
				if (val.indexOf('.') > 0) {
					var a = val.split('.');
					$this.val(a[2]+'-'+a[1]+'-'+a[0]);
				}
			},0);
			
		});
});

//CKEDITOR.config.height = 350;
//CKEDITOR.config.enterMode = CKEDITOR.ENTER_BR;
CKEDITOR.config.filebrowserBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=file' ?>';
CKEDITOR.config.filebrowserImageBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=image' ?>';
CKEDITOR.config.filebrowserFlashBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=flash' ?>';

var editor1 = CKEDITOR.replace( 'page-text', {
	height: 450
});

var editor1 = CKEDITOR.replace( 'page-lead', {
	height: 130
});

</script>

<?php if ($lock): ?>
<script type="text/javascript">
function lock_refresh() {
	$.get('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('System_Locks|lock'),'type'=>'news','object_id'=>$object->get('id'))) ?>',{},function(data){
		
	},'json');
}
$(document).ready(function(){
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
		url : '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('News|upload_image'),'sid'=>session_id(),'id'=>$object->GetID())) ?>',
		flash_swf_url : '<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.flash.swf',
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
		$('#news-image').html('<img src="'+a+'?'+date.getTime()+'" alt="" class="img-polaroid" />');

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
	
	/**
	 * Gallery Uploader
	 */
	
	var uploader2 = new plupload.Uploader({
		runtimes : 'html5,html4,flash',
		browse_button : 'pickfiles2',
		container: 'uploader2',
		max_file_size : '30mb',
		chunk_size : '50kb',
		unique_names : true,
		drop_element: 'drop-image-here2',
		multi_selection: true,
		multipart: true,
		url : '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Gallery|upload_images'),'sid'=>session_id(),'type'=>'news','id'=>$object->GetID())) ?>',
		flash_swf_url : '<?php echo BASE_DIR ?>/js/plupload/js/plupload.flash.swf',
		filters : [{title : "Zdjęcia", extensions : "jpg,png,gif,jpeg"}]
	});

	uploader2.bind('Init', function(up, params) {
		$('#upload-unavailable2').remove();
		$('#filelist2').hide();
	});

	uploader2.init();

	uploader2.bind('FilesAdded', function(up, files) {
		for (var i in files) {
			$('#filelist2').show().append('<div id="' + files[i].id + '" class="uploadQueueItem">' + files[i].name + ' (' + plupload.formatSize(files[i].size) + ')<div class="uploadProgress"><div class="uploadProgressBar" style="width: 0%;"></div></div></div>');
		}
		uploader2.start();
	});

	uploader2.bind('FileUploaded',function(up, file, info) {
		
		var a = info.response.split(';');
		var date = new Date();
		
		// Called when a file has finished uploading
		$('#gallery').append('<div class="gallery-image-cell">'
							+'<div class="gallery-image">'
								+'<a class="close" data-id="'+a[1]+'">x</a>'
								+'<img src="'+a[0]+'" alt="" /></div>'
							+'<textarea name="gi['+a[1]+'][title]"></textarea>'
						+'</div>');

		$('#'+file.id).slideUp(400,function(){
			$(this).remove();
		});
	});

	uploader2.bind('UploadProgress', function(up, file) {

		$('#'+file.id+' .uploadProgress .uploadProgressBar').css('width', file.percent + "%");
		
		if (file.percent > 99) {
			$('#'+file.id).slideUp(400,function(){
				$(this).remove();
			})
		}
	});

	uploader2.bind('UploadComplete', function(up, files) {
		$('#filelist2').slideUp();
	});
	
	$('#gallery').sortable({
		forceHelperSize: true,
		tolerance: 'cursor',
		helper: "clone",
		update: function(){
			
		}
	});
	$('#gallery .close').live('click',function(e){
		e.preventDefault();
		var $this = $(this).closest('.gallery-image-cell');
		$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Gallery|remove_image'))) ?>',{id:$(this).data('id')},function(){
			$this.fadeOut().remove();
		});
	});
</script>

<style>
.gallery-image-cell {
	float: left; padding: 4px; margin: 0 10px 10px 0; width: 124px; height: 171px; border: 1px solid #ccc; border-radius: 5px;
	background: #fff;
}
.gallery-image {
	height: 130px;
	position: relative;
	text-align: center;
}
.gallery-image-cell textarea {
	font-size: 11px;
	border: none;
	border-top: 1px solid #ccc;
	border-radius: 0;
	padding: 0;
	margin: 0 0 0 -1px;
	width: 100%;
	box-shadow: none;
	height: 40px;
	resize: none;
	line-height: 12px;
}
.gallery-image .close {
	background: #FFF;
    color: #000;
    font-size: 13px;
    line-height: 13px;
    opacity: 0.7;
    padding: 0 3px 3px;
    position: absolute;
    right: 0;
    top: 0;
}
</style>