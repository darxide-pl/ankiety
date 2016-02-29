<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading">
			&nbsp; Aktualności
			&nbsp;<span class="badge"><?php echo $this->list->getAmount() ?></span>
			<div class="btn-group pull-right">
				<a href="<?php echo $this->link->Build(array($this->name,'add')) ?>"  class="btn btn-sm btn-success">
					<i class="glyphicon glyphicon-plus"></i> Nowa aktualność</a>
			</div>
		</div>
		<div class="panel-body">
			<div class="btn-toolbar" role="toolbar">
				<div class="btn-group">
					<form class="form-inline">
						<div class="form-group has-feedback">
							<input type="text" name="filters[search]" class="form-control" placeholder="Szukaj" value="<?php echo $this->list->getFilter('search') ?>" />
							<a href="#" class="glyphicon glyphicon-remove form-control-feedback form-control-clear"></a>
						</div>
						<input type="submit" class="btn btn-primary" value="Szukaj" />
					</form>
				</div>
			</div>
		</div><!-- .panel-body -->
		
		<div class="table-responsive">
			<table class="table table-striped">
			<thead>
				<tr>
					<th width="80"></th>
					<th><?php echo $this->t('Title','Tytuł') ?></th>
					<th><?php echo $this->t('Views','Wyświetleń') ?></th>
					<th><?php echo $this->t('Modify date','Data modyfikacji') ?></th>
					<th width="60"><?php echo $this->t('Options','Opcje') ?></th>
					<th width="80"></th>
					<th width="20"></th>
				</tr>
			</thead>
			<tbody>

			<?php if ($rows = $this->list->population()): foreach ($rows as $o): ?>

			<tr class="row<?php echo ($i = $i == 1 ? 2 : 1);?> vmiddle">
				<td class="muted" style="text-align: center;"><small><?php echo f_format_date('<b>d.m.Y</b> <br /> H:i',$o->get('add_date')) ?></small></td>
				<td><input type="hidden" name="objects[]" class="object-id" value="<?php echo $o->get('id') ?>" />
					<a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->GetID())) ?>"><?php echo $o->get('title') ?></a> <a href="<?php echo Model_News::Build_Url($o) ?>" target="_blank" rel="tooltip" title="Otwórz w nowej zakładce"><i class="icon-share-alt"></i></a>
				</td>
				<td><?php echo (int)$o->get('views_total') ?></td>
				<td><a rel="tooltip" title="Historia zmian" href="<?php echo $this->link->Build(array($this->name,'revisions','oid'=>$o->get('id'))) ?>"><small><?php echo f_format_date('d.m.Y H:i',$o->get('modify_date')) ?></small></a>
					<div class="lock text-error invisible" id="lock-<?php echo $o->get('id') ?>">&nbsp;</div>
				</td>
				<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->GetID())) ?>" class="btn btn-info">Edytuj</a></td>
				<td><?php if ($o->get('publish')): ?><a href="#" data-label="Publikuj" class="btn btn-default btn-toggle-publish" data-id="<?php echo $o->get('id') ?>">Ukryj</a>
					<?php else: ?><a href="#" data-label="Ukryj" class="btn btn-warning btn-toggle-publish" data-id="<?php echo $o->get('id') ?>">Publikuj</a><?php endif ?></td>
				<td><a href="<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('News|delete'),'parent_id'=>$o->get('parent_id'),'id'=>$o->get('id'))) ?>" class=" btn btn-danger confirm" title="Czy usunąć stronę?"><i class="glyphicon glyphicon-remove"></a></td>
			</tr>

			<?php endforeach; else: ?>
				<tr><td colspan="7"><?php echo $this->t('No news in database','Brak aktualności w bazie danych.') ?></td></tr>
			<?php endif; ?>

			</tbody>
			</table>
		</div>
		
		<div class="panel-footer">
			<?php echo $this->list->paginator() ?>
		</div><!-- .panel-footer -->
		
	</div><!-- .panel -->
	
	
</div><!-- .container -->

<script type="text/javascript">
<!--

function locks_refresh() {
	
	var objects = $('.object-id').serializeAnything();
	
	$.get('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('System_Locks|check_locks'),'type'=>'news')) ?>',objects,function(data){
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

	$('.btn-toggle-publish').click(function(e){
		e.preventDefault();
		var $this = $(this), label = '';
		$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('News|switch_publish'))) ?>',{id:$this.data('id')},function(){
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
	
	locks_refresh();
	
	setInterval('locks_refresh()',<?php echo Model_System_Lock::LOCK_PERIOD * 1000 ?>);
});

-->
</script>