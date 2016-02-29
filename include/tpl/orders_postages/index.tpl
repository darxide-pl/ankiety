
<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading">
			Formy dostawy
			&nbsp;<span class="badge"><?php echo $this->list->getAmount() ?></span>
			<?php if ($this->auth->checkRight('admin|programers')): ?>
			<div class="btn-group pull-right">
				<a href="<?php echo $this->link->Build(array($this->name,'add')) ?>" class="btn btn-sm btn-success"><i class="glyphicon glyphicon-plus"></i> <span class="hidden-xs">Dodaj</span></a>
			</div>
			<?php endif ?>
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
		</div>
		<div class="table-responsive">
			<table class="table table-striped">
			<thead>
				<tr>
					<th width="30">LP</th>
					<th><?php echo $this->list->head_order_button('name','Nazwa') ?></th>
					<th><?php echo $this->list->head_order_button('price','Cena') ?></th>
					<th>Formy płatności</th>
					<th width="10"></th>
				</tr>
			</thead>
			<tbody>

			<?php if ($rows = $this->list->population()): foreach ($rows as $k => $o):?>
			<tr>
				<td class="text-muted"><?php echo $this->list->getOffset() + $k + 1 ?>.</td>				
				<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->get('id'))) ?>"><?php echo $o->get('name') ?></a>
					<br /><small class="text-muted"><?php echo $o->get('description') ?></small></td>
				<td><?php echo $o->get('price') ?> zł</td>
				<td><?php echo $o->get('payments_count') ?></td>
				<td>
					<?php if ($this->auth->checkRight('admin|programers')): ?>
					<a href="<?php echo $this->link->Build(array($this->name,$this->view,'id'=>$o->get('id'),'page_action' => f_eas('Orders_Postages|remove')))?>"
					   title="Usunąć?" class="confirm text-muted"><i class="glyphicon glyphicon-remove"></i>
					</a>
					<?php endif; ?>
				</td>
			</tr>
			<?php endforeach; else: ?>
				<tr><td colspan="9999">Nie posiadasz jeszcze żadnej formy dostawy lub wybrałeś zbyt szczegółowe filtry wyszukiwania. Skorzystaj z przycisku Dodaj po prawej stronie.</td></tr>
			<?php endif; ?>
			</tbody>
			</table>
		</div><!-- .table-responsive -->
		
		<div class="panel-footer">
			<?php echo $this->list->paginator() ?>
		</div><!-- .panel-footer -->
		
	</div><!-- .panel -->
	
</div><!-- .container -->