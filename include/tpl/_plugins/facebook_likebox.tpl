<?php if (Config::get('facebook.likebox_show')): ?>
<div id="fb_likebox" style="left: -<?php echo Config::get('facebook.likebox_width') ?>px;">
	<a href="#" id="fb_likebox_button"></a>
	<div id="fb_likebox_body">
		<iframe src="//www.facebook.com/plugins/likebox.php?href=<?php echo urlencode(Config::get('facebook.url')) ?>&amp;width=<?php echo Config::get('facebook.likebox_width') ?>&amp;height=290&amp;show_faces=true&amp;colorscheme=light&amp;stream=false&amp;show_border=true&amp;header=true" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:<?php echo Config::get('facebook.likebox_width') ?>px; height:290px;" allowTransparency="true"></iframe>
	</div> 
</div>
<?php endif;