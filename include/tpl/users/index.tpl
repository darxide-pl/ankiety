<div class="container">
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-user"></i> &nbsp; Użytkownicy
			&nbsp;<span class="badge"><?php echo $this->list->getAmount() ?></span>
			<div class="btn-group pull-right">
				<a href="<?php echo $this->link->Build(array($this->name,'add')) ?>" class="btn btn-sm btn-success">
					<i class="glyphicon glyphicon-plus"></i>
					<span class="hidden-xs">Stwórz użytkownika</span>
				</a>
			</div>
		</div>
		<div class="panel-body">
			<div class="btn-toolbar" role="toolbar">
				<div class="btn-group">
					<form class="form-inline">
						<input type="text" name="filters[search]" class="form-control" placeholder="Szukaj" value="<?php echo $this->list->getFilter('search') ?>" />
					</form>
				</div>
				<div class="btn-group">
					<a class="btn <?php echo $this->list->getFilter('status') == 'all' || $this->list->getFilter('status') == ''  ? 'btn-info' : 'btn-default' ?>" href="<?php echo $this->link->Build(array($this->name,$this->view,'filters[status]'=>'all')) ?>">Wszyscy</a>
					<?php if (Model_User::$status): foreach (Model_User::$status as $k => $v): ?>
					<a class="btn <?php echo $this->list->getFilter('status') == (string)$k ? 'btn-info' : 'btn-default' ?>" href="<?php echo $this->link->Build(array($this->name,$this->view,'filters[status]'=>$k)) ?>">
						<?php echo $v ?>
					</a>
					<?php endforeach; endif; ?>
				</div>
				<div class="btn-group">
					<a class="btn btn-default dropdown-toggle" data-toggle="dropdown" href="#">
						Grupa
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li class="<?php echo $this->list->getFilter('group_id') == 'all' || ! $this->list->getFilter('group_id')  ? 'active' : '' ?>">
							<a href="<?php echo $this->link->Build(array($this->name,$this->view,'filters[group_id]'=>'all')) ?>">Wszystkie</a></li>
						<?php if ($groups): foreach ($groups as $k => $v): ?>
						<li class="<?php echo $this->list->getFilter('group_id') == $k ? 'active' : '' ?>">
							<a href="<?php echo $this->link->Build(array($this->name,$this->view,'filters[group_id]'=>$k)) ?>"><?php echo $v ?></a></li>
						<?php endforeach; endif; ?>
					</ul>
				</div>
			</div>
		</div>
		<div class="table-responsive">
			<table class="table table-striped">
			<thead>
				<tr>
					<th><?php echo $this->list->head_order_button('id','ID') ?></th>
					<th><?php echo $this->list->head_order_button('name',$this->t('Name','Nazwa')) ?></th>
					<th><?php echo $this->list->head_order_button('email',$this->t('Email','Email')) ?></th>
					<th><?php echo $this->list->head_order_button('group',$this->t('Group','Grupa')) ?></th>
					<th><?php echo $this->list->head_order_button('last_visit',$this->t('Last visit','Ostatnia wizyta')) ?></th>
					<th><?php echo $this->list->head_order_button('status',$this->t('Status','Status')) ?></th>
					<th><?php echo $this->list->head_order_button('add_date',$this->t('Added','Dodano')) ?></th>
					<th width="20"></th>
				</tr>
			</thead>
			<tbody>

			<?php if ($rows = $this->list->population()): foreach ($rows as $k => $o):?>

			<tr>
				<td><?php echo $o->get('id') ?></td>
				<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->GetID())) ?>"><?php echo $o->Get('name') . ' ' . $o->Get('lastname') ?></a></td>
				<td><a href="mailto:<?php echo $o->Get('email');?>"><?php echo $o->Get('email');?></a></td>
				<td style="color:<?php echo $o->Get('User_Group.color');?>;"><?php echo $o->Get('User_Group.name');?></td>
				<td>
					<?php if (!$last_visit = strtotime($o->Get('last_visit'))):?>
						<span class="lessimportant"><?php echo $this->t('never','nigdy') ?></span>
					<?php else:?>
						<?php echo f_time_ago_to_string($last_visit, 1) ?>
					<?php endif;?>
				</td>
				<td><a href="#" class="btn item-toggle-active <?php echo $o->get('active') ? 'btn-primary' : 'btn-default' ?>" data-id="<?php echo $o->get('id') ?>"></a></td>
				<td><?php echo $o->Get('add_date');?></td>
				<td><a href="<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Users|delete'),'oid'=>$o->GetID())) ?>" class="confirm text-muted" title="Usunąć użytkownika?"><i class="glyphicon glyphicon-remove"></a></td>
			</tr>

			<?php endforeach; else: ?>
				<tr><td colspan="8"><?php echo $this->t('No users in database','Brak użytkowników w bazie danych.') ?></td></tr>
			<?php endif; ?>

			</tbody>
			</table>
		</div><!-- .table-responsive -->
		
		<div class="panel-footer">
			<?php echo $this->list->paginator() ?>
		</div><!-- .panel-footer -->
		
	</div><!-- .panel -->
	
	
</div><!-- .container -->

<script type="text/javascript">
<!--

$().ready(function(){

	$('#t_check').live('click',function(){
		$('input[name="t[]"]').each(function(i,item){
			$(this).attr('checked',!$(this).attr('checked'));
		});
	});
	
	$('.item-toggle-active').click(function(e){
		
		e.preventDefault();
		
		var $this = $(this);
		
		if ($this.hasClass('btn-primary')) {

			$.post('?page_action=<?php echo f_eas('Users|toggle_active') ?>',{id:$this.data('id')},function(data){
				$this
					.removeClass('btn-primary')
					.addClass('btn-default')
					.closest('tr').find('.item-update-date').text(data.output.update_date);
			},'json');
		} else {
		
			$.post('?page_action=<?php echo f_eas('Users|toggle_active') ?>',{id:$this.data('id')},function(data){
				$this
					.removeClass('btn-default')
					.addClass('btn-primary')
					.closest('tr').find('.item-update-date').text(data.output.update_date);
			},'json');
		}
	});
	
});

-->
</script>