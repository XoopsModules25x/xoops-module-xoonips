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
/**
 * file search plugin class for PDF
 */
class XooNIpsFileSearchPluginPDF extends XooNIpsFileSearchPlugin
{

    /**
     * constractor
     */
    public function __construct()
    {
        parent::__construct();
        $this->is_xml  = false;
        $this->is_utf8 = true;
    }

    /**
     * open file resource
     *
     * @acccess protected
     * @param string $filename file name
     */
    public function _open_file($filename)
    {
        $cmd          = sprintf('pdftotext -q -enc UTF-8 %s -', escapeshellarg($filename));
        $this->handle = @popen($cmd, 'rb');
    }

    /**
     * close file resource
     *
     * @acccess protected
     */
    public function _close_file()
    {
        @pclose($this->handle);
    }
}
