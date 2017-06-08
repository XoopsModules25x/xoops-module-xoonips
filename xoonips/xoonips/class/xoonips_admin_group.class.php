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

require_once __DIR__.'/xoonips_group.class.php';

/**
 * XooNIps Admin Group Handler class.
 */
class XooNIpsAdminGroupHandler extends XooNIpsGroupHandler
{
    /**
     * XooNIpsAdminGroupHandler constructor.
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * add user to XooNIps group.
     *
     * @param int  $gid      group id
     * @param int  $uid      user id
     * @param bool $is_admin true if user will be group admin
     *
     * @return bool false if failure
     */
    public function addUserToXooNIpsGroup($gid, $uid, $is_admin)
    {
        $xuHandler = xoonips_getOrmHandler('xoonips', 'users');
        $is_update = false;
        $is_admin_new = $is_admin ? 1 : 0;
        // check user and group exists
        $criteria = new Criteria('uid', $uid);
        if ($xuHandler->getCount($criteria) != 1) {
            // user not found
            return false;
        }
        $criteria = new Criteria('gid', $gid);
        if ($this->_xgHandler->getCount($criteria) != 1) {
            // group not found
            return false;
        }
        // check current groups
        $criteria = new CriteriaCompo(new Criteria('gid', $gid));
        $criteria->add(new Criteria('uid', $uid));
        $xgl_objs = $this->_xglHandler->getObjects($criteria);
        $xgl_count = count($xgl_objs);
        if ($xgl_count == 0) {
            // insert user to group
            $xgl_obj = $this->_xglHandler->create();
            $xgl_obj->set('gid', $gid);
            $xgl_obj->set('uid', $uid);
            $xgl_obj->set('is_admin', $is_admin_new);
            if (!$this->_xglHandler->insert($xgl_obj)) {
                return false;
            }
        } elseif ($xgl_count == 1) {
            // already exists
            $xgl_obj = $xgl_objs[0];
            $is_admin_old = $xgl_obj->get('is_admin');
            if ($is_admin_old == $is_admin_new) {
                // status not changed
                return true;
            }
            // update is_admin field
            $xgl_obj->set('is_admin', $is_admin_new);
            if (!$this->_xglHandler->insert($xgl_obj)) {
                return false;
            }
        } else {
            // unexcepted error - the user joined duplicated same group
            die('Fatal error occurred in '.__FILE__.' line '.__LINE__);
        }
        // record event log
        $eventHandler = xoonips_getOrmHandler('xoonips', 'event_log');
        if ($is_update) {
            $eventHandler->recordDeleteGroupMemberEvent($uid, $gid);
        }
        $eventHandler->recordInsertGroupMemberEvent($uid, $gid);

        return true;
    }

    /**
     * add user to default xoonips group.
     *
     * @param int $uid user id
     *
     * @return bool false if failure
     */
    public function addUserToDefaultXooNIpsGroup($uid)
    {
        return $this->addUserToXooNIpsGroup(GID_DEFAULT, $uid, false);
    }

    /**
     * delete user from xoonips group.
     *
     * @param int  $uid   user id
     * @param int  $gid   group id
     * @param bool $force force deletion
     *
     * @return bool false if failure
     */
    public function deleteUserFromXooNIpsGroup($gid, $uid, $force = false)
    {
        $xuHandler = xoonips_getOrmHandler('xoonips', 'users');
        // check user and group exists
        $criteria = new Criteria('uid', $uid);
        if ($xuHandler->getCount($criteria) != 1) {
            // user not found
            return false;
        }
        $criteria = new Criteria('gid', $gid);
        if ($this->_xgHandler->getCount($criteria) != 1) {
            // group not found
            return false;
        }
        // check current groups
        $criteria = new CriteriaCompo(new Criteria('gid', $gid));
        $criteria->add(new Criteria('uid', $uid));
        $xgl_objs = $this->_xglHandler->getObjects($criteria);
        $xgl_count = count($xgl_objs);
        if ($xgl_count == 0) {
            return true;
        } elseif ($xgl_count == 1) {
            $xgl_obj = $xgl_objs[0];
            if (!$force && $xgl_obj->get('is_admin') == 1) {
                // administrator can not leave from group member
                return false;
            }
            $iids = $this->getGroupItemIds($gid, $uid);
            if (!$force && count($iids) != 0) {
                // user has group shared items
                return false;
            }
            if (!$this->_xglHandler->deleteAll($criteria)) {
                return false;
            }
        } else {
            // unexcepted error - the user joined duplicated same group
            die('Fatal error occurred in '.__FILE__.' line '.__LINE__);
        }
        // record event log
        $eventHandler = xoonips_getOrmHandler('xoonips', 'event_log');
        $eventHandler->recordDeleteGroupMemberEvent($uid, $gid);

        return true;
    }

