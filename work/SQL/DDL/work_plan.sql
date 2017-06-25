-- DROP SCHEMA work_plan;

-- CREATE SCHEMA work_plan;
-- COMMENT ON SCHEMA work_plan IS '工項規劃機制';

DROP TABLE work_plan.project_break_down CASCADE;
DROP TABLE work_plan.site_project CASCADE;
DROP TABLE work_plan.package_break_down CASCADE;
DROP TABLE work_plan.working_package CASCADE;

--DROP TABLE work_plan.working_package CASCADE;
CREATE TABLE work_plan.working_package (
Id                      serial primary key,

package_name            varchar(255),
package_description     varchar(255),
package_criteria1       varchar(10),
package_criteria2       varchar(10),
package_criteria3       varchar(10),

operate_By              varchar(30),
operate_At              timestamp    default now()
);

COMMENT ON TABLE   work_plan.working_package                         IS '工項包表';
COMMENT ON COLUMN  work_plan.working_package.Id                      IS '工項包PK';

COMMENT ON COLUMN  work_plan.working_package.package_name            IS '工項包名稱';
COMMENT ON COLUMN  work_plan.working_package.package_description     IS '工項包說明';
COMMENT ON COLUMN  work_plan.working_package.package_criteria1       IS '工項包條件一';
COMMENT ON COLUMN  work_plan.working_package.package_criteria2       IS '工項包條件二';
COMMENT ON COLUMN  work_plan.working_package.package_criteria3       IS '工項包條件三';

COMMENT ON COLUMN  work_plan.working_package.operate_By              IS '操作者';
COMMENT ON COLUMN  work_plan.working_package.operate_At              IS '操作時間';


-- DROP TABLE work_plan.package_break_down CASCADE;
CREATE TABLE work_plan.package_break_down (
Id                      serial primary key,
parent_Id               int references work_plan.package_break_down(id),
package_id              int references work_plan.working_package(id),

item_name               varchar(255),
item_description        varchar(255),
item_criteria1          varchar(10),
item_criteria2          varchar(10),
item_criteria3          varchar(10),
item_criteria4          varchar(10),

operate_By              varchar(30),
operate_At              timestamp    default now()
);

COMMENT ON TABLE   work_plan.package_break_down                         IS '工項包拆解表';
COMMENT ON COLUMN  work_plan.package_break_down.Id                      IS '工項包拆解表PK';
COMMENT ON COLUMN  work_plan.package_break_down.parent_Id               IS '父工項包拆解表ID FK';
COMMENT ON COLUMN  work_plan.package_break_down.package_id              IS '工項包ID FK';

COMMENT ON COLUMN  work_plan.package_break_down.item_name               IS '項目名稱';
COMMENT ON COLUMN  work_plan.package_break_down.item_description        IS '項目說明';
COMMENT ON COLUMN  work_plan.package_break_down.item_criteria1          IS '項目條件一';
COMMENT ON COLUMN  work_plan.package_break_down.item_criteria2          IS '項目條件二';
COMMENT ON COLUMN  work_plan.package_break_down.item_criteria3          IS '項目條件三';
COMMENT ON COLUMN  work_plan.package_break_down.item_criteria4          IS '項目條件四';

COMMENT ON COLUMN  work_plan.package_break_down.operate_By              IS '操作者';
COMMENT ON COLUMN  work_plan.package_break_down.operate_At              IS '操作時間';


-- DROP TABLE work_plan.site_project;
CREATE TABLE work_plan.site_project (
Id                      serial primary key,
working_package_id      int references work_plan.working_package(id),

project_name            varchar(255),
project_status          varchar(5),
project_address         varchar(255),
owner                   varchar(255),
contactor               varchar(255),
contact_mobile          varchar(40),
note1                   varchar(255),

operate_By              varchar(30),
operate_At              timestamp    default now()
);

COMMENT ON TABLE   work_plan.site_project                         IS '專案工地表';
COMMENT ON COLUMN  work_plan.site_project.Id                      IS '專案工地PK';
COMMENT ON COLUMN  work_plan.site_project.working_package_id      IS '工項包 FK';

COMMENT ON COLUMN  work_plan.site_project.project_name            IS '專案名稱';
COMMENT ON COLUMN  work_plan.site_project.project_status          IS '專案狀態';
COMMENT ON COLUMN  work_plan.site_project.project_address         IS '專案位址';
COMMENT ON COLUMN  work_plan.site_project.owner                   IS '業主';
COMMENT ON COLUMN  work_plan.site_project.contactor               IS '聯絡人';
COMMENT ON COLUMN  work_plan.site_project.contact_mobile          IS '聯絡手機';
COMMENT ON COLUMN  work_plan.site_project.note1                   IS '備註一';

COMMENT ON COLUMN  work_plan.site_project.operate_By              IS '操作者';
COMMENT ON COLUMN  work_plan.site_project.operate_At              IS '操作時間';



--DROP TABLE work_plan.project_break_down CASCADE;
CREATE TABLE work_plan.project_break_down (
Id                      serial primary key,
parent_Id               int references work_plan.project_break_down(id),
item_id                 int references work_plan.package_break_down(id),

item_name               varchar(255),
item_description        varchar(255),
item_criteria1          varchar(10),
item_criteria2          varchar(10),
item_criteria3          varchar(10),
item_criteria4          varchar(10),

estimate_amount         NUMERIC(18,6),
measure_unit            varchar(5),

operate_By              varchar(30),
operate_At              timestamp    default now()
);

COMMENT ON TABLE   work_plan.project_break_down                         IS '專案拆解表';
COMMENT ON COLUMN  work_plan.project_break_down.Id                      IS '專案拆解表PK';
COMMENT ON COLUMN  work_plan.project_break_down.parent_Id               IS '父專案拆解ID FK';

COMMENT ON COLUMN  work_plan.project_break_down.item_name               IS '項目名稱';
COMMENT ON COLUMN  work_plan.project_break_down.item_description        IS '項目說明';
COMMENT ON COLUMN  work_plan.project_break_down.item_criteria1          IS '項目條件一';
COMMENT ON COLUMN  work_plan.project_break_down.item_criteria2          IS '項目條件二';
COMMENT ON COLUMN  work_plan.project_break_down.item_criteria3          IS '項目條件三';
COMMENT ON COLUMN  work_plan.project_break_down.item_criteria4          IS '項目條件四';
COMMENT ON COLUMN  work_plan.project_break_down.estimate_amount         IS '預估數量';
COMMENT ON COLUMN  work_plan.project_break_down.measure_unit            IS '單位';

COMMENT ON COLUMN  work_plan.project_break_down.operate_By              IS '操作者';
COMMENT ON COLUMN  work_plan.project_break_down.operate_At              IS '操作時間';
