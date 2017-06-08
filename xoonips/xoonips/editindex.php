<?php
// $Revision: 1.17.2.1.2.23 $
// ------------------------------------------------------------------------- //
//  XooNIps - Neuroinformatics Base Platform System                          //
//  Copyright (C) 2005-2011 RIKEN, Japan All rights reserved.                //
//  http://xoonips.sourceforge.jp/                                           //
// ------------------------------------------------------------------------- //
//  This program is free software; you can redistribute it and/or modify     //
//  it under the terms of the GNU General Public License as published by     //
//  the Free Software Foundation; either version 2 of the License, or        //
//  (at your option) any later version.                                      //
//                                                                           //
//  You may not change or alter any portion of this comment or credits       //
//  of supporting developers from this source code or any supporting         //
//  source code which is considered copyrighted (c) material of the          //
//  original comment or credit authors.                                      //
//                                                                           //
//  This program is distributed in the hope that it will be useful,          //
//  but WITHOUT ANY WARRANTY; without even the implied warranty of           //
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            //
//  GNU General Public License for more details.                             //
//                                                                           //
//  You should have received a copy of the GNU General Public License        //
//  along with this program; if not, write to the Free Software              //
//  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA //
// ------------------------------------------------------------------------- //

/* index module
 *
 * input:
 *   op                |open(default)|register|up|down|rename|delete|moveto|
 *  -------------------+-------------+--------+--+----+------+------+------+
 *   index_id          |*            |*       |* |*   |*     |*     |*     | current
 *   new_index_name    |             |*       |  |    |      |      |      |
 *   updown_xid        |             |        |* |*   |      |      |      |
 *   step[$updown_xid] |             |        |* |*   |      |      |      |
 *   check[]           |             |        |  |    |*     |*     |*     | check[0], check[1], check[2] ... <- xid
 *   rename[]          |             |        |  |    |*     |      |      | rename[xid] <- title
 *   moveto            |             |        |  |    |      |      |*     |
 *
 */

$xoopsOption['pagetype'] = 'user';
require __DIR__ . '/include/common.inc.php';
require_once __DIR__ . '/include/lib.php';
require_once __DIR__ . '/include/AL.php';
require __DIR__ . '/class/base/gtickets.php';

$xgroupHandler = xoonips_getHandler('xoonips', 'group');

$xnpsid = $_SESSION['XNPSID'];

xoonips_deny_guest_access();

$formdata = xoonips_getUtility('formdata');
$textutil = xoonips_getUtility('text');

$xid = $formdata->getValue('both', 'index_id', 'i', false, 0);

$post_keys = array(
    'op'                  => array(
        'type'    => 's',
        'default' => 'open'
    ),
    'new_index_name'      => array(
        'type'    => 's',
        'default' => ''
    ),
    'moveto'              => array(
        'type'    => 'i',
        'default' => 0
    ),
    'updown_xid'          => array(
        'type'    => 'i',
        'default' => 0
    ),
    'add_to_index_id_sel' => array(
        'type'    => 'i',
        'default' => 0
    ),
);
foreach ($post_keys as $key => $meta) {
    $type    = $meta['type'];
    $default = $meta['default'];
    $$key    = $formdata->getValue('post', $key, $type, false, $default);
}
$post_akeys = array(
    'steps'  => array(
        'type'    => 'i',
        'default' => array()
    ),
    'rename' => array(
        'type'    => 's',
        'default' => array()
    ),
    'check'  => array(
        'type'    => 'i',
        'default' => array()
    ),
);
foreach ($post_akeys as $key => $meta) {
    $type    = $meta['type'];
    $default = $meta['default'];
    $$key    = $formdata->getValueArray('post', $key, $type, false);
}

// check request
if (!in_array($op, array(
    'open',
    'register',
    'up',
    'down',
    'rename',
    'delete',
    'moveto',
    'add_to_public'
))
) {
    die('illegal reuest');
}
if ($op === 'up' || $op === 'down') {
    if ($updown_xid == 0 || !isset($steps[$updown_xid])) {
        die('illegal reuest');
    }
}
if ($op === 'moveto' && $moveto == 0) {
    die('illegal reuest');
}

// get current place
$uid     = $xoopsUser->getVar('uid');
$account = array();
if (RES_OK == xnp_get_account($xnpsid, $uid, $account)) {
    $privateXID = $account['private_index_id'];
} else {
    // user has no PrivateIndex.
    redirect_header(XOOPS_URL . '/index.php', 3, _NOPERM);
}

