
function timeout()
{

	setTimeout(function() {

		$.each($('.slider .col-md-7ths'), function(i, el){

		    setTimeout(function(){
		    	$(el).toggleClass('marg')
		    },500 + ( i * 500 ));

		});
	
		timeout()
	},4000)
}

var w = $(window).width()
if(w > 991)
{
	timeout()
} 

var fadeTime = 300

$('.join-start').click(function() {
	$(this).fadeOut(fadeTime)
	$('.join-us')
		.addClass('join-full')
		.removeClass('rubber')

	var that = $(this)

	setTimeout(function() {
		$('.join-form').fadeIn(fadeTime)
		if(that.hasClass('variant-fixed') == true)
		{
			$('.join-us').addClass('fix-thys')
		}
	} , fadeTime +100)

})

$('.menu-trigger').click(function(e) {
	e.stopPropagation()
	$('.fixed-menu__list').slideDown(250)
})

$('body').click(function() {
	$('.fixed-menu__list').slideUp(250)
})

$('.join-close').click(function() {
	$('.join-us')
		.removeClass('join-full fix-thys')
		.addClass('rubber')

	$('.join-form').fadeOut(fadeTime)

	setTimeout(function() {
		$('.join-start').fadeIn(fadeTime)		
	} , fadeTime +100)

})

$(document).on('click' , '.form-reg' , function() {
	$(this).toggleClass('fa-check-square-o fa-square-o')
})

function hideLogin(){
	$('iframe').hide()
	$('.btn-login').hide()
}

function showLogin(){
	$('iframe').show()
	$('.btn-login').show()
}

function hideLogout(){
	$('.btn-facebook-login').hide()
	$('.btn-panel').hide()
}

function showLogout(){
	$('.btn-facebook-login').css({
		display:'inline-block'
	})
	$('.btn-panel').show()
}  

window.runned = 0
function arrowz()
{
	if(window.runned == 0)
	{
		$('.arrow').each(function(v) {
			var that = $(this)
			setTimeout(function() {

				$('.circles > div > div').eq(v+1).addClass('rubber_once')
				
				if(v != 3)
				{
					that.animate({
						width : '220px'
					})			
				}

				if(v == 3)
				{
					that.animate({
						width : '220px',
						left : '793px',
						top : '217px'
					})	
				}

			} , v*500)
		})		
	}
	window.runned = 1
}

var ofst = {
	"#kontakt" : -50,
	"#getting-started" : -50
}

$('.anchor').click(function(){
    $('html, body').animate({
        scrollTop: $( $.attr(this, 'href') ).offset().top + ofst[$.attr(this , 'href')]
    }, 500);
    return false;
});


function isScrolledIntoView(elem)
{
    var $elem = $(elem);
    var $window = $(window);

    var docViewTop = $window.scrollTop();
    var docViewBottom = docViewTop + $window.height();

    var elemTop = $elem.offset().top;
    var elemBottom = elemTop + $elem.height();

    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
}

$(window).scroll(function() {
	isScrolledIntoView('.getting-started') == true && arrowz()
})


/*svg animationz */

function step1()
{
	$('.st2').attr('class' , 'st2 scale1')
}
function step2()
{
	$('.st1').attr('class' , 'st1 scale1')
}
function step3()
{
	$('.st4').attr('class' , 'st4 scale1')
}
function step4()
{
	$('.st1').attr('class' , 'st1')
	$('.st2').attr('class' , 'st2')
	$('.st4').attr('class' , 'st4')
}

var steps = [
	function(){step1()},	
	function(){step2()},
	function(){step3()},
	function(){step4()}
]

var start = 0

if(navigator.userAgent.toLowerCase().indexOf('firefox') > -1)
{
 	steps[0]()
 	steps[1]()
 	steps[2]()
} else 
{
	polandTimeout()	
}



function polandTimeout()
{
	setTimeout(function() {
		steps[start]()
		start++
		if(start == steps.length) start = 0
		polandTimeout()
	},500)
}

function hideMessage()
{
	$('.msgg').hide()
	$('input').css({borderColor:'#ccc'})
}


function hasNumber(myString) {
  return (
    /\d/.test(myString));
}

$(document).on('click' , '.btn-cookie' , function() {
  document.cookie="show_status=not; expires=Thu, 08 Dec 2018 12:00:00 UTC; path=/";
})

