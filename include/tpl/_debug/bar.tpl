<style type="text/css">
	#xedebug {position:fixed;bottom:0;width:100%;height:30px; background: #fff; box-shadow: 0 0 5px rgba(0,0,0,0.65);z-index:9999;}
	#xedebug-bar a {border: 1px solid #eee;padding: 5px 8px; float:left; color: #666;}
	#xedebug-bar a:hover {background: #efefef;color: #333;}
	#xedebug-box {position:relative;margin: 10px;}
	.xedebug-box {position:absolute; left:0; top:40px; z-index:9999; height: 440px; width:100%; overflow: auto;}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$('.xedebug-box').hide();
	$('.xedebug-tab').click(function(e){
		e.stopPropagation();
		var tab = $(this).attr('id').split('-').pop();
		$('.xedebug-box:visible').fadeOut('fast');
		if ($('#xedebug-box-'+tab).size() > 0) {
			$('#xedebug-box-'+tab).fadeIn();
			$('#xedebug').animate({height:'500px'},500);
		} else {
			$('#xedebug').animate({height:'30px'},500);
		}
		return false;
	});
});
</script>

<div id="xedebug">
	
	<div id="xedebug-bar">
		<a href="#" id="xedebug-tab-sql" class="xedebug-tab">SQL</a>
		<a href="#" id="xedebug-tab-post" class="xedebug-tab">POST</a>
		<a href="#" id="xedebug-tab-get" class="xedebug-tab">GET</a>
		<a href="#" id="xedebug-tab-request" class="xedebug-tab">REQUEST</a>
		<a href="#" id="xedebug-tab-files" class="xedebug-tab">FILES</a>
		<a href="#" id="xedebug-tab-server" class="xedebug-tab">SERVER</a>
		<a href="#" id="xedebug-tab-cookie" class="xedebug-tab">COOKIE</a>
		<a href="#" id="xedebug-tab-session" class="xedebug-tab">SESSION</a>
		<a href="#" id="xedebug-tab-close" class="xedebug-tab">CLOSE</a>
		
		<a href="#" style="float:right;"><?php
			/** (only for webmaster)
			 * This function prints page stats like:
			 * 	- parse time (s)
			 * 	- used memory (KB)
			 */
			echo f_print_page_statistics() ?></a>
		
		<a href="?page_action=<?php echo f_eas('Rootkit|clear_cache') ?>" style="float:right;" class="error">Usuń Cache</a>
	</div>
	
	<div id="xedebug-box">
		<div id="xedebug-box-sql" class="xedebug-box">
			<?php $Report = new Db_Report($this->db); $Report->draw(); ?>
		</div>
		<div id="xedebug-box-post" class="xedebug-box">
			<?php echo dump($_POST) ?>
		</div>
		<div id="xedebug-box-get" class="xedebug-box">
			<?php echo dump($_GET) ?>
		</div>
		<div id="xedebug-box-request" class="xedebug-box">
			<?php echo dump($_REQUEST) ?>
		</div>
		<div id="xedebug-box-files" class="xedebug-box">
			<?php echo dump($_FILES) ?>
		</div>
		<div id="xedebug-box-server" class="xedebug-box">
			<?php echo dump($_SERVER) ?>
		</div>
		<div id="xedebug-box-cookie" class="xedebug-box">
			<?php echo dump($_COOKIE) ?>
		</div>
		<div id="xedebug-box-session" class="xedebug-box">
			<?php echo dump($_SESSION) ?>
		</div>
	</div>
</div>