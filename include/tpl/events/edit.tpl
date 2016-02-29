<div class="container">
	
	<div class="panel panel-primary">
		
		<div class="panel-heading">
			Edycja wydarzenia
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">
	
			<form action="" method="post" class="form-horizontal" id="submit-form">

				<input type="hidden" name="page_action" id="page-action" value="<?php echo f_eas('Events|'.($object->get('id')?'update':'add')) ?>" />
				<input type="hidden" name="id" value="<?php echo (int) $object->get('id') ?>" />

				<div class="form-group">
					<div class="col-xs-12">
						<input type="text" name="name" class="form-control" value="<?php echo f_escape($object->get('name')) ?>" placeholder="Tytuł wydarzenia" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">Gdzie odbędzie się wydarzenie</label>
					<div class="col-sm-9"><input type="text" name="where" class="form-control" value="<?php echo f_escape($object->get('where')) ?>" placeholder="" /></div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">Data rozpoczęcia</label>
					<div class="col-sm-9"><input type="text" name="from" class="form-control datepicker" value="<?php echo $object->get('from') > 0 ? $object->get('from') : date('Y-m-d')  ?>" /></div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">Data zakończenia</label>
					<div class="col-sm-9"><input type="text" name="to" class="form-control datepicker" value="<?php echo $object->get('to') > 0 ? $object->get('to') : date('Y-m-d')  ?>" /></div>
				</div>

				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Galeria fotografii</label>
					<div class="col-sm-9">
						<select name="gallery_id" class="form-control">
							<option value="0">- bez galerii -</option>
							<?php echo Html::SelectOptions($galleries, $object->get('gallery_id')) ?>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">Publikuj</label>
					<div class="col-sm-9"><select name="publish" class="form-control"><?php echo Html::SelectOptions(array(1=>'Publikuj',0=>'Nie publikuj'),(int)$object->get('publish')) ?></select></div>
				</div>
				
				<div class="form-group">
					<div class="col-xs-12">
						Opis:
						<textarea name="description" id="page-text"><?php echo ($object->get('description')) ?></textarea>
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
						lub <a href="<?php echo $this->link->Build(array($this->name,'index')) ?>">Anuluj</a>
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

	$('.datepicker').datetimepicker({
		pickTime: false
	});
});

CKEDITOR.config.filebrowserBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=file' ?>';
CKEDITOR.config.filebrowserImageBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=image' ?>';
CKEDITOR.config.filebrowserFlashBrowseUrl = '<?php echo ABSOLUTE_HOME_PATH.'include/plugins/elfinder2.0/elfinder.html?mode=flash' ?>';

var editor1 = CKEDITOR.replace( 'page-text', {
	height: 450
});

</script>

<?php if ($lock): ?>
<script type="text/javascript">
function lock_refresh() {
	$.get('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('System_Locks|lock'),'type'=>'events','object_id'=>$object->get('id'))) ?>',{},function(data){
		
	},'json');
}
$(document).ready(function(){
	setInterval('lock_refresh()',<?php echo Model_System_Lock::LOCK_RATE * 1000 ?>);
});
</script>
<?php endif ?>