// check requests
if ($xid == 0) {
    $xid = $privateXID;
}
if ($xid == 1) {
    die('illegal request');
}

// check the right to access.
$index  = array();
$result = xnp_get_index($xnpsid, $xid, $index);
if ($result != RES_OK) {
    redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
}
if ($index['open_level'] == OL_PUBLIC && xnp_is_moderator($xnpsid, $uid)
    || $index['open_level'] == OL_GROUP_ONLY
       && $xgroupHandler->isGroupAdmin($uid, $index['owner_gid'])
    || $index['open_level'] == OL_PRIVATE && $index['owner_uid'] == $uid
) {
    // User has the right to write.
} else {
    // User doesn't have the right to write.
    redirect_header(XOOPS_URL . '/index.php', 3, _NOPERM);
}

// return index_id which is under IID_ROOT and has a node '$xid'. in error, return zero.
/**
 * @param $xid
 * @return int
 */
function xoonipsGetTopIndex($xid)
{
    global $xnpsid;

    $index  = array();
    $result = xnp_get_index($xnpsid, $xid, $index);
    if ($result != RES_OK) {
        return 0;
    }

    $indexes  = array();
    $criteria = array();
    $result   = xnp_get_indexes($xnpsid, IID_ROOT, $criteria, $indexes);
    if ($result != RES_OK) {
        return 0;
    }

    foreach ($indexes as $key => $val) {
        if ($index['open_level'] == $val['open_level']) {
            if ($index['open_level'] == OL_PUBLIC
                || $index['open_level'] == OL_GROUP_ONLY && $index['owner_gid'] == $val['owner_gid']
                || $index['open_level'] == OL_PRIVATE && $index['owner_uid'] == $val['owner_uid']
            ) {
                return $val['item_id'];
            }
        }
    }

    return 0;
}

// Value that sends to tree-block put on header.php behind.
$xoonipsURL         = 'editindex.php';
$xoonipsEditIndex   = true;
$xoonipsSelectedTab = xoonipsGetTopIndex($xid);

$GLOBALS['xoopsOption']['template_main'] = 'xoonips_editindex.tpl';
require XOOPS_ROOT_PATH . '/header.php';

$error_messages = array();

unset($indexCount);

// get certyfy_item from configration
$result = xnp_get_config_value('certify_item', $certify_item);
if ($result != RES_OK) {
    redirect_header(XOOPS_URL . '/', 3, "ERROR xnp_get_config_value can't get certify_item(result=$result)");
}

$handler             = xoops_getHandler('user');
$user                = $handler->get($uid);
$operation_user_name = $user->getVar('name');
$error               = false;

