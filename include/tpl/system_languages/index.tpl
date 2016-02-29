<ul class="nav nav-list sidebar-nav">
	<?php if ($langs): foreach ($langs as $lang): ?>
	<li class="<?php echo $this->get('language') == $lang['key'] ? 'active' : '' ?>">
		<a href="<?php echo $this->link->Build($this->name.'/'.$this->view.'/set_language/'.$lang['key'].'/') ?>">
			<?php echo $lang['name'] ?></a>
	</li>
	<?php endforeach; endif; ?>
</ul>


<div id="content" class="content-noright">

	<div class="container-grey">
		
		<button class="btn btn-primary btn-large btn-save-changes" style="float: right;" data-complete-text="<?php echo ucfirst($this->t('success','Sukces')) ?>, <?php echo ucfirst($this->t('save changes','Zapisz zmiany')) ?>" data-loading-text="<?php echo ucfirst($this->t('saving','Zapisuję')) ?> ..."><?php echo ucfirst($this->t('save changes','Zapisz zmiany')) ?></button>
		
		<form class="form-search" id="form-search">

			<input type="hidden" name="on_page" value="<?php echo $this->get('on_page') ?>" id="on_page" />
			<input type="hidden" name="page_nr" value="<?php echo $this->list->GetData('page_nr') ?>" id="page_nr" />
			<input type="hidden" name="order_by" value="<?php echo $this->list->GetData('order_by') ?>" id="order_by" />
			<input type="hidden" name="direction" value="<?php echo $this->list->GetData('order_dir') ?>" id="order_dir" />
			<input type="hidden" name="reloadlist_url" value="<?php echo $this->link->Build($this->name.'/'.$this->view.'/') ?>" id="reloadlist_url" />
			<input type="hidden" name="filters[only_empty]" value="<?php echo $this->list->GetFilter('only_empty') ?>" id="filter_only_empty" />

			<input type="text" placeholder="Szukaj" class="input-large search-query" name="filters[search]" id="filters_search" value="<?php echo $this->list->GetFilter('search') ?>">

		</form>	

	</div>
	
	<div class="container-white" style="padding-left: 0;">

		<form action="" method="post" namd="" id="edit-form">

			<input type="hidden" name="page_action" value="<?php echo f_eas('System_Languages|save_translations') ?>" />
			<input type="hidden" name="lang" value="<?php echo $this->get('language') ?>" />

			<table class="table table-striped">
				<thead>
					<tr>
						<th width="40%"><?php echo ucfirst($this->t('defalt','Domyślnie')) ?></th>
						<th class="form-inline"><?php echo ucfirst($this->t('translation','Tłumaczenie')) ?>
							<label class="checkbox"><input type="checkbox" name="filters[only_empty]" value="1" id="only_empty" <?php echo $this->list->GetFilter('only_empty') ? 'checked="checked"' : '' ?> /> <?php echo $this->t('show only empty','Pokaż tylko puste') ?></label>
						</th>
						<th width="20"><?php echo $this->t('delete','Usuń') ?></td>
					</tr>
				</thead>

				<tbody>

					<?php if ($rows = $this->list->population()): foreach ($rows as $k => $o): ?>

					<tr>
						<td><?php echo $o->get('I18n_Translation.text') ?></td>
						<td>
							<textarea class="input-xxlarge" id="description" rows="1" style="height: 20px;" name="t[<?php echo $o->get('I18n_Translation.key') ?>]"><?php echo $o->get('ToTranslate.text') ?></textarea>
						</td>
						<td><?php if ($o->get('I18n_Translation.key')): ?><input type="checkbox" name="d[<?php echo $o->get('I18n_Translation.key') ?>]" value="1" /><?php endif ?></td>
					</tr>

					<?php endforeach; else: ?>

					<tr><td colspan="2"><?php echo $this->t('no translations in database','No translations in database.') ?></td></tr>

					<?php endif; ?>

				</tbody>
			</table>

			<?php echo $this->list->navigation() ?>
			
		</form>
	
	</div>
		
</div>

<script type="text/javascript">

$('.btn-save-changes').live('click',function(e){
		
	e.preventDefault();

	var btn = $(this);

	//$('.btn-save-changes').button('loading');

	var form = $('#edit-form');

	//$.post('<?php echo $this->link->Build($this->name.'/'.$this->view.'/') ?>',form.serialize(),function(data){
		
		//$('.btn-save-changes').button('complete');
		
		form.submit();
		
	//});
});

$(document).ready(function(){
	
	$('#only_empty').live('click',function(){

		$('#filter_only_empty').val(($('#only_empty').attr('checked') ? '1' : '0'));
		
		$('#form-search').submit();
	}); 
});

</script>