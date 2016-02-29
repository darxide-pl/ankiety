<div class="container">
	
	<div class="panel panel-success">
		
		<div class="panel-heading">
			Nowy produkt
			<a href="<?php echo $this->link->Build(array($this->name)) ?>" class="close"><i class="glyphicon glyphicon-remove"></i></a>
		</div>
		<div class="panel-body">

			<form action="<?php echo $this->link->Build(array($this->name, $this->view)) ?>"
				  class="form-horizontal" method="post"
				  id="add_form" name="add_form">

				<input type="hidden" name="page_action" value="<?php echo f_eas('Products|add') ?>" />


				<div class="form-group">
					<label class="control-label col-sm-3" for="name">Nazwa</label>
					<div class="col-sm-9">
						<input type="text" name="name" id="name" value="<?php echo f_escape($object->get('name')) ?>" class="form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="category_id">Grupa</label>
					<div class="col-sm-9">
						<select name="category_id" class="form-control v-empty" id="category_id">
							<option value="">Wybierz grupę</option>
							<?php echo Html::SelectOptions($categories,$object->get('category_id')) ?>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-sm-3" for="description">Opis</label>
					<div class="col-sm-9">
						<textarea name="description" id="description" class="form-control textarea-expand"><?php echo $object->get('description') ?></textarea>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<label class="radio-inline">
							<input type="radio" name="active" value="1" checked="checked" /> Aktywne
						</label>
						<label class="radio-inline">
							<input type="radio" name="active" value="0" /> Niektywne
						</label>
					</div>
				</div>
				
				<input type="hidden" name="save_positions" value="0" />
				
				<div id="attributes-list">
					<!-- List of existing attributes -->
					<?php if ($attributes): foreach ($attributes as $aid => $aname): ?>
					<div class="form-group exists">
						<input type="hidden" name="pos[]" value="<?php echo $aid ?>" />
						<label class="col-sm-3">
							<div class="input-group">
								<span class="input-group-btn"><a href="" class="btn btn-default"><i class="glyphicon glyphicon-move"></i></a></span>
								<input type="text" name="at[<?php echo $aid ?>][name]" value="<?php echo f_escape($aname) ?>" class="form-control" placeholder="Atrybut" />
							</div>
						</label>
						<div class="col-sm-9">
							<input type="text" name="at[<?php echo $aid ?>][value]" value="<?php echo isset($attributes_values[$aid]) ? f_escape($attributes_values[$aid]) : '' ?>" class="form-control" placeholder="Wartość" />
						</div>
					</div>
					<?php endforeach; endif; ?>
				
					<!-- List of new attributes -->
				</div>
				
				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3" style="opacity:0.5">
						<div class="input-group" id="btn-add-attribute">
							<span class="input-group-btn">
								<a href="#" class="btn btn-default btn-remove-attribute"><i class="glyphicon glyphicon-plus"></i></a>
							</span>
							<input type="text" placeholder="Dodaj nowy atrybut" class="form-control" />
						</div>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-9 col-sm-offset-3">
						<input class="btn btn-success" type="submit" value="Zapisz zmiany" />
						lub
						<a href="<?php echo $this->link->Build(array($this->name)) ?>">Porzuć zmiany i wróć do listy</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
//<!--//

function startTypeaheadAttributes() {
	$(".typeahead-attribute").typeahead({
		minLength: 0,
		showHintOnFocus: true,
		source: function (query, process) {
			var input = $(this)[0].$element;
			return $.post('<?php echo $this->link->Build(array('search','attributes')) ?>', {attribute_id: input.data('id'), query: query }, function (data) {
				var search_items = [];
				$.each( data, function( ix, item, list ){
					//add the label to the display array
					search_items.push( item.label );
				});
				return process(search_items);
			},'json');
		}
	});
}

$(document).ready(function(){
	var validate = new FormValidate('#add_form',{},{
		serial: {
			check: 'empty',
			checkonblur: true,
			checkAjax: function(item,o){
				
				var success = true;
				
				$.ajax({
					type: 'POST',
					url: '<?php echo $this->link->Build(array($this->name,$this->view,'page_action'=>f_eas('Products|check_serial'))) ?>',
					async: false, // VERY IMPORTANT, will prevent to submit form before request end
					data: {serial:$(item).val(),id:0},
					success: function(data){
						if (data.error) {
							success = false;
							o.errors ++; // increase error num
							o.methods.error($(item)); // mark field as error
							$(item).next().removeClass('glyphicon-ok').addClass('glyphicon-remove');
							$(item).closest('.form-group').addClass('has-error');
						} else {
							$(item).next().removeClass('glyphicon-remove').addClass('glyphicon-ok');
							$(item).closest('.form-group').addClass('has-success');
						}
					},
					dataType: 'json'
				});

				return success;
			}
		},
		empty: {
			check: 'empty',
			checkonblur: true
		}
	});
	
	$('#btn-add-attribute').click(function(e){
		e.preventDefault();
		
		var attribute = 	
			'<div class="form-group">'+
				'<input type="hidden" name="pos[]" value="new" />'+
				'<label class="col-sm-3">'+
					'<div class="input-group">'+
						'<span class="input-group-btn"><a href="" class="btn btn-default"><i class="glyphicon glyphicon-move"></i></a></span>'+
						'<input type="text" name="atname[]" value="" class="form-control" placeholder="Atrybut" />'+
						'<span class="input-group-btn">'+
							'<a href="#" class="btn btn-danger btn-remove-attribute"><i class="glyphicon glyphicon-remove"></i></a>'+
						'</span>'+
					'</div>'+
				'</label>'+
				'<div class="col-sm-9">'+
					'<input type="text" name="atvalue[]" value="" class="form-control" placeholder="Wartość" />'+
				'</div>'+
			'</div>';
		
		$('#attributes-list').append(attribute);
		
		$('#attributes-list .form-group:last').find('.form-control:first').focus();
		
		return false;
	});
	
	$('#attributes-list').delegate('.btn-remove-attribute','click',function(){
		$(this).closest('.form-group').slideUp(400,function(){
			$(this).remove();
		});
	});
	
	$('#category_id').change(function(){
		var url = '<?php echo $this->link->Build(array($this->name,'attributes_list','category_id'=>'{cid}','oid'=>'0')) ?>';
		
		$('.typeahead-attribute').typeahead('destroy');
		
		$.get(url.replace('{cid}',$(this).val()),{},function(html){
			$('#attributes-list .exists').remove();
			$('#attributes-list').prepend(html);
			
			startTypeaheadAttributes();
		});
	});
	
	$('#attributes-list').sortable({
		handle: '.glyphicon-move',
		update: function(){
			$('input[name="save_positions"]').val('1');
		}
	});
});

//-->
</script>