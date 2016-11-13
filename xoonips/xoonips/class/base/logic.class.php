<?php
// $Revision: 1.1.4.1.2.19 $
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

include_once XOOPS_ROOT_PATH . '/class/xml/rpc/xmlrpcapi.php';
// for RSS update
include_once XOOPS_ROOT_PATH . '/modules/xoonips/include/lib.php';
include_once XOOPS_ROOT_PATH . '/modules/xoonips/include/AL.php';

/**
 *
 * base class of Business Logic
 *
 */
class XooNIpsLogic
{
    /**
     * XooNIpsLogic constructor.
     */
    public function __construct()
    {
    }

    /**
     * implement of logic
     * @abstract
     * @param[in] array $vars input parameters of logic
     * @param[out] XooNIpsResponse $response result of logic(success/fault, response, error)
     * @return bool
     */
    public function execute($vars, $response)
    {
        /* abstract */
        return false;
    }

    /**
     * @brief validate $sessionid and restore $_SESSION.
     *
     * @param [in]  $sessionid session ID
     * @return     array($result,$uid,$session)
     *             if $result==true && uid != UID_GUEST, $sessionid was valid, $uid and $session are user ID and XooNIpsSession object.
     *             if $result==true && uid == UID_GUEST, $sessionid was valid and $session=false.
     *             if $result==false,                    $sessionid was invalid and $uid=$session=false.
     *
     */
    public function restoreSession($sessionid)
    {
        global $_SESSION;
        session_id($sessionid);
        // restore $_SESSION
        $xoops_sessHandler = xoops_getHandler('session');
        $sess_data         = $xoops_sessHandler->read($sessionid);
        if ($sess_data == '') {
            return array(
                false,
                false,
                false
            );
        } else {
            session_decode($sess_data);
        }
        $uid = $_SESSION['xoopsUserId'];
        if ($uid == UID_GUEST) {
            // reject guest if guest is forbidden
            $xconfigHandler = xoonips_getOrmHandler('xoonips', 'config');
            $target_user    = $xconfigHandler->getValue(XNP_CONFIG_PUBLIC_ITEM_TARGET_USER_KEY);
            if ($target_user != XNP_CONFIG_PUBLIC_ITEM_TARGET_USER_ALL) {
                return array(
                    false,
                    false,
                    false
                );
            }
            $session = false;
        } else {
            // validate session
            $sessHandler = xoonips_getOrmHandler('xoonips', 'session');
            $sessions    =  $sessHandler->getObjects(new Criteria('sess_id', $sessionid));
            if (!$sessions || count($sessions) != 1) {
                return array(
                    false,
                    false,
                    false
                );
            }

            $memberHandler = xoops_getHandler('member');
            $xoops_user    = $memberHandler->getUser($_SESSION['xoopsUserId']);
            if ($xoops_user) {
                $GLOBALS['xoopsUser'] =  $xoops_user;
            }

            $session = $sessions[0];
            $session->setVar('updated', time(), true); // not gpc
            $sessHandler->insert($session);
        }
        return array(
            true,
            $uid,
            $session
        );
    }

