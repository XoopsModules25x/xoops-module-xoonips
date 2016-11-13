<?php
// $Revision: 1.1.2.10 $
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

include_once dirname(dirname(__DIR__)) . '/xoonips/class/xoonips_import_item.class.php';

/**
 * Class XNPSimulatorImportItem
 */
class XNPSimulatorImportItem extends XooNIpsImportItem
{
    public $_has_simulator_data = false;
    public $_has_preview        = false;

    /**
     * XNPSimulatorImportItem constructor.
     */
    public function __construct()
    {
        $handler     = xoonips_getOrmCompoHandler('xnpsimulator', 'item');
        $this->_item = $handler->create();
    }

    public function setHasSimulatorData()
    {
        $this->_has_simulator_data = true;
    }

    public function unsetHasSimulatorData()
    {
        $this->_has_simulator_data = false;
    }

    /**
     * @return bool
     */
    public function hasSimulatorData()
    {
        return $this->_has_simulator_data;
    }

    public function setHasPreview()
    {
        $this->_has_preview = true;
    }

    public function unsetHasPreview()
    {
        $this->_has_preview = false;
    }

    /**
     * @return bool
     */
    public function hasPreview()
    {
        return $this->_has_preview;
    }

    /**
     * get total file size(bytes) of this item
     * @return integer file size in bytes.
     */
    public function getTotalFileSize()
    {
        $size     = 0;
        $mainfile = $this->getVar('simulator_data');
        if (!$mainfile) {
            return 0;
        }
        $size = $mainfile->get('file_size');
        foreach ($this->getVar('preview') as $preview) {
            $size += $preview->get('file_size');
        }
        return $size;
    }

    /**
     * @return mixed
     */
    public function getClone()
    {
        $clone                      = parent::getClone();
        $clone->_has_simulator_data = $this->_has_simulator_data;
        $clone->_has_preview        = $this->_has_preview;
        return $clone;
    }
}

/**
 * Class XNPSimulatorImportItemHandler
 */
class XNPSimulatorImportItemHandler extends XooNIpsImportItemHandler
{

    /**
     * array of supported version of import file
     */
    public $_import_file_version
        = array(
            '1.00',
            '1.01',
            '1.02',
            '1.03'
        );

    /**
     * version string of detail information
     */
    public $_detail_version = null;

    /**
     * attachment file object(XooNIpsFile)
     */
    public $_simulator_data = null;

    /**
     * flag of attachment file parsed
     */
    public $_simulator_data_flag = false;

    /**
     * attachment file object(XooNIpsFile)
     */
    public $_preview = null;

    /**
     * flag of attachment file parsed
     */
    public $_preview_flag = false;

    /**
     * attachment_dl_limit flag
     */
    public $_attachment_dl_limit_flag = false;

    /**
     * attachment_dl__notify_limit flag
     */
    public $_attachment_dl_notify_limit_flag = false;

    /**
     * XNPSimulatorImportItemHandler constructor.
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * @return XNPSimulatorImportItem
     */
    public function create()
    {
        return new XNPSimulatorImportItem();
    }

