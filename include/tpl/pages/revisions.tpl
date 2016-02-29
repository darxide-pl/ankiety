<ul class="nav nav-list sidebar-nav">
	<li><a href="<?php echo $this->link->Build(array($this->name,'add','parent_id'=>$this->rv->get('parent_id'))) ?>"><i class="icon icon-plus"></i> Nowa strona</a></li>
</ul>

<div id="content" class="content-noright">

	<ul class="breadcrumb">
		<li><a href="<?php echo $this->link->Build() ?>"><i class="icon icon-home"></i></a> <span class="divider">/</span></li>
		<li><a href="<?php echo $this->link->Build(array($this->name)) ?>">Strony</a> <span class="divider">/</span></li>
		<?php echo $this->build_breadcrumb($object->get('parent_id')) ?>
		<li><a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$object->get('id'))) ?>"><?php echo $object->get('title') ?></a> <span class="divider">/</span></li>
		<li class="active">Poprzednie wersje</li>
	</ul>
	
	<?php if ($revision): ?>
	<div class="container-white">
		
		<h3><?php echo $revision->get('title') ?></h3>
		
		<?php if ($this->rv->get('compare')): ?>
		
		<?php echo text_diff($revision->get('text'), $object->get('text'),
				array(
					'title_left'=>'Wersja z dnia: '.$revision->get('add_date').'
						<a href="'.$this->link->Build(array($this->name,'edit','oid'=>$revision->get('page_id'),'page_action'=>f_eas('Pages|revive_copy'),'rid'=>$revision->get('id'))).'" class="btn btn-success confirm pull-right" title="Czy na pewno chcesz przywrócić tą wersję strony?">Przywróć</a>',
					'title_right'=>'Wersja obecna')); ?>
		
		<?php else: ?>
		<div>
			<?php echo $revision->get('text') ?>
		</div>
		<?php endif ?>
		<hr />
	</div>
	
	<?php endif ?>
	
	<div class="btn-toolbar" style="margin-left: 20px;">
	
		<div class="btn-group">

		</div>

		<form class="form-search" style="float: left; margin: 0 5px 0 0;">
			
			<div class="input-append">
				<input type="text" name="filters[search]" class="span2 search-query" placeholder="Szukaj" value="<?php echo $this->list->getFilter('search') ?>" />
				
				<a href="?filters[search]=" class="btn"><i class="icon-remove"></i></a>
			</div>
		</form>
		
		<div style="float: right;">
			<?php echo $this->list->navigation(); ?>
		</div>

	</div>

	<form action="" class="" style="clear: both;" method="post" id="lf">
	
		<table class="table table-striped">
		<thead>
			<tr>
				<th width="10">&nbsp;</th>
				<th><?php echo $this->t('Page','Strona') ?></th>
				<th><?php echo $this->t('Created','Utworzono') ?></th>
				<th><?php echo $this->t('By','Przez') ?></th>
				<th><?php echo $this->t('Difference in tekst','Różnica tekstu') ?></th>
				<th><?php echo $this->t('Options','Opcje') ?></th>
			</tr>
		</thead>
		<tbody id="sortable-table">

		<?php if ($rows = $this->list->population()): foreach ($rows as $o): ?>

		<tr class="row<?php echo ($i = $i == 1 ? 2 : 1);?> vmiddle">
			<td></td>
			<td><a href="<?php echo $this->link->Build(array($this->name,$this->view,'oid'=>$o->get('page_id'),'rid'=>$o->get('id'))) ?>"><?php echo $o->get('title') ?></a></td>
			<td><?php echo $o->get('add_date') ?></td>
			<td><?php echo $o->get('user_name') ?></td>
			<td class="muted"><?php similar_text($object->get('text'), $o->get('text'), $similar_percent); echo (100-round($similar_percent,1)) > 0 ? round(100-round($similar_percent,1),1).'%' : 'brak'; ?></td>
			<td><div class="btn-group">
					<a href="<?php echo $this->link->Build(array($this->name,'edit','oid'=>$o->get('page_id'),'page_action'=>f_eas('Pages|revive_copy'),'rid'=>$o->get('id'))) ?>" class="btn btn-small btn-success confirm" title="Czy na pewno chcesz przywrócić tą wersję strony?">Przywróć</a>
					<a href="<?php echo $this->link->Build(array($this->name,$this->view,'oid'=>$o->get('page_id'),'rid'=>$o->get('id'),'compare'=>1)) ?>" class="btn btn-small">Porównaj z obecną wersją</a>
				</disv></td>
		</tr>

		<?php endforeach; else: ?>
			<tr><td colspan="8"><?php echo $this->t('No revisions in database','Brak poprzednich wersji w bazie danych.') ?></td></tr>
		<?php endif; ?>

		<?php echo $this->list->foot() ?>

		</tbody>
		</table>

	</form>
		
</div>

<script type="text/javascript">
<!--

$(document).ready(function(){
	$('.btn-revive').click(function(e){
		e.preventDefault();
		
		
	});
});

-->
</script>