    /**
     * @brief    helper function for putItem, updateItem2.
     * update certify_state, insert event, update item_status, lock contents
     *
     * @param             $error
     * @param XooNIpsItem $item
     * @param             $uid
     * @return bool|result
     * @internal param XooNIpsResponse $response object
     * @internal param XooNIpsItem $item object
     */
    public function touchItem1($error, $item, $uid)
    {
        // get indexes
        $index_ids        = array();
        $index_item_links = $item->getVar('indexes');
        if (!$index_item_links || count($index_item_links) == 0) {
            $error->add(XNPERR_SERVER_ERROR, 'no indexes');
            return false;
        }
        // certify automatically?
        $xconfigHandler = xoonips_getOrmHandler('xoonips', 'config');
        $certify_item   = $xconfigHandler->getValue('certify_item'); // todo define string const
        if (null === $certify_item) {
            $error->add(XNPERR_SERVER_ERROR, 'no certify_item config');
            return false;
        }
        $auto_certify           = ($certify_item === 'auto');
        $indexHandler           = xoonips_getOrmHandler('xoonips', 'index');
        $eventlogHandler        = xoonips_getOrmHandler('xoonips', 'event_log');
        $index_item_linkHandler = xoonips_getOrmHandler('xoonips', 'index_item_link');
        $item_basicHandler      = xoonips_getOrmHandler('xoonips', 'item_basic');
        $is_public              = false;
        $len                    = count($index_item_links);
        $basic                  = $item->getVar('basic');
        $item_id                = $basic->get('item_id');
        for ($i = 0; $i < $len; $i++) {
            $index_item_link =  $index_item_links[$i];
            $certify_state   = $index_item_link->get('certify_state');
            $index_id        = $index_item_link->get('index_id');
            $index           = $indexHandler->get($index_id);
            if (!$index) {
                // maybe someone deleted this index.
                $error->add(XNPERR_SERVER_ERROR, "item is in non-existent index(index_id=$index_id)");
                return false;
            }
            $open_level = $index->get('open_level');
            if ($open_level == OL_GROUP_ONLY || $open_level == OL_PUBLIC) {
                // get moderator/groupadmin uid list
                $open_level = $index->get('open_level');
                if ($open_level == OL_PUBLIC && $auto_certify) {
                    $is_public = true;
                }
                $indexes[] = $index;
                if (!$eventlogHandler->recordRequestCertifyItemEvent($item_id, $index_id)) {
                    $error->add(XNPERR_SERVER_ERROR, 'cannot insert event');
                    return false;
                }
                if ($auto_certify) {
                    $index_item_link->setVar('certify_state', CERTIFIED, true); // not gpc
                    if (!$eventlogHandler->recordCertifyItemEvent($item_id, $index_id)) {
                        $error->add(XNPERR_SERVER_ERROR, 'cannot insert event');
                        return false;
                    }
                } else {
                    $index_item_link->setVar('certify_state', CERTIFY_REQUIRED, true); // not gpc
                }
                if (!$index_item_linkHandler->insert($index_item_link)) {
                    $error->add(XNPERR_SERVER_ERROR, 'cannot update index_item_link');
                    return false;
                }
                if ($auto_certify) {
                } else {
                    $item_basicHandler->lockItemAndIndexes($item_id, $index_id);
                }
            }
        }

        // update item_status
        $item_statusHandler = xoonips_getOrmHandler('xoonips', 'item_status');
        $old_item_status    = $item_statusHandler->get($item_id);
        $item_status        = $item_statusHandler->create(); // re-create because XooNIpsTableObject cannot be setVar(key,null,true)ed
        $item_status->setVar('item_id', $item_id, true); // not gpc
        if ($old_item_status) {
            $item_status->unsetNew();
        }
        if ($is_public) {
            // public -> public or non-public -> public
            $item_status->setVar('created_timestamp', time(), true); // not gpc
            $item_status->setVar('is_deleted', 0, true); // not gpc
            if (!$item_statusHandler->insert($item_status)) {
                $error->add(XNPERR_SERVER_ERROR, 'cannot update item_status');
                return false;
            }
        } else {
            if ($old_item_status && $old_item_status->get('is_deleted') == 0) {
                // public -> non-public
                $item_status->setVar('deleted_timestamp', time(), true); // not gpc
                $item_status->setVar('is_deleted', 1, true); // not gpc
                if (!$item_statusHandler->insert($item_status)) {
                    $error->add(XNPERR_SERVER_ERROR, 'cannot update item_status');
                    return false;
                }
            } else {
                // non-public -> non-public
            }
        }

        return true;
    }

