<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			Edycja strony
			<a href="<?php echo $this->link->Build(array($this->name,'index','parent_id'=>$object->get('parent_id'))) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">

			<form action="" method="post"class="form-horizontal" id="submit-form">

				<input type="hidden" name="page_action" id="page-action" value="<?php echo f_eas('Pages|update') ?>" />
				<input type="hidden" name="id" value="<?php echo (int) $object->get('id') ?>" />
				<input type="hidden" name="l" value="<?php echo $object->get('language') ?>" />
				<input type="hidden" name="type" value="<?php echo $object->get('type') ?>" />
				<input type="hidden" name="preview" value="0" id="preview" />
				
				<div class="form-group">
					<div class="col-xs-12">
						<input type="text" name="title" class="form-control input-huge" value="<?php echo f_escape($object->get('title')) ?>" />
					</div>
				</div>

				<div class="form-group">

					<div class="col-sm-4">
						<select name="page_type" class="form-control">
							<?php echo Html::SelectOptions(array('0'=>'Strona lokalna','1'=>'Strona zewnętrzna'),$object->get('page_type')) ?>
						</select>
					</div>
					<div class="col-sm-8 <?php echo $object->get('page_type') == 0 ? '' : 'hidden' ?>" id="alias-field">
						<div class="input-group">
							<span class="input-group-addon">Alias</span>
							<input type="text" name="alias" class="form-control" value="<?php echo f_escape($object->get('alias')) ?>" />
						</div>
					</div>
					<div class="col-sm-8 <?php echo $object->get('page_type') == 1 ? '' : 'hidden' ?>" id="redirect-field">
						<div class="input-group">
							<span class="input-group-addon">Adres URL: (np. http://...)</span>
							<input type="text" name="url" class="form-control" value="<?php echo f_escape($object->get('url')) ?>" />
						</div>
					</div>
				</div>
				
				<div class="row">
					
					<div class="col-md-6">
						
						<div class="form-group">
							<div class="col-xs-12">
								<textarea name="text" id="page-text"><?php echo ($object->get('text')) ?></textarea>
							</div>
						</div>
						
					</div><!-- .col-md-6 -->

					<div class="col-md-6">

						<div class="form-group">
							<label class="col-sm-3 control-label">Publikuj</label>
							<div class="col-sm-9"><select name="publish" class="form-control"><?php echo Html::SelectOptions(array(1=>'Publikuj',0=>'Nie publikuj'),(int)$object->get('publish')) ?></select></div>
						</div>

						<!--div class="form-group">
							<label class="col-sm-3 control-label">Owtórz w</label>
							<div class="col-sm-9"><select name="target" class="form-control"><?php echo Html::SelectOptions(array(0=>'Otwórz w tym samym oknie',1=>'Otwórz w nowej zakładce'),(int)$object->get('target')) ?></select></div>
						</div-->

						<!--div class="form-group">
							<div class="col-sm-9"><select name="access" class="form-control"><?php echo Html::SelectOptions(array(0=>'Dostęp dla wszystkich',1=>'Tylko dla zalogowanych'),(int)$object->get('access')) ?></select></div>
						</div-->

						<div class="form-group">
							<label class="col-sm-3 control-label">Strona nadrzędna</label>
							<div class="col-sm-9"><select name="parent_id" class="form-control">
								<?php echo Html::SelectOptions($pages,(int)$object->get('parent_id')) ?></select></div>
						</div>

						<div class="form-group">
							<div class="col-sm-9 col-sm-offset-3">
								<div class="img-thumbnail" id="news-image">
									<?php if ($object->get('image_filename')): ?>
									<img src="<?php echo DIR_UPLOAD_ABSOLUTE ?>/pages/min/<?php echo $object->get('image_filename') ?>" class="img-responsive" alt="" title="" />
									<?php endif ?>
								</div>
							</div>
						</div>

						<div id="uploader1" class="form-group">
							<div class="col-sm-9 col-sm-offset-3">
								<button id="pickfiles1" class="btn first last" type="button">Wybierz zdjęcie</button>
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
							<label class="col-sm-3 control-label">Słowa kluczowe</label>
							<div class="col-sm-9"><textarea class="form-control" name="meta_keywords"><?php echo ($object->get('meta_keywords')) ?></textarea></div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">Opis strony</label>
							<div class="col-sm-9"><textarea class="form-control" name="meta_description"><?php echo ($object->get('meta_description')) ?></textarea></div>
						</div>

						<?php if ($this->auth->isSuperadmin()): ?>
						<div class="form-group">
							<div class="col-sm-9 col-sm-offset-3">
								<input type="hidden" name="homepage" value="0" />
								<label>
									<input type="checkbox" name="homepage" value="1" <?php echo $object->get('homepage') == 1 ? 'checked' : '' ?> /> Stron główna
								</label>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label">Klucz systemowy</label>
							<div class="col-sm-9"><input type="text" class="form-control" name="system_key" value="<?php echo ($object->get('system_key')) ?>" /></div>
						</div>
						<?php endif ?>

						<div class="form-group">
							<div class="col-sm-9 col-sm-offset-3">
								<input type="submit" class="btn btn-primary" value="Zapisz" />
								lub <a href="<?php echo $this->link->Build(array($this->name,'index','parent_id'=>$object->get('parent_id'))) ?>">Anuluj</a>
								<input type="button" class="btn pull-right btn-success" id="btn-preview" value="Podgląd" />
							</div>
						</div>
						
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

var close_by_submit = false;
var has_changes = <?php echo $new ? 'true' : 'false' ?>;
	
window.addEventListener("beforeunload", function (e) {
	if (close_by_submit === false && has_changes === true) {
		var confirmationMessage = "";
		(e || window.event).returnValue = confirmationMessage;     //Gecko + IE
		return confirmationMessage;                        //Webkit, Safari, Chrome etc.
	}
});

window.addEventListener("unload", function (e) {
	
	if (close_by_submit === false && has_changes === true) {
		<?php if ($new == true): ?>
		$.ajax({
			type: 'POST',
			async: false,
			url: '<?php echo $this->link->Build(array('pages','index','page_action'=>f_eas('Pages|delete'),'id'=>$object->get('id'))) ?>',
			data: ''
		});
		<?php endif; ?>
	}
});

$(document).ready(function(){
	
	$('#submit-form').submit(function(){
		close_by_submit = true;
	});
	
	$('input[type="text"],select').click(function(){
		has_changes = true;
	});
	
	$('textarea').change(function(){
		has_changes = true;
	});

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
		$('#submit-form')
				.attr('target','_blank')
				.attr('action','<?php echo Model_Page::Build_Url($object) ?>').submit();
		
		$('#submit-form').attr('target','').attr('action','');
		$('#page-action').attr('name','page_action');
		$('#preview').val('0');
	});

});
</script>

<script type="text/javascript">

//CKEDITOR.config.height = 350;
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
	$.get('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('System_Locks|lock'),'type'=>'page','object_id'=>$object->get('id'))) ?>',{},function(data){
		
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
		url : '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Pages|upload_image'),'sid'=>session_id(),'id'=>$object->GetID())) ?>',
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
	
</script>