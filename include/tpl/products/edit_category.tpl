<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			<i class="glyphicon glyphicon-folder-open"></i> &nbsp; Edycja kategorii
			<a href="<?php echo $this->link->Build(array($this->name,'settings')) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">
			<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
				  class="form-horizontal" method="post" id="update_form" name="update_form">

				<input type="hidden" name="page_action" value="<?php echo f_eas('Products|save_category') ?>" />
				<input type="hidden" name="oid" value="<?php echo $object->get('id') ?>" />

				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Nazwa</label>
					<div class="col-sm-9">
						<input type="text" name="name" id="name" value="<?php echo f_escape($object->get('name')) ?>" class="form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Opis</label>
					<div class="col-sm-9">
						<textarea name="description" rows="5" id="description" class="form-control"><?php echo $object->get('description') ?></textarea>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<div class="img-thumbnail" id="news-image">
							<?php if ($object->get('image_filename')): ?>
							<img src="<?php echo DIR_UPLOAD_ABSOLUTE ?>/categories/<?php echo $object->get('image_filename') ?>" class="img-responsive" alt="" title="" />
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
					<div class="col-sm-9 col-sm-offset-3">
						<input class="btn btn-primary" type="submit" value="Zapisz zmiany" />						
					</div>
				</div>

			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
//<!--//

$(document).ready(function(){
	var validate = new FormValidate('#update_form',{},{
		empty: {
			check: 'empty',
			checkonblur: true
		}
	});
});

//-->
</script>

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
		url : '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Products|upload_category_image'),'sid'=>session_id(),'id'=>$object->GetID())) ?>',
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