    /**
     * @brief    helper function for putItem, updateItem2.
     * update notify, update rss
     * @param             $error
     * @param XooNIpsItem $item
     * @param             $uid
     * @return bool|result
     * @internal param XooNIpsResponse $response object
     * @internal param XooNIpsItem $item object
     */
    public function touchItem2($error, $item, $uid)
    {
        $basic   = $item->getVar('basic');
        $item_id = $basic->get('item_id');

        // notify
        $index_item_linkHandler = xoonips_getOrmHandler('xoonips', 'index_item_link');
        $index_item_links       = $index_item_linkHandler->getByItemId($item_id, array(
            OL_GROUP_ONLY,
            OL_PUBLIC
        ));
        foreach ($index_item_links as $link) {
            if ($link->get('certify_state') == CERTIFY_REQUIRED) {
                xoonips_notification_item_certify_request($link->get('item_id'), $link->get('index_id'));
            } elseif ($link->get('certify_state') == CERTIFIED) {
                xoonips_notification_item_certified_auto($link->get('item_id'), $link->get('index_id'));
            }
        }

        return true;
    }

    /** get ids of group-certified item.
     * @param gid
     * @return item_id[]
     */
    public function getCertifiedGroupItemIds($gid)
    {
        $index_item_linkHandler = xoonips_getOrmHandler('xoonips', 'index_item_link');
        $join                   = new XooNIpsJoinCriteria('xoonips_index', 'index_id', 'index_id');
        $criteria               = new CriteriaCompo();
        $criteria->add(new Criteria('gid', $gid));
        $criteria->add(new Criteria('open_level', OL_GROUP_ONLY));
        $criteria->add(new Criteria('certify_state', CERTIFIED));
        $criteria->setGroupBy('item_id');
        $index_item_links =  $index_item_linkHandler->getObjects($criteria, false, 'item_id', false, $join);
        $iids             = array();
        foreach ($index_item_links as $link) {
            $iids[] = $link->get('item_id');
        }
        return $iids;
    }

    /**
     * @brief get size of item. useful if item is not on DB yet.
     * @param item [in] XooNIpsItemCompo
     * @return bool|int
     */
    public function getSizeOfItem($item)
    {
        $basic            = $item->getVar('basic');
        $item_typeHandler = xoonips_getOrmHandler('xoonips', 'item_type');
        $item_type        = $item_typeHandler->get($basic->get('item_type_id'));
        if (!$item_type) {
            return false;
        }
        $detail_item_typeHandler = xoonips_getOrmHandler($item_type->get('name'), 'item_type');
        if (!$detail_item_typeHandler) {
            return false;
        }
        $detail_item_type = $detail_item_typeHandler->get($basic->get('item_type_id'));
        if (!$detail_item_type) {
            return false;
        }
        $result = 0;
        foreach ($detail_item_type->getFileTypeNames() as $file_type_name) {
            $files = $item->getVar($file_type_name);
            if (is_array($files)) {
                foreach ($files as $file) {
                    $result += $file->get('file_size');
                }
            } elseif ($files) {
                $result += $files->get('file_size');
            }
        }
        return $result;
    }
    /* todo: test
    *  if ( sizeof(private_iids) + new_size - old_size > private_item_storage_limit ) -> error: private item storage limit exceeds
    *  if ( !$old_index_item_links && count(private_iids) + 1 > private_item_number_limit ) -> error: private item number limit exceeds
    *  if (  old && new && private                 ) -> check private storage(+new-old)
    *  if ( !old && new && private                 ) -> check private storage(+new    ), check private num(+1)
    *  if (  old && new && group   && auto_certify ) -> check group storage(+new-old)
    *  if ( !old && new && group   && auto_certify ) -> check group storage(+new    ), check group num(+1)
    *  new: no permission -> -
    *  old: no permission -> -
    *  new: no index -> error: cannot get index
    *  old: no index -> error: cannot get index
    *  user: no user -> error: no such user
    */

