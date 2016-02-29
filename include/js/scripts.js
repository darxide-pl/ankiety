(function($) {
	$.fn.serializeAnything = function() {
		var toReturn = [];
		$.each(this, function() {
			if (this.name && !this.disabled && (this.checked || /select|textarea/i.test(this.nodeName) || /text|hidden|password/i.test(this.type))) {
				var val = $(this).val();
				toReturn.push( encodeURIComponent(this.name) + "=" + encodeURIComponent( val ) );
			}
		});
		return toReturn.join("&").replace(/%20/g, "+");
	}
})(jQuery);

$(document).ready(function(){
	
	setTimeout(function(){$('.success-box:visible').fadeOut(1500);$('.error-box:visible').fadeOut(1500);},4000);
	
	jQuery(function($){
		$.datepicker.regional['pl'] = {
			closeText: 'Zamknij',
			prevText: '&#x3c;Poprzedni',
			nextText: 'Następny&#x3e;',
			currentText: 'Dziś',
			monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj','Czerwiec',
			'Lipiec','Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
			monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze',
			'Lip','Sie','Wrz','Pa','Lis','Gru'],
			dayNames: ['Niedziela','Poniedziałek','Wtorek','Środa','Czwartek','Piątek','Sobota'],
			dayNamesShort: ['Nie','Pn','Wt','Śr','Czw','Pt','So'],
			dayNamesMin: ['N','Pn','Wt','Śr','Cz','Pt','So'],
			weekHeader: 'Tydz',
			dateFormat: 'yy-mm-dd',
			firstDay: 1,
			isRTL: false,
			showMonthAfterYear: false,
			yearSuffix: ''};
		$.datepicker.setDefaults($.datepicker.regional['pl']);
	});
	
	$('.datepicker').datepicker();

	$('a.confirm').click(function(){
		return confirm($(this).attr('title'));
	});
	
	// stop default btn actions (eg. form submit)
	$('button.btn').click(function(e){
		if ($(this).hasClass('islink')) {
			if ($(this).hasClass('confirm')) {
				if (confirm($(this).attr('title'))) {
					location.href = $(this).val();
				}
			} else {
				location.href = $(this).val();
			}
		}
		e.preventDefault();
	});
	
	// add active state to input backgrounds
	$('div.btn input[type="checkbox"]').click(function(){
		if ($(this).parent().hasClass('btn-active')) {
			$(this).parent().removeClass('btn-active');
		} else {
			$(this).parent().addClass('btn-active');
		}
		return true;
	});
	
	// add active state to input backgrounds
	$('div.btn input[type="text"]').click(function(){
		$(this).parent().addClass('btn-active');
	});

	// remove active state from leaved inputs
	$('div.btn input[type="text"]').blur(function(){
		$(this).parent().removeClass('btn-active');
	});
	
	$('.side-menu-title').click(function(){
		$(this).next().toggle();
	});

	$('.btn-ls-trigger').click(function(){
		if ($(this).find('.btn-ls:visible').size()) {
			$(this).find('.btn-ls').hide();
		} else {
			$(this).find('.btn-ls').show();
		}
		
	});

	$('.btn-ls-it').click(function(){
		$(this).parent().prev('input').val($(this).attr('title'));
		$(this).parent().parent().find('.btn-ls-text').html($(this).html());
		$('.btn-ls').hide();
		return false;
	});
	
	$('.btn-m-btn').click(function(){
		var a = $(this).next();
		if (a.is(':visible')) {
			$(this).next().stop(true,true).fadeOut();
		} else {
			$('.btn-m2:visible').hide();
			$(this).next().stop(true,true).fadeIn();
		}
	});
});