<?php

// ------------------------------------------------------------------------- //
//  XooNIps - Neuroinformatics Base Platform System                          //
//  Copyright (C) 2005-2014 RIKEN, Japan All rights reserved.                //
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

// XooNIps Data item type module

defined('XOOPS_ROOT_PATH') || exit('XOOPS root path not defined');

$modversion['name'] = _MI_XNPDATA_NAME;
$modversion['version'] = 3.50;
$modversion['description'] = _MI_XNPDATA_DESC;
$modversion['credits'] = 'The XooNIps Project (https://xoonips.osdn.jp/)';
$modversion['author'] = 'XooNIps developers';
$modversion['license'] = 'GPL see LICENSE';
$modversion['official'] = 0;
$modversion['image'] = 'images/xnpdata_slogo.png';
$modversion['dirname'] = 'xnpdata';

// Sql file (must contain sql generated by phpMyAdmin or phpPgAdmin)
// All tables should not have any prefix!
$modversion['sqlfile']['mysql'] = 'sql/mysql.sql';
$modversion['tables'][0] = 'xnpdata_item_detail';
$modversion['tables'][1] = 'xnpdata_experimenter';

// Admin things
$modversion['hasAdmin'] = 1;
$modversion['adminindex'] = 'admin/index.php';
$modversion['adminmenu'] = 'admin/menu.php';

// Menu
$modversion['hasMain'] = 0;

// Templates
$modversion['templates'][1]['file'] = 'xnpdata_list_block.html';
$modversion['templates'][1]['description'] = 'list block';
$modversion['templates'][2]['file'] = 'xnpdata_register_block.html';
$modversion['templates'][2]['description'] = 'register block';
$modversion['templates'][3]['file'] = 'xnpdata_detail_block.html';
$modversion['templates'][3]['description'] = 'detail block';
$modversion['templates'][4]['file'] = 'xnpdata_confirm_block.html';
$modversion['templates'][4]['description'] = 'confirm block';
$modversion['templates'][5]['file'] = 'xnpdata_search_block.html';
$modversion['templates'][5]['description'] = 'search block';
$modversion['templates'][6]['file'] = 'xnpdata_transfer_item_detail.html';
$modversion['templates'][6]['description'] = '';
$modversion['templates'][7]['file'] = 'xnpdata_transfer_item_list.html';
$modversion['templates'][7]['description'] = '';
$modversion['templates'][8]['file'] = 'xnpdata_oaipmh_oai_dc.xml';
$modversion['templates'][8]['description'] = 'OAI-PMH oai_dc';
$modversion['templates'][9]['file'] = 'xnpdata_oaipmh_junii2.xml';
$modversion['templates'][9]['description'] = 'OAI-PMH junii2';

// Blocks

// config
$modversion['config'][1]['name'] = 'enable_dl_limit';
$modversion['config'][1]['title'] = '_MI_XNPDATA_CFG_DL_LIMIT';
$modversion['config'][1]['description'] = '_MI_XNPDATA_CFG_DL_LIMIT_DESC';
$modversion['config'][1]['formtype'] = 'yesno';
$modversion['config'][1]['valuetype'] = 'int';
$modversion['config'][1]['default'] = 1;

//Install script
$modversion['onInstall'] = 'include/oninstall.inc.php';
$modversion['onUpdate'] = 'include/onupdate.inc.php';
$modversion['onUninstall'] = 'include/onuninstall.inc.php';
