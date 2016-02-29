<div class="container">
	<div class="panel panel-default">
		<div class="panel-heading">
			<i class="glyphicon glyphicon-file"></i> &nbsp; Zapytania
			&nbsp;<span class="badge"><?php echo $this->list->getAmount() ?></span>
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

		<div class="table-responsive">
			
			<form action="" class="" method="post" id="lf">
	
				<input type="hidden" name="page_action" value="" id="lf-pa" />

				<table class="table table-striped" style="margin-bottom: 0; padding-bottom: 0;">
				<thead>
					<tr>
						<th colspan="2">
							<div class="btn-group btn-group-xs">
								<button id="t_check" class="btn btn-default"><i class="glyphicon glyphicon-ok"></i></button>
								<button data-toggle="dropdown" class="btn btn-default dropdown-toggle">
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu">
									<li><a title="Czy na pewno chcesz usunąć zaznaczone opinie?" class="list-option" href="#remove">Usuń zaznaczone</a></li>
								</ul>
							</div>
						</th>
						<th width="100"><a href="<?php echo $this->link->Build(array($this->name,$this->view,'order_by'=>'add_date')) ?>"><?php echo $this->t('Date','Data') ?></a></th>
						<th><a href="<?php echo $this->link->Build(array($this->name,$this->view,'order_by'=>'fullname')) ?>"><?php echo $this->t('Name','Nazwa') ?></a></th>
						<th>Komentarz</th>
						<th width="200">Kontakt</th>
						<th width="100"><a href="<?php echo $this->link->Build(array($this->name,$this->view,'order_by'=>'ip')) ?>"><?php echo $this->t('IP address','Adres IP') ?></a></th>
					</tr>
				</thead>
				<tbody>

				<?php if ($rows = $this->list->population()): foreach ($rows as $o): ?>

				<tr>
					<td><input type="checkbox" name="t[]" value="<?php echo $o->get('id') ?>" /></td>
					<td class="muted" align="center"><?php echo $k+1 ?>.</td>
					<td><?php echo $o->get('date') ?></td>
					<td><?php echo $o->get('name') ?></td>
					<td><div class="text-overflow product-question-text"><span><?php echo strip_tags($o->get('text')) ?></span></div></td>
					<td>
						<?php echo $o->get('phone') ? 'tel.: '.$o->get('phone').'<br />' : '' ?>
						<?php echo $o->get('email') ? 'e-mail: <a href="mailto:'.$o->get('email').'">'.$o->get('email').'</a><br />' : '' ?>
					</td>
					<td><?php echo $o->get('ip') ?></td>
				</tr>

				<?php endforeach; else: ?>
					<tr><td colspan="8"><?php echo $this->t('No contact forms in database','Brak zapytan w bazie danych.') ?></td></tr>
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


<style type="text/css">
.product-question-text {width: 400px; height: 38px; overflow:hidden; position:relative; cursor: default; padding-right: 8px;}
</style>

<script type="text/javascript">
<!--//

$(document).ready(function(){

	$('#t_check').live('click',function(e){
		e.preventDefault();
		$('input[name="t[]"]').each(function(i,item){
			$(this).attr('checked',!$(this).attr('checked'));
		});
	});
	
	var text_overflow_selected = false;
	
	$('.text-overflow').bind('textselect',function(e,text){
		text_overflow_selected = text != '';
	});
	
	$('.text-overflow').click(function(){
		
		if (text_overflow_selected) {
			return true;
		}
		
		$(this).stop(true,true);
		
		if ($(this).find('span').outerHeight() > $(this).height()) {
			$(this).data('default_height',$(this).height());
			$(this).animate({
				height: $(this).find('span').outerHeight()
			},100);
		} else {
			$(this).animate({
				height: $(this).data('default_height')
			},100);
		}
	});
	
	$('.text-overflow').each(function(i,item){
		if ($(item).find('span').outerHeight() > $(item).height()) {
			$(item).append('<span style="position:absolute; font-size: 12px; font-weight: bold; color: red; right: 0;bottom:0;" class="text-overflow-">&raquo;</span>');
		}
	});
	
	$('.list-option').click(function(e){
		e.preventDefault();
		var option = $(this).attr('href').substr(1);
		if (option == 'remove') {
			if (confirm($(this).attr('title'))) {
				$('#lf-pa').val('<?php echo f_eas('Contact_Form|remove_selected') ?>');
				$('#lf').submit();
			}
		}
		
		return;
	});
});

-->
</script>