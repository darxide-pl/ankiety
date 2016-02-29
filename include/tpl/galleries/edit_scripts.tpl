<script type="text/javascript">

$(document).ready(function(){
	var validate = new FormValidate('#update_form',{},{
		empty: {
			check: 'empty',
			checkonblur: true
		}
	});
	
	//CKEDITOR.config.height = 350;
	CKEDITOR.config.filebrowserBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=file' ?>';
	CKEDITOR.config.filebrowserImageBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=image' ?>';
	CKEDITOR.config.filebrowserFlashBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=flash' ?>';

	var editor1 = CKEDITOR.replace( 'description', {
		height: 250
	});

});

//-->
</script>

<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.js"></script>
<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.flash.js"></script>
<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.html4.js"></script>
<script type="text/javascript" src="<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.html5.js"></script>

<script type="text/javascript">

$(document).ready(function(){

	$('#colors-list').delegate('.image .thumbnail .close','click',function(e){
		e.preventDefault();
		var $this = $(this).closest('.image');
		var id = $this.data('id');

		if (confirm('Usunąć zdjęcie?')) {
			$.post('?page_action=<?php echo f_eas('Galleries|remove_image') ?>',{id:id,type:'main'},function(d){
				$this.fadeOut(400,function(){$(this).remove();});
			});
		}
	});

	$('#colors-list').sortable({});
});

/*
 * Color images
 */

var uploader3 = new plupload.Uploader({
	runtimes : 'html5,html4,flash',
	browse_button : 'pickfiles3',
	container: 'uploader3',
	max_file_size : '10mb',
	chunk_size : '100kb',
	unique_names : true,
	multi_selection: true,
	multipart: true,
	url : '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Galleries|upload_image'),'id'=>$object->get('id'),'type'=>'color','sid'=>session_id())) ?>',
	flash_swf_url : '<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.flash.swf',
	preinit : {
		UploadFile: function(up, file) {
			up.settings.multipart_params = {original_name : file.name};
		}
	}
});
uploader3.bind('Init', function(up, params) {
	$('#upload-unavailable3').remove();
	$('#filelist2').hide();
});
uploader3.init();
uploader3.bind('FilesAdded', function(up, files) {
	for (var i in files) {
		$('#filelist3').show().append('<div id="' + files[i].id + '" class="uploadQueueItem">' + files[i].name + ' (' + plupload.formatSize(files[i].size) + ')<div class="uploadProgress"><div class="uploadProgressBar" style="width: 0%;"></div></div></div>');
	}
	uploader3.start();
});
uploader3.bind('FileUploaded',function(up, file, info) {

	var r = JSON.parse(info.response);

	if (r.error) {
		alert(r.error.message);
	}

	$('#colors-list').append(
		'<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 image" data-id="'+r.id+'">'
			+'<div class="thumbnail">'
				+'<span class="close">&times;</span>'
				+'<a target="_blank" href="'+r.path+'">'
					+'<img src="'+r.path+'" alt="" />'
				+'</a>'
				+'<input type="text" name="color['+r.id+'][title]" class="form-control input-sm" value="'+r.title+'" />'
			+'</div>'
		+'</div>');

	$('#'+file.id).slideUp(400,function(){
		$(this).remove();
	});
});
uploader3.bind('UploadProgress', function(up, file) {
	$('#'+file.id+' .uploadProgress .uploadProgressBar').css('width', file.percent + "%");
	if (file.percent > 99) {
		$('#'+file.id).slideUp(400,function(){
			$(this).remove();
		});
	}
});
uploader3.bind('UploadComplete', function(up, files) {
	$('#filelist3').slideUp();
});

</script>