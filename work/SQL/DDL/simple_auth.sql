-- Schema: PRI

﻿-- DROP SCHEMA PRI CASCADE ;

﻿-- CREATE SCHEMA PRI;
﻿-- COMMENT ON SCHEMA PRI IS '權限機制 檢核登入者';


 Drop Table PRI.Duty        CASCADE;  -- 任職
 Drop Table PRI.APP_User    CASCADE;  --  1 使用者
 Drop Table PRI.Data_Auth   CASCADE;  --  4 資料授權
 Drop Table PRI.Fun_Auth    CASCADE;  --  4 授權
 Drop Table PRI.Auth_Group  CASCADE;  --  2 授權種類
 Drop Table PRI.Fun         CASCADE;  --  1 系統功能
 Drop Table PRI.Service     CASCADE;  --  2 服務
 Drop Table PRI.Org         CASCADE;  --  1 組織
 Drop Table PRI.Para        CASCADE;  --  1 參數


CREATE TABLE PRI.Para (
Id             serial primary key,
para_Catalogue varchar(60),
para_I18n      varchar(120),
para_Name      varchar(60),
para_Value     varchar(60),

operate_By     varchar(30),
operate_At     timestamp    default now()
);

COMMENT ON TABLE   PRI.Para                   IS '權限用參數表';
COMMENT ON COLUMN  PRI.Para.Id                IS '權限用參數表PK';
COMMENT ON COLUMN  PRI.Para.para_Catalogue    IS '參數分類';
COMMENT ON COLUMN  PRI.Para.para_I18n         IS '語系';
COMMENT ON COLUMN  PRI.Para.para_Name         IS '參數名稱';
COMMENT ON COLUMN  PRI.Para.para_Value        IS '參數值';
COMMENT ON COLUMN  PRI.Para.operate_By        IS '操作者';
COMMENT ON COLUMN  PRI.Para.operate_At        IS '操作時間';


CREATE TABLE PRI.Org (
Id            serial primary key,
parent_Org_Id int   references PRI.Org(Id),

org_code      varchar(10),
org_Name      varchar(30),
org_Type      varchar(1),
org_criteria1 varchar(10),
org_criteria2 varchar(10),
org_criteria3 varchar(10),

operate_By    varchar(30),
operate_At    timestamp    default now()
);

COMMENT ON TABLE   PRI.Org                  IS '組織表';
COMMENT ON COLUMN  PRI.Org.Id               IS '組織表PK';
COMMENT ON COLUMN  PRI.Org.parent_Org_Id    IS '上層組織FK; 樹狀組織, 若需支援網路形需另擴充';
COMMENT ON COLUMN  PRI.Org.org_code         IS '組織代碼:ex:EVA, EGAT, UNI';
COMMENT ON COLUMN  PRI.Org.org_Name         IS '名稱';
COMMENT ON COLUMN  PRI.Org.org_Type         IS '組織樣態; G:集團group, C:公司company; B:商務單元biz unit; D:部門department; T:職務duty';
COMMENT ON COLUMN  PRI.Org.org_criteria1    IS '組織條件一;組織性質; P:軟體開發者provider: A:經銷商agent; T:終端使用者terminal';
COMMENT ON COLUMN  PRI.Org.org_criteria2    IS '組織條件二;統一編號';
COMMENT ON COLUMN  PRI.Org.org_criteria3    IS '組織條件三';
COMMENT ON COLUMN  PRI.Org.operate_By       IS '操作者';
COMMENT ON COLUMN  PRI.Org.operate_At       IS '操作時間';


CREATE TABLE PRI.Service (
Id                    serial primary key,
provider_Id           int references PRI.Org(Id),
service_Name          varchar(60),
service_url           varchar(255),
parameter_description varchar(255),
service_key           varchar(255),
service_key_password  varchar(20),
connect_frequency     varchar(2),

operate_By            varchar(30),
operate_At            timestamp    default now()
);

