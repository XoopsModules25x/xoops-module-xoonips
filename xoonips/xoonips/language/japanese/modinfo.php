<?php
// $Revision: 1.18.2.1.2.5 $
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
 * $Revision: 1.18.2.1.2.5 $
 */

// _MI_<MODULENAME>_<STRINGNAME>
/*
define("_MI_XOONIPS_ITEM_NAME","XooNIps Item");
define("_MI_XOONIPS_ITEM_DESC","XooNIps Item Module");
define("_MI_XOONIPS_ACCOUNT_NAME","XooNIps Account");
define("_MI_XOONIPS_ACCOUNT_DESC","XooNIps Account Module");
define("_MI_XOONIPS_BINDER_NAME","XooNIps Binder Item Type Module");
define("_MI_XOONIPS_BINDER_DESC","XooNIps Binder Item Type Module");
define("_MI_XOONIPS_CONFIG_NAME","XooNIps Configuration");
define("_MI_XOONIPS_CONFIG_DESC","XooNIps Configuration Module");
define("_MI_XOONIPS_MODERATOR_NAME","XooNIps Moderator");
define("_MI_XOONIPS_MODERATOR_DESC","XooNIps Moderator Module");
define("_MI_XOONIPS_INDEX_NAME","XooNIps Index");
define("_MI_XOONIPS_INDEX_DESC","XooNIps Index Module");
*/
// The name of this module
define("_MI_XOONIPS_NAME","XooNIps");
// A brief description of this module
define("_MI_XOONIPS_DESC","XooNIps Module");

//submenu labels
define("_MI_XOONIPS_ITEM_SMNAME1", "�����ƥ���Ͽ");//
define("_MI_XOONIPS_ITEM_SMNAME2", "�����ƥྵǧ");//
define("_MI_XOONIPS_ITEM_SMNAME3", "�ܺٸ���");//

define("_MI_XOONIPS_ITEM_BNAME1", "XooNIps����");//

define("_MI_XOONIPS_MODERATOR_BNAME2", "XooNIps��ǥ졼�� �ᥤ���˥塼");// 

//submenu labels
define("_MI_XOONIPS_MODERATOR_SMNAME1", "���롼�״���");// 
define("_MI_XOONIPS_MODERATOR_SMNAME2", "�桼����ǧ");// 

define("_MI_XOONIPS_INDEX_BNAME1", "����ǥå����ĥ꡼");// 

//submenu labels
define("_MI_XOONIPS_INDEX_SMNAME1", "�ץ饤�١��ȥĥ꡼�Խ�");// 
define("_MI_XOONIPS_INDEX_SMNAME2", "���롼�ץĥ꡼�Խ�");// 
define("_MI_XOONIPS_INDEX_SMNAME3", "�����ĥ꡼�Խ�");// 


// Names of admin menu items
define("_MI_XOONIPS_CONFIG_DSN", "DSN");
define("_MI_XOONIPS_CONFIG_DSN_DESC", "ODBC �� DSN ̾");

define("_MI_XOONIPS_ACCOUNT_BNAME1", "XooNIps ������");
define("_MI_XOONIPS_ACCOUNT_BNAME2", "XooNIps �桼����˥塼");
define("_MI_XOONIPS_ACCOUNT_BNAME3", "XooNIps ���롼�ץ�˥塼");
define("_MI_XOONIPS_ACCOUNT_BNAME4", "XooNIps ��ǥ졼����˥塼");

//submenu labels
define("_MI_XOONIPS_ACCOUNT_SMNAME1", "��������Ⱦ���");
define("_MI_XOONIPS_ACCOUNT_SMNAME2", "����������Խ�");
define("_MI_XOONIPS_ACCOUNT_SMNAME4", "���롼�״���");


//administrator menu
define("_MI_XOONIPS_ADMENU1", "�����ƥ�����");
define("_MI_XOONIPS_ADMENU2", "�����ȥݥꥷ������");
define("_MI_XOONIPS_ADMENU3", "���ƥʥ�");

//notification
define ('_MI_XOONIPS_USER_NOTIFY', 'XooNIps�桼��');
define ('_MI_XOONIPS_USER_NOTIFYDSC', 'XooNIps�桼���ؤ�����');

define ('_MI_XOONIPS_ADMINISTRATOR_NOTIFY', '������');
define ('_MI_XOONIPS_ADMINISTRATOR_NOTIFYDSC', '��ǥ졼�������롼�״����Ԥؤ�����');

// �ʲ�XooNIpsNotification����Ѥ������Ρ�subject��main.php �����
define( "_MI_XOONIPS_ITEM_TRANSFER_NOTIFY", "�����ƥ�ܾ�����" );
define( "_MI_XOONIPS_ITEM_TRANSFER_NOTIFYCAP", "�����ƥ�ν�ͭ�Ԥ��ѹ����줿�������Τ���" );
define( "_MI_XOONIPS_ITEM_TRANSFER_NOTIFYDSC", "�����ƥ�ν�ͭ�Ԥ��ѹ����줿�������Τ������롥" );

define( "_MI_XOONIPS_ACCOUNT_CERTIFY_NOTIFY", "��������Ⱦ�ǧ����" );
define( "_MI_XOONIPS_ACCOUNT_CERTIFY_NOTIFYCAP", "��������Ȥξ�ǧ�����Τ���" );
define( "_MI_XOONIPS_ACCOUNT_CERTIFY_NOTIFYDSC", "��������Ȥξ�ǧ���׵ᤵ�줿��硦��������Ȥ���ǧ���줿�������Τ������롥" );

