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

require_once __DIR__.'/../base/view.class.php';

/**
 * Class XooNIpsViewImportConfirm.
 */
class XooNIpsViewImportConfirm extends XooNIpsView
{
    /**
     * XooNIpsViewImportConfirm constructor.
     *
     * @param associative $response
     */
    public function __construct($response)
    {
        parent::__construct($response);
    }

    public function render()
    {
        global $xoopsOption, $xoopsConfig, $xoopsUser, $xoopsUserIsAdmin, $xoopsLogger, $xoopsTpl;

        $GLOBALS['xoopsOption']['template_main'] = 'xoonips_import_confirm.tpl';
        require XOOPS_ROOT_PATH.'/header.php';
        $xoopsTpl->assign('token_hidden', $this->_params['ticket_html']);
        require XOOPS_ROOT_PATH.'/footer.php';
    }
}
