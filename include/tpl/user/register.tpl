<div class="container">
	<div class="hero-unit" style="margin: 100px auto; width: 600px;">
		
		<form class="form-vertical row-fluid">
			
			<input type="hidden" name="page_action" value="<?php echo f_eas('Users|register') ?>" />
			
			<p>Podaj adres email aby utworzyć nowe konto lub <a href="<?php echo $this->link->Build('/') ?>">przejdź do logowania</a>.</p>

			<div class="control-group">
				<input type="text" name="email" id="email" value="" class="span12 input-huge" placeholder="Adres e-mail" autocomplete="off" />
			</div>
			
			<div class="control-group" id="password" style="display: none;">
				<input type="password" name="password" value="" class="span12 input-huge" placeholder="Hasło" autocomplete="off" />
			</div>
		
			<div class="control-group">
				<input type="submit" value="Stwórz konto" class="btn btn-large btn-primary" />
				<a href="<?php echo $this->link->Build('/') ?>" class="btn btn-large" id="btn-login">Zaloguj się</a>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
$(function(){
	$('#email').focus(function(){
		$('#password').not(':visible').slideDown();
	});
});
</script>