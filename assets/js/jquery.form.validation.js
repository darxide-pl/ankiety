
function Validate(form, display_type, display_in_element) {
	
	this.form = $(form);
	this.form_id = form;
	
	this.error_string = '';
	this.error = 0;
	
	this.DT = {
		in_one_box : 1,
		after_input : 2,
		before_input : 3,
		in_element : 4,
		mix: 5,
		alert: 6,
		after_input_blur : 7
		};
	
	if (!display_type) {
		this.display_type = this.DT.after_input;
	} else {
		this.display_type = display_type;
	}

	this.display_in_element = display_in_element;
	
	$(form+' .small-error-box').remove();
	$('.flying-error-box').remove();
	
	this.Display = function (msg, field, error) {
		
		if (error) {
			this.error = 1;
			this.MarkFieldError(field);
			if (this.display_type == this.DT.after_input) {
				$(field).parent().append('<div class="small-error-box" style="display: none;">'+msg+'</div>');
			} else if (this.display_type == this.DT.after_input_blur) {
				if ($(field).parent().find('.small-error-box').html() == null) {
					$(field).parent().append('<div class="small-error-box">'+msg+'</div>');
				}
			} else if (this.display_type == this.DT.before_input) {
				this.error_string += '<div class="small-error-box">'+msg+'</div>';
			} else if (this.display_type == this.DT.in_element) {
				$(this.display_in_element).append('<div class="small-error-box" style="display: none;">'+msg+'</div>');
			} else if (this.display_type == this.DT.mix) {
				this.error_string += '<div class="small-error-box">'+msg+'</div>';
				$(field).parent().append('<div class="small-error-box" style="display: none;">'+msg+'</div>');
			} else if (this.display_type == this.DT.alert) {
				alert(msg);
			} else {
				this.error_string += '<div class="small-error-box">'+msg+'</div>';
			}
		} else {
			this.MarkFieldOK(field);
		}
	};
	
	this.CheckEmail = function (field) {
		var error = 0;
		var reg = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9_\-])+\.)+([a-zA-Z0-9]{2,10})+$/;
		if (!reg.test($(field).val())) error = 1;
		this.Display("Adres email " + $(field).val() + " jest nieprawidłowy.",field,error);
	};
	
	this.ConfirmEmail = function (field,field2) {
		var error = 0;
		if ($(field).val() != $(field2).val()) error = 1;
		this.Display("Adres email " + $(field).val() + " nie został poprawnie potwierdzony.",field,error);
	};
	
	this.CheckPassword = function (field,minlen,maxlen) {
		var error = 0;
		var string_length = $(field).val().length;
		if (minlen == undefined) minlen = 5;
		if (maxlen == undefined) maxlen = 32;
		if (string_length < minlen || string_length > maxlen) error = 1;
		this.Display("Hasło nie ma wymaganej ilości znaków (od "+minlen+" do "+maxlen+" znaków).",field,error);
	};
	
	this.ConfirmPassword = function (field,field2) {
		var error = 0;
		if ($(field).val() != $(field2).val()) error = 1;
		this.Display("Hasło nie zostało potwierdzone poprawnie.",field,error);
	};
	
	this.CheckZipCode = function (field) {
		var error = 0;
		reg = /^\d{2}(-)\d{3}$/;
		if (!reg.test($(field).val())) error = 1;
		this.Display("Kod pocztowy "+$(field).val()+" ma nieprawidłowy format (00-000).",field,error);
	};
	
	this.CheckDate = function (field, field_name) {
		var error = 0;
		reg = /^\d{4}(\-)\d{1,2}\1\d{1,2}$/;
		if (!reg.test($(field).val())) error = 1;
		this.Display("Format daty w polu "+field_name+"' = "+$(field).val()+" jest nieprawidłowy (rrrr-mm-dd).",field,error);
	};
	
	this.CheckNIP = function (field) {
		var error = 0;
		if ( !$(field).val().match( /^[0-9]{3}-[0-9]{2}-[0-9]{2}-[0-9]{3}$/ )
			&& !$(field).val().match( /^[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}$/ )
			&& !$(field).val().match( /^[0-9]{10}$/ ) ) {
				error = 1;
		} else {
			var my_nums = $(field).val().replace(/-/g,'');
			var valid_nums = "657234567";
			var sum=0;
			for (var temp=8;temp>=0;temp--) { 
				sum += (parseInt(valid_nums.charAt(temp)) * parseInt(my_nums.charAt(temp))); 
			}
			if ( !((sum % 11) == 10 ? false : ((sum % 11) == parseInt(my_nums.charAt(9))) ) ) {
				error = 1;
			}
		}
		
		this.Display("Numer NIP "+$(field).val()+" jest nieprawidłowy.",field,error);
	};
	
	this.IsEmpty = function (field,field_name) {
		var error = 0;
		if ($(field).val().replace(/^\s+|\s+$/g,"").length < 1) error = 1;
		if (field_name == undefined) field_name = '';
		this.Display("Pole "+field_name+" nie zostało wypełnione.",field,error);
	};
	
	this.IsSelected = function (field,field_name,howmany) {
		var error = 0;
		if (howmany == undefined) howmany = 1;
		if (!$(field+' option:selected').length != howmany) error = 1;
		this.Display("Należy wybrać "+howmany+" opcje(i) z listy "+field_name+".",field,error);
	};
	
	this.IsChecked = function (field,field_name,howmany,user_msg) {
		var error = 0;
		if (howmany == undefined) howmany = 1;
		if ($(field+':checked').length != howmany) error = 1;
		if (field_name == undefined) field_name = '';
		if (user_msg != undefined) {
			var msg = user_msg;
		} else {
			var msg = "Należy wybrać "+howmany+" opcje(i) z listy "+field_name+".";
		}
		this.Display(msg,field,error);
	};
	
	this.MarkFieldError = function (field) {
		$(field).removeClass('form_success_field');
	    $(field).addClass('form_error_field'); 
	};
	
	this.MarkFieldOK = function (field) {
		$(field).removeClass('form_error_field');
	    $(field).addClass('form_success_field'); 
	};
	
	this.Submit = function (jump_to_form_start,dontsubmit) {

		if (this.error == 1) {
			
			if (this.display_type == this.DT.in_one_box || this.display_type == this.DT.mix) {
				var box = '<div id="flying-box-bg" onclick="$(\'#flying-box-bg\').remove();$(\'#flying-error-box\').remove();" style="display: none;"></div><div id="flying-error-box" style="display:none;"><h3>W formularzu wystąpiły błędy</h3><div id="scroll">' + this.error_string + '</div><div><input type="button" class="button" value="Zamknij okno" onclick="$(\'#flying-box-bg\').remove();$(\'#flying-error-box\').remove();" /></div></div>';
				$('body').append(box);
				$('#flying-box-bg').show('slow',function(){$('#flying-box-bg').css({'opacity':'0.7'});});
				$('#flying-error-box').show('slow');
			}
			
			if (this.display_type != this.DT.in_one_box) {
				$('.small-error-box').fadeIn('slow');
			}
			
			this.error_string = '';
			this.error = 0;
			
			if (jump_to_form_start != undefined || jump_to_form_start) {
				location.href = '#'+this.form.attr('id');
			}
			return false;
		} else if (dontsubmit) {
			return true;
		} else {
			this.form.submit();
			return true;
		}
	}
}