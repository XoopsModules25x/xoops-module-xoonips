<?php

// $Revision: 1.4.8.3 $
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
/* constant strings
 * $Revision: 1.4.8.3 $
 */

// _MD_<MODULENAME>_<STRINGNAME>

//metadata:junii type
/* id : text
00 : ��������,
01 : �������̡���ʸ,
02 : �������̡���ʸ�ʳ�,/
10 : �������̥ꥹ��,
11 : �������̥ꥹ�ȡ��༡����ʪ,
12 : �������̥ꥹ�ȡ���ʸ�ꥹ��,
13 : �������̥ꥹ�ȡ��ץ������ȴ�Ϣ����,
14 : �������̥ꥹ�ȡ��ֱ����,/
20 : �����,
21 : ����񸻡��ǡ���,
22 : ����񸻡����եȥ�����,
23 : ����񸻡��Ż�Ū������,/
30 : ����Ծ���,
31 : ����Ծ��󡽸ĿͤΥڡ���,
32 : ����Ծ��󡽸��漼�ȥåץڡ���,
33 : ����Ծ��󡽸���Ծ���ꥹ��,
34 : ����Ծ��󡽸���Ծ���ǡ����١���,/
40 : �������,
41 : ������󡽹ֵ�����ꥹ��,
42 : ��������ŻҶ���ꥹ��,/
50 : �޽�۾���,
51 : �޽�۾��󡽿޽�ۡ����ȥåץڡ���,
52 : �޽�۾��󡽿޽�ۻ���,/
60 : �ǥ�����ߥ塼������,/
70 : ���;���,
71 : ���;��󡽥ǡ����١���,
72 : ���;���ʸ����Ͽ��ʸ������,
73 : ���;��󡽥�󥯽����Żҥ��㡼�ʥ뽸,
74 : ���;��󡽥᡼��󥰥ꥹ��,/
80 : �������,
81 : ������������إȥåץڡ���,
82 : ��������������ȿ��ȥåץڡ���,
83 : ������������ع������
*/
define('_MD_XOONIPS_METADATA_JUNII', '
��������,
�������̡���ʸ,
�������̡���ʸ�ʳ�,/
�������̥ꥹ��,
�������̥ꥹ�ȡ��༡����ʪ,
�������̥ꥹ�ȡ���ʸ�ꥹ��,
�������̥ꥹ�ȡ��ץ������ȴ�Ϣ����,
�������̥ꥹ�ȡ��ֱ����,/
�����,
����񸻡��ǡ���,
����񸻡����եȥ�����,
����񸻡��Ż�Ū������,/
����Ծ���,
����Ծ��󡽸ĿͤΥڡ���,
����Ծ��󡽸��漼�ȥåץڡ���,
����Ծ��󡽸���Ծ���ꥹ��,
����Ծ��󡽸���Ծ���ǡ����١���,/
�������,
������󡽹ֵ�����ꥹ��,
��������ŻҶ���ꥹ��,/
�޽�۾���,
�޽�۾��󡽿޽�ۡ����ȥåץڡ���,
�޽�۾��󡽿޽�ۻ���,/
�ǥ�����ߥ塼������,/
���;���,
���;��󡽥ǡ����١���,
���;���ʸ����Ͽ��ʸ������,
���;��󡽥�󥯽����Żҥ��㡼�ʥ뽸,
���;��󡽥᡼��󥰥ꥹ��,/
�������,
������������إȥåץڡ���,
��������������ȿ��ȥåץڡ���,
������������ع������
');

// Metadata: JUNII2 type (will be fixed by 2006-10-13)
/* id : text
00 : Journal Article
01 : Thesis or Dissertation
02 : Departmental Bulletin Paper
03 : Conference Paper
04 : Book
05 : Technical Report
06 : Research Paper
07 : Preprint
10 : Presentation
11 : Article
12 : Learning Material
20 : Data or Dataset
30 : Software
 */
define('_MD_XOONIPS_METADATA_JUNII2', '
Journal Article,
Thesis or Dissertation,
Departmental Bulletin Paper,
Conference Paper,
Book,
Technical Report,
Research Paper,
Preprint,/
Presentation,
Article,
Learning Material,/
Data or Dataset,/
Software
');