// operate
if ($op === 'open' || $op == '') {
}
if ($op === 'add_to_public' && isset($check)) {
    // check token ticket
    if (!$xoopsGTicket->check(true, 'xoonips_edit_index')) {
        exit();
    }

    $item_lockHandler = xoonips_getOrmHandler('xoonips', 'item_lock');
    foreach ($check as $index_id) {
        //ignore lock because of to make public a group index
        if ($item_lockHandler->isLocked($index_id)
            && $item_lockHandler->getLockType($index_id) == XOONIPS_LOCK_TYPE_PUBLICATION_GROUP_INDEX
        ) {
            continue;
        }
        xoonips_show_error_if_index_locked($index_id, $xid);
    }

    $xoopsDB->queryF('START TRANSACTION');// start transaction

    $index_group_index_linkHandler = xoonips_getOrmHandler('xoonips', 'index_group_index_link');
    $configHandler                 = xoonips_getOrmHandler('xoonips', 'config');
    if ($configHandler->getValue('certify_item') === 'on') {
        if (!$index_group_index_linkHandler->requireToMakePublic($add_to_index_id_sel, $check)) {
            $xoopsDB->queryF('ROLLBACK');
            trigger_error('cannot insert to xoonips_index_group_index_link');
            redirect_header(XOOPS_URL . '/', 3, _MD_XOONIPS_GROUP_TREE_TO_PUBLIC_INDEX_TREE_FAILED);
        }

        if (!xoonips_group_index_to_public_event_log($add_to_index_id_sel, $check)) {
            $xoopsDB->queryF('ROLLBACK');
            redirect_header(XOOPS_URL . '/', 3, _MD_XOONIPS_GROUP_TREE_TO_PUBLIC_INDEX_TREE_FAILED);
        }

        $xoopsDB->queryF('COMMIT');
        $index_group_index_linkHandler->notifyMakePublicGroupIndex(array($add_to_index_id_sel), $check, 'group_item_certify_request');
        redirect_header(XOOPS_URL . '/modules/' . $xoopsModule->dirname() . '/editindex.php?index_id=' . $xid, 5,
                        "Succeed\n<br>" . _MD_XOONIPS_ITEM_NEED_TO_BE_CERTIFIED);
    } elseif ($configHandler->getValue('certify_item') === 'auto') {
        if (!$index_group_index_linkHandler->makePublic($add_to_index_id_sel, $check)) {
            $xoopsDB->queryF('ROLLBACK');
            redirect_header(XOOPS_URL . '/', 3, _MD_XOONIPS_GROUP_TREE_TO_PUBLIC_INDEX_TREE_FAILED);
        }

        if (!xoonips_group_index_to_public_event_log($add_to_index_id_sel, $check)) {
            $xoopsDB->queryF('ROLLBACK');
            redirect_header(XOOPS_URL . '/', 3, _MD_XOONIPS_GROUP_TREE_TO_PUBLIC_INDEX_TREE_FAILED);
        }

        $xoopsDB->queryF('COMMIT');
        $index_group_index_linkHandler->notifyMakePublicGroupIndex(array($add_to_index_id_sel), $check, 'group_item_certified');
        redirect_header(XOOPS_URL . '/modules/' . $xoopsModule->dirname() . '/editindex.php?index_id=' . $xid, 3, 'Succeed');
    } else {
        $xoopsDB->queryF('ROLLBACK');
        die('unknown certify_item config:' . $configHandler->getValue('certify_item'));
    }
    exit();
} elseif ($op === 'register') {
    // check token ticket
    if (!$xoopsGTicket->check(true, 'xoonips_edit_index')) {
        exit();
    }

    $indexes = array();
    $result  = xnp_get_indexes($xnpsid, $xid, array(), $indexes);
    if ($result != RES_OK) {
        redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
    }
    do {
        list($limitLabel, $indexCount, $indexNumberLimit) = xoonipsGetIndexCountInfo($xnpsid, $xid);
        if ("$indexNumberLimit" != '' && $indexNumberLimit <= $indexCount) {
            $error_messages[] = _MD_XOONIPS_INDEX_TOO_MANY_INDEXES;
            break;
        }

        // warn if index name is empty
        if (!isset($new_index_name) || strlen($new_index_name) == 0) {
            $error_messages[] = _MD_XOONIPS_INDEX_TITLE_EMPTY;
            break;
        }

        $lengths = xnpGetColumnLengths('xoonips_item_title');
        list($within, $without) = xnpTrimString($new_index_name, $lengths['title']);

        // warn if string is too long
        if (strlen($without)) {
            $error_messages[] = sprintf(_MD_XOONIPS_INDEX_TITLE_EXCEEDS, $new_index_name);
            break;
        }

        // break if sibling has same name
        foreach ($indexes as $index) {
            if ($index['titles'][DEFAULT_INDEX_TITLE_OFFSET] == $new_index_name) {
                $error_messages[] = sprintf(_MD_XOONIPS_INDEX_TITLE_CONFLICT, $new_index_name);
                break 2;
            }
        }

        $index  = array();
        $result = xnp_get_index($xnpsid, $xid, $index);
        if ($result != RES_OK) {
            redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
        }

        // register index
        $index['parent_index_id'] = $xid;
        $index['titles']          = array(encodeMacSafari2Server($new_index_name));
        if (xnp_insert_index($xnpsid, $index, $new_xid) == RES_OK) {
            $indexCount++;
            // Record events(insert index)
            $eventlogHandler = xoonips_getOrmHandler('xoonips', 'event_log');
            $eventlogHandler->recordInsertIndexEvent($new_xid);
            header('Location: ' . XOOPS_URL . '/modules/xoonips/editindex.php?index_id=' . (int)$xid);
        }
    } while (false);
} elseif ($op === 'up' || $op === 'down') {
    // check token ticket
    if (!$xoopsGTicket->check(true, 'xoonips_edit_index')) {
        exit();
    }
    $step = $steps[$updown_xid];

    if ($op === 'up') {
        $dir = -1;
    } else {
        $dir = 1;
    }

    // get children
    $childIndexes = array();
    $criteria     = array(
        'orders' => array(
            array(
                'name'  => 'sort_number',
                'order' => 'ASC'
            )
        )
    );
    $result       = xnp_get_indexes($xnpsid, $xid, $criteria, $childIndexes);
    if ($result == RES_OK) {
        $childIndexesLen = count($childIndexes);

        // error if any child index is locked.
        for ($i = 0; $i < $childIndexesLen; $i++) {
            xoonips_show_error_if_index_locked($childIndexes[$i]['item_id'], $xid);
        }

        // get pos
        $pos = -1;
        for ($i = 0; $i < $childIndexesLen; $i++) {
            if ($childIndexes[$i]['item_id'] == $updown_xid) {
                $pos = $i;
                break;
            }
        }
        //var_dump( $childIndexes );
        if ($pos != -1) {
            // change orders
            for ($j = 0; $j < $step; $j++) {
                $pos += $dir;
                if ($pos < 0 || $childIndexesLen <= $pos) {
                    break;
                }
                $updown_xid2 = $childIndexes[$pos]['item_id'];
                $result      = xnp_swap_index_sort_number($xnpsid, $updown_xid, $updown_xid2);
                //echo "swap($updown_xid,$updown_xid2) result=$result";
                if ($result != RES_OK) {
                    break;
                }
            }
        }
    }
    header('Location: ' . XOOPS_URL . '/modules/xoonips/editindex.php?index_id=' . (int)$xid);
} elseif (($op === 'rename' || $op === 'delete' || $op === 'moveto') && isset($check)) {
    // check token ticket
    if (!$xoopsGTicket->check(true, 'xoonips_edit_index')) {
        exit();
    }

    $xoopsMailer = getMailer();
    $lengths     = xnpGetColumnLengths('xoonips_item_title');

    // error if checked index is locked.
    reset($check);
    while (list($key, $index_id) = each($check)) {
        xoonips_show_error_if_index_locked($index_id, $xid);
    }

    reset($check);
    while (list($key, $index_id) = each($check)) {
        $index_id = (int)$index_id;
        $index    = array();
        $result   = xnp_get_index($xnpsid, $index_id, $index);
        if ($result != RES_OK) {
            redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
        }

        $oldPathString = xoonipsGetPathString($xnpsid, $index_id);
        if ($op === 'rename') {
            $notification_context = xoonips_notification_before_user_index_renamed($index_id);
            $new_index_name       = encodeMacSafari2Server($rename[$index_id]);
            list($within, $without) = xnpTrimString($new_index_name, $lengths['title']);

            // warning, if string length is too long
            if (strlen($without)) {
                $error_messages[] = sprintf(_MD_XOONIPS_INDEX_TITLE_EXCEEDS, $new_index_name);
                continue;
            }

            // warning, if title is empty
            if (strlen($new_index_name) == 0) {
                $error_messages[] = _MD_XOONIPS_INDEX_TITLE_EMPTY;
                continue;
            }

            // Warning, if there is the same name of index.
            $indexes = array();
            $result  = xnp_get_indexes($xnpsid, $xid, array(), $indexes);
            if ($result != RES_OK) {
                redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
            }

            foreach ($indexes as $index2) {
                if ($index2['titles'][DEFAULT_INDEX_TITLE_OFFSET] == $within) {
                    $error_messages[] = sprintf(_MD_XOONIPS_INDEX_TITLE_CONFLICT, $within);
                    continue 2;
                }
            }

            $old_index        = $index;
            $index['titles']  = array($within);
            $index['without'] = $without;

            if (xnp_update_index($xnpsid, $index) == RES_OK) {
                // record events(update index)
                $eventlogHandler = xoonips_getOrmHandler('xoonips', 'event_log');
                $eventlogHandler->recordUpdateIndexEvent($index_id);
            }
        } elseif ($op === 'delete') {
            $indexHandler = xoonips_getOrmHandler('xoonips', 'index');
            if (!$indexHandler->getPerm($index_id, $xoopsUser->getVar('uid'), 'delete')) {
                redirect_header(XOOPS_URL . '/modules/xoonips/editindex.php?index_id=' . (int)$xid, 3, _MD_XOONIPS_ITEM_FORBIDDEN);
            }
            // check publication request of lower group index
            $notification_context = xoonips_notification_before_user_index_deleted($index_id);

            if (xnp_delete_index($xnpsid, $index_id) == RES_OK) {
                /*
            //TODO move items from deleted index to parent index only if private item.
            $index_compoHandler= xoonips_getOrmCompoHandler('xoonips', 'index');
            if($index_compoHandler->deleteAllDescendents($index_id)
               && $index_compoHandler->deleteByKey($index_id)){
*/
                // record events(delete index)
                $eventlogHandler = xoonips_getOrmHandler('xoonips', 'event_log');
                $eventlogHandler->recordDeleteIndexEvent($index_id);
            }
        } elseif ($op === 'moveto') {
            $notification_context = xoonips_notification_before_user_index_moved($index_id);

            // Can't move to another area(Public/Group/Private)
            $destIndex = array();
            $result1   = xnp_get_index($xnpsid, $moveto, $destIndex);
            $srcIndex  = array();
            $result2   = xnp_get_index($xnpsid, $index_id, $srcIndex);
            if ($destIndex['open_level'] != $srcIndex['open_level'] || $destIndex['owner_uid'] != $srcIndex['owner_uid']
                || $destIndex['owner_gid'] != $srcIndex['owner_gid']
            ) {
                $error_messages[] = _MD_XOONIPS_INDEX_BAD_MOVE;
                break;
            }

            // move
            $index['parent_index_id'] = $moveto;
            $result                   = xnp_update_index($xnpsid, $index);
            if ($result == RES_OK) {
                // record events(update index)
                $eventlogHandler = xoonips_getOrmHandler('xoonips', 'event_log');
                $eventlogHandler->recordUpdateIndexEvent($index_id);
            }
        } else {
        }

        if ($result != RES_OK) {
            redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
        }

        // notificate rename, delete, and move to item's owner
        if ($op === 'rename') {
            xoonips_notification_after_user_index_renamed($notification_context);
        } elseif ($op === 'delete') {
            xoonips_notification_after_user_index_deleted($notification_context);
        } elseif ($op === 'moveto') {
            xoonips_notification_after_user_index_moved($notification_context);
        }
    }
    header('Location: ' . XOOPS_URL . '/modules/xoonips/editindex.php?index_id=' . (int)$xid);
} else {
}