    /**
     * @brief    check if enough space is available
     * @param       $error
     * @param       $uid
     * @param       $new_size
     * @param       $new_index_item_links
     * @param int   $old_size
     * @param array $old_index_item_links
     * @return bool
     * @internal param $error [out] error information
     * @internal param $uid [in] user id
     * @internal param $new_size [in]  future total file size of item
     * @internal param $new_index_item_links [in]  where item will be registered to
     * @internal param $old_size [in]  current total file size of item
     * @internal param $old_index_item_links [in]  where item is registered to
     */
    public function isEnoughSpace($error, $uid, $new_size, $new_index_item_links, $old_size = 0, $old_index_item_links = array())
    {
        $result = true;
        // check private index limit
        $userHandler = xoonips_getOrmHandler('xoonips', 'users');
        $user        = $userHandler->get($uid);
        if (!$user) {
            $error->add(XNPERR_SERVER_ERROR, "no such user(uid=$uid)");
            return false;
        }
        $index_item_linkHandler = xoonips_getOrmHandler('xoonips', 'index_item_link');
        $private_iids           = $index_item_linkHandler->getPrivateItemIdsByUid($uid);
        $fileHandler            = xoonips_getOrmHandler('xoonips', 'file');
        if ($fileHandler->getTotalSizeOfItems($private_iids) + $new_size - $old_size > $user->get('private_item_storage_limit')) {
            $error->add(XNPERR_STORAGE_OF_ITEM_LIMIT_EXCEEDS, "private item storage limit exceeds(uid=$uid)");
            $result = false;
        }
        if (!$old_index_item_links) {
            if (count($private_iids) + 1 > $user->get('private_item_number_limit')) {
                $error->add(XNPERR_NUMBER_OF_ITEM_LIMIT_EXCEEDS, "private item number limit exceeds(uid=$uid)");
                $result = false;
            }
        }
        // get group ids
        $indexHandler = xoonips_getOrmHandler('xoonips', 'index');
        $new_gids     = array();
        foreach ($new_index_item_links as $link) {
            $index_id = $link->get('index_id');
            $index    = $indexHandler->get($index_id);
            if (!$index) {
                $error->add(XNPERR_SERVER_ERROR, "cannot get index(index_id=$index_id)");
                return false;
            } elseif ($index->get('open_level') == OL_GROUP_ONLY) {
                $new_gids[$index->get('gid')] = true;
            }
        }
        $old_gids = array();
        foreach ($old_index_item_links as $link) {
            $index_id = $link->get('index_id');
            $index    = $indexHandler->get($index_id);
            if (!$index) {
                $error->add(XNPERR_SERVER_ERROR, "cannot get index(index_id=$index_id)");
                return false;
            } elseif ($index->get('open_level') == OL_GROUP_ONLY) {
                $old_gids[$index->get('gid')] = true;
            }
        }
        // item number/storage limit check (group) (only if auto_certify)
        $xconfigHandler = xoonips_getOrmHandler('xoonips', 'config');
        $certify_item   = $xconfigHandler->getValue('certify_item');
        if (null === $certify_item) {
            $error->add(XNPERR_SERVER_ERROR, 'cannot get certify_item config');
            return false;
        } elseif ($certify_item === 'auto' && count($new_gids)) {
            $groupsHandler = xoonips_getOrmHandler('xoonips', 'groups');
            foreach ($new_gids as $gid => $dummy) {
                $group      = $groupsHandler->get($gid);
                $group_iids = $this->getCertifiedGroupItemIds($gid);
                if ($fileHandler->getTotalSizeOfItems($group_iids) + $new_size - (empty($old_gids[$gid]) ? 0 : $old_size)
                    > $group->get('group_item_storage_limit')
                ) {
                    $error->add(XNPERR_SERVER_ERROR, "group item storage limit exceeds(gid=$gid)");
                    $result = false;
                }
                if (empty($old_gids[$gid])) {
                    if (count($group_iids) + 1 > $group->get('group_item_number_limit')) {
                        $error->add(XNPERR_SERVER_ERROR, "group item number limit exceeds(gid=$gid)");
                        $result = false;
                    }
                }
            }
        }
        return $result;
    }

    /**
     * @brief    guess mime-type of file
     * @param XooNIpsFile $file
     * @return mime -type string(e.g. application/pdf)
     * @internal param XooNIpsFile $file
     */
    public function guessMimeType($file)
    {
        // TODO: move this function
        $fileutil  = xoonips_getUtility('file');
        $file_path = $file->getFilepath();
        $file_name = $file->get('original_file_name');
        return $fileutil->get_mimetype($file_path, $file_name);
    }

