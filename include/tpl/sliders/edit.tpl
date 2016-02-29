
<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			Edycja slajdu
			
			<?php if ($prev): ?>
			<a href="<?php echo $this->link->Build(array($this->name,$this->view,'oid'=>$prev)) ?>" class="text-info"><i class="glyphicon glyphicon-chevron-left"></i></a>
			<?php endif; ?>
			
			<?php if ($next): ?>
			<a href="<?php echo $this->link->Build(array($this->name,$this->view,'oid'=>$next)) ?>" class="text-info"><i class="glyphicon glyphicon-chevron-right"></i></a>
			<?php endif; ?>
			
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>


		<div class="panel-body">

			<form action="" method="post" class="form-horizontal" id="submit-form">
			
				<input type="hidden" name="page_action" value="<?php echo f_eas('Sliders|update') ?>" />
				<input type="hidden" name="id" value="<?php echo (int) $object->get('id') ?>" />

				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Tytuł</label>
					<div class="col-sm-9">
						<input type="text" name="name" id="name" value="<?php echo f_escape($object->get('name')) ?>" class="form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<div class="img-thumbnail" id="news-image">
							<?php if ($object->get('image_filename')): ?>
							<img src="<?php echo DIR_UPLOAD_ABSOLUTE ?>/slider/<?php echo $object->get('image_filename') ?>" class="img-responsive" alt="" title="" />
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
					<label class="control-label col-sm-3">Status</label>
					<div class="col-sm-9"><select name="publish" class="form-control"><?php echo Html::SelectOptions(array(1=>'Publikuj',0=>'Nie publikuj'),(int)$object->get('publish')) ?></select></div>
				</div>					
					
				<div class="form-group">
					<label class="control-label col-sm-3">Adres URL</label>
					<div class="col-sm-9"><input type="text" name="url" class="form-control" value="<?php echo f_escape($object->get('url')) ?>" placeholder="" /></div>
				</div>
					
				<div class="form-group">
					<label class="control-label col-sm-3">Treść html</label>
					<div class="col-sm-9"><textarea name="description" id="slider-html" class="form-control" rows="4"><?php echo ($object->get('description')) ?></textarea></div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-12">
						<input class="btn btn-primary" type="submit" value="Zapisz zmiany" />
						lub
						<a href="<?php echo $this->link->Build(array($this->name)) ?>">Porzuć zmiany i wróć do listy</a>
					</div>
				</div>
				
			</form>
		</div>
			
		<div class="panel-footer">
			<i class="glyphicon glyphicon-time"></i> <?php echo $object->get('update_date') > 0 ? $object->get('update_date') : $object->get('add_date') ?>
			
			<i class="glyphicon glyphicon-user"></i> <?php echo $object->get('update_user') ?>
		</div><!-- .panel-footer -->
		
	</div>
	
</div>

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
			url: '<?php echo $this->link->Build(array($this->name,'index','page_action'=>f_eas('Sliders|delete'),'id'=>$object->get('id'))) ?>',
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
</script>

<script type="text/javascript">

//CKEDITOR.config.height = 350;
CKEDITOR.config.filebrowserBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=file' ?>';
CKEDITOR.config.filebrowserImageBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=image' ?>';
CKEDITOR.config.filebrowserFlashBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=flash' ?>';

var editor1 = CKEDITOR.replace( 'slider-html', {
	height: 350
});

</script>

<?php if ($lock): ?>
<script type="text/javascript">
function lock_refresh() {
	$.get('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('System_Locks|lock'),'type'=>'sliders','object_id'=>$object->get('id'))) ?>',{},function(data){
		
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
		url : '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Sliders|upload_image'),'sid'=>session_id(),'id'=>$object->GetID())) ?>',
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
		$('#news-image').html('<img src="'+a+'?'+date.getTime()+'" alt="" class="img-polaroid" style="max-width: 100%;" />');

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