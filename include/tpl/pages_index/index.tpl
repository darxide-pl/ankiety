<div class="slider2">
  <div class="wrapper">
    <div class="col-md-7ths col-sm-7ths slide-check">
      <img src="<?php echo BASE_DIR ?>/assets/img/slice1.jpg" />
      <img src="<?php echo BASE_DIR ?>/assets/img/slice4.jpg" class="hidden-xs hidden-sm" />
    </div>
    <div class="col-md-7ths col-sm-7ths">
      <img src="<?php echo BASE_DIR ?>/assets/img/slice2.jpg" />
      <img src="<?php echo BASE_DIR ?>/assets/img/slice5.jpg" class="hidden-xs hidden-sm" />      
    </div>
    <div class="col-md-7ths col-sm-7ths">
      <img src="<?php echo BASE_DIR ?>/assets/img/slice3.jpg" />
      <img src="<?php echo BASE_DIR ?>/assets/img/slice6.jpg" class="hidden-xs hidden-sm" />
    </div>
    <div class="col-md-7ths col-sm-7ths">
      <img src="<?php echo BASE_DIR ?>/assets/img/slice4.jpg" />
      <img src="<?php echo BASE_DIR ?>/assets/img/slice7.jpg" class="hidden-xs hidden-sm" />      
    </div>
    <div class="col-md-7ths col-sm-7ths">
      <img src="<?php echo BASE_DIR ?>/assets/img/slice5.jpg" />
      <img src="<?php echo BASE_DIR ?>/assets/img/slice1.jpg" class="hidden-xs hidden-sm" />      
    </div>
    <div class="col-md-7ths col-sm-7ths">
      <img src="<?php echo BASE_DIR ?>/assets/img/slice6.jpg" />
      <img src="<?php echo BASE_DIR ?>/assets/img/slice2.jpg" class="hidden-xs hidden-sm" />
    </div>
    <div class="col-md-7ths col-sm-7ths">
      <img src="<?php echo BASE_DIR ?>/assets/img/slice7.jpg" />
      <img src="<?php echo BASE_DIR ?>/assets/img/slice3.jpg" class="hidden-xs hidden-sm" />      
    </div>

    <div class="join-us rubber">
        <div class="wrapping">
          <div class="join-start variant-fixed">
            <strong>Dołącz</strong><br>do nas
          </div>
          <div class="join-form">
           <div class="float-right" id="login_messages"></div>
            <i class="fa fa-times join-close"></i>
            <form action="http://cati.ecrf.biz.pl/user/register_rest" method="post" id="login_form"> 
            <div>Formularz rejestracyjny</div>
            <div class="msgg msg-1">email jest nieprawidłowy</div>
            <input class="form-control" placeholder="email" name="email"></input>  
            <div class="msgg msg-2">Podaj imię</div>
            <div class="msgg msg-3">Imię nie może zawierać liczby</div>                        
            <input class="form-control" placeholder="imię" name="first-name"></input>
            <div class="msgg msg-4">Podaj nazwisko</div>
            <div class="msgg msg-5">Nazwisko nie może zawierać liczby</div>            
            <input class="form-control" placeholder="nazwisko" name="surname"></input>
            <div class="msgg msg-6">Akceptacja regulaminu jest wymagana</div>
            <i id="regulamin_checked" class="fa fa-square-o form-reg"></i>rejestrując się, akceptuję <a href="/regulamin-panelu-badawczego">regulamin</a>  
            <input type="hidden" name="page_action" value="7ed1feb90b13a__VXNlcnN8cmVnaXN0ZXJfcmVzdA%3D%3D__52fe1c9f2409828147cb33c194b" />
            <input id="panel_register" class="btn btn-primary" value="Zarejestruj się" />
            </form>
          </div>
        </div>
    </div>
  </div>
</div>


<div class="breadcrumb-box">
	<div class="wrapper">
		<?php echo Breadcrumbs::build() ?>
	</div>
</div>

<div class="wrapper subpage">

	<div>

		<?php if ($object->get('alias') != 'system'): ?>
		<h1><?php echo $object->get('title') ?></h1>
		<?php endif; ?>

		<?php echo $object->get('lead') ?>

		<?php if ($this->auth->checkRight('admin|programers')): ?>
		<div id="editable" style="clear: both; overflow: hidden;">
			<?php echo $object->get('text') ?>
		</div>
		<?php else: ?>
		<?php echo $object->get('text') ?>
		<?php endif; ?>

	</div>

	<?php if ($this->auth->checkRight('admin|programers')): ?>
	<div class="admin-page-toolbar">
		<a href="#" class="btn btn-success" id="btn-edit-page">Edytuj treść strony</a>
	</div>
	<?php endif; ?>
</div>
			

<?php //include APPLICATION_PATH.'/include/tpl/pages_index/plugins/menu.tpl' ?>

<script type="text/javascript">

on(function(){


});
  
  console.log('a');
</script>