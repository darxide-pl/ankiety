<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">CMS</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-navbar">
			
			<ul class="nav navbar-nav">
				
				<li<?php echo $this->rv->get('menu') == 'pages' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('pages') ?>">Strony</a></li>
				
				<!--li<?php echo $this->rv->get('menu') == 'news' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('news') ?>">Aktualności</a></li-->
				
				<li<?php echo $this->rv->get('menu') == 'sliders' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('sliders') ?>">Slider</a></li>
				
				<li<?php echo $this->rv->get('menu') == 'contactforms' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('contactforms') ?>">Zapytania</a></li>

				<li<?php echo $this->rv->get('menu') == 'logos' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('logos') ?>">Loga</a></li>

				<!--li<?php echo $this->rv->get('box') == 'box' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('box') ?>">Boksy</a></li-->
				
				<!--li<?php echo $this->rv->get('menu') == 'products' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('products') ?>">Produkty</a></li-->
				
				<!--li<?php echo $this->rv->get('menu') == 'stores' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('stores') ?>">Sklepy</a></li-->
				
				<!--li<?php echo $this->rv->get('menu') == 'galleries' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('galleries') ?>">Galerie</a></li-->
				
				<!--li<?php echo $this->rv->get('menu') == 'events' ? ' class="active"' : '' ?>><a href="<?php echo $this->link->Build('events') ?>">Wydarzenia</a></li-->
				
				
				
				<li class="dropdown <?php echo $this->rv->get('menu') == 'configuration' ? 'active' : '' ?>">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="glyphicon glyphicon-cog"></i> <span class="visible-xs">&nbsp; Ustawienia</span></a>
					<ul class="dropdown-menu">
						<li><a href="<?php echo $this->link->Build('configuration/') ?>">Podstawowe</a></li>
						<?php if ($this->auth->isSuperadmin()): ?>
						<li><a href="<?php echo $this->link->Build('users/groups_rights/') ?>">Prawa dostępu</a></li>
						<?php endif ?>
						<li><a href="<?php echo $this->link->Build('system_messages/') ?>">Powiadomienia</a></li>
						<?php /*li class="divider"></li>
						<li><a href="<?php echo $this->link->Build('orders_payments/') ?>">Formy płatności</a></li>
						<li><a href="<?php echo $this->link->Build('orders_postages/') ?>">Formy dostawy</a></li*/ ?>
						<li class="divider"></li>
						<li><a href="<?php echo $this->link->Build('users/') ?>"><i class="glyphicon glyphicon-user"></i> Użytkownicy</a></li>
						<?php if ($this->auth->isSuperadmin()): ?>
						<li><a href="<?php echo $this->link->Build('system_languages/') ?>"><i class="icon icon-book"></i> Wersje językowe</a></li>
						<?php endif ?>
					</ul>
				</li>
			</ul>
			
			<ul class="nav navbar-nav">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-plus text-muted"></i></a>
					<ul class="dropdown-menu">
						
					</ul>
				</li>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<?php echo $this->auth->user['name'].' '.$this->auth->user['lastname'] ?> 
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li><a href="<?php echo $this->link->Build('user') ?>"><i class="glyphicon glyphicon-user"></i> &nbsp; Mój profil</a></li>
						<li class="divider"></li>
						<li><a href="?auth_action=logout"><i class="glyphicon glyphicon-off"></i> &nbsp; Wyloguj się</a></li>
						<?php if (Auth::isSuperadmin()): ?>
						<li class="divider"></li>
						<li><a href="?page_action=<?php echo f_eas('Rootkit|clear_cache') ?>"><i class="glyphicon glyphicon-refresh"></i> &nbsp; Wyszyść Cache</a></li>
						<?php endif ?>
					</ul>
				</li>
			</ul>
		</div><!-- /.navbar-collapse -->
	</div><!-- /.container-fluid -->
</nav>