    /**
     *
     * @param $parser
     * @param $name
     * @param $attribs
     * @internal param $
     */
    public function xmlStartElementHandler($parser, $name, $attribs)
    {
        global $xoopsDB;
        parent::xmlStartElementHandler($parser, $name, $attribs);

        switch (implode('/', $this->_tag_stack)) {
            case 'ITEM/DETAIL':
                //
                // validate version and set it to 'version' variable
                //
                if (!empty($attribs['VERSION'])) {
                    if (in_array($attribs['VERSION'], $this->_import_file_version)) {
                        $this->_detail_version = $attribs['VERSION'];
                    } else {
                        $this->_import_item->setErrors(E_XOONIPS_INVALID_VALUE,
                                                       'unsupported version(' . $attribs['VERSION'] . ') ' . $this->_get_parser_error_at());
                    }
                } else {
                    $this->_detail_version = '1.00';
                }
                break;
            case 'ITEM/DETAIL/FILE':
                $this->_file_type_attribute = $attribs['FILE_TYPE_NAME'];

                $file_typeHandler = xoonips_getOrmHandler('xoonips', 'file_type');
                $fileHandler      = xoonips_getOrmHandler('xoonips', 'file');
                $criteria         = new Criteria('name', addslashes($attribs['FILE_TYPE_NAME']));
                $file_type        = $file_typeHandler->getObjects($criteria);
                if (count($file_type) == 0) {
                    $this->_import_item->setErrors(E_XOONIPS_ATTR_NOT_FOUND,
                                                   'file_type_id is not found:' . $attribs['FILE_TYPE_NAME'] . $this->_get_parser_error_at());
                    break;
                }

                $unicode = xoonips_getUtility('unicode');
                if ($this->_file_type_attribute === 'simulator_data') {
                    if ($this->_simulator_data_flag) {
                        $this->_import_item->setErrors(E_XOONIPS_ATTACHMENT_HAS_REDUNDANT,
                                                       "multiple $name attachments is not allowed" . $this->_get_parser_error_at());
                        break;
                    }
                    $this->_simulator_data = $fileHandler->create();
                    $this->_simulator_data->setFilepath($this->_attachment_dir . '/' . $attribs['FILE_NAME']);
                    $this->_simulator_data->set('original_file_name',
                                                $unicode->decode_utf8($attribs['ORIGINAL_FILE_NAME'], xoonips_get_server_charset(), 'h'));
                    $this->_simulator_data->set('mime_type', $attribs['MIME_TYPE']);
                    $this->_simulator_data->set('file_size', $attribs['FILE_SIZE']);
                    $this->_simulator_data->set('sess_id', session_id());
                    $this->_simulator_data->set('file_type_id', $file_type[0]->get('file_type_id'));
                } elseif ($this->_file_type_attribute === 'preview') {
                    $this->_preview = $fileHandler->create();
                    $this->_preview->setFilepath($this->_attachment_dir . '/' . $attribs['FILE_NAME']);
                    $this->_preview->set('original_file_name',
                                         $unicode->decode_utf8($attribs['ORIGINAL_FILE_NAME'], xoonips_get_server_charset(), 'h'));
                    $this->_preview->set('mime_type', $attribs['MIME_TYPE']);
                    $this->_preview->set('file_size', $attribs['FILE_SIZE']);
                    $this->_preview->set('sess_id', session_id());
                    $this->_preview->set('file_type_id', $file_type[0]->get('file_type_id'));
                } else {
                    $this->_import_item->setErrors(E_XOONIPS_ATTR_NOT_FOUND,
                                                   'file_type_id is not found:' . $attribs['FILE_TYPE_NAME'] . $this->_get_parser_error_at());
                    break;
                }
                break;
            case 'ITEM/DETAIL/FILE/CAPTION':
            case 'ITEM/DETAIL/FILE/THUMBNAIL':
                break;
        }
    }

