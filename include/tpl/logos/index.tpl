<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading">
			
			Referencje&nbsp;<span class="badge"><?php echo $this->list->getAmount() ?></span>
			
			<div class="btn-group pull-right ">
				<a class="btn btn-default" href="<?php echo $this->link->Build(array($this->name,'add')) ?>"><i class="glyphicon glyphicon-plus"></i><span class="hidden-xs"> &nbsp; Dodaj referencje</span></a>
				<a class="btn btn-default" href="#" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-cog"></i></a>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="panel-body">

			<form class="form-inline">
				<div class="form-group has-feedback">
					<label class="sr-only"></label>
					<input type="text" name="filters[search]" class="form-control" placeholder="Szukaj" value="<?php echo $this->list->getFilter('search') ?>" />
					<a href="#" class="glyphicon glyphicon-remove form-control-feedback form-control-clear"></a>

				</div>
				<input type="submit" class="btn btn-primary" value="Szukaj" />
			</form>

		</div>

		<form class="" method="post" id="lf" style="margin: 0; padding: 0">
			<div class="table-responsive">
				<table class="table table-striped" style="margin: 0; padding: 0">
				<thead>
					<tr>
						<th width="10">
							<?php if ($parent->get('id') > 0): ?>
							<a href="<?php echo $this->link->Build(array($this->name,$this->view,'parent_id'=>$parent->get('parent_id'))) ?>"><i class="icon-chevron-up" rel="tooltip" title="Powrót"></i></a>
							<?php else: ?>
							&nbsp;
							<?php endif ?>
						</th>
						<th width="10">&nbsp;</th>
						<th width="100"><?php echo $this->t('Image','Zdjęcie') ?></th>
						<th><?php echo $this->t('Name','Nazwa') ?></th>
						<th><?php echo $this->t('Modify date','Data aktualizacji') ?></th>
						<th width="60"><?php echo $this->t('Options','Opcje') ?></th>
						<th width="20"></th>
					</tr>
				</thead>
				<tbody id="sortable-table">

				<?php if ($rows = $this->list->population()): foreach ($rows as $o): ?>

				<tr class="row<?php echo ($i = $i == 1 ? 2 : 1);?> vmiddle">
					<td>
						<i class="glyphicon glyphicon-move"></i>
						<input type="hidden" name="o[]" value="<?php echo $o->get('pos') ?>.<?php echo $o->get('id') ?>" />
						<input type="hidden" name="objects[]" class="object-id" value="<?php echo $o->get('id') ?>" />
					</td>
					<td><?php if ($o->get('children')>0): ?><a href="<?php echo $this->link->Build(array($this->name,$this->view,'parent_id'=>$o->get('id'))) ?>"><i class="icon icon-folder-open" rel="tooltip" title="Otwórz folder"></i> <?php //echo $o->get('children') ?></a><?php endif ?></td>
					<td><?php if ($o->get('image_filename')): ?>
						<img src="<?php echo DIR_UPLOAD_ABSOLUTE ?>/logo/thumbs/<?php echo $o->get('image_filename') ?>" class="img-polaroid" alt="" title="" />
						<?php endif ?></td>
					<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->get('id'))) ?>"><?php echo $o->get('name') ? $o->get('name') : '(edytuj)' ?></a></td>
					<td><small><?php echo f_format_date('d.m.Y H:i',$o->get('modify_date')) ?></small></small>
						<div class="lock text-error invisible" id="lock-<?php echo $o->get('id') ?>">&nbsp;</div></td>
					<td><?php if ($o->get('publish')): ?><a href="#" data-label="Publikuj" class="btn btn-default btn-toggle-publish" data-id="<?php echo $o->get('id') ?>">Ukryj</a>
						<?php else: ?><a href="#" data-label="Ukryj" class="btn btn-warning btn-toggle-publish" data-id="<?php echo $o->get('id') ?>">Publikuj</a><?php endif ?></td>
					<td><a href="<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Logos|delete'),'id'=>$o->get('id'),'parent_id'=>$o->get('parent_id'))) ?>" class="confirm btn btn-danger" title="Czy usunąć baner?"><i class="glyphicon glyphicon-remove"></a></td>
				</tr>

				<?php endforeach; else: ?>
					<tr><td colspan="999"><?php echo $this->t('No banners in database','Brak banerów w bazie danych.') ?></td></tr>
				<?php endif; ?>

				</tbody>
				</table>
			</div>
		</form>
		
		<div class="panel-footer">
			<?php echo $this->list->paginator() ?>
		</div><!-- .panel-footer -->
	</div>
		
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<form action="" method="post" class="form-horizontal">
		<input type="hidden" name="page_action" value="<?php echo f_eas('Configurations|save') ?>" />
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Ustawienia</h4>
				</div>
				<div class="modal-body">
					
					<div class="form-group">
						<label class="col-md-4 control-label">Pokaż referencje</label>
						<div class="col-md-8">
							<label class='radio-inline'>
								<input type="radio" name="cfg[logo][show]" value="0" checked /> Nie
							</label>
							<label class='radio-inline'>
								<input type="radio" name="cfg[logo][show]" value="1" <?php echo Config::get('logo.show') ? 'checked' : '' ?> /> Tak
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-4 control-label">Wymiary loga</label>
						<div class="col-md-4">
							<div class="input-group">
								<input type="text" name="cfg[logo][width]" placeholder="szerokość" value="<?php echo Config::get('logo.width') ?>" class="form-control" />
								<span class="input-group-addon">px</span>
							</div>
						</div>
						<div class="col-md-4">
							<div class="input-group">
								<input type="text" name="cfg[logo][height]" placeholder="wysokość" value="<?php echo Config::get('logo.height') ?>" class="form-control" />
								<span class="input-group-addon">px</span>
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-4 control-label">Wymiary miniaturki</label>
						<div class="col-md-4">
							<div class="input-group">
								<input type="text" name="cfg[logo][width_thumb]" placeholder="szerokość" value="<?php echo Config::get('logo.width_thumb') ?>" class="form-control" />
								<span class="input-group-addon">px</span>
							</div>
						</div>
						<div class="col-md-4">
							<div class="input-group">
								<input type="text" name="cfg[logo][height_thumb]" placeholder="wysokość" value="<?php echo Config::get('logo.height_thumb') ?>" class="form-control" />
								<span class="input-group-addon">px</span>
							</div>
						</div>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Anuluj</button>
					<button type="submit" class="btn btn-primary">Zapisz zmiany</button>
				</div>
			</div>
		</div>
	</form>
