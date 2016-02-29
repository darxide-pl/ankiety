<div class="container">

	<div class="row">
		<div class="span6">
			<h2>Ostatnio zalogowani</h2>
			<?php if ($users): ?>
			<table class="table table-condensed">
			<?php foreach ($users as $u): ?>
				<tr>
					<td><?php echo $u['name'].' '.$u['lastname'] ?></td>
					<td><?php echo $u['date'] ?></td>
					<td><?php echo f_time_to_string2(strtotime($u['last_action_time'])-strtotime($u['date']),3) ?></td>
				</tr>
			<?php endforeach ?>
			</table>
			<?php else: ?>
			<p>Brak użytkowników.</p>
			<?php endif ?>
		</div>
	</div>
</div>