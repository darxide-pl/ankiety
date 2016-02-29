<?php

class Db_Report {
	
	private $_db;
	private $_sql_key_words;
	private $_sql_functions;
	
	function __construct(DB $db) {
		$this->_db = $db;
		$this->_sql_key_to_nl = array('where','left','right','from','values','group','order','having','union','limit');
		$this->_sql_key_words = array('DESCRIBE','select','insert','delete','on','in','values','left','join','right','group','by','order','asc','desc','limit','where','as','from','update','set','and','or','distinct','into','is','null','not','charset','having','union');
		$this->_sql_functions = array('UNIX_TIMESTAMP','sum','curdate','count','max','min','year','month','day','date', 'now','md5','sha1','substr');
	}
	
	function draw() {
		$s = '<style>
.db { padding-bottom: 30px; margin-bottom: 50px; margin-left: 25px; color: #777; clear:both; width: 90%; font-size: 12px; font-family: arial; }
.db span.function { color: blue; }
.db span.keyword { font-weight: bold; color: #333; }
.db span.sql_string { color: red; }
.db span.sql_sign { color: orange; }
.db td.speed0 { background-color: #49e5ea; }
.db td.speed1 { background-color: #58ea49; }
.db td.speed2 { background-color: #ffaa00; }
.db td.speed3 { background-color: #ff5939; }
.db-sql-insert { background-color: #f0ff6c; }
.db-sql-update { background-color: #ffbf6c; }
.db-sql-delete { background-color: #af9dff; }
.db-sql-error { border: 1px solid red; background-color: #FF6666; padding: 4px; margin: 2px; }
.db #db_list { background: #efefef; }
.db #db_list td, .db #db_list th { border: 1px solid #ccc; padding: 3px 2px; }
</style>';
		if (is_array($this->_db->_queries_sql) && count($this->_db->_queries_sql) > 0) {
		
			$timer = 0;
			$queries = array_reverse($this->_db->_queries_sql);

			foreach ($queries as $id => $query) {
				if (!empty($query['sign'])) {
					$query['sign'] = '<span class="sql_sign">#'.$query['sign'].'</span> ';
				}
				foreach ($this->_sql_functions as $function) {
					$function = preg_quote($function);
					$query['sql'] = preg_replace("/\b(".$function.")\b[^`.,'\"]{1}/i", '<span class="function">'.strtoupper($function).'</span>(', $query['sql']);
				}
				foreach ($this->_sql_key_words as $keyword) {
					$keyword = preg_quote($keyword);
					$query['sql'] = preg_replace("/\b(".$keyword.")\b[^`.,'\"]{1}/i", '<span class="keyword">'.strtoupper($keyword).' </span>', $query['sql']);
				}
				foreach ($this->_sql_key_to_nl as $keyword) {
					$keyword = preg_quote($keyword);
					$query['sql'] = preg_replace("/\b(".$keyword.")\b[^`.,'\"]{1}/i", '<br />'.strtoupper($keyword).' ', $query['sql']);
				}
				//$query['sql'] = preg_replace("/\'(.{120,}?)\'/eis","'\''.substr('\\1',0,70).' <b>[...]</b>\''",$query['sql']);
				
				$query['sql'] = str_replace('\\\'','{{slashquota}}',$query['sql']);
				$query['sql'] = preg_replace("/\'(.*?)\'/is","<span class=\"sql_string\">'$1'</span>",$query['sql']);
				$query['sql'] = str_replace('{{slashquota}}','\\\'',$query['sql']);
				
				$timer += $query['time'];
				if (strpos($query['sql'],'INSERT') >= 0) $class = ' db-sql-insert'; 
				elseif (strpos($query['sql'],'UPDATE') >= 0) $class = ' db-sql-update';
				elseif (strpos($query['sql'],'DELETE') >= 0) $class = ' db-sql-delete';
				else $class = '';
				
				$time = round($query['time'],4);
				
				$time_id = 0;
				
				if ($time >= 0.1) {
					$time_id = 3;
				} else if ($time >= 0.01) {
					$time_id = 2;
				} else if ($time >= 0.001) {
					$time_id = 1;
				}
				
				$s .= '<tr class="'.($query['error'] ? 'error' : '').'">';
				$s .= '<td>'.$query['affected_rows'].'</td>';
				$s .= '<td class="speed'.$time_id.'">'.$time.'</td>';
				$s .= '<td>'.($query['error'] ? $query['errno'] : '').'</td>';
				$s .= '<td>'.$query['sign'].$query['sql'].'</td></tr>'."\n";
			}
		}
		$s = '<table class="db" >
			<thead><tr class="'.($this->_db->_error ? 'error' : '').'">
			<td colspan="5">Wszystkich zapytań: <b>'.$this->_db->queries.'</b> w czasie <b>'.round($timer,4).' s</b></td></tr><thead>
			<tbody id="db_list">
				<tr><th>Rows</th><th>ms</th><th>Err</th><th>Zapytanie</th></tr>
				'.$s.'</tbody></table>';
		echo $s;
	}
}

?>