</div>

<script type="text/javascript">
<!--//

function locks_refresh() {
	
	var objects = $('.object-id').serializeAnything();
	
	$.get('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('System_Locks|check_locks'),'type'=>'logo')) ?>',objects,function(data){
		if (data.output.locks) {
			$.each(data.output.locks,function(i,item){
				if (item != '0') {
					$('#lock-'+i).fadeIn(300).removeClass('invisible').html('<small>Edytuje: <strong>'+item+'</strong></small>');
				} else if(!$('#lock-'+i).hasClass('invisible')) {
					$('#lock-'+i).addClass('invisible');
				}
			});
		}
	},'json');
	
}

$(document).ready(function(){

	$('#t_check').live('click',function(){
		$('input[name="t[]"]').each(function(i,item){
			$(this).attr('checked',!$(this).attr('checked'));
		});
	});
	
	$('.btn-toggle-publish').click(function(e){
		e.preventDefault();
		var $this = $(this), label = '';
		$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Logos|switch_publish'))) ?>',{id:$this.data('id')},function(){
			if ($this.hasClass('btn-warning')) {
				$this.removeClass('btn-warning');
			} else {
				$this.addClass('btn-warning');
			}
			
			label = $this.data('label');
			$this.data('label',$this.text()).text(label);
			
		},'json');
	});
	
	locks_refresh();
	
	setInterval('locks_refresh()',<?php echo Model_System_Lock::LOCK_PERIOD * 1000 ?>);
	
	
	
	// Return a helper with preserved width of cells
	var fixHelper = function(e, ui) {
		ui.children().each(function() {
			$(this).width($(this).width());
		});
		return ui;
	};

	$("#sortable-table").sortable({
		helper: fixHelper,
		handle: '.glyphicon-move',
		axis: 'y',
		update: function(){
			var vars = $('#lf').serialize();
			$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_nr'=>$this->list->GetData('page_nr'),'page_action'=>f_eas('Logos|ajax_save_positions'))) ?>',vars,function(data){
				// result
			},'json');
		}
	});//.disableSelection();
	
	$('input[name="cfg[logo][width_thumb]"]').keyup(function(e){
		var w = $('input[name="cfg[logo][width]"]').val(),
			h = $('input[name="cfg[logo][height]"]').val(),
			wt = $(this).val();
		$('input[name="cfg[logo][height_thumb]"]').val(Math.round((wt*h)/w));
	});
});

-->
</script>