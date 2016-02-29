<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-file"></i> &nbsp; Strony
			&nbsp;<span class="badge"><?php echo $this->list->getAmount() ?></span>
			<div class="btn-group pull-right">
				<a href="<?php echo $this->link->Build(array($this->name,'add','parent_id'=>$this->rv->get('parent_id'),'l'=>$this->get('language'))) ?>" class="btn btn-default"><i class="glyphicon glyphicon-plus"></i> Dodaj stronę</a>
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

		</div><!-- .panel-body -->

		<!-- Nav tabs -->
		<ul class="nav nav-tabs">
			<li <?php echo $this->get('group_id') == 0 ? 'class="active"' : '' ?>><a href="?g=0">Strony</a></li>
			<?php if ($groups): foreach ($groups as $group): ?>
			<li <?php echo $this->get('group_id') == $group['id'] ? 'class="active"' : '' ?>><a href="?g=<?php echo $group['id'] ?>"><?php echo $group['name'] ?></a></li>
			<?php endforeach; endif; ?>
		</ul>
		
		<div class="table-responsive">
			
			<form action="" class="" method="post" id="lf">
	
				<table class="table table-striped" style="margin-bottom: 0; padding-bottom: 0;">
				<thead>
					<tr>
						<th width="10">
							<?php if ($parent->get('id') > 0): ?>
							<a href="<?php echo $this->link->Build(array($this->name,$this->view,'parent_id'=>$parent->get('parent_id'))) ?>"><i class="glyphicon glyphicon-chevron-up" rel="tooltip" title="Powrót"></i></a>
							<?php else: ?>
							&nbsp;
							<?php endif ?>
						</th>
						<th width="10">&nbsp;</th>
						<th><?php echo $this->t('Page','Strona') ?></th>
						<th></th>
						<th><?php echo $this->t('Views','Wyświetleń') ?></th>
						<th><?php echo $this->t('Modify date','Data modyfikacji') ?></th>
						<th width="60"><?php echo $this->t('Options','Opcje') ?></th>
						<th width="80">&nbsp;</th>
						<th width="60">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="sortable-table">

				<?php if ($rows = $this->list->population()): foreach ($rows as $o): ?>

				<tr>
					<td><?php if(!$search): ?>
						<i class="glyphicon glyphicon-move"></i>
						<input type="hidden" name="o[]" value="<?php echo $o->get('pos') ?>.<?php echo $o->get('id') ?>" />
						<?php endif ?>
						<input type="hidden" name="objects[]" class="object-id" value="<?php echo $o->get('id') ?>" />
					</td>
					<td><?php if ($o->get('children')>0): ?><a href="<?php echo $this->link->Build(array($this->name,$this->view,'parent_id'=>$o->get('id'))) ?>"><i class="glyphicon glyphicon-folder-open" rel="tooltip" title="Otwórz folder"></i> <?php //echo $o->get('children') ?></a><?php endif ?></td>
					<td><a href="<?php echo $o->get('children') ? $this->link->Build(array($this->name,$this->view,'parent_id'=>$o->get('id'))) : $this->link->Build(array($this->name,'edit','oid'=>$o->get('id'))) ?>"><?php echo $o->get('title') ?></a></td>
					<td><a href="<?php echo $this->link->Build(array($this->name,'add','parent_id'=>$o->get('id'),'l'=>$this->get('language'))) ?>" class="text-muted tip" data-toggle="tooltip" data-placement="top" title="Dodaj podstronę"><i class="glyphicon glyphicon-plus"></i></a></td>
					<td><?php echo (int)$o->get('views_total') ?></td>
					<td><a rel="tooltip" title="Historia zmian" href="<?php echo $this->link->Build(array($this->name,'revisions','oid'=>$o->get('id'))) ?>"><small><?php echo f_format_date('d.m.Y H:i',$o->get('modify_date')) ?></small></a>
						<div class="lock text-error invisible" id="lock-<?php echo $o->get('id') ?>">&nbsp;</div></td>
					<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->get('id'))) ?>" class="btn btn-info">Edytuj</a></td>
					<td><?php if ($o->get('publish')): ?><a href="#" data-label="Publikuj" class="btn btn-default btn-toggle-publish" data-id="<?php echo $o->get('id') ?>">Ukryj</a>
						<?php else: ?><a href="#" data-label="Ukryj" class="btn btn-warning btn-toggle-publish" data-id="<?php echo $o->get('id') ?>">Publikuj</a><?php endif ?></td>
					<td><a href="<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Pages|delete'),'parent_id'=>$o->get('parent_id'),'id'=>$o->get('id'))) ?>" class="confirm btn btn-danger" title="Czy usunąć stronę?"><i class="glyphicon glyphicon-remove"></a></td>
				</tr>

				<?php endforeach; else: ?>
					<tr><td colspan="8"><?php echo $this->t('No pages in database','Brak stron w bazie danych.') ?></td></tr>
				<?php endif; ?>

				</tbody>
				</table>

			</form>
		</div>
		
		<div class="panel-footer">
			<?php echo $this->list->paginator() ?>
		</div><!-- .panel-footer -->
		
	</div><!-- .panel -->
	
	