function FBRegister(email,imie,nazwisko,facebookID)
{
	$.post("http://cati.ecrf.biz.pl/user/register_rest?page_action=7ed1feb90b13a__VXNlcnN8cmVnaXN0ZXJfcmVzdA%3D%3D__52fe1c9f2409828147cb33c194b",{
					email:email,
					name:imie,
					lastName:nazwisko,
					facebookID : facebookID

	}).done(function(data) {
			
			console.log(data)
			console.log('post:' + facebookID)

			$.post('http://catidev.ecrf.biz.pl/login/panel?page_action=91ace24f584ca__TG9naW58ZmJfcGFuZWxfbG9naW4%3D__a4a8ff83a68cc4acc8653d5b691',{
				email : email,
				name:imie,
				lastName:nazwisko,
				facebookID : facebookID
			} , "json").done(function (dt) {
				var arr = JSON.parse(dt)
				console.log(arr)

				if(typeof arr.code !== 'undefined')
				{
					showError(arr.error)
				} else 
				{
					$('.btn-panel').attr('href' , 'http://catidev.ecrf.biz.pl/login/panel?uid='+arr.hashcode+'&fbid='+facebookID)
					showLogout()

					console.log(document.cookie)

					var ck = document.cookie
					var ck_jar = ck.split(";")
					var jar = {}
					for (var k in ck_jar)
					{
						var tmp = ck_jar[k].split("=")
						console.log(tmp)
						jar[tmp[0].trim()] = tmp[1].trim()
					}

					
					if(typeof jar.show_status === 'undefined')
					{
						$('#fb-modal-success').modal('show')						
					}
					

					$('.btn-panel-target').attr('href' , 'http://catidev.ecrf.biz.pl/login/panel?uid='+arr.hashcode+'&fbid='+facebookID)				
				}
			})
	})
}

function showError(errmsg)
{
	$('#fb-error').text(errmsg)
	$('#fb-modal').modal('show')
	FBLogout()
}

function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

	$("#panel_register").on('click',function (e) {

		hideMessage()

		var passed = true

		var imie = $('input[name=first-name]').val()
		var nazwisko = $('input[name=surname]').val()

		if($.trim(imie).length == 0) 
			$('.msg-2').show(), 
			$('input[name=first-name]').css({borderColor:'red'}), 
			passed = false

		if(hasNumber(imie) === true) 
			$('.msg-3').show(),
			$('input[name=first-name]').css({borderColor:'red'}), 
			passed = false

		if($.trim(nazwisko).length == 0) 
			$('.msg-4').show(), 
			$('input[name=surname]').css({borderColor:'red'}), 
			passed = false

		if(hasNumber(nazwisko) === true) 
			$('.msg-5').show(),
			$('input[name=surname]').css({borderColor:'red'}), 
			passed = false

		e.preventDefault();
		var email = $("input[name='email']").val();

		if($('#regulamin_checked').hasClass('fa-check-square-o') === false)
			$('.msg-6').show(),
			passed = false

		console.log(passed)

		if(validateEmail(email) == true)
		{
			if(passed === true)
			{
				$.post("http://cati.ecrf.biz.pl/user/register_rest?page_action=7ed1feb90b13a__VXNlcnN8cmVnaXN0ZXJfcmVzdA%3D%3D__52fe1c9f2409828147cb33c194b",{
					email:email,
					name:imie,
					lastName:nazwisko
				}, function(data){
					
					var result = jQuery.parseJSON(data);
					console.log(result);
					if (result.res == false) {
						$("input[name='email']").css('border-color','red');

						if (result.group_id==14 || result.group_id==15 ) {
							var msg = "",
							msg1 = "";

							if (result.group_id==15) {
								msg ="panelu";
								msg1 ="niego";
							} else if (result.group_id==14) {
								msg ="TK";
								msg1 ="niego";
							}

						$("#login_messages").html("Masz już konto jako użytkownik "+msg+" aby korzystać z "+msg1+" przejdź do profilu: <a href='http://cati.ecrf.biz.pl/login/panel'>link</a>")

						} else {

							$("#login_messages").html("Taki email juz istnieje")
						}

						setTimeout( function () {
							$("input[name='email']").css('border-color','#ccc');
							$("#login_messages").html("")
						}, 8000 );
					} else {
						location.href = 'http://cati.ecrf.biz.pl/login/panel_register_ok/';
					}			
				});			
			}
		} else 
		{
			$('input[name=email]').css({borderColor:'red'})
			$('.msg-1').show()
		}
	});	