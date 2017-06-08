<?php
// $Revision: 1.1.2.15 $
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

require_once __DIR__ . '/../base/action.class.php';

/**
 * Class XooNIpsActionOaipmhSearchSearch
 */
class XooNIpsActionOaipmhSearchSearch extends XooNIpsAction
{
    public $_orderDir        = 'asc';
    public $_orderBy         = 'title';
    public $_page            = 0;
    public $_searchCacheId   = 0;
    public $_metadataPerPage = 20;
    public $_logicName       = null;

    /**
     * XooNIpsActionOaipmhSearchSearch constructor.
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * @return null
     */
    public function _get_logic_name()
    {
        return $this->_logicName;
    }

    /**
     * @return string
     */
    public function _get_view_name()
    {
        return 'oaipmh_search_result';
    }

    public function preAction()
    {
        xoonips_allow_post_method();

        $repository_id = $this->_formdata->getValue('post', 'repository_id', 'i', true);
        xoonips_validate_request($this->isValidRepositoryId($repository_id));

        $order_by = $this->_formdata->getValue('post', 'order_by', 's', false);
        xoonips_validate_request(in_array($order_by, array(
            'title',
            'identifier',
            'last_update_date',
            'creation_date',
            'date'
        )));

        $order_dir = $this->_formdata->getValue('post', 'order_dir', 's', false);
        xoonips_validate_request(in_array($order_dir, array(
            'asc',
            'desc'
        )));

        $metadata_per_page = $this->_formdata->getValue('post', 'metadata_per_page', 'i', false);
        xoonips_validate_request(in_array($metadata_per_page, array(
            20,
            50,
            100
        )));

        $page = $this->_formdata->getValue('post', 'page', 'i', false);
        xoonips_validate_request($page > 0);

        $search_flag = $this->_formdata->getValue('post', 'search_flag', 'i', false);
        xoonips_validate_request(in_array($search_flag, array(
            0,
            1
        )));

        $search_cache_id = $this->_formdata->getValue('post', 'search_cache_id', 'i', false);
        if (null !== $search_cache_id) {
            xoonips_validate_request($this->searchCacheExists($search_cache_id));
        }

        $keyword = $this->_formdata->getValue('post', 'keyword', 's', false);
        if (0 == $repository_id && '' == $keyword) {
            $this->_searchCacheId = 0;
            $this->_logicName     = null;
            return;
        }

        $this->_orderDir        = $order_dir;
        $this->_orderBy         = $order_by;
        $this->_metadataPerPage = $metadata_per_page;
        $this->_page            = $page;
        $this->_searchCacheId   = null === $search_cache_id ? '0' : $search_cache_id;

        $this->_params[] = session_id();
        $this->_params[] = $repository_id;
        $this->_params[] = $keyword;
        $this->_params[] = $this->_orderBy;
        $this->_params[] = $this->_orderDir;
    }

    public function doAction()
    {
        if ((boolean)$this->_formdata->getValue('post', 'search_flag', 'i', false)
            || !$this->searchCacheExists($this->_formdata->getValue('post', 'search_cache_id', 's', false))
        ) {
            $this->_logicName = 'oaipmhSearch';
            parent::doAction();
        }
        //global $xoopsDB;var_dump(xoops_getenv('HTTP_REFERER'),$_SERVER['REQUEST_METHOD'],get_class($xoopsDB));
        if ($this->_response->getResult()) {
            $this->_searchCacheId = $this->_response->getSuccess();
        }
        if ($this->_response->getResult()
            && (boolean)$this->_formdata->getValue('post', 'search_flag', 'i', false)
        ) {
            $eventHandler = xoonips_getOrmHandler('xoonips', 'event_log');
            $eventHandler->recordQuickSearchEvent('metadata', $this->_formdata->getValue('post', 'keyword', 'n', false),
                                                  $this->getRepositoryUrl($this->_formdata->getValue('post', 'repository_id', 'i', false)));
        }
    }

