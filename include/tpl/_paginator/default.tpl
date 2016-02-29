<?php if ($this->getPagesNum() > 1):
	echo '<div class="pagenavigator"><p>';
	if ($this->getPageNumber() > 1):
		echo '<span class="previous"><a class="link-previous" href="?page_nr='.($this->getPageNumber()-1).'&SearchText='.$_REQUEST['SearchText'].'">«&nbsp;Poprzednia</a></span>';
	else:
		echo '<span class="previous">«&nbsp;Poprzednia</span>';
	endif;
	echo '<span class="divider">|</span>';
	for($page = 1; $page<=$this->getPagesNum(); $page++):
		if ($page != $this->getPageNumber()):
			echo ' <span class="other"><a href="?page_nr='.$page.'&SearchText='.$_REQUEST['SearchText'].'" title="Strona: '.$page.'">'.$page.'</a></span> ';
		else:
			echo ' <span class="current">'.$page.'</span> ';
		endif;
		echo '<span class="divider">|</span>';
	endfor;
	if ($this->getPageNumber() < $this->getPagesNum()):
		echo '<span class="next"><a class="link-next" href="?page_nr='.($this->getPageNumber()+1).'&SearchText='.$_REQUEST['SearchText'].'">Następna&nbsp;»</a></span>';
	else:
		echo '<span class="next">Następna&nbsp;»</span>';
	endif;
	echo '</p></div>';
endif; ?>