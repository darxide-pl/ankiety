<?php

class Model_Box extends Generic_Object {
	
	public static function LoadByPage($page_id) {
		return Model_Box::NewInstance()->find()
			->join('RIGHT JOIN `page_box` pb ON pb.`box_id` = Box.`id`')
			->where('pb.`page_id` = '.$page_id.' AND Box.`publish` = 1')
			->fetch();
	}
	
	public static function Display($box) {
		$s = 
			'<div class="infobox-wrapper">
				<div class="infobox">
					<div class="content-view-box">
						<div class="attribute-title">
							<h2><a href="'.$box->get('url').'">'.$box->get('title').'</a></h2>
						</div>
						';
		if ($box->get('type') == '') {
			$s .= '<div class="attribute-image">
						<a href="'.$box->get('url').'"><img src="'.BASE_DIR.'/upload/box/'.$box->get('image_filename').'" width="300" height="300" style="border: 0px;" alt="" title="" /></a>    
					</div>';
		} else {
			
			$news = Db::Instance()->all("SELECT * FROM `news` WHERE `publish` = 1 ORDER BY `add_date` DESC LIMIT 5;");
			
			if ($news) {
				$s .= '<div class="content-view-list">
                        <ul>';
				foreach ($news as $v) {
					$s .= '<li><a href="'.Model_News::Build_Url($v).'">'.$v['title'].'</a></li>';
				}
				$s .= '</ul>
                    </div>';
			}
		}
		
		$s .= '<div class="attribute-long">
							<p><b>'.$box->get('text').'</b></p>
						</div>
					</div>
				</div>
			</div>';
		
		return $s;
	}
}