    /**
     *
     * @param $parser
     * @param $name
     * @internal param $
     */
    public function xmlEndElementHandler($parser, $name)
    {
        global $xoopsDB;
        $detail  = $this->_import_item->getVar('detail');
        $unicode = xoonips_getUtility('unicode');

        switch (implode('/', $this->_tag_stack)) {
            case 'ITEM/DETAIL':
                if ($this->_detail_version === '1.00') {
                } elseif ($this->_detail_version === '1.01') {
                    $keys[] = 'attachment_dl_limit';
                } else {
                    $keys[] = 'attachment_dl_notify';
                }

                foreach (array(
                             'simulator_type',
                             'rights',
                             'readme',
                             'use_cc',
                             'cc_commercial_use',
                             'cc_modification',
                         ) as $key
                ) {
                    if (null === $detail->get($key, 'n')) {
                        $this->_import_item->setErrors(E_XOONIPS_TAG_NOT_FOUND, " no $key" . $this->_get_parser_error_at());
                    }
                }
                //error if no developers
                if (count($this->_import_item->getVar('developer')) == 0) {
                    $this->_import_item->setErrors(E_XOONIPS_TAG_NOT_FOUND, ' no developer' . $this->_get_parser_error_at());
                }
                break;
            case 'ITEM/DETAIL/SIMULATOR_TYPE':
            case 'ITEM/DETAIL/RIGHTS':
            case 'ITEM/DETAIL/README':
            case 'ITEM/DETAIL/USE_CC':
            case 'ITEM/DETAIL/CC_MODIFICATION':
            case 'ITEM/DETAIL/CC_COMMERCIAL_USE':
                $detail->set(strtolower(end($this->_tag_stack)), $unicode->decode_utf8($this->_cdata, xoonips_get_server_charset(), 'h'), true);
                break;
            case 'ITEM/DETAIL/DEVELOPERS/DEVELOPER':
                if ($this->_detail_version !== '1.03') {
                    break;
                }
                $developers = $this->_import_item->getVar('developer');

                $developerHandler = xoonips_getOrmHandler('xnpsimulator', 'developer');
                $developer        = $developerHandler->create();

                $developer->set('developer', $unicode->decode_utf8($this->_cdata, xoonips_get_server_charset(), 'h'));
                $developer->set('developer_order', count($developers));

                $developers[] = $developer;
                break;
            case 'ITEM/DETAIL/DEVELOPER':
                if ($this->_detail_version !== '1.00'
                    && $this->_detail_version !== '1.01'
                    && $this->_detail_version !== '1.02'
                ) {
                    //<developer> is only for 1.00, 1.01 and 1.02
                    break;
                }
                $developerHandler = xoonips_getOrmHandler('xnpsimulator', 'developer');
                $developers       = $this->_import_item->getVar('developer');
                $developer        = $developerHandler->create();
                $developer->set('developer', trim($unicode->decode_utf8($this->_cdata, xoonips_get_server_charset(), 'h')));
                $developer->set('developer_order', 0);
                $developers[0] = $developer;
                break;
            case 'ITEM/DETAIL/ATTACHMENT_DL_LIMIT':
                if ($this->_attachment_dl_limit_flag) {
                    $this->_import_item->setErrors(E_XOONIPS_TAG_REDUNDANT, 'attachment_dl_limit is redundant' . $this->_get_parser_error_at());
                } elseif (ctype_digit($this->_cdata)) {
                    $detail->set('attachment_dl_limit', (int)$this->_cdata);
                    $this->_attachment_dl_limit_flag = true;
                } else {
                    $this->_import_item->setErrors(E_XOONIPS_INVALID_VALUE,
                                                   'invalid value(' . $this->_cdata . ') of attachment_dl_limit' . $this->_get_parser_error_at());
                }
                break;
            case 'ITEM/DETAIL/ATTACHMENT_DL_NOTIFY':
                if ($this->_attachment_dl_notify_limit_flag) {
                    $this->_import_item->setErrors(E_XOONIPS_TAG_REDUNDANT, 'attachment_dl_notify is redundant' . $this->_get_parser_error_at());
                } elseif (ctype_digit($this->_cdata)) {
                    $detail->set('attachment_dl_notify', (int)$this->_cdata);
                    $this->_attachment_dl_notify_limit_flag = true;
                } else {
                    $this->_import_item->setErrors(E_XOONIPS_INVALID_VALUE,
                                                   'invalid value(' . $this->_cdata . ') of attachment_dl_notify' . $this->_get_parser_error_at());
                }
                break;
            case 'ITEM/DETAIL/FILE':
                $fileHandler = xoonips_getOrmHandler('xoonips', 'file');
                if ($this->_file_type_attribute === 'simulator_data') {
                    $this->_simulator_data_flag = true;
                    if (!$fileHandler->insert($this->_simulator_data)) {
                        $this->_import_item->setErrors(E_XOONIPS_DB_QUERY,
                                                       "can't insert attachment file:" . $this->_simulator_data->get('original_file_name')
                                                       . $this->_get_parser_error_at());
                    }
                    $this->_simulator_data = $fileHandler->get($this->_simulator_data->get('file_id'));
                    $this->_import_item->setVar('simulator_data', $this->_simulator_data);
                    $this->_import_item->setHasSimulatorData();
                    $this->_file_type_attribute = null;
                } elseif ($this->_file_type_attribute === 'preview') {
                    $this->_preview_flag = true;
                    if (!$fileHandler->insert($this->_preview)) {
                        $this->_import_item->setErrors(E_XOONIPS_DB_QUERY,
                                                       "can't insert attachment file:" . $this->_preview->get('original_file_name')
                                                       . $this->_get_parser_error_at());
                    }
                    $this->_preview = $fileHandler->get($this->_preview->get('file_id'));
                    $previews       = $this->_import_item->getVar('preview');
                    $previews[]     = $this->_preview;
                    $this->_import_item->setHasPreview();
                    $this->_file_type_attribute = null;
                } else {
                    die('unknown file type:' . $this->_file_type_attribute);
                }
                break;
            case 'ITEM/DETAIL/FILE/CAPTION':
                if ($this->_file_type_attribute === 'simulator_data') {
                    $this->_simulator_data->set('caption', $unicode->decode_utf8($this->_cdata, xoonips_get_server_charset(), 'h'));
                } elseif ($this->_file_type_attribute === 'preview') {
                    $this->_preview->set('caption', $unicode->decode_utf8($this->_cdata, xoonips_get_server_charset(), 'h'));
                }
                break;
                break;
            case 'ITEM/DETAIL/FILE/THUMBNAIL':
                if ($this->_file_type_attribute === 'simulator_data') {
                    $this->_simulator_data->set('thumbnail_file', base64_decode($this->_cdata));
                } elseif ($this->_file_type_attribute === 'preview') {
                    $this->_preview->set('thumbnail_file', base64_decode($this->_cdata));
                }
                break;
        }

        parent::xmlEndElementHandler($parser, $name);
    }

