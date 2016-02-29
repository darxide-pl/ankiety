<div class="container">
	
	<form action="" method="post">	
		<input type="hidden" name="page_action" value="<?php echo f_eas('Pages_Data|save') ?>" />
		<input type="hidden" name="key" value="<?php echo f_escape($object['key']) ?>" />
		<input type="hidden" name="lang" value="<?php echo f_escape($object['lang']) ?>" />
		<input type="hidden" name="type" value="html" />
		<div class="form-group">
			<label class="control-label">Treść HTML</label>
			<div>
				<textarea name="value" id="value"><?php echo $object['value'] ?></textarea>
			</div>
		</div>
		<input type="submit" class="btn btn-primary" value="Zapisz zmiany" />
		<input type="button" class="btn" value="Anuluj" />
	</form>
	
</div>

<script type="text/javascript">
	
//CKEDITOR.config.height = 350;
CKEDITOR.config.enterMode = CKEDITOR.ENTER_BR;
CKEDITOR.config.filebrowserBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=file' ?>';
CKEDITOR.config.filebrowserImageBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=image' ?>';
CKEDITOR.config.filebrowserFlashBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=flash' ?>';

var editor1 = CKEDITOR.replace( 'value', {
	height: 350
});

</script>