</div><!-- .container -->

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
					
					<h4>Częste pytania</h4>
					
					<div class="form-group">
						<label class="col-md-4 control-label">Pokaż</label>
						<div class="col-md-8">
							<label class='radio-inline'>
								<input type="radio" name="cfg[page][faq_show]" value="0" checked /> Nie
							</label>
							<label class='radio-inline'>
								<input type="radio" name="cfg[page][faq_show]" value="1" <?php echo Config::get('page.faq_show') ? 'checked' : '' ?> /> Tak
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-4 control-label">Wybierz katalog</label>
						<div class="col-md-8">
							<input type="hidden" id="cfg-page-faq" name="cfg[page][faq]" value="<?php echo (int)Config::get('page.faq') ?>" />
							<input type="text" name="" value="<?php echo $cfg_faq->get('title').' - '.$cfg_faq->get('id') ?>" class="typeahead-pages form-control" />
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-4 control-label">Limit</label>
						<div class="col-md-4">
							<input type="number" min="1" name="cfg[page][faq_limit]" value="<?php echo (int)Config::get('page.faq_limit') ?>" class="form-control" />
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
	
	$.get('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('System_Locks|check_locks'),'type'=>'page')) ?>',objects,function(data){
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
			$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_nr'=>$this->list->GetData('page_nr'),'page_action'=>f_eas('Pages|ajax_save_positions'))) ?>',vars,function(data){
				// result
			},'json');
		}
	});//.disableSelection();
	
	$('.btn-toggle-publish').click(function(e){
		e.preventDefault();
		var $this = $(this), label = '';
		$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Pages|switch_publish'))) ?>',{id:$this.data('id')},function(){
			if ($this.hasClass('btn-warning')) {
				$this.removeClass('btn-warning')
						.addClass('btn-default');
			} else {
				$this.addClass('btn-warning');
			}
			
			label = $this.data('label');
			$this.data('label',$this.text()).text(label);
			
		},'json');
	});
	
	$('#language-select').change(function(e){
		location.href='?l='+$(this).val();
	});
	
	$('#group-select').change(function(e){
		location.href='?g='+$(this).val();
	});
	
	locks_refresh();
	
	setInterval('locks_refresh()',<?php echo Model_System_Lock::LOCK_PERIOD * 1000 ?>);
	
	var map;
	
	$(".typeahead-pages").typeahead({
		minLength: 2,
		//showHintOnFocus: true,
		source: function (query, process) {
			var input = $(this)[0].$element;
			map = {};
			return $.post('<?php echo $this->link->Build(array('search','pages')) ?>', { query: query }, function (data) {
				var search_items = [];
				$.each( data, function( ix, item, list ){
					//add the label to the display array
					map[item.label] = item;
					search_items.push( item.label );
				});
				return process(search_items);
			},'json');
		}, updater: function (item) {
			$('#cfg-page-faq').val(map[item].id);
			return item;
		}
	}).focus(function(){
		//$(this).lookup();
	});
});

-->
</script>