<?php
// $Revision: 1.24.2.1.2.18 $
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

/* REQUEST_METHOD: POST -> invalid cache. $_POST saved as $_SESSION['post_id'], and variables are acquired with GET.
   specified post_id -> valid cache. Input forms are accuired in $_SESSION['post_id'].
   specified item_type_id -> valid cache. Input forms are empty.
   unspecified item_type_id and unspecified post_id -> invalid cache. variables are acquired after the specification of item_type_id.
   If cache is valid, the #8043 problem occurs. -> xnpsid is buried in URL.
*/

if ($_SERVER['REQUEST_METHOD'] === 'GET' && (isset($_GET['item_type_id']) || isset($_GET['post_id']))) {
    session_cache_limiter('private');
    session_cache_expire(5);
}

$xoopsOption['pagetype'] = 'user';
include __DIR__ . '/include/common.inc.php';
include_once __DIR__ . '/include/lib.php';
include_once __DIR__ . '/include/AL.php';
include_once __DIR__ . '/include/item_limit_check.php';

$xnpsid = $_SESSION['XNPSID'];

xnpEncodeMacSafariPost();
xnpEncodeMacSafariGet();

// If post_id is specified, $_POST is restored.
$formdata = xoonips_getUtility('formdata');
$post_id  = $formdata->getValue('get', 'post_id', 'n', false);
if (null !== $post_id && $_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_SESSION['post_id']) && isset($_SESSION['post_id'][$post_id])) {
        $_POST = unserialize($_SESSION['post_id'][$post_id]);
    }
}

foreach (array(
             'item_type_id' => 0,
             'scrollX'      => 0,
             'scrollY'      => 0
         ) as $k => $v
) {
    $$k = $formdata->getValue('both', $k, 'i', false, $v);
}

xoonips_deny_guest_access();

$uid = $_SESSION['xoopsUserId'];

//Uncertified user can't access(except XOOPS administrator).
if (!$xoopsUser->isAdmin($xoopsModule->getVar('mid'))
    && !xnp_is_activated($xnpsid, $uid)
) {
    redirect_header(XOOPS_URL . '/', 3, _MD_XOONIPS_MODERATOR_NOT_ACTIVATED);
}

$select_item_type = array();
$item_typeHandler = xoonips_getOrmHandler('xoonips', 'item_type');
$item_types       =  $item_typeHandler->getObjectsSortByWeight();
if ($item_types) {
    foreach ($item_types as $i) {
        $select_item_type[$i->get('display_name')] = $i->get('item_type_id');
    }
} else {
    die('item type is not found');
}

if (empty($item_type_id)) {
    // set default item type id
    if (isset($_SESSION['xoonipsITID'])) {
        $item_type_id = $_SESSION['xoonipsITID'];
    } else {
        $item_type_id = $item_types[0]->get('item_type_id');
    }
}
$_SESSION['xoonipsITID'] = $item_type_id; // setting of default value in item_type_id to display next time

if (!isset($item_type_id) && !isset($post_id) && $_SERVER['REQUEST_METHOD'] === 'GET') {
    header('HTTP/1.0 303 See Other');
    header('Location: ' . XOOPS_URL . "/modules/xoonips/register.php?item_type_id=$item_type_id&dummy=$xnpsid");
    echo sprintf(_IFNOTRELOAD, XOOPS_URL . "/modules/xoonips/register.php?item_type_id=$item_type_id&dummy=$xnpsid");
    exit;
}

$xoonipsTreeCheckBox          = true;
$xoonipsURL                   = '';
$xoonipsCheckPrivateHandlerId = 'PrivateIndexCheckedHandler'; //see also xoonips_register.tpl

$GLOBALS['xoopsOption']['template_main'] = 'xoonips_register.tpl';
include XOOPS_ROOT_PATH . '/header.php';

//check private_item_number_limit
if (available_space_of_private_item() == 0) {
    if (!isset($system_message)) {
        $system_message = '';
    }
    $system_message .= '<span style="color: red;">' . _MD_XOONIPS_ITEM_WARNING_ITEM_NUMBER_LIMIT . '</span><br>';
    $xoopsTpl->assign('system_message', $system_message);
    $xoopsTpl->assign('scrollX', 0);
    $xoopsTpl->assign('scrollY', 0);
    include XOOPS_ROOT_PATH . '/footer.php';
    exit();
}

$item_typeHandler = xoonips_getOrmHandler('xoonips', 'item_type');
$item_type        = $item_typeHandler->get($item_type_id);
if (!$item_type) {
    $item_type = $item_typeHandler->get($item_types[0]->get('item_type_id'));
}

//select_item_type: array( 'item type name' => 'item_type_id', ... );
$xoopsTpl->assign('select_item_type', $select_item_type);
$xoopsTpl->assign('item_type_id', $item_type_id);
$xoopsTpl->assign('xnpsid', $xnpsid);
$xoopsTpl->assign('next_url', 'confirm_register.php');
$xoopsTpl->assign('prev_url', 'register.php');
$xoopsTpl->assign('this_url', XOOPS_URL . '/modules/xoonips/register.php');
$xoopsTpl->assign('accept_charset', xnpGetMacSafariAcceptCharset());

include_once XOOPS_ROOT_PATH . '/modules/' . $item_type->get('viewphp');
$func = $item_type->get('name') . 'GetRegisterBlock';
$body = $func();

$xoopsTpl->assign('body', $body);
if (isset($system_message)) {
    $xoopsTpl->assign('system_message', $system_message);
}
$xoonipsCheckedXID = $formdata->getValue('post', 'xoonipsCheckedXID', 's', false);
if (isset($xoonipsCheckedXID)) {
    $xoopsTpl->assign('index_checked_id', $xoonipsCheckedXID);
}

$xoopsTpl->assign('scrollX', $scrollX);
$xoopsTpl->assign('scrollY', $scrollY);

$xoopsTpl->assign('invalid_doi_message', sprintf(_MD_XOONIPS_ITEM_DOI_INVALID_ID, XNP_CONFIG_DOI_FIELD_PARAM_MAXLEN));

$account = array();
if (xnp_get_account($xnpsid, $uid, $account) == RES_OK) {
    $iids = array();
    if (xnp_get_private_item_id($xnpsid, $uid, $iids) == RES_OK) {
        $xoopsTpl->assign('num_of_items_current', count($iids));
    } else {
        $xoopsTpl->assign('num_of_items_current', 0);
    }
    $xoopsTpl->assign('num_of_items_max', $account['item_number_limit']);
    $xoopsTpl->assign('storage_of_items_max', sprintf('%.02lf', $account['item_storage_limit'] / 1000 / 1000));
    $xoopsTpl->assign('storage_of_items_current', sprintf('%.02lf', filesize_private() / 1000 / 1000));
}

// If the page is made by POST, $_POST is made to save somewhere and page redirects.
// rfc2616 10.3.4 303 See Other
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $post_id             = uniqid('postid', true);
    $_SESSION['post_id'] = array($post_id => serialize($_POST));
    header('HTTP/1.0 303 See Other');
    header('Location: ' . XOOPS_URL . "/modules/xoonips/register.php?post_id=$post_id");
    echo sprintf(_IFNOTRELOAD, XOOPS_URL . "/modules/xoonips/register.php?post_id=$post_id");
    //redirect_header("register.php?post_id=$post_id", 5, "redirecting...");
    exit;
}

// The output( header("Cache-control: no-cache") etc ) is prevented by footer.php.
header('Content-Type:text/html; charset=' . _CHARSET);
//echo "\r\n"; flush();

include XOOPS_ROOT_PATH . '/footer.php';
