<?php

echo $this->lays->draw();

$this->list->header->add(TLH2_DATE, 'date');
$this->list->header->add(TLH2_TIME);
$this->list->header->add(TLH2_LENGHT);
$this->list->header->add(TLH2_IPADDRESS);
$this->list->header->add(TLH2_BROWSER);

$rows = $this->list->population();

echo $this->list->head();

if ($rows):
	foreach ($rows as $o):?>
	<?php 
	
	$time_start = strtotime($o->GetDate());
	$time_to = strtotime($o->GetLastActionTime());
	$difference = $time_to - $time_start;
	if ($difference < 0) {
		$difference = 0;
	}
	$login_time = f_time_to_string2($difference);
	
	$class = '';
	switch ($o->GetError()) {
		case '2': $class .= ' important';
		case '1': $class .= ' error';
		break;
		default:
			$class .= $time_start != $time_to ? ' success' : ' lessimportant';
	}
	
	$BS = new BrowserSniffer($o->GetBrowser());
	
	?>
	<tr class="row<?php echo ($i = $i == 1 ? 2 : 1);?><?php echo $class;?>">
		<td><?php echo substr($o->GetDate(),0,10);?></td>
		<td><?php echo substr($o->GetDate(),11);?></td>
		<td class="right"><?php echo $login_time;?></td>
		<td><?php echo $o->GetIpAddress();?></td>
		<td><?php echo $BS->GetName().' <b>'.$BS->GetVersion().'</b>';?></td>
	</tr>

	<?php endforeach;
else: 
	echo $this->list->row('Brak logowań.');
endif;

echo $this->list->foot();

echo f_html_draw_button('submit','Wróć','location.href=\''.$this->link->Build(array($this->name,'edit')).'\';');