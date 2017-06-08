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

require_once XOOPS_ROOT_PATH . '/modules/xoonips/class/base/logic.class.php';

/**
 *
 * subclass of XooNIpsLogic(getItemtype)
 *
 */
class XooNIpsLogicGetItemtype extends XooNIpsLogic
{

    /**
     * execute getItemtype
     *
     * @param[in]  $vars[0] session ID
     * @param[in]  $vars[1] item type ID
     * @param[out] $response->result true:success, false:failed
     * @param[out] $response->error  error information
     * @param[out] $response->success item type structure 2
     * @return bool
     */
    public function execute($vars, $response)
    {
        // parameter check
        $error =  $response->getError();
        if (count($vars) > 2) {
            $error->add(XNPERR_EXTRA_PARAM);
        }
        if (count($vars) < 2) {
            $error->add(XNPERR_MISSING_PARAM);
        }
        //
        if (isset($vars[0]) && strlen($vars[0]) > 32) {
            $error->add(XNPERR_INVALID_PARAM, 'too long parameter 1');
        }
        if (!isset($vars[1])) {
            $error->add(XNPERR_MISSING_PARAM, 'parameter 2 missing');
        }
        if (!ctype_digit($vars[1]) && !is_int($vars[1])) {
            $error->add(XNPERR_INVALID_PARAM, 'not integer parameter 2');
        }
        //
        if ($error->get(0)) {
            // return if parameter error
            $response->setResult(false);
            return;
        } else {
            $response->setResult(false);
            $sessionid    = $vars[0];
            $item_type_id = (int)$vars[1];
        }
        list($result, $uid, $session) = $this->restoreSession($sessionid);
        if (!$result) {
            $response->setResult(false);
            $error->add(XNPERR_INVALID_SESSION);
            return false;
        }
        // item_type_id -> detail_item_type
        $item_typeHandler = xoonips_getOrmHandler('xoonips', 'item_type');
        $item_type        = $item_typeHandler->get($item_type_id);
        if (!$item_type) {
            $response->setResult(false);
            $error->add(XNPERR_NOT_FOUND, "cannot get itemtype(item_type_id=$item_type_id)");
            return false;
        }
        $item_type_name          = $item_type->get('name');
        $detail_item_typeHandler = xoonips_getOrmHandler($item_type_name, 'item_type');
        if (!$detail_item_typeHandler) {
            $response->setResult(false);
            $error->add(XNPERR_ERROR, "unsupported itemtype($item_type_id)");
            return false;
        }
        $detail_item_type = $detail_item_typeHandler->get($item_type_id);
        if (!$detail_item_type) {
            $response->setResult(false);
            $error->add(XNPERR_ERROR, "unsupported itemtype($item_type_id)");
            return false;
        }
        $response->setSuccess($detail_item_type);
        $response->setResult(true);
        return true;
    }
}
