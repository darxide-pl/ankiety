<div id="form-signin-bg">
	<div class="container">
		<form action="<?php echo $this->link->Build(array($this->name));?>" method="post" class="form-signin">
			
			<input type="hidden" name="auth_action" value="login" />
			<h1 class="form-signin-heading">Witaj w domu</h1>
			<input type="text" class="form-control" name="auth_login" placeholder="Adres e-mail / Login" required="" autofocus="" />
			<input type="password" class="form-control" name="auth_password" placeholder="Hasło dostępowe" required="" />

			<input class="btn btn-lg btn-primary btn-block" type="submit" value="Zaloguj się" />
		</form>
		<!--<p class="text-center sign-up"><strong>Sign up</strong> for a new account</p>-->
	</div>
</div>