COMMENT ON TABLE   PRI.Service                       IS   '軟體服務表';
COMMENT ON COLUMN  PRI.Service.Id                    IS '軟體服務PK';
COMMENT ON COLUMN  PRI.Service.provider_Id           IS '軟體服務提供者FK';
COMMENT ON COLUMN  PRI.Service.service_Name          IS '軟體服務名稱';
COMMENT ON COLUMN  PRI.Service.service_url           IS '軟體服務URL';
COMMENT ON COLUMN  PRI.Service.parameter_description IS '參數說明';
COMMENT ON COLUMN  PRI.Service.service_key           IS '代表鍵值';
COMMENT ON COLUMN  PRI.Service.service_key_password  IS '連線密碼';
COMMENT ON COLUMN  PRI.Service.connect_frequency     IS '連線頻率';
COMMENT ON COLUMN  PRI.Service.operate_By            IS '操作者';
COMMENT ON COLUMN  PRI.Service.operate_At            IS '操作時間';


CREATE TABLE PRI.Fun (
Id            serial primary key,
parent_Fun_Id int   references PRI.Fun(Id),
service_id    int   references PRI.Service(Id),
fun_Code      varchar(15),
fun_Type      varchar(2),
layer         varchar(2),
layer_Seq     varchar(3),
fun_Name      varchar(60),
fun_Path      varchar(120),
operations    varchar(255),
active_Flag   varchar(1),
boot_Flag     varchar(1),

operate_By    varchar(30),
operate_At    timestamp      default now()
);

COMMENT ON TABLE   PRI.Fun             IS   '程式功能表';
COMMENT ON COLUMN  PRI.Fun.Id            IS '程式功能PK';
COMMENT ON COLUMN  PRI.Fun.parent_Fun_Id IS '上層程式功能FK; 樹狀結構';
COMMENT ON COLUMN  PRI.Fun.service_id    IS '所屬軟體服務FK';
COMMENT ON COLUMN  PRI.Fun.fun_Code      IS '程式代碼';
COMMENT ON COLUMN  PRI.Fun.fun_Type      IS '程式形態; W:網頁應用程式, B:批次處理Batch, WS:WebService';
COMMENT ON COLUMN  PRI.Fun.layer         IS '層數';
COMMENT ON COLUMN  PRI.Fun.layer_Seq     IS '同一層中的順序';
COMMENT ON COLUMN  PRI.Fun.fun_Name      IS '程式功能名稱';
COMMENT ON COLUMN  PRI.Fun.fun_Path      IS '程式功能路徑';
COMMENT ON COLUMN  PRI.Fun.operations    IS '程式功能操作; 對資料庫進行何種操作';
COMMENT ON COLUMN  PRI.Fun.active_Flag   IS '啟用旗標; Y:啟用, N:未啟用';
COMMENT ON COLUMN  PRI.Fun.boot_Flag     IS '啟動旗標; Y:可以啟動, N:不可啟動';
COMMENT ON COLUMN  PRI.Fun.operate_By    IS '操作者';
COMMENT ON COLUMN  PRI.Fun.operate_At    IS '操作時間';


CREATE TABLE PRI.Auth_Group (
Id                     serial primary key,

Auth_Group_Name        varchar(20),
Auth_Group_Description varchar(60),
Auth_Group_type        varchar(1),
editable               varchar(1) default 'Y',

operate_By             varchar(30),
operate_At             timestamp default now()
);

COMMENT ON TABLE   PRI.Auth_Group                        IS '授權群組表';
COMMENT ON COLUMN  PRI.Auth_Group.Id                     IS '授權群組PK';
COMMENT ON COLUMN  PRI.Auth_Group.Auth_Group_Name        IS '授權群組名稱;';
COMMENT ON COLUMN  PRI.Auth_Group.Auth_Group_Description IS '授權群組說明';
COMMENT ON COLUMN  PRI.Auth_Group.Auth_Group_type        IS '授權群組形態;ex:R:角色, D:部門, T:任務小組, BU:商務單元';
COMMENT ON COLUMN  PRI.Auth_Group.editable               IS '是否可編輯: Y:可編輯, N:不可編輯';
COMMENT ON COLUMN  PRI.Auth_Group.operate_By             IS '操作者';
COMMENT ON COLUMN  PRI.Auth_Group.operate_At             IS '操作時間';


