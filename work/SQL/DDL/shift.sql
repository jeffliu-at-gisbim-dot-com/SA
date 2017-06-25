-- DROP SCHEMA shift CASCADE ;

-- CREATE SCHEMA shift;
-- COMMENT ON SCHEMA shift IS '輪班機制';

DROP TABLE shift.daily_shift;
DROP TABLE shift.duty_transition;
DROP TABLE shift.pattern;
DROP TABLE shift.shift_period;
DROP TABLE shift.shift_code;


-- DROP   TABLE shift.shift_code;
CREATE TABLE shift.shift_code (
Id                      serial primary key,
                        
code                    varchar(10),
description             varchar(255),
shift_type              varchar(1), -- ex:D:日班 N:夜班 T:過渡班
counting_item1          varchar(1),
counting_item2          varchar(1),
counting_item3          varchar(1),
counting_item4          varchar(1),
counting_item5          varchar(1),
counting_item6          varchar(1),
counting_item7          varchar(1),
counting_item8          varchar(1),

operate_By              varchar(30),
operate_At              timestamp    default now()
);

COMMENT ON TABLE   shift.shift_code                         IS '輪班代碼表';
COMMENT ON COLUMN  shift.shift_code.Id                      IS '輪班代碼表PK';
                                                            
COMMENT ON COLUMN  shift.shift_code.code                    IS '輪班代碼';
COMMENT ON COLUMN  shift.shift_code.description             IS '輪班代碼說明';
COMMENT ON COLUMN  shift.shift_code.shift_type              IS '輪班代碼型態';
COMMENT ON COLUMN  shift.shift_code.counting_item1          IS '誤早餐';
COMMENT ON COLUMN  shift.shift_code.counting_item2          IS '誤晚餐';
COMMENT ON COLUMN  shift.shift_code.counting_item3          IS '誤早車';
COMMENT ON COLUMN  shift.shift_code.counting_item4          IS '誤晚車';
COMMENT ON COLUMN  shift.shift_code.counting_item5          IS '';
COMMENT ON COLUMN  shift.shift_code.counting_item6          IS '';
COMMENT ON COLUMN  shift.shift_code.counting_item7          IS '';
COMMENT ON COLUMN  shift.shift_code.counting_item8          IS '';

COMMENT ON COLUMN  shift.shift_code.operate_By              IS '操作者';
COMMENT ON COLUMN  shift.shift_code.operate_At              IS '操作時間';

-- 每一個班表, 由多個時間區段組合而成
-- DROP   TABLE shift.shift_period;
CREATE TABLE shift.shift_period (
Id             serial primary key,
shift_code_id  int references shift.shift_code(id),

period_start   varchar(4), -- 區段開始時間 ex:0830
period_end     varchar(4), -- 區段結束時間 ex:1030
period_type    varchar(1), -- ex:W 工作時間, R休息時間

operate_By     varchar(30),
operate_At     timestamp    default now()
);

COMMENT ON TABLE   shift.shift_period               IS '輪班區段表';
COMMENT ON COLUMN  shift.shift_period.Id            IS '輪班區段表PK';

COMMENT ON COLUMN  shift.shift_period.period_start  IS '區段開始時間';
COMMENT ON COLUMN  shift.shift_period.period_end    IS '區段結束時間';
COMMENT ON COLUMN  shift.shift_period.period_start  IS '區段型態';

COMMENT ON COLUMN  shift.shift_period.operate_By    IS '操作者';
COMMENT ON COLUMN  shift.shift_period.operate_At    IS '操作時間';


-- 班表輪班規律, 定義組織部門的輪班規則
-- DROP   TABLE shift.pattern;
CREATE TABLE shift.pattern (
Id            serial primary key,
org_id        int, -- 

code_pattern  varchar(255), 
index_seq     varchar(1),
index_date    date,

operate_By     varchar(30),
operate_At     timestamp    default now()
);

