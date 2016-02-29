
<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading">
			Produkty
			&nbsp;<span class="badge"><?php echo $this->list->getAmount() ?></span>
			<div class="btn-group pull-right">
				<a href="<?php echo $this->link->Build(array($this->name,'settings')) ?>" class="btn btn-default"><i class="glyphicon glyphicon-folder-open" title=""></i> &nbsp; Kategorie produktów</a>
				<a class="btn btn-default" href="<?php echo $this->link->Build(array($this->name,'add')) ?>"><i class="glyphicon glyphicon-plus"></i><span class="hidden-xs"> &nbsp; Dodaj produkt</a>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="panel-body">
			<div class="btn-toolbar" role="toolbar">
				<div class="btn-group">
					<form class="form-inline">
						<div class="form-group has-feedback">
							<input type="text" name="filters[search]" class="form-control" placeholder="Szukaj" value="<?php echo $this->list->getFilter('search') ?>" />
							<a href="#" class="glyphicon glyphicon-remove form-control-feedback form-control-clear"></a>
						</div>
						<select name="filters[category_id]" class="form-control">
							<option value="all">- wybierz kategorię -</option>
							<?php echo Html::SelectOptions($categories,$this->list->getFilter('category_id')) ?>
						</select>
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
					<th>Grupa</th>
					<th>Status</th>
					<th>Modyfikacja</th>
					<th width="10"></th>
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
				<td><?php echo $o->get('category_name') ?></td>
				<td><a href="#" class="btn item-toggle-active <?php echo $o->get('active') ? 'btn-primary' : 'btn-default' ?>" data-id="<?php echo $o->get('id') ?>"></a></td>
				<td class="item-update-date"><?php echo $o->get('update_date') > 0 ? $o->get('update_date') : '' ?></td>
				<td>
					<a class="confirm" title="Skopiować urządzenie?" href="<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Products|copy'),'id'=>$o->get('id'),)) ?>"><i class="glyphicon glyphicon-transfer"></i></a>
				</td>
				<td><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->get('id'))) ?>" class="btn btn-info">Edytuj</a></td>
				<td>
					<a class="confirm btn btn-danger" href="<?php echo $this->link->Build(array($this->name,$this->view,'id'=>$o->get('id'),'page_action' => f_eas('Products|remove')))?>"
						title="Usunąć urządzenie z bazy?"><i class="glyphicon glyphicon-remove"></i>
					</a>
				</td>
			</tr>
			<?php endforeach; else: ?>
				<tr><td colspan="9999">Zmień filtry wyszukiwania albo nie posiadasz jeszcze żadnego urządzenia. Skorzystaj z przycisku Dodaj po prawej stronie.</td></tr>
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
	
	$('.item-toggle-active').click(function(e){
		
		e.preventDefault();
		
		var $this = $(this);
		
		if ($this.hasClass('btn-primary')) {

			$.post('?page_action=<?php echo f_eas('Products|toggle_active') ?>',{id:$this.data('id')},function(data){
				$this
					.removeClass('btn-primary')
					.addClass('btn-default')
					.closest('tr').find('.item-update-date').text(data.output.update_date);
			},'json');
		} else {
		
			$.post('?page_action=<?php echo f_eas('Products|toggle_active') ?>',{id:$this.data('id')},function(data){
				$this
					.removeClass('btn-default')
					.addClass('btn-primary')
					.closest('tr').find('.item-update-date').text(data.output.update_date);
			},'json');
		}
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
			$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_nr'=>$this->list->GetData('page_nr'),'page_action'=>f_eas('Products|ajax_save_positions'))) ?>',vars,function(data){
				// result
			},'json');
		}
	});//.disableSelection();
});
</script>