    /**
     * create new group.
     *
     * @param string $name       group name
     * @param string $desc       group description
     * @param array  $admin_uids administrator's uids
     * @param int    $max_item   maximum number of items
     * @param int    $max_index  maximum number of indexes
     * @param float  $max_size   maximum storage size [MB]
     *
     * @return bool false if failure
     */
    public function createGroup($name, $desc, $admin_uids, $max_item, $max_index, $max_size)
    {
        if (in_array(strtolower($name), array(
            'public',
            'private',
            'root',
        ))) {
            // doesn't accept system reserved name
            return false;
        }
        if ($this->existsGroup($name)) {
            // group name is already used
            return false;
        }
        // create group
        $xg_obj = $this->_xgHandler->create();
        $xg_obj->set('gname', $name);
        $xg_obj->set('gdesc', $desc);
        $xg_obj->set('group_item_number_limit', $max_item);
        $xg_obj->set('group_index_number_limit', $max_index);
        $xg_obj->set('group_item_storage_limit', $max_size);
        if (!$this->_xgHandler->insert($xg_obj)) {
            return false;
        }
        $gid = $xg_obj->get('gid');
        // create group root index
        $indexHandler = xoonips_getOrmHandler('xoonips', 'index');
        $gxid = $indexHandler->createGroupRootIndex($gid);
        if ($gxid === false) {
            $this->_xgHandler->delete($xg_obj);

            return false;
        }
        // update group index id
        $xg_obj->unsetNew();
        $xg_obj->set('group_index_id', $gxid);
        if (!$this->_xgHandler->insert($xg_obj)) {
            // TODO: remove index
            return false;
        }
        // record event log
        $eventHandler = xoonips_getOrmHandler('xoonips', 'event_log');
        $eventHandler->recordInsertGroupEvent($gid);
        // add admin user to group
        foreach ($admin_uids as $uid) {
            $this->addUserToXooNIpsGroup($gid, $uid, true);
        }

        return true;
    }

