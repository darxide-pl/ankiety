
<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading">
			Galerie fotografii
			&nbsp;<span class="badge"><?php echo $this->list->getAmount() ?></span>
			<div class="btn-group pull-right">
				<a class="btn btn-sm btn-success" href="<?php echo $this->link->Build(array($this->name,'add')) ?>"><i class="glyphicon glyphicon-plus"></i><span class="hidden-xs"> &nbsp; Dodaj galerię</span></a>
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
		</div>
		<form class="" method="post" id="lf">
		<div class="table-responsive">
			<table class="table table-striped">
			<thead>
				<tr>
					<th width="20"></th>
					<th>ID</th>
					<th>Nazwa</th>
					<th>Modyfikacja</th>
					<th width="10"></th>
					<th width="10"></th>
				</tr>
			</thead>
			<tbody id="sortable-table">
			<?php if ($rows = $this->list->population()): foreach ($rows as $k => $o):?>
			<tr>
				<td><?php if(!$search): ?>
					<i class="glyphicon glyphicon-move"></i>
					<input type="hidden" name="o[]" value="<?php echo $o->get('id') ?>" />
					<?php endif ?>
				</td>
				<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->get('id'))) ?>" class="btn btn-default"><b><?php echo $o->get('id') ?></b></a></td>
				<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->get('id'))) ?>"><?php echo $o->get('name') ?></a></td>
				<td class="item-update-date"><?php echo $o->get('update_date') > 0 ? $o->get('update_date') : '' ?></td>

				<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->get('id'))) ?>" class="btn btn-info">Edytuj</a></td>
				<td>
					<a class="confirm btn btn-danger" href="<?php echo $this->link->Build(array($this->name,$this->view,'id'=>$o->get('id'),'page_action' => f_eas('Products|remove')))?>"
						title="Usunąć galerię z bazy?"><i class="glyphicon glyphicon-remove"></i>
					</a>
				</td>
			</tr>
			<?php endforeach; else: ?>
				<tr><td colspan="9999">Zmień filtry wyszukiwania albo nie posiadasz jeszcze żadnej galerii. Skorzystaj z przycisku Dodaj po prawej stronie.</td></tr>
			<?php endif; ?>
			</tbody>
			</table>
		</div><!-- .table-responsive -->
		</form>
		
		<div class="panel-footer">
			<?php echo $this->list->paginator() ?>
		</div><!-- .panel-footer -->
		
	</div><!-- .panel -->
	
	
</div><!-- .container -->

<script type="text/javascript">
$().ready(function(){
	
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
			$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_nr'=>$this->list->GetData('page_nr'),'page_action'=>f_eas('Galleries|ajax_save_positions'))) ?>',vars,function(data){
				// result
			},'json');
		}
	});//.disableSelection();
});
</script>