CREATE TABLE PRI.Fun_Auth (
Id              serial      primary key,
Auth_Group_Id   int         references PRI.Auth_Group(Id),
fun_Id          int         references PRI.Fun(Id),
operations      varchar(255),

operate_By      varchar(30),
operate_At      timestamp   default now()
);
COMMENT ON TABLE   PRI.Fun_Auth               IS '功能授權表';
COMMENT ON COLUMN  PRI.Fun_Auth.Id            IS '功能授權PK';
COMMENT ON COLUMN  PRI.Fun_Auth.Auth_Group_Id IS '授權群組ID FK';
COMMENT ON COLUMN  PRI.Fun_Auth.fun_Id        IS '程式功能FK';
COMMENT ON COLUMN  PRI.Fun_Auth.operations    IS '授權操作:';
COMMENT ON COLUMN  PRI.Fun_Auth.operate_By    IS '操作者';
COMMENT ON COLUMN  PRI.Fun_Auth.operate_At    IS '操作時間';


CREATE TABLE PRI.Data_Auth (
Id              serial primary key,
Auth_Group_Id   int         references  PRI.Auth_Group(id),
org_Id          int         references  PRI.Org(id),
view_range      char(1),
operate_By      varchar(30),
operate_At      timestamp    default now()
);

COMMENT ON TABLE   PRI.Data_Auth               IS '資料授權表: 授權角色可操作的資料範圍';
COMMENT ON COLUMN  PRI.Data_Auth.Id            IS '資料授權PK';
COMMENT ON COLUMN  PRI.Data_Auth.Auth_Group_Id IS '授權群組ID FK';
COMMENT ON COLUMN  PRI.Data_Auth.org_Id        IS '組織ID FK';
COMMENT ON COLUMN  PRI.Data_Auth.view_range    IS '檢視範圍; l:僅該組織, d:該組織及其下屬組織';
COMMENT ON COLUMN  PRI.Data_Auth.operate_By    IS '操作者';
COMMENT ON COLUMN  PRI.Data_Auth.operate_At    IS '操作時間';


CREATE TABLE PRI.App_User (
Id               serial primary key,
account          varchar(255) unique,
employee_no      varchar(255) unique,
user_Name        varchar(30),
encrypt_passwd   varchar(65),
encrypt_type     char(1)     default '0',


operate_By       varchar(30),
operate_At       timestamp default now()
);

COMMENT ON TABLE   PRI.App_User                 IS '使用者表';
COMMENT ON COLUMN  PRI.App_User.Id              IS '使用者PK';
COMMENT ON COLUMN  PRI.App_User.account         IS '帳號(工號)';
COMMENT ON COLUMN  PRI.App_User.user_Name       IS '使用者姓名';
COMMENT ON COLUMN  PRI.App_User.encrypt_passwd  IS '加密後的使用者密碼';
COMMENT ON COLUMN  PRI.App_User.encrypt_type    IS '密碼加密方式[0:不加密, 1:md5]';
COMMENT ON COLUMN  PRI.App_User.operate_By      IS '操作者';
COMMENT ON COLUMN  PRI.App_User.operate_At      IS '操作時間';


CREATE TABLE PRI.Duty (
Id              serial primary key,
user_Id         int references  PRI.App_User(Id),
Auth_Group_Id   int references  PRI.Auth_Group(Id),
valid_After     timestamp,
valid_Before    timestamp,

operate_By      varchar(30),
operate_At      timestamp default now()
);

COMMENT ON TABLE   PRI.Duty               IS '任職表';
COMMENT ON COLUMN  PRI.Duty.Id            IS '任職PK';
COMMENT ON COLUMN  PRI.Duty.user_Id       IS '使用者FK';
COMMENT ON COLUMN  PRI.Duty.Auth_Group_Id IS '角色FK';
COMMENT ON COLUMN  PRI.Duty.valid_After   IS '生效日';
COMMENT ON COLUMN  PRI.Duty.valid_Before  IS '生效日';
COMMENT ON COLUMN  PRI.Duty.operate_By    IS '操作者';
COMMENT ON COLUMN  PRI.Duty.operate_At    IS '操作時間';

