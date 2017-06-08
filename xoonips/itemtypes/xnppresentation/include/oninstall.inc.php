<?php
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
defined('XOOPS_ROOT_PATH') || exit('XOOPS root path not defined');

//  Install script for XooNIps Presentation item type module
/**
 * @param $xoopsMod
 * @return bool
 */
function xoops_module_install_xnppresentation($xoopsMod)
{
    global $xoopsDB;

    // register itemtype
    $table = $xoopsDB->prefix('xoonips_item_type');
    $mid   = $xoopsMod->getVar('mid');
    $sql
           = "INSERT INTO $table ( name, display_name, mid, viewphp ) VALUES ( 'xnppresentation', 'Presentation', $mid, 'xnppresentation/include/view.php' )";
    if ($xoopsDB->query($sql) == false) {
        // cannot register itemtype
        return false;
    }

    // register filetype
    $table = $xoopsDB->prefix('xoonips_file_type');
    $mid   = $xoopsMod->getVar('mid');
    $sql   = "INSERT INTO $table ( name, display_name, mid ) VALUES ( 'presentation_file', 'Presentation File', $mid )";
    if ($xoopsDB->query($sql) == false) {
        // cannot register itemtype
        return false;
    }

    // Delete 'Module Access Rights' from all groups
    // This allows to remove redundant module name in Main Menu
    $memberHandler = xoops_getHandler('member');
    $gpermHandler  = xoops_getHandler('groupperm');
    $groups        = $memberHandler->getGroupList();
    foreach ($groups as $groupid2 => $groupname) {
        if ($gpermHandler->checkRight('module_read', $mid, $groupid2)) {
            $criteria = new CriteriaCompo();
            $criteria->add(new Criteria('gperm_groupid', $groupid2));
            $criteria->add(new Criteria('gperm_itemid', $mid));
            $criteria->add(new Criteria('gperm_name', 'module_read'));

            $objects = $gpermHandler->getObjects($criteria);
            if (count($objects) == 1) {
                $gpermHandler->delete($objects[0]);
            }
        }
    }

    // $item_type_id = $xoopsDB->getInsertId();
    return true;
}
