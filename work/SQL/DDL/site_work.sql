
-- DROP SCHEMA site_work;

-- CREATE SCHEMA site_work;
-- COMMENT ON SCHEMA site_work IS '現地派工刷工機制';

DROP TABLE site_work.working_record;
DROP TABLE site_work.work_group_working_item;
DROP TABLE site_work.work_group_member;
DROP TABLE site_work.work_group;
DROP TABLE site_work.work_assign;


-- 工作分派
-- DROP   TABLE site_work.work_assign;
CREATE TABLE site_work.work_assign (
Id                      serial primary key,

assign_date             date,
assign_criteria_1       varchar(10),  -- shift_type
assign_criteria_2       varchar(10),
assign_criteria_3       varchar(10),
assign_criteria_4       varchar(10),
assign_criteria_5       varchar(10),

operate_By              varchar(30),
operate_At              timestamp    default now()
);

COMMENT ON TABLE   site_work.work_assign                         IS '工作派分表';
COMMENT ON COLUMN  site_work.work_assign.Id                      IS '工作派分表PK';
                                                             
COMMENT ON COLUMN  site_work.work_assign.assign_date             IS '派分日期';
COMMENT ON COLUMN  site_work.work_assign.assign_criteria_1       IS '派分條件一';
COMMENT ON COLUMN  site_work.work_assign.assign_criteria_2       IS '派分條件二';
COMMENT ON COLUMN  site_work.work_assign.assign_criteria_3       IS '派分條件三';
COMMENT ON COLUMN  site_work.work_assign.assign_criteria_4       IS '派分條件四';
COMMENT ON COLUMN  site_work.work_assign.assign_criteria_5       IS '派分條件五';

COMMENT ON COLUMN  site_work.work_assign.operate_By              IS '操作者';
COMMENT ON COLUMN  site_work.work_assign.operate_At              IS '操作時間';


-- 工作派分群組
-- DROP TABLE site_work.work_group;
CREATE TABLE site_work.work_group (
Id                      serial primary key,
work_assign_id          int references site_work.work_assign(id),

work_group_name         varchar(20),
work_group_description  varchar(20),
work_group_criteria1    varchar(10),
work_group_criteria2    varchar(10),

operate_By              varchar(30),
operate_At              timestamp    default now()
);

COMMENT ON TABLE   site_work.work_group                         IS '工作派分群組表';
COMMENT ON COLUMN  site_work.work_group.Id                      IS '工作派分群組表PK';

COMMENT ON COLUMN  site_work.work_group.work_group_name         IS '群組名稱';
COMMENT ON COLUMN  site_work.work_group.work_group_description  IS '群組說明';
COMMENT ON COLUMN  site_work.work_group.work_group_criteria1    IS '群組條件一';
COMMENT ON COLUMN  site_work.work_group.work_group_criteria2    IS '群組條件二';

COMMENT ON COLUMN  site_work.work_group.operate_By              IS '操作者';
COMMENT ON COLUMN  site_work.work_group.operate_At              IS '操作時間';


-- 工作派分群組-成員
-- DROP   TABLE site_work.work_group_member;
CREATE TABLE site_work.work_group_member (
Id                      serial primary key,
work_group_id           int references site_work.work_group(id),

employee_no             varchar(20),
employee_name           varchar(60),
member_criteria1        varchar(10),
member_criteria2        varchar(10),

operate_By              varchar(30),
operate_At              timestamp    default now()
);
COMMENT ON TABLE   site_work.work_group_member                  IS '工作派分群組成員表';
COMMENT ON COLUMN  site_work.work_group_member.Id               IS '工作派分群組成員表PK';
COMMENT ON COLUMN  site_work.work_group_member.work_group_id    IS '工作分派群組ID FK';
                                                            
COMMENT ON COLUMN  site_work.work_group_member.employee_no      IS '員工工號';
COMMENT ON COLUMN  site_work.work_group_member.employee_name    IS '員工姓名';
COMMENT ON COLUMN  site_work.work_group_member.member_criteria1 IS '成員條件一';
COMMENT ON COLUMN  site_work.work_group_member.member_criteria2 IS '成員條件二';

COMMENT ON COLUMN  site_work.work_group_member.operate_By       IS '操作者';
COMMENT ON COLUMN  site_work.work_group_member.operate_At       IS '操作時間';


-- 工作派分群組-工作項目
-- DROP TABLE site_work.work_group_working_item
CREATE TABLE site_work.work_group_working_item (
Id                      serial primary key,
work_group_id           int references site_work.work_group(id),

item_code               varchar(20),
item_description        varchar(20),
item_criteria1          varchar(10),
item_criteria2          varchar(10),
item_criteria3          varchar(10),

operate_By              varchar(30),
operate_At              timestamp    default now()
);
COMMENT ON TABLE   site_work.work_group_working_item                   IS '工作派分群組工項表';
COMMENT ON COLUMN  site_work.work_group_working_item.Id                IS '工作派分群組工項表PK';
COMMENT ON COLUMN  site_work.work_group_working_item.work_group_id     IS '工作分派群組ID FK';

COMMENT ON COLUMN  site_work.work_group_working_item.item_code         IS '項目代碼';
COMMENT ON COLUMN  site_work.work_group_working_item.item_description  IS '項目說明';
COMMENT ON COLUMN  site_work.work_group_working_item.item_criteria1    IS '項目條件一';
COMMENT ON COLUMN  site_work.work_group_working_item.item_criteria2    IS '項目條件二';
COMMENT ON COLUMN  site_work.work_group_working_item.item_criteria3    IS '項目條件三';

COMMENT ON COLUMN  site_work.work_group_working_item.operate_By        IS '操作者';
COMMENT ON COLUMN  site_work.work_group_working_item.operate_At        IS '操作時間';



-- 實際刷工資料
-- DROP TABLE site_work.working_record;
CREATE TABLE site_work.working_record (
Id                      serial primary key,

employee_no             varchar(20),
employee_name           varchar(60),
record_start            timestamp,
record_end              timestamp,

operate_By              varchar(30),
operate_At              timestamp    default now()
);
COMMENT ON TABLE   site_work.working_record                   IS '工作紀錄表';