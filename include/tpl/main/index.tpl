
<style type="text/css">
ul.point-list { list-style: none; float: left; margin: 10px; padding: 0; }
ul.point-list li { margin: 3px 0 3px 15px;}
ul.point-list li.title {margin:3px 0;}
</style>

<div class="box-bg" style="float: right; width: 320px; margin-left: 5px;">
	
	<div class="box-head">
	
		<div class="box-title"><?php echo $this->t('About Application','O programie') ?></div>
		
	</div>
	
	<ul class="point-list">
		<li><?php echo $this->t('Name','Nazwa') ?>: <b>B2B</b></li>
		<li><?php echo $this->t('Version','Wersja') ?>: <b>2.0</b></li>
		<li><?php echo $this->t('Engine version','Wersja silnika') ?>: <b>2.1.0</b></li>
		<li><?php echo $this->t('Published','Data publikacji') ?>: 01.03.2012</li>
	</ul>

</div>

<div class="box-bg" style="float: right; width: 320px; margin-left: 5px;">
	
	<div class="box-head">
	
		<div class="box-title"><?php echo $this->t('Loged','Zalogowany') ?></div>
		
	</div>
	
	<ul class="point-list">
		<li><b><?php echo $page->auth->user['name'].' '.
			$page->auth->user['lastname'];?></b> (<?php echo $page->auth->user['login'];?>)</li>
		<li><?php echo $this->t('Group','Grupa') ?>: <b><?php echo $page->auth->user['group_name'];?></b></li>
		<li><?php echo $this->t('IP Address','Adres IP') ?>: <?php echo f_get_ip_address();?></li>
		<li><?php echo $this->t('From','Od') ?>: <?php echo f_time_ago_to_string(strtotime($page->auth->user['login_time']),1);?></li>
		<li><a href="<?php echo $this->link->Build(array('main','index','auth_action'=>'logout'));?>" class="error"><?php echo $this->t('Logout','Wyloguj się') ?></a></li>
	</ul>
	
</div>

<div class="box-bg">
	
	<div class="box-head">
	
		<div class="box-title"><?php echo $this->t('Navigation','Nawigacja') ?></div>
		
	</div>

	<?php $MenuWidget = new MainMenuWidget($page->menu);?>
	<?php echo $MenuWidget->BuildMenu();?>
</div>