    /**
     * update group.
     *
     * @param int    $gid        group id
     * @param string $name       group name
     * @param string $desc       group description
     * @param array  $admin_uids administrator's uids
     * @param int    $max_item   maximum number of items
     * @param int    $max_index  maximum number of indexes
     * @param float  $max_size   maximum storage size [MB]
     *
     * @return bool false if failure
     */
    public function updateGroup($gid, $name, $desc, $admin_uids, $max_item, $max_index, $max_size)
    {
        $xg_obj = $this->_xgHandler->get($gid);
        if (!is_object($xg_obj)) {
            return false;
        }
        // check status
        if (in_array(strtolower($name), array(
            'public',
            'private',
            'root',
        ))) {
            // doesn't accept system reserved name
            return false;
        }
        if ($this->existsGroup($name, $gid)) {
            // new group name is already used
            return false;
        }
        $item_lockHandler = xoonips_getOrmHandler('xoonips', 'item_lock');
        if ($item_lockHandler->isLocked($xg_obj->get('group_index_id'))) {
            // group root index is locked
            return false;
        }

        $old_name = $xg_obj->get('gname');
        $xg_obj->set('gname', $name);
        $xg_obj->set('gdesc', $desc);
        $xg_obj->set('group_item_number_limit', $max_item);
        $xg_obj->set('group_index_number_limit', $max_index);
        $xg_obj->set('group_item_storage_limit', $max_size);
        if (!$this->_xgHandler->insert($xg_obj)) {
            return false;
        }
        // update group admin privileges
        $uids = $this->getUserIds($gid, true);
        $add_uids = array_diff($admin_uids, $uids);
        $del_uids = array_diff($uids, $admin_uids);
        foreach ($add_uids as $uid) {
            if (!$this->addUserToXooNIpsGroup($gid, $uid, true)) {
                return false;
            }
        }
        foreach ($del_uids as $uid) {
            if (!$this->addUserToXooNIpsGroup($gid, $uid, false)) {
                return false;
            }
        }
        if ($old_name != $name) {
            // rename index title
            $xid = $xg_obj->get('group_index_id');
            $indexHandler = xoonips_getOrmHandler('xoonips', 'index');
            if (!$indexHandler->renameIndexTitle($xid, $name)) {
                return false;
            }
        }
        // record event log
        $eventHandler = xoonips_getOrmHandler('xoonips', 'event_log');
        $eventHandler->recordUpdateGroupEvent($gid);

        return true;
    }

    /**
     * delete xoonips group.
     *
     * @param int $gid group id
     *
     * @return bool false if failure
     */
    public function deleteGroup($gid)
    {
        $xg_obj = $this->_xgHandler->get($gid);
        if (!is_object($xg_obj)) {
            return false;
        }
        $admin_rankingHandler = xoonips_getHandler('xoonips', 'admin_ranking');
        $indexHandler = xoonips_getOrmHandler('xoonips', 'index');
        $item_basicHandler = xoonips_getOrmHandler('xoonips', 'item_basic');
        $index_item_linkHandler = xoonips_getOrmHandler('xoonips', 'index_item_link');
        $titleHandler = xoonips_getOrmHandler('xoonips', 'title');
        $keywordHandler = xoonips_getOrmHandler('xoonips', 'keyword');
        $eventHandler = xoonips_getOrmHandler('xoonips', 'event_log');
        // check group index locking status for group root index deletion
        $gid_criteria = new Criteria('gid', $gid);
        $join = new XooNIpsJoinCriteria('xoonips_item_lock', 'index_id', 'item_id', 'INNER');
        if ($indexHandler->getCount($gid_criteria, $join) != 0) {
            // some indexes is locked
            return false;
        }
        // delete rankings
        if (!$admin_rankingHandler->deleteGroupRankings($gid)) {
            return false;
        }
        // delete group members
        $uids = $this->getUserIds($gid, false);
        foreach ($uids as $uid) {
            if (!$this->deleteUserFromXooNIpsGroup($gid, $uid, true)) {
                return false;
            }
        }
        // delete group indexes
        $index_objs = $indexHandler->getObjects($gid_criteria);
        foreach ($index_objs as $index_obj) {
            $index_id = $index_obj->get('index_id');
            $parent_index_id = $index_obj->get('parent_index_id');
            $indexHandler->delete($index_obj);
            $item_criteria = new Criteria('item_id', $index_id);
            $item_basicHandler->deleteAll($item_criteria);
            $titleHandler->deleteAll($item_criteria);
            $keywordHandler->deleteAll($item_criteria);
            $index_criteria = new Criteria('index_id', $index_id);
            $index_item_linkHandler->deleteAll($index_criteria);
            if ($parent_index_id != IID_ROOT) {
                // record event log : delete index
                $eventHandler->recordDeleteIndexEvent($index_id);
            }
        }
        // delete group
        if (!$this->_xgHandler->delete($xg_obj)) {
            return false;
        }
        // record event log : delete group
        $eventHandler->recordDeleteGroupEvent($gid);

        return true;
    }
}
