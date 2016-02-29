

<div class="page-contact">

	<div class="breadcrumb-box">
		<div class="wrapper">
			<?php echo Breadcrumbs::build() ?>
		</div>
	</div>

	<div class="wrapper">

		

		<div class="text">
			
			<?php if ($this->auth->checkRight('admin|programers')): ?>
			<div id="editable" style="clear: both; overflow: hidden;">
				<?php echo $object->get('text') ?>
			</div>
			<?php else: ?>
			<?php echo $object->get('text') ?>
			<?php endif; ?>
		</div>

		<form action="" method="post" class="contact-form">

			<input type="hidden" name="page_action" value="<?php echo f_eas('Contact_Form|send') ?>">

			<h2>Formularz kontaktowy</h2>
			<p>Zapraszamy do kontaktu z konsultantami do spraw oprogramowania CATI-System: biuro@cati-system.pl</p>
			<label for="name">Personalia:</label>
			<input class="form-control" type="text" placeholder="Wpisz imię i/lub nazwisko" name="name" required>
			<label for="email">Adres Email:</label>
			<input class="form-control" placeholder="Wpisz swój adres email" type="text" name="email" required="required">
			<label for="email">Twoja wiadomość:</label>
			<textarea class="form-control message" placeholder="Swoją wiadomość wpisz tutaj" name="text" required></textarea>
			<textarea name="additional" class="form-control" placeholder="" style="display: none;"></textarea>
			<div class="controls">
				<button class="btn btn-primary" type="submit"><i class="i i-arrow-right-small-white"></i> WYŚLIJ FORMULARZ</button>
				<button class="btn btn-transparent" type="reset"><i class="i i-x"></i> WYCZYŚĆ</button>
			</div>
		</form>	

		<?php if ($this->auth->checkRight('admin|programers')): ?>
		<div class="admin-page-toolbar">
			<a href="#" class="btn btn-success" id="btn-edit-page">Edytuj treść strony</a>
		</div>
		<?php endif; ?>
		
	</div>
</div>

	<?php /*
	<form action="" method="post" class="contact-form" id="contact-form">
		
		<input type="hidden" name="page_action" value="<?php echo f_eas('Contact_Form|send') ?>">

		<h1><strong>Formularz kontaktowy</strong></h1>
	
		<div class="form-group floating-label-form-group">
			<label for="title">Imię i nazwisko</label>
			<input class="form-control v-empty" type="text" name="name" placeholder="Imię i nazwisko">
		</div>
	
		<div class="form-group floating-label-form-group">
			<label for="title">Telefon</label>
			<input class="form-control v-empty" type="text" name="phone" placeholder="Telefon">
		</div>
	
		<div class="form-group floating-label-form-group">
			<label for="title">Adres e-mail</label>
			<input class="form-control v-empty" type="text" name="email" placeholder="Adres e-mail">
		</div>
	
		<div class="form-group floating-label-form-group">
			<label for="title">Zapytanie</label>
			<textarea name="text" class="form-control v-empty" placeholder="Zapytanie"></textarea>
		</div>

		<div class="form-group" style="display: none;">
			<label for="title">Odpowiedź</label>
			<textarea name="additional" class="form-control" placeholder=""></textarea>
		</div>

		<div class="form-group">
			<button class="btn btn-lg btn-primary">WYŚLIJ FORMULARZ</button>
		</div>

	</form>*/ ?>