//////////////////////// display
$indexHandler = xoonips_getOrmHandler('xoonips', 'index');
if (!isset($indexCount)) {
    list($limitLabel, $indexCount, $indexNumberLimit) = xoonipsGetIndexCountInfo($xnpsid, $xid);
}
$xoopsTpl->assign('limitLabel', $limitLabel);
$xoopsTpl->assign('indexCount', $indexCount);
$xoopsTpl->assign('indexNumberLimit', $indexNumberLimit);

$xoopsTpl->assign('group_administrator', $xgroupHandler->isGroupAdmin($uid, $index['owner_gid']));
$xoopsTpl->assign('create_permission', $indexHandler->getPerm($xid, @$_SESSION['xoopsUserId'], 'create'));
$xoopsTpl->assign('write_permission', $indexHandler->getPerm($xid, @$_SESSION['xoopsUserId'], 'write'));

/** generate character strings from result of xoonipsGetPathArray()
 * @param $xnpsid
 * @param $xid
 * @return string
 */
function xoonipsGetPathString($xnpsid, $xid)
{
    $dirArray = xoonipsGetPathArray($xnpsid, $xid);
    $ar       = array();
    foreach ($dirArray as $key => $val) {
        $ar[] = $val['titles'][DEFAULT_INDEX_TITLE_OFFSET];
    }
    return '/' . implode('/', $ar);
}

