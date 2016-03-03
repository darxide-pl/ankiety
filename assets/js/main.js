
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