    /**
     * @brief create thumbnail image of file
     * @param $error
     * @param $file
     * @return bool
     */
    public function createThumbnail($error, $file)
    {
        $file_path = $file->getFilepath();
        $mimetype  = $file->get('mime_type');
        $fileutil  = xoonips_getUtility('file');
        $thumbnail = $fileutil->get_thumbnail($file_path, $mimetype);
        if (empty($thumbnail)) {
            $error->add(XNPERR_INVALID_PARAM, 'failed to create thumbnail');
            return false;
        }
        $file->set('thumbnail_file', $thumbnail);
        return true;
    }

    /** convert prefixed number to a number(e.g. '4k' to 4096)
     * @param $val
     * @return int|string
     */
    public function returnBytes($val)
    {
        if ($val == '' || $val == -1) {
            // '' : disable memory limit.
            // -1 : unlimit size
            $val = '1G';
        }
        $val  = trim($val);
        $len  = strlen($val);
        $last = strtolower($val{$len - 1});
        if (!is_numeric($last)) {
            $val = substr($val, 0, $len - 1);
            switch ($last) {
                // The 'G' modifier is available since PHP 5.1.0
                case 'g':
                    $val *= 1024;
                case 'm':
                    $val *= 1024;
                case 'k':
                    $val *= 1024;
            }
        }
        return $val;
    }

    /*
        function _check_missing_parameters( $params, $num_of_params ){
            if ( count($params) < $num_of_params ){
                $this -> _response->setResult(false);
                $this -> _error->add(XNPERR_MISSING_PARAM);
                return false;
            }
            return true;
        }

        function _check_extra_parameters( $params, $num_of_params ){
            if ( count($params) > $num_of_params ){
                $this -> _response->setResult(false);
                $this -> _error->add(XNPERR_EXTRA_PARAM);
                return false;
            }
            return true;
        }
    */

    /** convert lock type to string.
     * @param $lock_type
     * @return string
     */
    public function getLockTypeString($lock_type)
    {
        switch ($lock_type) {
            case XOONIPS_LOCK_TYPE_NOT_LOCKED:
                return 'not locked';
            case XOONIPS_LOCK_TYPE_CERTIFY_REQUEST:
                return 'requested to certify';
            case XOONIPS_LOCK_TYPE_TRANSFER_REQUEST:
                return 'requested to transfer';
        }
        return "(internal error: unsupported lock type. lock_type=$lock_type)";
    }

    /**
     * @param $response
     * @param $year
     * @param $month
     * @param $mday
     * @param $year_required
     * @param $month_required
     * @param $mday_required
     * @return bool
     */
    public function isPublicationDateValid($response, $year, $month, $mday, $year_required, $month_required, $mday_required)
    {
        $error       = $response->getError();
        $year_valid  = false;
        $month_valid = false;
        $mday_valid  = false;
        if (empty($year) || ctype_digit($year) && (1 <= $year && $year <= 9999)) {
            $year_valid = true;
            $int_year   = (int)$year;
        }
        if (empty($month) || ctype_digit($month) && (1 <= $month && $month <= 12)) {
            $month_valid = true;
            $int_month   = (int)$month;
        }
        if (empty($mday) || ctype_digit($mday) && (1 <= $mday && $mday <= 31 && checkdate($int_month, $mday, $int_year))) {
            $mday_valid = true;
            $int_mday   = (int)$mday;
        }

        if (!$year_valid || !$month_valid || !$mday_valid || $int_year == 0 && ($int_month != 0 || $int_mday != 0)
            || $int_month == 0
               && $int_mday != 0
        ) {
            $error->add(XNPERR_INVALID_PARAM, 'invalid creation date');
            return false;
        }

        $is_complete = true;
        if ($year_required && $int_year == 0) {
            $error->add(XNPERR_INCOMPLETE_PARAM, 'creation_year');
            $is_complete = false;
        }
        if ($month_required && $int_month == 0) {
            $error->add(XNPERR_INCOMPLETE_PARAM, 'creation_month');
            $is_complete = false;
        }
        if ($mday_required && $int_mday == 0) {
            $error->add(XNPERR_INCOMPLETE_PARAM, 'creation_mday');
            $is_complete = false;
        }
        return $is_complete;
    }
}
