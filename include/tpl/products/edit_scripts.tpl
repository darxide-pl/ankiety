<script type="text/javascript">
function startTypeaheadAttributes() {
	$(".typeahead-attribute").typeahead({
		minLength: 0,
		showHintOnFocus: true,
		source: function (query, process) {
			var input = $(this)[0].$element;
			return $.post('<?php echo $this->link->Build(array('search','attributes')) ?>', {attribute_id: input.data('id'), query: query }, function (data) {
				var search_items = [];
				$.each( data, function( ix, item, list ){
					//add the label to the display array
					search_items.push( item.label );
				});
				return process(search_items);
			},'json');
		}
	}).focus(function(){
		//$(this).lookup();
	});
}

$(document).ready(function(){
	var validate = new FormValidate('#update_form',{},{
		serial: {
			check: 'empty',
			checkonblur: true,
			checkAjax: function(item,o){
				
				var success = true;
				
				$.ajax({
					type: 'POST',
					url: '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Products|check_serial'))) ?>',
					async: false, // VERY IMPORTANT, will prevent to submit form before request end
					data: {serial:$(item).val(),id:<?php echo (int)$object->get('id') ?>},
					success: function(data){
						if (data.error) {
							success = false;
							o.errors ++; // increase error num
							o.methods.error($(item)); // mark field as error
							$(item).next().removeClass('glyphicon-ok').addClass('glyphicon-remove');
							$(item).closest('.form-group').addClass('has-error');
						} else {
							$(item).next().removeClass('glyphicon-remove').addClass('glyphicon-ok');
							$(item).closest('.form-group').addClass('has-success');
						}
					},
					dataType: 'json'
				});

				return success;
			}
		},
		empty: {
			check: 'empty',
			checkonblur: true
		}
	});

	$('#btn-add-attribute').click(function(e){
		e.preventDefault();

		var attribute = 	
			'<div class="form-group">'+
				'<input type="hidden" name="pos[]" value="new" />'+
				'<label class="col-sm-3">'+
					'<div class="input-group">'+
						'<span class="input-group-btn"><a href="" class="btn btn-default"><i class="glyphicon glyphicon-move"></i></a></span>'+
						'<input type="text" name="atname[]" value="" class="form-control" placeholder="Atrybut" />'+
						'<span class="input-group-btn">'+
							'<a href="#" class="btn btn-danger btn-remove-attribute"><i class="glyphicon glyphicon-remove"></i></a>'+
						'</span>'+
					'</div>'+
				'</label>'+
				'<div class="col-sm-9">'+
					'<input type="text" name="atvalue[]" value="" class="form-control" placeholder="Wartość" />'+
				'</div>'+
			'</div>';

		$('#attributes-list').append(attribute);

		$('#attributes-list .form-group:last').find('.form-control:first').focus();

		return false;
	});

	$('#attributes-list').delegate('.btn-remove-attribute','click',function(){
		$(this).closest('.form-group').slideUp(400,function(){
			$(this).remove();
		});
	});

	$('#update_form').delegate('#category_id','change',function(){
		var url = '<?php echo $this->link->Build(array($this->name,'attributes_list','category_id'=>'{cid}','oid'=>(int)$object->get('id'))) ?>';

		$('.typeahead-attribute').typeahead('destroy');

		$.get(url.replace('{cid}',$(this).val()),{},function(html){
			$('#attributes-list .exists').remove();
			$('#attributes-list').prepend(html);

			startTypeaheadAttributes();
		});
	});

	$('#attributes-list').sortable({
		handle: '.glyphicon-move',
		update: function(){
			$('input[name="save_positions"]').val('1');
		}
	});
	
	startTypeaheadAttributes();
	
	$('#btn-add-stroller').click(function(e){
		e.preventDefault();

		var attribute = 	
			'<div class="form-group">'+
				'<input type="hidden" name="stpos[]" value="new" />'+
				'<label class="col-xs-6">'+
					'<div class="input-group">'+
						'<input type="text" name="stbrand[]" value="" class="form-control" placeholder="Marka" />'+
						'<span class="input-group-btn">'+
							'<a href="#" class="btn btn-danger btn-remove-stroller"><i class="glyphicon glyphicon-remove"></i></a>'+
						'</span>'+
					'</div>'+
				'</label>'+
				'<div class="col-xs-6">'+
					'<input type="text" name="stname[]" value="" class="form-control" placeholder="Model" />'+
				'</div>'+
			'</div>';

		$('#strollers-list').append(attribute);

		$('#strollers-list .form-group:last').find('.form-control:first').focus();

		return false;
	});

	$('#strollers-list').delegate('.btn-remove-stroller','click',function(){
		$(this).closest('.form-group').slideUp(400,function(){
			$(this).remove();
		});
	});
	
	$('#btn-add-movie').click(function(e){
		e.preventDefault();

		var attribute = 	
			'<div class="form-group">'+
				'<input type="hidden" name="movpos[]" value="new" />'+
				'<label class="col-xs-6">'+
					'<div class="input-group">'+
						'<input type="text" name="movtitle[]" value="" class="form-control" placeholder="Tytuł filmu" />'+
						'<span class="input-group-btn">'+
							'<a href="#" class="btn btn-danger btn-remove-movie"><i class="glyphicon glyphicon-remove"></i></a>'+
						'</span>'+
					'</div>'+
				'</label>'+
				'<div class="col-xs-6">'+
					'<input type="text" name="movurl[]" value="" class="form-control" placeholder="Link do filmu" />'+
				'</div>'+
			'</div>';

		$('#movies-list').append(attribute);

		$('#movies-list .form-group:last').find('.form-control:first').focus();

		return false;
	});

	$('#movies-list').delegate('.btn-remove-movie','click',function(){
		$(this).closest('.form-group').slideUp(400,function(){
			$(this).remove();
		});
	});
	
	//CKEDITOR.config.height = 350;
	CKEDITOR.config.filebrowserBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=file' ?>';
	CKEDITOR.config.filebrowserImageBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=image' ?>';
	CKEDITOR.config.filebrowserFlashBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=flash' ?>';

	var editor1 = CKEDITOR.replace( 'description', {
		height: 450
	});

	var editor2 = CKEDITOR.replace( 'functions', {
		height: 450
	});
	
	var editor3 = CKEDITOR.replace( 'manual', {
		height: 450
	});
	
	var editor4 = CKEDITOR.replace( 'short', {
		height: 150
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

	$('#images-top-list').delegate('.image .thumbnail .close','click',function(e){
		e.preventDefault();
		var $this = $(this).closest('.image');
		var id = $this.data('id');

		if (confirm('Usunąć zdjęcie?')) {
			$.post('?page_action=<?php echo f_eas('Products|remove_image') ?>',{id:id,type:'top'},function(d){
				$this.fadeOut(400,function(){$(this).remove();});
			});
		}
	});

	$('#images-list').delegate('.image .thumbnail .close','click',function(e){
		e.preventDefault();
		var $this = $(this).closest('.image');
		var id = $this.data('id');

		if (confirm('Usunąć zdjęcie?')) {
			$.post('?page_action=<?php echo f_eas('Products|remove_image') ?>',{id:id,type:'main'},function(d){
				$this.fadeOut(400,function(){$(this).remove();});
			});
		}
	});

	$('#colors-list').delegate('.image .thumbnail .close','click',function(e){
		e.preventDefault();
		var $this = $(this).closest('.image');
		var id = $this.data('id');

		if (confirm('Usunąć zdjęcie?')) {
			$.post('?page_action=<?php echo f_eas('Products|remove_image') ?>',{id:id,type:'main'},function(d){
				$this.fadeOut(400,function(){$(this).remove();});
			});
		}
	});
	
	$('#images-desc-list').delegate('.image .thumbnail .close','click',function(e){
		e.preventDefault();
		var $this = $(this).closest('.image');
		var id = $this.data('id');

		if (confirm('Usunąć zdjęcie?')) {
			$.post('?page_action=<?php echo f_eas('Products|remove_image') ?>',{id:id,type:'main'},function(d){
				$this.fadeOut(400,function(){$(this).remove();});
			});
		}
	});

	$('#images-top-list').sortable({});
	$('#images-list').sortable({});
	$('#colors-list').sortable({});
	$('#images-desc-list').sortable({});
});