COMMENT ON TABLE   shift.pattern               IS '輪班規律表';
COMMENT ON COLUMN  shift.pattern.Id            IS '輪班規律表PK';

COMMENT ON COLUMN  shift.pattern.code_pattern  IS '輪班規律';
COMMENT ON COLUMN  shift.pattern.index_seq     IS '計算索引-索引值';
COMMENT ON COLUMN  shift.pattern.index_date    IS '計算索引-索引日';

COMMENT ON COLUMN  shift.pattern.operate_By    IS '操作者';
COMMENT ON COLUMN  shift.pattern.operate_At    IS '操作時間';


-- 員工部門任職調動資料
-- DROP TABLE shift.duty_transition;
CREATE TABLE shift.duty_transition (
Id             serial primary key,

employee_no    varchar(20),  
duty_start     date,
duty_end       date,
note           varchar(255),

operate_By     varchar(30),
operate_At     timestamp    default now()
);

COMMENT ON TABLE   shift.duty_transition             IS '員工部門任職調動表';
COMMENT ON COLUMN  shift.duty_transition.Id          IS '員工部門任職調動表PK';

COMMENT ON COLUMN  shift.duty_transition.employee_no IS '員工工號';
COMMENT ON COLUMN  shift.duty_transition.duty_start  IS '任職開始時間';
COMMENT ON COLUMN  shift.duty_transition.duty_end    IS '任職結束時間';
COMMENT ON COLUMN  shift.duty_transition.note        IS '調動備註';

COMMENT ON COLUMN  shift.duty_transition.operate_By  IS '操作者';
COMMENT ON COLUMN  shift.duty_transition.operate_At  IS '操作時間';

-- 每日輪班資料
-- DROP TABLE shift.daily_shift;
CREATE TABLE shift.daily_shift (
Id                      serial primary key,
                        
employee_no             varchar(20),  
shift_date              varchar(8), -- ex: 20170506
shift_code              varchar(1),
shift_type              varchar(1),
counting_item1          varchar(1),
counting_item2          varchar(1),
counting_item3          varchar(1),
counting_item4          varchar(1),
counting_item5          varchar(1),
counting_item6          varchar(1),
counting_item7          varchar(1),
counting_item8          varchar(1),

operate_type            varchar(1), -- ex:G:by generate, U:by upload, M:by manual edit
operate_By              varchar(30),
operate_At              timestamp    default now()
);

COMMENT ON TABLE   shift.daily_shift                         IS '每日輪班表';
COMMENT ON COLUMN  shift.daily_shift.Id                      IS '輪班區段表PK';
                                                             
COMMENT ON COLUMN  shift.daily_shift.employee_no             IS '員工工號';
COMMENT ON COLUMN  shift.daily_shift.shift_date              IS '輪班日期';
COMMENT ON COLUMN  shift.daily_shift.shift_code              IS '輪班代碼';
COMMENT ON COLUMN  shift.daily_shift.shift_type              IS '輪班型態';
COMMENT ON COLUMN  shift.daily_shift.counting_item1          IS '誤早餐';
COMMENT ON COLUMN  shift.daily_shift.counting_item2          IS '誤晚餐';
COMMENT ON COLUMN  shift.daily_shift.counting_item3          IS '誤早車';
COMMENT ON COLUMN  shift.daily_shift.counting_item4          IS '誤晚車';
COMMENT ON COLUMN  shift.daily_shift.counting_item5          IS '';
COMMENT ON COLUMN  shift.daily_shift.counting_item6          IS '';
COMMENT ON COLUMN  shift.daily_shift.counting_item7          IS '';
COMMENT ON COLUMN  shift.daily_shift.counting_item8          IS '';

COMMENT ON COLUMN  shift.daily_shift.operate_By              IS '操作者';
COMMENT ON COLUMN  shift.daily_shift.operate_At              IS '操作時間';