/** return array of indexes (path from ROOT to xid, Don't contain ROOT)
 * @param $xnpsid
 * @param $xid
 * @return array
 */
function xoonipsGetPathArray($xnpsid, $xid)
{
    $dirArrayR = array();
    for ($p_xid = $xid; $p_xid != IID_ROOT; $p_xid = (int)$index['parent_index_id']) {
        // get $index
        $index  = array();
        $result = xnp_get_index($xnpsid, $p_xid, $index);
        if ($result != RES_OK) {
            redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
        }

        $dirArrayR[] = $index;
    }
    $ct       = count($dirArrayR);
    $dirArray = array();
    for ($i = 0; $i < $ct; $i++) {
        $dirArray[] = $dirArrayR[$ct - $i - 1];
    }
    return $dirArray;
}

$dirArray = xoonipsGetPathArray($xnpsid, $xid);

// get Children
// -> childIndexes
$childIndexes       = array();
$index_compoHandler = xoonips_getOrmCompoHandler('xoonips', 'index');
$join               = new XooNIpsJoinCriteria('xoonips_index', 'item_id', 'index_id');
$criteria2          = new Criteria('parent_index_id', $xid);
$criteria2->setSort('sort_number');
foreach ($index_compoHandler->getObjects($criteria2, true, '', false, $join) as $index_id => $childindex) {
    $item_lockHandler              = xoonips_getOrmHandler('xoonips', 'item_lock');
    $index_group_index_linkHandler = xoonips_getOrmHandler('xoonips', 'index_group_index_link');

    $titles                  =  $childindex->getVar('titles');
    $childIndexes[$index_id] = array(
        'isLocked'                    => $item_lockHandler->isLocked($index_id),
        'titles'                      => array($titles[0]->getVar('title', 's')),
        'item_id'                     => $index_id,
        'lockTypeString'              => $textutil->html_special_chars(get_lock_type_string($index_id)),
        'write_permission'            => $indexHandler->getPerm($index_id, @$_SESSION['xoopsUserId'], 'write'),
        'public_index_string'         => '',
        'public_index_pending_string' => ''
    );

    foreach ($index_group_index_linkHandler->getByGroupIndexId($index_id, @$_SESSION['xoopsUserId']) as $link) {
        $childIndexes[$index_id]['public_index_string']
            .= xnpGetIndexPathString($xnpsid, $link->get('index_id')) . '<br>';
        $childIndexes[$index_id]['public_index_pending_string']
            .= _MD_XOONIPS_ITEM_PENDING_NOW . '<br>';
    }
}

