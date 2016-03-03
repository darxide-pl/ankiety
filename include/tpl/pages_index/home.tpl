<div class="slider">
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
          <div class="join-start">
            <strong>Dołącz</strong><br>do nas
          </div>
          
          <div class="join-form">
            <div class="float-right" id="login_messages"></div>
            <i class="fa fa-times join-close"></i>
            <form action="http://catidev.ecrf.biz.pl/user/register_rest" method="post" id="login_form"> 
              <input class="form-control" placeholder="email" name="email"></input>  
              <input class="form-control" placeholder="imię" name="first-name"></input>
              <input class="form-control" placeholder="nazwisko" name="surname"></input>
              <i class="fa fa-square-o form-reg"></i>rejestrując się, akceptuję <a href="/regulamin">regulamin</a>  
              <input type="hidden" name="page_action" value="7ed1feb90b13a__VXNlcnN8cmVnaXN0ZXJfcmVzdA%3D%3D__52fe1c9f2409828147cb33c194b" />
              <input id="panel_register" class="btn btn-primary" value="rejestruj" />
            </form>
          </div>
        </div>
    </div>

  </div>
</div>

<div class="getting-started" id="getting-started">
    <div class="wrapper">
        <div class="header">
            Jak zacząć
        </div>

        <div class="row-fluid circles hidden-xs ">
            <div class="col-md-3 col-sm-3"><div>01</div></div>
            <div class="col-md-3 col-sm-3"><div>02</div></div>
            <div class="col-md-3 col-sm-3"><div>03</div></div>
            <div class="col-md-3 col-sm-3"><div>04</div></div>
        </div>

        <div class="row-fluid labels">
            <div class="col-md-3 col-sm-3"><strong>Dołącz</strong> do nas</div>
            <div class="col-md-3 col-sm-3"><strong>Opowiedz</strong> o sobie</div>
            <div class="col-md-3 col-sm-3"><strong>Wyrażaj</strong> opinię</div>
            <div class="col-md-3 col-sm-3"><strong>Zbieraj</strong> profity</div>
        </div>

        <div class="arrow arrow1 hidden-xs hidden-sm">
            <img src="<?php echo BASE_DIR ?>/assets/img/arrow-up.png">
        </div>

        <div class="arrow arrow2 hidden-xs hidden-sm">
            <img src="<?php echo BASE_DIR ?>/assets/img/arrow-down-right.png" />
        </div>

        <div class="arrow arrow3 hidden-xs hidden-sm"> 
            <img src="<?php echo BASE_DIR ?>/assets/img/arrow-up.png" />
        </div>

        <div class="arrow arrow4 hidden-xs hidden-sm">
            <img src="<?php echo BASE_DIR ?>/assets/img/arrow-down-left.png" />
        </div>
    </div>
</div>


<div class="contact" id="kontakt">
    <div class="wrapper">
        <div>
            <img src="<?php echo BASE_DIR ?>/assets/img/logo.svg" />
        </div>
        <div style="margin-top: 25px;">
            (+48) 22 12 28 025<br>
            biuro@rstat.pl<br>
            ul. Kowalczyka 17<br>
            44-206 Rybnik
        </div>
    </div>
</div>

<script type="text/javascript">

on(function(){

  $("#panel_register").on('click',function (e) {

    var email = $("input[name='email']").val();

      $.post("http://catidev.ecrf.biz.pl/user/register_rest?page_action=7ed1feb90b13a__VXNlcnN8cmVnaXN0ZXJfcmVzdA%3D%3D__52fe1c9f2409828147cb33c194b",{email:email}, function(data){

         var result = jQuery.parseJSON(data);

         if (result.res == false) {

          $("input[name='email']").css('border-color','red');

          $("#login_messages").html("Taki email juz istnieje")

          console.log(result.msg);

         } else {

          location.href = 'http://catidev.ecrf.biz.pl/login/panel/';

         }

    });

  });


});
  
</script>