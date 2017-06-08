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

/*
alter table following from xoonips 3.24
ALTER TABLE `x_xoonips_item_keyword` DROP PRIMARY KEY ;
ALTER TABLE `x_xoonips_item_keyword` ADD `seq_id` INT( 10 ) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST ;
ALTER TABLE `x_xoonips_item_keyword` CHANGE `keyword` `keyword` VARCHAR( 255 ) NOT NULL;
ALTER TABLE `x_xoonips_item_keyword` ADD UNIQUE (`item_id` ,`keyword_id` );
*/

/**
 * @brief data object of keyword
 *
 * @li    getVar('seq_id') :
 * @li    getVar('item_id') :
 * @li    getVar('keyword_id') :
 * @li    getVar('keyword') :
 */
class XooNIpsOrmKeyword extends XooNIpsTableObject
{
    /**
     * XooNIpsOrmKeyword constructor.
     */
    public function __construct()
    {
        $this->initVar('seq_id', XOBJ_DTYPE_INT, 0, false);
        $this->initVar('item_id', XOBJ_DTYPE_INT, null, false);
        $this->initVar('keyword_id', XOBJ_DTYPE_INT, null, false);
        $this->initVar('keyword', XOBJ_DTYPE_TXTBOX, null, true, 255);
    }
}

/**
 * @brief handler object of keyword
 */
class XooNIpsOrmKeywordHandler extends XooNIpsTableObjectHandler
{
    /**
     * XooNIpsOrmKeywordHandler constructor.
     *
     * @param XoopsDatabase $db
     */
    public function __construct($db)
    {
        parent::__construct($db);
        $this->__initHandler('XooNIpsOrmKeyword', 'xoonips_item_keyword', 'seq_id');
    }

    /**
     * get keywords.
     *
     * @param int $item_id
     *
     * @return array object array
     */
    public function &getKeywords($item_id)
    {
        $criteria = new Criteria('item_id', $item_id);
        $criteria->setSort('keyword_id');
        $criteria->setOrder('ASC');

        return $this->getObjects($criteria);
    }
}
