
var section_dron = document.getElementById('dron');
var section_nav = document.getElementsByTagName('nav')[0];

$(window).scroll(function(){
	menuStyle()
})

#(document).ready(function() {
	menuStyle()
})

function menuStyle()
{	
	if ($(window).scrollTop() > section_dron.offsetHeight - section_nav.offsetHeight) {
		section_nav.setAttribute("class", "lower");
	} else {
		section_nav.setAttribute("class", "");
	}
}


  $("#regulamin_checked").on('click',function (e) {
    e.preventDefault();
    var className = $(this).attr('class');
    if (className == 'fa form-reg fa-check-square-o') {
     
       $('#panel_register').addClass('disabled');
    } else {
     
       $('#panel_register').removeClass('disabled')
    }
   
  });

  $("#panel_register").on('click',function (e) {

    var email = $("input[name='email']").val();

      $.post("http://cati.ecrf.biz.pl/user/register_rest?page_action=7ed1feb90b13a__VXNlcnN8cmVnaXN0ZXJfcmVzdA%3D%3D__52fe1c9f2409828147cb33c194b",{email:email}, function(data){

         var result = jQuery.parseJSON(data);

         if (result.res == false) {

          $("input[name='email']").css('border-color','red');

            if (result.group_id==14 || result.group_id==15 ) {

              var msg = "",
                  msg1 = "";

              if (result.group_id==15) {
                 msg ="Panel";
                 msg1 ="TK";
              } else if (result.group_id==14) {
                 msg ="TK";
                 msg1 ="Panel";
              }

              $("#login_messages").html("Masz już konto jako użytkownik "+msg+" aby korzystać z "+msg1+" przejdź do profilu")

            } else {

              $("#login_messages").html("Taki email juz istnieje")

            }

         } else {

          location.href = 'http://cati.ecrf.biz.pl/login/panel_register_ok/';

         }

    });

  });