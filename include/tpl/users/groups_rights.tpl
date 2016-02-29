<script type="text/javascript">
//<!--//

$(document).ready(function(){
	
	$('.radio_cell input[type="checkbox"]').change(function(){
		var $this = $(this);
		$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Users_Groups|save_single_right'))) ?>',
			encodeURI($this.attr('name')+'='+($this.attr('checked')?1:0)),
			function(data){
				$this.parent().css('backgroundColor','orange');
			}
		);
	});

	$('#btn-rebuild-config').click(function(e){
		e.preventDefault();
		$.post('<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Users_Groups|rewrite_config_file'))) ?>',
			'',
			function(data){
				alert(data);
			}
		);
		return false;
	});
	
});
//-->
</script>

<div id="content">

	<form action="" method="post" id="save_form" name="save_form">

		<div class="btn-toolbar text-center">
			<a class="btn btn-default" href="<?php echo $this->link->Build(array($this->name, $this->view, 'page_action' => f_eas('System_Modules|rebuild_all') )) ?>"><i class="icon icon-refresh"></i> Odśwież moduły</a>
			<button class="btn btn-primary" id="btn-rebuild-config">Generuj pliki praw grup</button>
		</div>

		<table class="table table-striped">
		<thead>
			<tr>
				<th></th>
				<?php
					if ($ugroups): foreach ($ugroups as $group):
						echo '<th>'.$group['name'].'</th>';
					endforeach; endif; ?>
			</tr>
		</thead>
		<tbody>

		<?php if ($rows = $this->list->population()): ?>

			<?php

			$module = '';
			$show_group = $this->get('module_id');
			$first = (bool) !$show_group;

			foreach ($rows as $o):?>
			<tr>
				<th><?php echo $o['System_Module.title'] ?> <small class="text-muted pull-right" style="font-weight: normal;"><?php echo $o['System_Module.name'] ?></small></th>
				<?php 
				if ($ugroups):
				foreach ($ugroups as $group):?>
				<?php $active = $modules_rights[$group['id']][$o['System_Module.object']] ?>
				<td width="80" class="radio_cell" align="center" style="<?php echo $active ? 'background: #99ff99;' : ''?>">
					<input type="checkbox" name="mr[<?php echo $o['System_Module.object'] ?>][<?php echo $group['id'] ?>]" value="1" <?php echo $active ? 'checked="checked"' : '' ?> />
				</td>
				<?php endforeach;
				endif;
				?>
			</tr>
				<?php if ($first) $first = false; ?>
				<?php if ($views[$o['System_Module.object']]):?>
					<?php foreach ($views[$o['System_Module.object']] as $view):?>
			<tr>
				<td><?php echo $view['System_Module_View.title'] ?>
					<small class="text-muted pull-right"><?php echo $view['System_Module_View.name'] ?></small></td>

				<?php if ($ugroups): ?>
				<?php foreach ($ugroups as $group): ?>
				<?php $active = $view_rights[$o['System_Module.object'].'-'.$view['System_Module_View.view'].'-'.$group['id']] ?>
				<td width="80" align="center" class="radio_cell" style="<?php echo $active ? 'background: #99ff99;' : ''?>">
					<input type="checkbox" name="r[<?php echo $o['System_Module.object'] ?>][<?php echo $view['System_Module_View.view'] ?>][<?php echo $group['id'] ?>]" value="1" <?php echo $active ? 'checked="checked"' : '' ?> /></td>
				<?php endforeach ?>
				<?php endif ?>
			</tr>
					<?php endforeach;?>
				<?php endif;?>

		<?php endforeach; else: ?>
		<tr><td colspan="5">Brak modułów w systemie.</td></tr>
		<?php endif; ?>

		

		</tbody>
		</table>

		<?php echo $this->list->foot() ?>

	</form>
	
</div>