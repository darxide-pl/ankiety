<?php

function rebuild_tree($parent, $left) { 
	
	global $db;
	
    // the right value of this node is the left value + 1 
    $right = $left+1;

    // get all children of this node   <br>
    $result = $db->query('SELECT `id` FROM `page` WHERE `parent_id` = "'.$parent.'";');
	
    while ($row = $result->fetch_assoc()) {
        // recursive execution of this function for each 
        // child of this node
        // $right is the current right value, which is
        // incremented by the rebuild_tree function
        $right = rebuild_tree($row['id'], $right);
    }

    // we've got the left value, and now that we've processed
    // the children of this node we also know the right value
    $db->query('UPDATE `page` SET `lft` = '.$left.', `rgt` = '.
                 $right.' WHERE `id` = "'.$parent.'";');
    // return the right value of this node + 1
    return $right+1;
}


function display_tree($parent_id) {
    // retrieve the left and right value of the $root node
    $result0 = DB::Instance()->query('SELECT lft, rgt FROM `page` '.
                           'WHERE `parent_id` = "'.$parent_id.'" ORDER BY `lft` ASC;');
    
	while ($row0 = $result0->fetch_array()) {
		
		// start with an empty $right stack
		$right = array();

		// now, retrieve all descendants of the $root node
		$result = DB::Instance()->query('SELECT `title`, `lft`, `rgt` FROM `page` '.
							   'WHERE `lft` BETWEEN '.$row0['lft'].' AND '.
							   $row0['rgt'].' ORDER BY `lft` ASC;');

		// display each row
		while ($row = $result->fetch_array()) {
			// only check stack if there is one
			if (count($right)>0) {
				// check if we should remove a node from the stack 
				while ($right[count($right)-1]<$row['rgt']) {
					array_pop($right);
				}
			}

			// display indented node title
			echo str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',count($right)).$row['lft'].' '.$row['title'].' '.$row['rgt']."<br />";

			// add this node to the stack
			$right[] = $row['rgt'];
		}
	}
}

//rebuild_tree(0, 0);

display_tree(0);