// prev_idnex_id, next_index_id are set
reset($childIndexes);
/**
 * @param $index_id
 * @return string
 */
function get_lock_type_string($index_id)
{
    $item_lockHandler = xoonips_getOrmHandler('xoonips', 'item_lock');
    if ($item_lockHandler->isLocked($index_id)) {
        return sprintf(_MD_XOONIPS_WARNING_CANNOT_EDIT_LOCKED_INDEX, xoonips_get_lock_type_string($item_lockHandler->getLockType($index_id)));
    }
    return '';
}

// generate list about 'moveto'
require_once __DIR__ . '/include/gentree.php';

/**
 * @param $index
 */
function genSelectLabels($index)
{
    $textutil    = xoonips_getUtility('text');
    $title       = $index['titles'][DEFAULT_INDEX_TITLE_OFFSET];
    $indent_html = str_repeat('&nbsp;&nbsp;', (int)$index['depth']);
    if (isset($index['child_count']) && $index['child_count'] != 0) {
        $select_label = sprintf(' %s ( %u )', $title, $index['child_count']);
    } else {
        $select_label = sprintf(' %s ', $title);
    }
    $index['indent_html']  = $indent_html;
    $index['select_label'] = $textutil->html_special_chars($select_label);
}

$index = array();
xnp_get_index($xnpsid, $xid, $index);

$indexTree = genSameAreaIndexTree($xnpsid, $uid, $index);
array_walk($indexTree, 'genSelectLabels');

//public index tree set
$public_index    = array('open_level' => OL_PUBLIC);
$publicindexTree = genSameAreaIndexTree($xnpsid, $uid, $public_index);
$len             = count($publicindexTree);
for ($i = 0; $i < $len; $i++) {
    if (!isset($item_type_id)) {
        $item_type_id = null; //Notice undefined variable
    }
}
array_walk($publicindexTree, 'genSelectLabels');

// escape error message
$err_mes = array();
foreach ($error_messages as $mes) {
    $err_mes[] = $textutil->html_special_chars($mes);
}