    public function postAction()
    {
        $textutil = xoonips_getUtility('text');
        if ($this->_page > ceil($this->getTotalMetadataCount() / $this->_metadataPerPage)) {
            $this->_page = 1;
        }
        $this->_view_params['search_cache_id']   = $this->_searchCacheId;
        $this->_view_params['order_by']          = $this->_orderBy;
        $this->_view_params['order_dir']         = $this->_orderDir;
        $this->_view_params['metadata_per_page'] = $this->_metadataPerPage;
        $this->_view_params['total_metadata_count']
                                                 = $this->getTotalMetadataCount();
        $this->_view_params['start_metadata_count']
                                                 = $this->getStartMetadataCount();
        $this->_view_params['end_metadata_count']
                                                 = $this->getEndMetadataCount();
        $this->_view_params['page']              = $this->_page;
        $this->_view_params['maxpage']
                                                 = ceil($this->getTotalMetadataCount() / $this->_metadataPerPage);
        $this->_view_params['pages']
                                                 = $this->getSelectablePageNumber($this->_view_params['page'], $this->_view_params['maxpage']);
        $this->_view_params['metadata']
                                                 = $this->getMetadataArrays($this->_searchCacheId, $this->_orderBy, $this->_orderDir,
                                                                            $this->getStartMetadataCount(), $this->getEndMetadataCount());
        $this->_view_params['repository_id']     = $this->_formdata->getValue('post', 'repository_id', 'i', false);
        $this->_view_params['keyword']           = $textutil->html_special_chars($this->_formdata->getValue('post', 'keyword', 's', false));
    }

    /**
     * @return int
     */
    public function getStartMetadataCount()
    {
        if ($this->getEndMetadataCount() == 0) {
            return 0;
        }
        return ($this->_page - 1) * $this->_metadataPerPage + 1;
    }

    /**
     * @return mixed
     */
    public function getEndMetadataCount()
    {
        return min($this->_page * $this->_metadataPerPage, $this->getTotalMetadataCount());
    }

    /**
     * metadata array from search cache id
     * @access private
     * @param integer $search_cache_id search cache id
     * @param string  $order_by        sort field name
     * @param string  $order_dir       'asc' or 'desc'
     * @param integer $start_count     number of first row to get(first row is 1)
     * @param integer $end_count       number of last row to get
     * @return array of metadata associative array
     */
    public function getMetadataArrays($search_cache_id, $order_by, $order_dir, $start_count, $end_count)
    {
        global $xoopsDB;

        $textutil              = xoonips_getUtility('text');
        $cacheHandler          = xoonips_getOrmHandler('xoonips', 'search_cache');
        $cache_metadataHandler = xoonips_getOrmHandler('xoonips', 'search_cache_metadata');
        $metadataHandler       = xoonips_getOrmHandler('xoonips', 'oaipmh_metadata');
        $repositoryHandler     = xoonips_getOrmHandler('xoonips', 'oaipmh_repositories');

        if (!$cacheHandler->get($search_cache_id)) {
            return array();
        }

        $criteria = new Criteria('search_cache_id', $search_cache_id);
        $criteria->setStart(max(0, $start_count - 1));
        $criteria->setLimit($end_count - $start_count + 1);

        $criteria->setSort($this->getOrderByColumn($order_by));
        $criteria->setOrder($order_dir);
        $join = new XooNIpsJoinCriteria('xoonips_oaipmh_metadata', 'identifier', 'identifier', 'INNER', 'tmeta');

        $metadata_cache = $cache_metadataHandler->getObjects($criteria, false, '', false, $join);
        if (!$metadata_cache) {
            return array();
        }

        $result = array();
        foreach ($metadata_cache as $cache) {
            $repository = $repositoryHandler->get($cache->getExtraVar('repository_id'));
            if (!$repository) {
                continue;
            }

            $result[] = array(
                'id'               => $cache->getVar('identifier', 's'),
                'metadata_id'      => $textutil->html_special_chars($cache->getExtraVar('metadata_id')),
                'title'            => $textutil->html_special_chars($cache->getExtraVar('title')),
                'repository_name'  => $repository->getVar('repository_name', 's'),
                'last_update_date' => $textutil->html_special_chars($cache->getExtraVar('last_update_date')),
                'creation_date'    => $textutil->html_special_chars($cache->getExtraVar('creation_date')),
                'date'             => $textutil->html_special_chars($cache->getExtraVar('date')),
                'link'             => $textutil->html_special_chars($cache->getExtraVar('link'))
            );
        }
        return $result;
    }

    /**
     * is search cache id is exists
     * @access private
     * @param $cache_id
     * @return bool
     */
    public function searchCacheExists($cache_id)
    {
        $cacheHandler = xoonips_getOrmHandler('xoonips', 'search_cache');
        $cache        = $cacheHandler->get((int)$cache_id);
        return $cache !== false;
    }