/*
 * Main images
 */

var uploader2 = new plupload.Uploader({
	runtimes : 'html5,html4,flash',
	browse_button : 'pickfiles2',
	container: 'uploader2',
	max_file_size : '10mb',
	chunk_size : '100kb',
	unique_names : true,
	multi_selection: true,
	multipart: true,
	url : '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Products|upload_image'),'id'=>$object->get('id'),'type'=>'main','sid'=>session_id())) ?>',
	flash_swf_url : '<?php echo BASE_DIR ?>/assets/js/plupload/js/plupload.flash.swf',
	preinit : {
		UploadFile: function(up, file) {
			up.settings.multipart_params = {original_name : file.name};
		}
	}
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

	var r = JSON.parse(info.response);

	if (r.error) {
		alert(r.error.message);
	}

	$('#images-list').append(
		'<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 image" data-id="'+r.id+'">'
			+'<a class="thumbnail" target="_blank" href="'+r.path+'">'
				+'<span class="close">&times;</span>'
				+'<img src="'+r.path+'" alt="" />'
				+'<input type="hidden" name="main['+r.id+'][title]" value="'+r.title+'" />'
			+'</a>'
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
		});
	}
});
uploader2.bind('UploadComplete', function(up, files) {
	$('#filelist2').slideUp();
});

</script>