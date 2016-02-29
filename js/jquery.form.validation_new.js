
function FormValidate(form, settings, validation) {
	
	// Create some defaults, extending them with any options that were provided
	settings = $.extend({
		mode : 'default',
		preventSubmit : 0,
		jumpToStart : 1
	}, settings);
	
	var $o = this;
	
	var form = $(form);
	
	this.errors = 0;
	
	this.methods = {
		f: function(a,b) {

			if (b.checkonblur || b.checkonkeyup || b.checkonchange) {
				var inputs = form.find('.v-'+a);
				if (inputs.length > 0) {
					inputs.each(function(i,item){
						
						if (b.checkonblur) {
							$(item).bind('blur.validate',function(){
								
								if (!$o.methods.validate(this,b)) {
									if (b.onError) {
										b.onError($(item),$o);
									}
								} else if (b.onSuccess) {
									b.onSuccess($(item),$o);
								}
							});
						}

						if (b.checkonchange) {
							
							$(item).bind('change.validate',function(){
								
								if (!$o.methods.validate(this,b)) {
									if (b.onError) {
										b.onError($(item),$o);
									}
								} else if (b.onSuccess) {
									b.onSuccess($(item),$o);
								}
							});
						}
						
						if (b.checkonkeyup) {
							
							$(item).bind('keyup.validate',function(){
								
								if (!$o.methods.validate(this,b)) {
									if (b.onError) {
										b.onError($(item),$o);
									}
								} else if (b.onSuccess) {
									b.onSuccess($(item),$o);
								}
							});
						}
					});
				}
			}
		},
		validate: function(field, b) {

			if (b.condition) {
				if (!b.condition(field, $o)) {
					$o.methods.clear($(field));
					return true;
				}
			}
			
			var ret = validation_methods[b.check]($(field),b.params);
			if (!ret) return false;
			
			if (b.checkAjax) {
				if (!b.checkAjax(field,$o)) {
					return false;
				}
			}

			return true;
		},
		display: function (msg, field, error) {

			$o.methods.clear(field);

			if (error) {

				$o.errors++;

				$o.methods.error(field);

				if (settings.mode == 'default') {
					field.parent().append('<div class="text-danger input-error-text">'+msg+'</div>');
				} else {
					alert(msg);
				}
			} else {
				$o.methods.success(field);
			}
		},
		isvalid: function(field) {
			return !field.closest('.form-group').hasClass('has-error');
		},
		error: function(field) {
			field.closest('.form-group').removeClass('has-success');
			field.closest('.form-group').addClass('has-error'); 
		},
		success: function(field) {
			field.closest('.form-group').removeClass('has-error');
			field.closest('.form-group').addClass('has-success');
		},
		clear: function(field) {

			if (field) {
				field.closest('.form-group')
					.removeClass('has-success')
					.removeClass('has-error')
					.find('.input-error-text').remove();
			} else {
				
				$o.errors = 0;
				
				form.find('.has-success').removeClass('has-success');
				form.find('.has-error').removeClass('has-error');
				form.find('.input-error-text').remove();
			}
		},
		submit: function () {

			$o.methods.clear();

			if (validation) {
				$.each(validation,function(a,b){
					var inputs = form.find('.v-'+a);
					if (inputs.length > 0) {
						inputs.each(function(i,item){
							if (!$o.methods.validate(this,b)) {
								if (b.onError) {
									b.onError($(item),$o);
								}
							} else if (b.onSuccess) {
								b.onSuccess($(item),$o);
							}
						});
					}
				});
			}
			
			form.data('errors',$o.errors);

			if ($o.errors > 0) {

				if (settings.jumpToStart) {
					
					var first_error = form.find('.has-error:first');
					
					$('html, body').animate({
                        scrollTop: first_error.offset().top - first_error.height() - 20
                    }, 800);
				}

				$o.errors = 0;

				// Form has errors - dont submit
				return false;

			} else if (settings.preventSubmit) {
				// Dont submit the form
				return false;
			} else {
				// Submit form
				//form.submit();
				return true;
			}
		}
	};
	
	if (validation) {
		$.each(validation,function(i,item){
			$o.methods.f(i,item);
		});
	}

	var validation_methods = {
		
		email: function (field) {
			var error = 0;
			var reg = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9_\-])+\.)+([a-zA-Z0-9]{2,10})+$/;
			if (!reg.test(field.val())) error = 1;
			$o.methods.display("Adres email " + field.val() + " jest nieprawidłowy.",field,error);
			return !error;
		},
		confirm_email: function (field,field2) {
			var error = 0;
			if (field.val() != field2.val()) error = 1;
			$o.methods.display("Adres email " + field.val() + " nie został poprawnie potwierdzony.",field,error);
			return !error;
		},
		password: function (field,params) {
			var error = 0;
			var string_length = field.val().length;
			if (params == undefined) params = {min:6,max:32};
			if (params.min == undefined) params.min = 6;
			if (params.max == undefined) params.max = 32;
			if (string_length < params.min || string_length > params.max) error = 1;
			$o.methods.display("Hasło nie ma wymaganej ilości znaków (od "+params.min+" do "+params.max+" znaków).",field,error);
			return !error;
		},
		confirm_password: function (field,params) {
			var error = 0;
			if (field.val() != $(params.to).val()) error = 1;
			$o.methods.display("Hasło nie zostało potwierdzone poprawnie.",field,error);
			return !error;
		},
		zip_code: function (field) {
			var error = 0;
			reg = /^\d{2}(-)\d{3}$/;
			if (!reg.test(field.val())) error = 1;
			$o.methods.display("Kod pocztowy "+field.val()+" ma nieprawidłowy format (00-000).",field,error);
			return !error;
		},
		date: function (field) {
			var error = 0;
			reg = /^\d{4}(\-)\d{1,2}\1\d{1,2}$/;
			if (!reg.test(field.val())) error = 1;
			$o.methods.display("Format daty "+field.val()+" jest nieprawidłowy (rrrr-mm-dd).",field,error);
			return !error;
		},
		nip: function(field) {
			var error = 0;
			if ( !field.val().match( /^[0-9]{3}-[0-9]{2}-[0-9]{2}-[0-9]{3}$/ )
				&& !field.val().match( /^[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}$/ )
				&& !field.val().match( /^[0-9]{10}$/ ) ) {
					error = 1;
			} else {
				var my_nums = field.val().replace(/-/g,'');
				var valid_nums = "657234567";
				var sum=0;
				for (var temp=8;temp>=0;temp--) { 
					sum += (parseInt(valid_nums.charAt(temp)) * parseInt(my_nums.charAt(temp))); 
				}

				if ( !((sum % 11) == 10 ? false : ((sum % 11) == parseInt(my_nums.charAt(9))) ) ) {
					error = 1;
				}
			}

			$o.methods.display("Numer NIP "+field.val()+" jest nieprawidłowy.",field,error);
			return !error;
		},
		empty: function (field) {
			var error = 0;
			if (field.val().replace(/^\s+|\s+$/g,"").length < 1) error = 1;
			$o.methods.display("Pole nie zostało wypełnione.",field,error);
			return !error;
		},
		selected: function (field,howmany) {
			var error = 0;
			if (howmany == undefined) howmany = 1;
			if (field.find('option:selected').length != howmany) error = 1;
			$o.methods.display("Należy wybrać "+howmany+" opcje(i).",field,error);
			return !error;
		},
		checked: function (field,params) {

			var error = 0;
			
			if (params == undefined) params = {msg: "Należy zaznaczyć opcję."};
			
			if (!field.is(':checked')) error = 1;

			$o.methods.display(params.msg,field,error);
			
			return !error;
		},
		regexp: function (field, regexp, message_on_error) {
			var error = 0;
			if (!regexp.test($(field).val())) error = 1;
			$o.methods.display(message_on_error,field,error);
			return !error;
		}
	};

	form.bind('submit.validate',function(){
	
		return $o.methods.submit();
	});

	this.Submit = $o.methods.submit;
}