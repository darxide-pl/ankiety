<?php if ($attributes): foreach ($attributes as $aid => $a): ?>
<div class="form-group exists">
	<input type="hidden" name="pos[]" value="<?php echo $aid ?>" />
	<label class="col-sm-3">
		<div class="input-group">
			<span class="input-group-btn"><a href="" class="btn btn-default"><i class="glyphicon glyphicon-move"></i></a></span>
			<input type="text" name="at[<?php echo $aid ?>][name]" value="<?php echo f_escape($a['name']) ?>" class="form-control" placeholder="Atrybut" />
			<span class="input-group-addon">
				<input type="checkbox" name="at[<?php echo $aid ?>][allow_copy]" value="1" <?php echo $a['allow_copy'] ? 'checked="checked"' : '' ?> />
			</span>
		</div>
	</label>
	<div class="col-sm-9">
		<input type="text" name="at[<?php echo $aid ?>][value]" value="<?php echo isset($attributes_values[$aid]) ? f_escape($attributes_values[$aid]) : '' ?>" class="form-control typeahead-attribute" data-id="<?php echo $aid ?>" placeholder="Wartość" />
	</div>
</div>
<?php endforeach; endif; ?>