define( "_MI_XOONIPS_ITEM_CERTIFY_NOTIFY", "�����ƥྵǧ����" );
define( "_MI_XOONIPS_ITEM_CERTIFY_NOTIFYCAP", "�����ƥ�ξ�ǧ�����Τ���" );
define( "_MI_XOONIPS_ITEM_CERTIFY_NOTIFYDSC", "�����ƥ�θ����׵᤬���ä���硢�����ƥ�θ����׵᤬��ǧ����ǧ���ݤ��줿�������Τ������롥" );

define( "_MI_XOONIPS_USER_ITEM_TRANSFER_NOTIFY", "�����ƥ�ܾ�����" );
define( "_MI_XOONIPS_USER_ITEM_TRANSFER_NOTIFYCAP", "�����ƥ�ΰܾ������Τ���" );
define( "_MI_XOONIPS_USER_ITEM_TRANSFER_NOTIFYDSC", "�����ƥ�ΰܾ����׵ᤵ�줿��硢�����ƥ�ΰܾ��׵��ǧ�����ݤ��줿�������Τ������롥" );

define( "_MI_XOONIPS_USER_ITEM_UPDATED_NOTIFY", "�����ƥ๹������" );
define( "_MI_XOONIPS_USER_ITEM_UPDATED_NOTIFYCAP", "��ʬ�Υ����ƥ�����Ƥ������Ԥˤ�깹�����줿�������Τ���" );
define( "_MI_XOONIPS_USER_ITEM_UPDATED_NOTIFYDSC", "��ʬ�Υ����ƥ�����Ƥ������Ԥˤ�깹�����줿�������Τ������롥" );

define( "_MI_XOONIPS_USER_ITEM_CERTIFIED_NOTIFY", "�����ƥྵǧ����" );
define( "_MI_XOONIPS_USER_ITEM_CERTIFIED_NOTIFYCAP", "�����ƥब��ǧ���줿�������Τ���" );
define( "_MI_XOONIPS_USER_ITEM_CERTIFIED_NOTIFYDSC", "�����ƥ�򥤥�ǥå�������Ͽ���뤳�Ȥ�ǧ���줿�������Τ������롥" );

define( "_MI_XOONIPS_USER_ITEM_REJECTED_NOTIFY", "�����ƥྵǧ��������" );
define( "_MI_XOONIPS_USER_ITEM_REJECTED_NOTIFYCAP", "�����ƥब��ǧ����ʤ��ä��������Τ���" );
define( "_MI_XOONIPS_USER_ITEM_REJECTED_NOTIFYDSC", "�����ƥ�򥤥�ǥå�������Ͽ���뤳�Ȥ�ǧ����ʤ��ä��������Τ������롥" );

define( "_MI_XOONIPS_USER_FILE_DOWNLOADED_NOTIFY", "�ե�����Υ�������ɤ�����" );
define( "_MI_XOONIPS_USER_FILE_DOWNLOADED_NOTIFYCAP", "��ʬ���������������ƥ�Υե����뤬��������ɤ��줿�������Τ���" );
define( "_MI_XOONIPS_USER_FILE_DOWNLOADED_NOTIFYDSC", "��ʬ���������������ƥ�Υե����뤬��������ɤ��줿�������Τ������롥" );



define( "_MI_XOONIPS_USER_GROUP_ITEM_CERTIFIED_NOTIFY", "���롼�ץ����ƥྵǧ����" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_CERTIFIED_NOTIFYCAP", "���롼�ץ����ƥब��ǧ���줿�������Τ���" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_CERTIFIED_NOTIFYDSC", "���롼�ץ����ƥ�򥤥�ǥå�������Ͽ���뤳�Ȥ�ǧ���줿�������Τ������롥" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_CERTIFIED_NOTIFYSBJ", "���ʤ��Υ��롼�ץ����ƥ�Ͼ�ǧ����ޤ���" );

define( "_MI_XOONIPS_USER_GROUP_ITEM_REJECTED_NOTIFY", "���롼�ץ����ƥྵǧ��������" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_REJECTED_NOTIFYCAP", "���롼�ץ����ƥब��ǧ����ʤ��ä��������Τ���" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_REJECTED_NOTIFYDSC", "���롼�ץ����ƥ�򥤥�ǥå�������Ͽ���뤳�Ȥ�ǧ����ʤ��ä��������Τ������롥" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_REJECTED_NOTIFYSBJ", "���ʤ��Υ��롼�ץ����ƥ�Ͼ�ǧ����ޤ���Ǥ���" );

define( "_MI_XOONIPS_USER_GROUP_ITEM_CERTIFY_REQUEST_NOTIFY", "���롼�ץ����ƥྵǧ�׵�����" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_CERTIFY_REQUEST_NOTIFYCAP", "��ǧ��ɬ�פʥ��롼�ץ����ƥबȯ�������������Τ���" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_CERTIFY_REQUEST_NOTIFYDSC", "���롼�ץ����ƥबPublic����ǥå�������Ͽ���줿�Ȥ������Τ������롥" );
define( "_MI_XOONIPS_USER_GROUP_ITEM_CERTIFY_REQUEST_NOTIFYSBJ", "��ǧ�Ԥ��Υ��롼�ץ����ƥब����ޤ�" );





//itemtype block labels
define("_MI_XOONIPS_ITEMTYPE_BNAME1", "�����ƥॿ���װ���");// 

define("_MI_XOONIPS_RANKING", "��󥭥�"); 
define("_MI_XOONIPS_RANKING_NEW", "����");

//userlist block label
define("_MI_XOONIPS_USERLIST", "�桼������");
?>
