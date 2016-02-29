var ckeditor_opened = false;

function openCKEditor() {

	if (ckeditor_opened) {
		return true;
	}

	$('#editable').attr('contenteditable','true');

	CKEDITOR.config.startupFocus = true;
	
	CKEDITOR.inline( 'editable' );

	$('#btn-edit-page').text('Zapisz zmiany');

	ckeditor_opened = true;
}

function openCKEditor_Small(key) {


	$('#page_data_'+key).attr('contenteditable','true');

	
	
	CKEDITOR.inline( 'page_data_'+key );

	//$('#btn-edit-page').text('Zapisz zmiany');

	//ckeditor_opened = true;
}

function saveCKEditor_Small(key) {

	//this is the foreach loop
	for(var i in CKEDITOR.instances) {
	    /* this returns the names of the textareas/id of the instances. */
	    if (CKEDITOR.instances[i].name == 'page_data_'+key) {
	    	CKEDITOR.instances[i].updateElement();
	    	var data = CKEDITOR.instances[i].getData();
	    }
	}

	
	$.post('?save_data',{language: 'pl', key: key, value: data},function(){
		alert('Zmiany zapisano.');
	});
}

$(document).ready(function(){

	$('#btn-edit-page').click(function(e){
		e.preventDefault();
		
		if (ckeditor_opened == true) {
			e.preventDefault();
			var data = CKEDITOR.instances.editable.getData();
			$.post('?save',{language:'pl',text: data},function(){
				alert('Zmiany zapisano.');
			});
			return false;
		}
		
		openCKEditor();
	});

	$('.btn-pde').click(function(){
		openCKEditor_Small($(this).data('key'));
		$(this).hide()
		$(this).next().show();
	});

	$('.btn-pde-save').click(function(){
		saveCKEditor_Small($(this).data('key'));
	});

});