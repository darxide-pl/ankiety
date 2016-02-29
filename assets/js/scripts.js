
function nl2br (str, is_xhtml) {
	// http://kevin.vanzonneveld.net
	var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br ' + '/>' : '<br>';
	return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
}

function password(length, special) {
	var iteration = 0;
	var password = "";
	var randomNumber;
	if(special == undefined){
		var special = false;
	}
	while(iteration < length){
		randomNumber = (Math.floor((Math.random() * 100)) % 94) + 33;
		if(!special){
			if ((randomNumber >=33) && (randomNumber <=47)) {
				continue;
			}
			if ((randomNumber >=58) && (randomNumber <=64)) {
				continue;
			}
			if ((randomNumber >=91) && (randomNumber <=96)) {
				continue;
			}
			if ((randomNumber >=123) && (randomNumber <=126)) {
				continue;
			}
		}
		iteration++;
		password += String.fromCharCode(randomNumber);
	}
	return password;
}

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

/*!
* Copyright Andrée Hansson, 2009
* Licensed under the MIT license
* http://www.opensource.org/licenses/mit-license.php
*
* Contact: E-mail: peolanha _AT gmail _DOT com
* Twitter: peolanha
* Website: http://andreehansson.se/
*/
(function ($) {
	var
	// Will contain the last events' string and element, used for comparison
	selObj = {
		str : "", 
		el : undefined
	},

	// Cache selection range methods
	docSel = document.selection,
	winSel = window.getSelection && window.getSelection(),

	// Events to be bound for our handler
	bindEvents = ['mouseup', 'keyup'],

	// Helper to grab currently selected text
	getSelected = function (evt) {

		// If the called event originates from a inputbox/form element (in FF), use that
		// to get the selected text (FF doesn't trigger getSelection() on input
		// elements natively)
		var el = $(evt.originalEvent.target).is(':input') ?
		evt.originalEvent.target :
		undefined;

		return el && +el.selectionEnd ?
		$(el).val().substring(el.selectionStart, el.selectionEnd) :
		(winSel || docSel.createRange().text || "").toString();
	},

	// Helper to grab which common ancestor the text has
	getOrigin = function (input) {
		return docSel && docSel.createRange().parentElement()
		|| input
		|| winSel && winSel.getRangeAt(0).commonAncestorContainer
		|| document.body;
	},

	// Create our custom event namespace
	$me = $.event.special.textselect = {

		// Do stuff when it is bound
		setup: function () {
			var that = this;

			// Hook mouseup to fire our custom event
			$(bindEvents).each(function (i, o) {
				$(that).bind(o, $me.handler);
			});
		},

		// Do stuff when it is unbound
		teardown: function () {
			var that = this;

			$(bindEvents).each(function (i, o) {
				$(that).unbind(o, $me.handler);
			});
		},

		// Do stuff when the event is triggered
		handler: function (evt) {

			// Since we're not letting jQuery handle this object (due to our return
			// parameters, we "fix" the event object to be cross-browser compliant
			// manually
			evt = $.event.fix(evt);

			// Grab currently selected text and its common ancestor element
			var
			curText = getSelected(evt),
			conElement = $(evt.originalEvent.target).is(':input') ?
			getOrigin(evt.originalEvent.target) :
			getOrigin();

			if (conElement.nodeType === 3) conElement = conElement.parentNode;

			// If it differs from the old selected text, trigger event
			if (selObj.str !== curText || selObj.el !== conElement) {

				// Set currently selected text (and element) to the actual currently
				// selected text and element
				selObj = {
					str : curText, 
					el : conElement
				};

				// Change event type to our custom event
				evt.type = 'textselect';

				// Fire the simulated event
				$.event.trigger(evt, [selObj.str, selObj.el]);
			}
		}
	};
})(jQuery);

$(document).ready(function(){
	
	$('.textarea-expand').autosize();
	
	setTimeout(function(){
		$('.page-alerts:visible').animate({
			height: 0
		},700,function(){$('.page-alerts').remove();});
	},4000);

	$('a.confirm').click(function(e){
		if (!confirm($(this).attr('title'))) {
			e.preventDefault();
			return false;
		}
	});
	
	$('.chosen-select').chosen();
	
	$('.modal-trigger').click(function(e){
		var $this = $(this);
		e.preventDefault();
		$($this.data('modal')+' .modal-body').load($this.data('load'),function(result){
			$($this.data('modal')).modal({show:true});
		});
	});
	
	$('.tip').tooltip();
	
	$('.form-control-clear').click(function(){
		$(this).prev().val('').focus();
	});
});