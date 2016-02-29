<ul class="nav nav-list sidebar-nav">
	<li></li>
</ul>


<div class="right-side">
	
</div>

<div id="content">
	<div class="container-grey">
		<p>
			Zaproszenia do współpracy są ważne przez 48 godzin od złożenia.
		</p>
	</div>
	
	<div class="container-white">
		
		<div class="btn-toolbar">
			<a href="<?php echo $this->link->Build('user/invites/filters[status]/-1') ?>" class="btn <?php echo $this->list->getFilter('status') == '-1'  ? 'disabled' : '' ?>">Pokaż tylko nowe</a>
			<a href="<?php echo $this->link->Build('user/invites/filters[status]/1') ?>" class="btn <?php echo $this->list->getFilter('status') == '1'  ? 'disabled' : '' ?>">Pokaż tylko zatwierdzone</a>
			<a href="<?php echo $this->link->Build('user/invites/filters[status]/all') ?>" class="btn <?php echo $this->list->getFilter('status') == 'all' || ! $this->list->getFilter('status')  ? 'disabled' : '' ?>">Pokaż wszystkie zaproszenia</a>
		</div>
		
		<?php if ($invites = $this->list->population()): ?>
		<table class="table">
			<?php foreach ($invites as $o): ?>
			<tr>
				<td width="140"><?php echo $o->get('added') ?></td>
				<td>Przestrzeń robocza: <b><?php echo $o->get('workspace_name') ?></b><br />
					<a href="#"><?php echo $o->get('user_email') ?></a></td>
				<td width="80">
					<?php echo Model_User_Invite::$status[$o->get('status')] ?>
				</td>
				<td width="200">
					<?php if ($o->get('status') == '-1'): ?>
					<div class="btn-group">
						<a href="<?php echo $this->link->Build('user/invites/page_action/'.f_eas('Users|answer_invitation').'/decision/1/invite_id/'.$o->GetID()) ?>" class="btn btn-success">
							<i class="icon icon-ok icon-white"></i> Zatwierdź</a>
						<a href="<?php echo $this->link->Build('user/invites/page_action/'.f_eas('Users|answer_invitation').'/decision/0/invite_id/'.$o->GetID()) ?>" class="btn btn-danger">
							Odrzuć <i class="icon icon-remove icon-white"></i></a>
					</div>
					<?php else: ?>
					<?php endif ?>
				</td>
			</tr>
			<?php endforeach ?>
		</table>
		<?php else: ?>
		Nie posiadasz aktualnie żadnych zaproszeń :-(
		<?php endif ?>
		
	</div>
	
</div>