    /**
     *
     * Update item_id and sess_id of xoonips_file.
     *
     * @param $item         XooNIpsImportItem that is imported.
     * @param $import_items array of all of XooNIpsImportItems
     */
    public function onImportFinished($item, $import_items)
    {
        if ('xnpsimulatorimportitem' !== strtolower(get_class($item))) {
            return;
        }

        $this->_set_file_delete_flag($item);

        // nothing to do if no file
        if ($item->hasSimulatorData()) {
            $simulator_data = $item->getVar('simulator_data');
            $this->_fix_item_id_of_file($item, $simulator_data);
            $this->_create_text_search_index($simulator_data);
        }

        // nothing to do if previews
        $previews = $item->getVar('preview');
        foreach (array_keys($previews) as $key) {
            if ($previews[$key]->get('file_id') > 0) {
                $this->_fix_item_id_of_file($item, $previews[$key]);
                $this->_create_text_search_index($previews[$key]);
            }
        }

        parent::onImportFinished($item, $import_items);
    }

    /**
     * @param $item
     * @return bool
     */
    public function insert($item)
    {
        $handler = xoonips_getOrmCompoHandler('xnpsimulator', 'item');
        return $handler->insert($item);
    }

    /**
     * @param $item
     */
    public function setNew($item)
    {
        $handler = xoonips_getOrmCompoHandler('xnpsimulator', 'item');
        return $handler->setNew($item);
    }

    /**
     * @param $item
     */
    public function unsetNew($item)
    {
        $handler = xoonips_getOrmCompoHandler('xnpsimulator', 'item');
        return $handler->unsetNew($item);
    }

    /**
     * @param $item
     */
    public function setDirty($item)
    {
        $handler = xoonips_getOrmCompoHandler('xnpsimulator', 'item');
        return $handler->setDirty($item);
    }

    /**
     * @param $item
     */
    public function unsetDirty($item)
    {
        $handler = xoonips_getOrmCompoHandler('xnpsimulator', 'item');
        return $handler->unsetDirty($item);
    }

    /**
     * reeturn import log text of import item.
     * @param $import_item reference of XooNIpsImportItem object
     * @return string import log text
     */
    public function getImportLog($import_item)
    {
        $text   = parent::getImportLog($import_item);
        $detail = $import_item->getVar('detail');

        $text .= "\ndetail.simulator_type " . $detail->get('simulator_type');
        foreach ($import_item->getVar('developer') as $developer) {
            $text .= "\ndetail.developer " . $developer->get('developer');
        }
        $text .= "\ndetail.rights " . mb_ereg_replace('\n', '\n', mb_ereg_replace('\\\\', '\\\\', $detail->get('rights', 'n')));
        $text .= "\ndetail.readme " . mb_ereg_replace('\n', '\n', mb_ereg_replace('\\\\', '\\\\', $detail->get('readme', 'n')));
        $text .= "\ndetail.use_cc " . $detail->get('use_cc');
        $text .= "\ndetail.cc_commercial_use " . $detail->get('cc_commercial_use');
        $text .= "\ndetail.cc_modification " . $detail->get('cc_modification');
        $text .= "\ndetail.attachment_dl_limit " . $detail->get('attachment_dl_limit');
        $text .= "\ndetail.attachment_dl_notify " . $detail->get('attachment_dl_notify');

        return $text;
    }

    /**
     * @param reference $item
     */
    public function import($item)
    {
        if ($item->getUpdateFlag()) {
            $detail = $item->getVar('detail');
            $detail->unsetNew();
            $detail->setDirty();

            //copy attachment file
            $simulator_data = $item->getVar('simulator_data');
            if ($item->hasSimulatorData()) {
                $fileHandler = xoonips_getOrmHandler('xoonips', 'file');
                $clonefile   = $fileHandler->fileClone($simulator_data);
                $clonefile->setDirty();
                $item->setVar('simulator_data', $clonefile);

                $simulator_data = $item->getVar('simulator_data');
            }
            if ($item->hasPreview()) {
                $fileHandler = xoonips_getOrmHandler('xoonips', 'file');
                $previews    = array();
                foreach ($item->getVar('preview') as $preview) {
                    $clonefile = $fileHandler->fileClone($preview);
                    $clonefile->setDirty();
                    $previews[] = $preview;
                }
                $item->setVar('preview', $previews);
            }
        }
        parent::import($item);
    }
}
