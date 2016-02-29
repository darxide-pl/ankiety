
<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-envelope"></i> &nbsp; Powiadomienia e-mail
			<?php if (Auth::isSuperadmin()): ?>
			<div class="btn-group pull-right">
				<a href="<?php echo $this->link->Build(array($this->name,'add')) ?>" class="btn btn-sm btn-success">
					<i class="glyphicon glyphicon-plus"></i> 
					<span class="hidden-xs">Stwórz powiadomienie</span>
				</a>
			</div>
			<?php endif ?>
		</div>
		<div class="table-responsive">
			<table class="table table-striped">
			<thead>
				<tr>
					<th style="width:15px;"></th>
					<th>Powiadomienie</th>
					<th>Tytuł</th>
					<?php if (Auth::isSuperadmin()): ?><th>Kod akcji</th><?php endif ?>
					<th width="10"></th>
				</tr>
			</thead>
			<tbody>
			<?php if ($rows = $this->list->population()): foreach ($rows as $k => $o):?>
			<tr>
				<td><?php echo $k+1 ?></td>
				<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->GetID())) ?>"><?php echo $o->Get('System_Action.name') ?></a></td>
				<td><?php echo $o->Get('title');?></td>
				<?php if (Auth::isSuperadmin()): ?><td><?php echo $o->Get('System_Action.constant') ?></td><?php endif ?>

				<td><a href="<?php echo $this->link->Build(array($this->name,$this->view,'message_id'=>$o->GetID(),'page_action' => f_eas('System_Messages|delete')))?>"
					   title="Usunąć powiadomienie?" class="confirm text-danger"><i class="glyphicon glyphicon-remove"></i>
					</a></td>
			</tr>
			<?php endforeach; else: ?>
				<tr><td colspan="9999">Nie posiasz żadnych powiadomień.</td></tr>
			<?php endif; ?>
			</tbody>
			</table>
		</div>
	</div>
	
	<?php echo $this->list->foot() ?>
</div>