    /**
     * get number of metadata of search result
     * @access private
     * @return integer
     */
    public function getTotalMetadataCount()
    {
        $cache_metadataHandler = xoonips_getOrmHandler('xoonips', 'search_cache_metadata');
        $result                =  $cache_metadataHandler->getObjects(new Criteria('search_cache_id', $this->_searchCacheId), false, 'count(*)');
        if (!$result) {
            return 0;
        }
        return $result[0]->getExtraVar('count(*)');
    }

    /**
     * return boolean value of modification of metadata
     * @access private
     * @param int $timestamp timestamp of search cache id
     * @return true(modified), false(not modified)
     */
    public function isMetadataModified($timestamp)
    {
        $eventHandler = xoonips_getOrmHandler('xoonips', 'event_log');
        // this events modify search result.
        // if one of this event is newer than search cache,
        // don't use search cache.
        $event_type_ids = array(
            ETID_INSERT_ITEM,
            ETID_UPDATE_ITEM,
            ETID_DELETE_ITEM,
            ETID_DELETE_GROUP,
            ETID_INSERT_GROUP_MEMBER,
            ETID_DELETE_GROUP_MEMBER,
            ETID_DELETE_INDEX,
            ETID_CERTIFY_ITEM,
            ETID_REJECT_ITEM,
            ETID_TRANSFER_ITEM,
        );
        $criteria       = new CriteriaCompo();
        $criteria->add(new Criteria('event_type_id', '(' . implode(',', $event_type_ids) . ')', 'IN'));
        $criteria->add(new Criteria('timestamp', $timestamp, '>='));
        $result = $eventHandler->getObjects($criteria);
        if (!$result || count($result) == 0) {
            return false;
        }
        return true;
    }

    /**
     * @param $identifiers
     * @param $order_by
     * @param $order_dir
     * @return array
     */
    public function sortIdentifiers($identifiers, $order_by, $order_dir)
    {
        global $xoopsDB;
        $metadataHandler = xoonips_getOrmHandler('xoonips', 'oaipmh_metadata');

        $esc_id = array();
        foreach ($identifiers as $id) {
            $esc_id[] = $xoopsDB->quoteString($esc_id);
        }
        $criteria = new Criteria('identifier', '(' . implode(',', $esc_id) . ')', 'IN');
        $criteria->setSort($order_by);
        $criteria->setOrder($order_dir);

        $result   = array();
        $metadata =  $metadataHandler->getObjects($criteria);
        if (!$metadata) {
            return array();
        }
        foreach ($metadata as $meta) {
            $result[] = $meta->get('identifier');
        }
        return $result;
    }

    /**
     * @param $order_by
     * @return string
     */
    public function getOrderByColumn($order_by)
    {
        switch ($order_by) {
            case 'title':
                return 'title';
            case 'identifier':
                return 'tmeta.identifier';
            case 'last_update_date':
                return 'last_update_date_for_sort';
            case 'creation_date':
                return 'creation_date_for_sort';
            case 'date':
                return 'date_for_sort';
            default:
                return 'title';
        }
    }

    /**
     *
     * @param $page    integer current page number
     * @param $maxpage integer max page number
     * @return array of integer page numbers
     *
     */
    public function getSelectablePageNumber($page, $maxpage)
    {
        //centering current page number(5th of $pages)
        $pages = array(min(max(1, $page - 4), max(1, $maxpage - 9)));
        for ($i = 1; $i < 10 && $pages[$i - 1] < $maxpage; $i++) {
            $pages[$i] = $pages[$i - 1] + 1;
        }
        return $pages;
    }

    /**
     *
     * @access private
     * @param integer $repository_id
     * @return repository url or null(reository not found)
     */
    public function getRepositoryUrl($repository_id)
    {
        $repositoryHandler = xoonips_getOrmHandler('xoonips', 'oaipmh_repositories');
        $repository        = $repositoryHandler->get((int)$repository_id);
        if (!$repository) {
            return null;
        }
        return $repository->get('URL');
    }

    /**
     *
     * @access private
     * @param $id repository id
     * @return bool true if valid repository id or zero
     */
    public function isValidRepositoryId($id)
    {
        if ($id == 0) {
            return true;
        }
        $handler = xoonips_getOrmHandler('xoonips', 'oaipmh_repositories');

        $rows =  $handler->getObjects(new Criteria('repository_id', addslashes($id)));
        return $rows && count($rows) > 0;
    }
}