$xoopsTpl->assign('updown_options', array(
    1  => 1,
    2  => 2,
    3  => 3,
    4  => 4,
    5  => 5,
    6  => 6,
    7  => 7,
    8  => 8,
    9  => 9,
    10 => 10
));
$xoopsTpl->assign('childCount', count($childIndexes));
$xoopsTpl->assign('open_level', $index['open_level']);
$xoopsTpl->assign('xid', $xid);
$xoopsTpl->assign('index_path', $dirArray); //
$xoopsTpl->assign('child_indexes', $childIndexes);
$xoopsTpl->assign('index_tree', $indexTree);
$xoopsTpl->assign('public_index_tree', $publicindexTree);
$xoopsTpl->assign('accept_charset', xnpGetMacSafariAcceptCharset());
$xoopsTpl->assign('error_message', $err_mes);
$xoopsTpl->assign('xoonips_editprofile_url', XOOPS_URL . '/modules/xoonips/edituser.php?uid=' . $uid);
// token ticket
$token_ticket = $xoopsGTicket->getTicketHtml(__LINE__, 1800, 'xoonips_edit_index');
$xoopsTpl->assign('token_ticket', $token_ticket);

require XOOPS_ROOT_PATH . '/footer.php';

// sum of numbers index(private/group) that specified xid, maximum of numbers index.
/**
 * @param $xnpsid
 * @param $xid
 * @return array
 */
function xoonipsGetIndexCountInfo($xnpsid, $xid)
{
    $index  = array();
    $result = xnp_get_index($xnpsid, $xid, $index);
    if ($result != RES_OK) {
        redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
    }
    $openLevel = $index['open_level'];

    $indexes = array();
    $result  = xnp_get_all_indexes($xnpsid, array(), $indexes);
    if ($result != RES_OK) {
        redirect_header(XOOPS_URL . '/index.php', 3, 'ERROR');
    }
    $indexesLen = count($indexes);

    if ($openLevel == OL_PRIVATE) {
        $indexUID   = $index['owner_uid'];
        $indexCount = 0;
        for ($i = 0; $i < $indexesLen; $i++) {
            if ($indexes[$i]['owner_uid'] == $indexUID) {
                $indexCount++;
            }
        }
        global $account;
        $indexNumberLimit = $account['index_number_limit'];
        $limitLabel       = _MD_XOONIPS_INDEX_NUMBER_OF_PRIVATE_INDEX_LABEL;
    } elseif ($openLevel == OL_GROUP_ONLY) {
        $xgroupHandler = xoonips_getHandler('xoonips', 'group');
        $indexGID      = $index['owner_gid'];
        $xg_obj        = $xgroupHandler->getGroupObject($indexGID);
        if (!is_object($xg_obj)) {
            redirect_header(XOOPS_URL . '/', 3, _MD_XOONIPS_ERROR_GROUP_SELECT);
        }
        $indexCount = 0;
        for ($i = 0; $i < $indexesLen; $i++) {
            if ($indexes[$i]['owner_gid'] == $indexGID) {
                $indexCount++;
            }
        }
        $indexNumberLimit = $xg_obj->get('group_index_number_limit');
        $limitLabel       = _MD_XOONIPS_INDEX_NUMBER_OF_GROUP_INDEX_LABEL;
    } else {
        return array(
            false,
            false,
            false
        );
    }

    return array(
        $limitLabel,
        $indexCount,
        $indexNumberLimit
    );
}

/** show error message and redirect if $locked_index_id is locked.
 * @param $locked_index_id
 * @param $current_index_id
 */
function xoonips_show_error_if_index_locked($locked_index_id, $current_index_id)
{
    $item_lockHandler = xoonips_getOrmHandler('xoonips', 'item_lock');
    if ($item_lockHandler->isLocked($locked_index_id)) {
        redirect_header(XOOPS_URL . '/modules/xoonips/editindex.php?index_id=' . $current_index_id, 5,
                        sprintf(_MD_XOONIPS_ERROR_CANNOT_EDIT_LOCKED_INDEX,
                                xoonips_get_lock_type_string($item_lockHandler->getLockType($locked_index_id))));
    }
}

/**
 * @param $to_index_id
 * @param $group_index_ids
 * @return bool
 */
function xoonips_group_index_to_public_event_log($to_index_id, $group_index_ids)
{
    $indexHandler    = xoonips_getOrmHandler('xoonips', 'index');
    $eventlogHandler = xoonips_getOrmHandler('xoonips', 'event_log');
    foreach ($group_index_ids as $group_index_id) {
        $group_index = $indexHandler->get($group_index_id);
        if (!$group_index) {
            trigger_error("group index not found: $group_index_id");
            return false;
        }

        if (!$eventlogHandler->recordGroupIndexToPublicEvent($to_index_id, $group_index_id, $group_index->get('gid'))) {
            trigger_error('cannot record group index to public event');
            return false;
        }
    }
    return true;
}
