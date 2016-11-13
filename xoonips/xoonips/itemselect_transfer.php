<?php
// $Revision: 1.1.2.12 $
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

//  select items

// This page can't be cached. Results of search
// (cached before login) don't display after login.
session_cache_limiter('none');
$xoopsOption['pagetype'] = 'user';
include __DIR__ . '/include/common.inc.php';

$xnpsid = $_SESSION['XNPSID'];

include_once __DIR__ . '/include/lib.php';
include_once __DIR__ . '/include/AL.php';

xoonips_deny_guest_access();

xnpEncodeMacSafariPost();
xnpEncodeMacSafariGet();

include_once __DIR__ . '/include/extra_param.inc.php';
include_once __DIR__ . '/include/item_list_header.inc.php';

$itemselect_private_only     = true;
$xoonipsTree['private_only'] = true;

// disable to link in index tree block
$xoonipsURL = '';

$formdata       = xoonips_getUtility('formdata');
$op             = $formdata->getValue('both', 'op', 's', false, '');
$onclickidx_ops = array(
    'select_item_index',
    'select_item_index_pagenavi',
);
if (in_array($op, $onclickidx_ops)) {
    $xoonipsTree['onclick_title'] = 'xoonips_itemselect_index';
}

include XOOPS_ROOT_PATH . '/header.php';
include __DIR__ . '/include/itemselect.inc.php';

$formdata   = xoonips_getUtility('formdata');
$submit_url = $formdata->getValue('post', 'submit_url', 's', false, '');

$item_list_header              = xoonips_item_list_header();
$item_list_header['order_by']  = (isset($_SESSION['xoonips_order_by']) ? $_SESSION['xoonips_order_by'] : 'title');
$item_list_header['order_dir'] = (isset($_SESSION['xoonips_order_dir']) ? $_SESSION['xoonips_order_dir'] : ASC);
$xoopsTpl->assign('item_list_header', $item_list_header);
$xoopsTpl->assign('submit_url', $submit_url);
if (isset($search_itemtype)) {
    $xoopsTpl->assign('search_itemtype', $search_itemtype);
}
include XOOPS_ROOT_PATH . '/footer.php';
