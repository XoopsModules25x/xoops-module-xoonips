<?php
// $Revision: 1.1.4.1.2.5 $
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
if (!defined('XOOPS_ROOT_PATH')) {
    exit();
}

// get requests
$formdata = xoonips_getUtility('formdata');
$uid      = $formdata->getValue('get', 'uid', 'i', true);

// is uid really xoonips user ?
$usersHandler  = xoonips_getOrmHandler('xoonips', 'xoops_users');
$xusersHandler = xoonips_getOrmHandler('xoonips', 'users');
$u_obj         = $usersHandler->get($uid);
$xu_obj        = $xusersHandler->get($uid);
if (!is_object($u_obj) || !is_object($xu_obj)) {
    redirect_header($xoonips_admin['mypage_url'], 3, _AM_XOONIPS_MSG_ILLACCESS);
}

// is uid really not system admin or moderator or group admin user ?
$xmemberHandler = xoonips_getHandler('xoonips', 'member');
$xgroupHandler  = xoonips_getHandler('xoonips', 'group');
if ($xmemberHandler->isAdmin($uid) || $xmemberHandler->isModerator($uid) || $xgroupHandler->isGroupAdmin($uid)) {
    redirect_header($xoonips_admin['mypage_url'], 3, _AM_XOONIPS_MAINTENANCE_ACCOUNT_DCONFIRM_MSG_IGNORE_USER);
}

// is uid really has not public/group items ?
$index_item_linkHandler = xoonips_getOrmHandler('xoonips', 'index_item_link');
if (count($index_item_linkHandler->getNonPrivateItemIds($uid)) > 0) {
    redirect_header($xoonips_admin['mypage_url'], 3, _AM_XOONIPS_MAINTENANCE_ACCOUNT_DCONFIRM_MSG_ITEM_HANDOVER);
}

// title
$title = _AM_XOONIPS_MAINTENANCE_ACCOUNT_DCONFIRM_TITLE;

// breadcrumbs
$breadcrumbs = array(
    array(
        'type'  => 'top',
        'label' => _AM_XOONIPS_TITLE,
        'url'   => $xoonips_admin['admin_url'] . '/',
    ),
    array(
        'type'  => 'link',
        'label' => _AM_XOONIPS_MAINTENANCE_TITLE,
        'url'   => $xoonips_admin['myfile_url'],
    ),
    array(
        'type'  => 'link',
        'label' => _AM_XOONIPS_MAINTENANCE_ACCOUNT_TITLE,
        'url'   => $xoonips_admin['mypage_url'],
    ),
    array(
        'type'  => 'label',
        'label' => $title,
        'url'   => '',
    ),
);

// token ticket
require_once __DIR__ . '/../../class/base/gtickets.php';
$ticket_area  = 'xoonips_admin_maintenance_account_delete';
$token_ticket = $xoopsGTicket->getTicketHtml(__LINE__, 1800, $ticket_area);

// templates
require_once __DIR__ . '/../../class/base/pattemplate.class.php';
$tmpl = new PatTemplate();
$tmpl->setBasedir('templates');
$tmpl->readTemplatesFromFile('maintenance_account_confirm.tmpl.tpl');

// assign template variables
$tmpl->addVar('header', 'TITLE', $title);
$tmpl->setAttribute('breadcrumbs', 'visibility', 'visible');
$tmpl->addRows('breadcrumbs_items', $breadcrumbs);
$tmpl->addVar('main', 'TOKEN_TICKET', $token_ticket);
$tmpl->addVar('main', 'ACTION', 'delete');
$tmpl->addVar('main', 'CONFIRM_MSG', _AM_XOONIPS_MSG_DELETE_CONFIRM);
// >> user inforamtion from
$tmpl->addVar('main', 'UID_TITLE', _AM_XOONIPS_LABEL_UID);
$tmpl->addVar('main', 'UID_VALUE', $uid);
$tmpl->addVar('main', 'UNAME_TITLE', _AM_XOONIPS_LABEL_UNAME);
$tmpl->addVar('main', 'UNAME_VALUE', $u_obj->getVar('uname', 's'));
$tmpl->addVar('main', 'NAME_TITLE', _AM_XOONIPS_LABEL_NAME);
$tmpl->addVar('main', 'NAME_VALUE', $u_obj->getVar('name', 's'));
$tmpl->addVar('main', 'EMAIL_TITLE', _AM_XOONIPS_LABEL_EMAIL);
$tmpl->addVar('main', 'EMAIL_VALUE', $u_obj->getVar('email', 's'));
$tmpl->addVar('main', 'NO', _AM_XOONIPS_LABEL_BACK);
$tmpl->addVar('submit', 'YES', _AM_XOONIPS_LABEL_DELETE);

// display
xoops_cp_header();
$tmpl->displayParsedTemplate('main');
xoops_cp_footer();
