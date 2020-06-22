----------------------------------------------------------
--DROP TABLE BEFORE CREATING

drop table question;
DROP TABLE AUTHORITY_TABLE;
DROP TABLE FEATURES_TABLE;
DROP TABLE POSTACCUSE;
DROP TABLE MEMBERACCUSE;
DROP TABLE AUCTACCUSE;
DROP TABLE ADMINISTRATOR;
DROP TABLE BID;
DROP TABLE AUCT;
DROP TABLE PRODUCT_ORDER_LIST;
DROP TABLE PRODUCT_ORDER;
drop table GRO_ORDER;
DROP TABLE ORDSTAT;
drop table FAVOURITE_GRO;
drop table GRO_MEM;
drop table GROUPBUY;
drop table REBATE;
DROP TABLE CUSTOMER_MESSAGE;
DROP TABLE ONE_TO_ONE;
DROP TABLE FAVOURITE_BOUNS;
DROP TABLE BOUNS_ORDER;
DROP TABLE BOUNS_STATE;
DROP TABLE BOUNS_MALL;
DROP TABLE DISCOUNT_LIST;
DROP TABLE FAVOURITE_PRODUCT;
DROP TABLE PRODUCT;
DROP TABLE DISCOUNT;
DROP TABLE PRODUCT_TYPE;
DROP TABLE COMM;
DROP TABLE FAVORITE_POST;
DROP TABLE POST;
DROP TABLE PTYPE;
DROP TABLE MEMBER;

DROP SEQUENCE BID_SEQ;
DROP SEQUENCE AUCT_SEQ;
DROP SEQUENCE ORDSTAT_SEQ;
drop sequence GROUPBUY_seq;
drop sequence REBATE_seq;
drop sequence GRO_ORDER_seq;
DROP SEQUENCE CM_SEQ;
DROP SEQUENCE CR_SEQ;
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE SEQ_DIS_ID ;
DROP SEQUENCE SEQ_ORESTAT_ID ;
DROP SEQUENCE SEQ_P_ID;
DROP SEQUENCE SEQ_PO_ID;
DROP SEQUENCE POST_SEQ;
DROP SEQUENCE COMM_SEQ;
DROP SEQUENCE PTYPE_SEQ;
DROP SEQUENCE BOUNS_STATE_SEQ;
DROP SEQUENCE BOUNS_MALL_SEQ;
DROP SEQUENCE BOUNS_ORDER_SEQ;
DROP SEQUENCE POSTACCUSE_SEQ;
DROP SEQUENCE MEMBERACCUSE_SEQ;
DROP SEQUENCE AUCTACCUSE_SEQ;
DROP SEQUENCE ADMINISTRATOR_SEQ;
DROP SEQUENCE FEATURES_SEQ;

--DROP TABLE BEFORE CREATING
----------------------------------------------------------

ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-mm-dd';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'yyyy-mm-dd hh24:mi:ss';

-----------------------------TABLE-----------------------------

CREATE TABLE MEMBER(
    MEM_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    MEM_EMAIL VARCHAR2(30) UNIQUE NOT NULL,
    MEM_PASS VARCHAR2(30) NOT NULL,
    MEM_NAME VARCHAR2(50),
    MEM_ICON BLOB,
    MEM_PHONE VARCHAR2(30),
    MEM_ADDR VARCHAR2(200),
    BANK_ACC VARCHAR2(30),
    CARD_NO VARCHAR2(16),
    CARD_YY VARCHAR2(4),
    CARD_MM VARCHAR2(2),
    CARD_SEC VARCHAR2(3),
    MEM_AUTHO NUMBER(2) NOT NULL,
    MEM_BONUS NUMBER(30),
    MEM_JOINDAT DATE DEFAULT CURRENT_TIMESTAMP,
    MEM_BIRTH DATE,
    MEM_WARN NUMBER(30)
);

CREATE TABLE ADMINISTRATOR (
 ADM_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 ADM_ACCO               VARCHAR2(30),
 ADM_PASS               VARCHAR2(30),
 ADM_NAME               VARCHAR2(30),
 ADM_STATE              NUMBER(2)
 );
 
 CREATE TABLE FEATURES_TABLE (
 F_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 F_TYPE               VARCHAR2(30)
 );
 
 CREATE TABLE AUTHORITY_TABLE (
 ADM_NO             VARCHAR2(30) NOT NULL,
 F_NO               VARCHAR2(30) NOT NULL,
 PRIMARY KEY(ADM_NO,F_NO),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO),
 FOREIGN KEY(F_NO)REFERENCES FEATURES_TABLE(F_NO)
 );

CREATE TABLE CUSTOMER_MESSAGE(
CM_ID VARCHAR2(30) not null PRIMARY KEY,
CM_TIME TIMESTAMP DEFAULT current_timestamp,
CM_WORD clob,
CM_PIC blob,
CM_STATUS NUMBER(1),
CM_CUSTOMERID VARCHAR2(30) references MEMBER(MEM_ID)
);

CREATE TABLE ONE_TO_ONE(
CR_ID VARCHAR2(30) not null PRIMARY KEY,
USER_ONE VARCHAR2(30) references MEMBER(MEM_ID),
USER_TWO VARCHAR2(30) references MEMBER(MEM_ID),
CR_TIME TIMESTAMP DEFAULT current_timestamp,
CR_WORD clob,
CR_PIC blob,
CR_STATUS NUMBER(1)
);

CREATE TABLE PTYPE(
    PTYPE_ID NUMBER(30) PRIMARY KEY NOT NULL,
    TYPE VARCHAR2(30)
);

CREATE TABLE POST(
    POST_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    MEM_ID VARCHAR2(30) NOT NULL,
    PTYPE_ID NUMBER(30) NOT NULL,
    P_STATUS NUMBER(1) NOT NULL,
    P_TITLE VARCHAR2(200) NOT NULL,
    TEXT CLOB NOT NULL,
    IMAGE BLOB,
    LAST_EDIT TIMESTAMP,
    POST_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_POST_MEMBER
    FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID),
    CONSTRAINT FK_POST_PTYPE
    FOREIGN KEY (PTYPE_ID) REFERENCES PTYPE(PTYPE_ID)
);

CREATE TABLE COMM(
    COMM_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    POST_ID VARCHAR2(30) NOT NULL,
    MEM_ID VARCHAR2(30) NOT NULL,
    C_STATUS NUMBER(1) NOT NULL,
    TEXT CLOB NOT NULL,
    LAST_EDIT TIMESTAMP,
    POST_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_COMM_POST
    FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID),
    CONSTRAINT FK_COMM_MEMBER
    FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID)
);

CREATE TABLE FAVORITE_POST(
    MEM_ID VARCHAR2(30),
    POST_ID VARCHAR2(30),
    CONSTRAINT PK_FAV
    PRIMARY KEY (MEM_ID, POST_ID),
    CONSTRAINT FK_FAV_MEMBER
    FOREIGN KEY (MEM_ID) REFERENCES MEMBER(MEM_ID),
    CONSTRAINT FK_FAV_POST
    FOREIGN KEY (POST_ID) REFERENCES POST(POST_ID)
);

CREATE TABLE PRODUCT_TYPE(
    PT_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
    TYPENAME VARCHAR2(30)
);

CREATE TABLE ORDSTAT(
    ORDSTAT_ID VARCHAR2(3) PRIMARY KEY NOT NULL,
    ORDSTAT    VARCHAR2(20)
);

CREATE TABLE DISCOUNT(
    DIS_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
    DIS_NAME VARCHAR2(40),
    STAR_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    END_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PRODUCT(
    P_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
    PT_ID VARCHAR2(10) REFERENCES PRODUCT_TYPE(PT_ID) NOT NULL,
    P_NAME VARCHAR2(40),
    P_PRICE NUMBER,
    P_IMAGE BLOB,
    P_INFO CLOB,
    P_SALES NUMBER,
    P_STOCK NUMBER,
    P_ADD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    P_STAT NUMBER
);

CREATE TABLE FAVOURITE_PRODUCT(
    P_ID VARCHAR2(10) REFERENCES PRODUCT(P_ID)  NOT NULL,
    MEM_ID VARCHAR(10) REFERENCES MEMBER(MEM_ID)  NOT NULL,
    PRIMARY KEY(P_ID,MEM_ID)
);

CREATE TABLE PRODUCT_ORDER(
    PO_ID VARCHAR2(20) PRIMARY KEY NOT NULL,
    MEM_ID VARCHAR2(20) REFERENCES MEMBER(MEM_ID),
    ORDSTAT_ID VARCHAR2(3) REFERENCES ORDSTAT(ORDSTAT_ID),
    ADD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    RETURN_FORM CLOB
);

CREATE TABLE PRODUCT_ORDER_LIST(
    PO_ID VARCHAR2(20) REFERENCES PRODUCT_ORDER(PO_ID)  NOT NULL,
    P_ID VARCHAR2(10) REFERENCES PRODUCT(P_ID)  NOT NULL,
    ORDER_QUA NUMBER,
    P_PRICE NUMBER,
    PRIMARY KEY(PO_ID,P_ID)
);

CREATE TABLE DISCOUNT_LIST(
    P_ID VARCHAR2(10) REFERENCES PRODUCT(P_ID)  NOT NULL,
    DIS_ID VARCHAR2(10) REFERENCES DISCOUNT(DIS_ID)  NOT NULL,
    DIS_PRICE NUMBER,
    PRIMARY KEY(P_ID,DIS_ID)
);

CREATE TABLE BOUNS_STATE(
    BS_ID VARCHAR2(5) PRIMARY KEY NOT NULL,
    BS_STAT VARCHAR2(50)
);

CREATE TABLE BOUNS_MALL (
    BON_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    PT_ID VARCHAR2(10) NOT NULL,
    CONSTRAINT FK_BOUNS_MALL_PRODUCT_TYPE FOREIGN KEY ( PT_ID )
        REFERENCES PRODUCT_TYPE ( PT_ID ),
    BON_NAME VARCHAR2(100) NOT NULL,
    BON_PRICE NUMBER(20) CHECK ( BON_PRICE >= 0 ),
    BON_IMAGE BLOB,
    BON_INFO VARCHAR2(4000) NOT NULL,
    BON_EXCHANGE NUMBER(10) CHECK ( BON_EXCHANGE >= 0 ),
    BON_STOCK NUMBER(10) NOT NULL CHECK ( BON_STOCK >= 0 ),
    BON_ADDDATE DATE DEFAULT CURRENT_TIMESTAMP,
    BON_STATUS VARCHAR2(5) NOT NULL
);

CREATE TABLE BOUNS_ORDER(
    ORD_ID VARCHAR2(30) PRIMARY KEY NOT NULL,
    MEM_ID VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_BOUNS_ORDER_MEMBER FOREIGN KEY ( MEM_ID )
        REFERENCES MEMBER ( MEM_ID ),
    BON_ID VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_BOUNS_ORDER_BONUS_MALL FOREIGN KEY ( BON_ID )
        REFERENCES BOUNS_MALL ( BON_ID ),
    ORD_DATE DATE DEFAULT CURRENT_TIMESTAMP,
    BS_ID VARCHAR2(5),
    CONSTRAINT FK_BONUS_ORDER_BOUNS_STATE FOREIGN KEY ( BS_ID )
        REFERENCES BOUNS_STATE ( BS_ID )
);

CREATE TABLE FAVOURITE_BOUNS(
    MEM_ID VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_FAVOURITE_BOUNS_MEMBER FOREIGN KEY ( MEM_ID )
        REFERENCES MEMBER ( MEM_ID ),
    BON_ID VARCHAR2(30) NOT NULL,
    CONSTRAINT FK_FAVOURITE_BOUNS_BOUNS_MALL FOREIGN KEY ( BON_ID )
        REFERENCES BOUNS_MALL ( BON_ID )
);

CREATE TABLE AUCT (
    AUCT_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
    SALE_ID VARCHAR2(7) NOT NULL,   
    BUY_ID VARCHAR2(7),
    PT_ID VARCHAR2(10),
    AUCT_NAME VARCHAR2(200) NOT NULL,
    AUCT_START TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    AUCT_END TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ORD_END TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    IMMED_PRC NUMBER(20),
    AUCT_PRC NUMBER(20),
    AUCT_INC NUMBER(10),
    AUCT_DESC CLOB,
    AUCT_PIC BLOB,
    AUCT_SOLD NUMBER(5),
    AUCT_DOWN NUMBER(5),
    ORDSTAT_ID VARCHAR2(10),
    ORD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PAY_END TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    RCPT_NAME VARCHAR2(50),
    RCPT_CEL VARCHAR2(30),
    RCPT_ADD VARCHAR2(200),
    CONSTRAINT FK1_AUCT_MEMBER
    FOREIGN KEY (SALE_ID) REFERENCES MEMBER (MEM_ID),
    CONSTRAINT FK2_AUCT_MEMBER
    FOREIGN KEY (BUY_ID) REFERENCES MEMBER (MEM_ID),
    CONSTRAINT FK3_AUCT_PRODUCT_TYPE
    FOREIGN KEY (PT_ID) REFERENCES PRODUCT_TYPE (PT_ID),
    CONSTRAINT FK4_AUCT_ORDSTAT
    FOREIGN KEY (ORDSTAT_ID) REFERENCES ORDSTAT(ORDSTAT_ID)
 );
 
CREATE TABLE BID(
    BID_ID VARCHAR2(9) NOT NULL,
    AUCT_ID VARCHAR2(10) NOT NULL,
    BUY_ID VARCHAR2(7) NOT NULL,
    BID_PRC NUMBER(20) NOT NULL,
    BID_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP ,
    BID_WIN NUMBER(10) NOT NULL,
    CONSTRAINT PK_BID PRIMARY KEY (BID_ID),
    CONSTRAINT FK1_BID_AUCT
    FOREIGN KEY (AUCT_ID) REFERENCES AUCT (AUCT_ID),
    CONSTRAINT FK2_BID_MEMBER
    FOREIGN KEY (BUY_ID) REFERENCES MEMBER (MEM_ID)
);

CREATE TABLE REBATE (
  REB_NO VARCHAR2(10) PRIMARY KEY NOT NULL,
  DISCOUNT NUMBER(10),
  PEOPLE VARCHAR2(10)
);

CREATE TABLE GROUPBUY(
GRO_ID VARCHAR2(10) constraint groupbuy_grono_pk primary key,
START_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
END_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
GROTIME_DATE NUMBER,
STATUS NUMBER(20) default 0,
PEOPLE VARCHAR2(10),
MONEY NUMBER(20),
P_ID VARCHAR2(10) NOT NULL constraint product_p_id_fk references product(P_ID),
REB1_NO VARCHAR2(10)constraint rebate_reb1_no_fk references rebate(REB_NO),
REB2_NO VARCHAR2(10)constraint rebate_reb2_no_fk references rebate(REB_NO),
REB3_NO VARCHAR2(10)constraint rebate_reb3_no_fk references rebate(REB_NO)
);

CREATE TABLE GRO_ORDER (
  ORD_ID VARCHAR2(10) PRIMARY KEY NOT NULL,
  ADD_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  MEM_ID VARCHAR2(10)NOT NULL REFERENCES MEMBER(MEM_ID),
  GRO_ID VARCHAR2(10)NOT NULL REFERENCES GROUPBUY(GRO_ID),
  ORDSTAT_ID VARCHAR2(3)NOT NULL REFERENCES ORDSTAT(ORDSTAT_ID)
);

create table FAVOURITE_GRO(
	MEM_ID 	varchar2(10)	not null,
	GRO_ID	VARCHAR2(10)	not null,
	constraint FAVOURITE_GRO_mem_id_gro_id_pk primary key (MEM_ID,GRO_ID),
	constraint MEMBER_mem_id_fk foreign key (MEM_ID) references MEMBER (MEM_ID),
	constraint GROUPBUY_gro_id_fk foreign key (GRO_ID) references GROUPBUY (GRO_ID)
);

create table GRO_MEM(
	MEM_ID 	varchar2(10)not null,
	GRO_ID	VARCHAR2(10)not null,

	constraint GRO_MEM_MEM_ID_fk foreign key (MEM_ID) references MEMBER (MEM_ID),
	constraint GRO_MEM_gro_id_fk foreign key (GRO_ID) references groupbuy (GRO_ID),
    constraint GRO_MEM_MEM_ID_pk primary key(GRO_ID,MEM_ID)
);

CREATE TABLE POSTACCUSE (
 PSAC_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 MEM_ID                  VARCHAR2(30),
 POST_ID                 VARCHAR2(30),
 ADM_NO                  VARCHAR2(30),
 PSAC_CONTENT            CLOB,
 PSAC_STATE              NUMBER(3),
 FOREIGN KEY(MEM_ID)REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(MEM_ID)REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO)
);

CREATE TABLE MEMBERACCUSE (
 MEMAC_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 ADM_NO                   VARCHAR2(30),
 MEMAC_CONTENT            CLOB,
 MEMAC_STATE              NUMBER(3),
 MEM1_ID  VARCHAR2(30) REFERENCES MEMBER(MEM_ID),
 MEM2_ID  VARCHAR2(30) REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO)
);

CREATE TABLE AUCTACCUSE (
 AUCTAC_NO                 VARCHAR2(30) PRIMARY KEY NOT NULL,
 MEM_ID                    VARCHAR2(30),
 AUCT_ID                   VARCHAR2(10),
 ADM_NO                    VARCHAR2(30),
 AUCTAC_CONTENT            CLOB,
 AUCTAC_STATE              NUMBER(30),
 FOREIGN KEY(MEM_ID)REFERENCES MEMBER(MEM_ID),
 FOREIGN KEY(AUCT_ID)REFERENCES AUCT(AUCT_ID),
 FOREIGN KEY(ADM_NO)REFERENCES ADMINISTRATOR(ADM_NO)
 );
 
create table question(
QA_ID VARCHAR2(10) not null PRIMARY KEY,
ANS clob,
QUE clob
);

-----------------------------TABLE-----------------------------

-----------------------------SEQUENCE-----------------------------

CREATE SEQUENCE MEMBER_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE SEQ_DIS_ID 
INCREMENT BY 1 
START WITH 1 
NOMAXVALUE
;

CREATE SEQUENCE SEQ_ORESTAT_ID 
INCREMENT BY 1 
START WITH 1  
NOMAXVALUE 
;
CREATE SEQUENCE SEQ_P_ID 
INCREMENT BY 1 
START WITH 1 
NOMAXVALUE
;
CREATE SEQUENCE SEQ_PO_ID 
INCREMENT BY 1 
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE PTYPE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE POST_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE COMM_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE CM_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE CR_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE BOUNS_STATE_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
;

CREATE SEQUENCE BOUNS_MALL_SEQ
START WITH 1
INCREMENT BY 1
;

CREATE SEQUENCE BOUNS_ORDER_SEQ
START WITH 1
INCREMENT BY 1
;

CREATE SEQUENCE ORDSTAT_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE AUCT_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;

CREATE SEQUENCE BID_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
;




create sequence REBATE_seq
increment by 1
start with 1
nomaxvalue
nocycle
nocache
;

create sequence GROUPBUY_seq
increment by 1
start with 1
nomaxvalue
nocycle
nocache
;

create sequence GRO_ORDER_seq
increment by 1
start with 1
nomaxvalue
nocycle
nocache
;

CREATE SEQUENCE ADMINISTRATOR_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;
 
 CREATE SEQUENCE FEATURES_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;
 
CREATE SEQUENCE POSTACCUSE_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE 
 ;
 
 CREATE SEQUENCE MEMBERACCUSE_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;
 
 CREATE SEQUENCE AUCTACCUSE_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 ;

-----------------------------SEQUENCE-----------------------------

-----------------------------新增會員-----------------------------

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'servereDiarrhea@gmail.com', '123456', '早餐店大冰奶', '0912345678', '桃園市中壢區中大路300號', '121234512345', '1234567898765432', '2028', '11', '876', 2, 5000, to_date('1970-01-01', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'pg18Guardian@gmail.com', '123456', '十八禁銅人', '0987654321', '桃園市中壢區三光路115號', '43215678912345', '9876123476545678', '2023', '04', '551', 2, 499, to_date('1970-01-02', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'neutralVoter@gmail.com', '123456', '中壢李姓選民', '0923456789', '桃園市中壢區健行路229號', '843257564928', '7364856382659380', '2021', '06', '366', 2, 16888, to_date('1970-01-03', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'alBacino@gmail.com', '123456', '艾爾不怕西諾', '0934567890', '桃園市中壢區林森路95號', '47584776534274', '5828565532195890', '2011', '02', '313', 2, 23999, to_date('1970-01-04', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'tomohisaAtFGS@gmail.com', '123456', '金寶山下製酒', '0945678901', '桃園市中壢區元化路357號', '8475875947599', '5638449676900713', '2028', '10', '335', 2, 33666, to_date('1970-01-05', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'johnCenan@gmail.com', '123456', '江西男', '0956789012', '桃園市平鎮區振興路2號', '334785769930', '2274388900216475', '2031', '10', '585', 2, 66666, to_date('1970-01-06', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'iPadWarmWater@gmail.com', '123456', '一定iPad溫開水', '0967890123', '桃園市平鎮區環南路三段100號', '54909483775894', '1385966849604958', '2024', '05', '984', 2, 55123, to_date('1970-01-07', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'ayalReallyStrict@gmail.com', '123456', '阿粵真der很嚴格', '0978901234', '桃園市中壢區廣州路25號', '447384758672', '6485938495069485', '2029', '12', '374', 2, 123456, to_date('1970-01-08', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, BANK_ACC, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'fiveSpeedMouth@gmail.com', '123456', '投資一定有風險', '0989012345', '桃園市中壢區龍東路750號', '31326654694948', '8377586849586757', '2026', '08', '394', 2, 23456, to_date('1970-01-09', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'fiveSpeedMouth2@gmail.com', '123456', '基金投資有賺有賠', '0990123456', '桃園市八德區山下街115號', '3948586948594739', '2023', '04', '118', 1, 34567, to_date('1970-01-10', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, CARD_NO, CARD_YY, CARD_MM, CARD_SEC, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'prospectus@gmail.com', '123456', '申購前應詳閱公開說明書', '0901234567', '桃園市八德區廣德里18鄰廣興路601巷25號', '8374857687748576', '2022', '09', '368', 1, 45678, to_date('1970-01-11', 'yyyy-mm-dd'), 0);

INSERT INTO member 
(MEM_ID, MEM_EMAIL, MEM_PASS, MEM_NAME, MEM_PHONE, MEM_ADDR, MEM_AUTHO, MEM_BONUS, MEM_BIRTH, MEM_WARN)
VALUES 
('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'), 'admin@gmail.com', '123456', '平台管理員', '0901234567', '桃園市中壢區華勛街363巷', 1, 50000, to_date('1970-01-12', 'yyyy-mm-dd'), 0);

-----------------------------新增會員-----------------------------

-----------------------------新增管理員-----------------------------

INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'DAVID','123456','DAVID',1);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'JAMES','168888','JAMES',1);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'JIM','080808','JIM',0);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'JOHN','567890','JOHN',1);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'JUDY','556656','JUDY',1);
INSERT INTO ADMINISTRATOR VALUES ('ad'||LPAD(to_char(administrator_seq.NEXTVAL),6,'0'),'ALICE','878787','ALICE',1);

-----------------------------新增管理員-----------------------------

-----------------------------新增管理員功能-----------------------------

INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'新增帳號/密碼');
INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'修改帳號/密碼');
INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'修改會員檢舉案狀態');
INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'修改文章檢舉案狀態');
INSERT INTO FEATURES_TABLE VALUES ('f'||LPAD(to_char(features_seq.NEXTVAL),6,'0'),'修改商品檢舉案狀態');

-----------------------------新增管理員功能-----------------------------

-----------------------------新增管理員權限-----------------------------

INSERT INTO AUTHORITY_TABLE VALUES ('ad000001','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000003','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000004','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000005','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000002','f000002');
INSERT INTO AUTHORITY_TABLE VALUES ('ad000006','f000002');

-----------------------------新增管理員權限-----------------------------

---商品分類 PRODUCT_TYPE---

INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('1',3,'0'),'Switch主機');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('2',3,'0'),'Switch遊戲');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('3',3,'0'),'Switch周邊');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('4',3,'0'),'PS4主機');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('5',3,'0'),'PS4遊戲');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('6',3,'0'),'PS4周邊');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('7',3,'0'),'XBOX主機');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('8',3,'0'),'XBOX遊戲');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('9',3,'0'),'XBOX周邊');
INSERT INTO PRODUCT_TYPE(PT_ID,TYPENAME)
VALUES('PT'||LPAD('10',3,'0'),'其他');

---商品分類 PRODUCT_TYPE---

---限時優惠專案 DISCOUNT---

INSERT INTO DISCOUNT(DIS_ID,DIS_NAME,STAR_DATE,END_DATE)
VALUES('DIS'||LPAD(TO_CHAR(SEQ_DIS_ID.NEXTVAL),3,'0'),'單身狗優惠','2020-11-11','2020-11-12');
INSERT INTO DISCOUNT(DIS_ID,DIS_NAME,STAR_DATE,END_DATE)
VALUES('DIS'||LPAD(TO_CHAR(SEQ_DIS_ID.NEXTVAL),3,'0'),'爸爸節優惠','2020-08-08','2020-08-09');
INSERT INTO DISCOUNT(DIS_ID,DIS_NAME,STAR_DATE,END_DATE)
VALUES('DIS'||LPAD(TO_CHAR(SEQ_DIS_ID.NEXTVAL),3,'0'),'聖誕節優惠','2020-12-25','2020-12-26');

---限時優惠專案 DISCOUNT---

---商城商品 PRODUCT---

INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT001','Nintendo Switch',9780,'
▉ 可遊玩時間加長!!!

▉ 遊戲生活變得更加互動

▉ 改變形態多種遊戲模式：TV模式、桌上模式、手提模式

▉ 最多連線8台主機，進行對戰或協力遊戲

▉ Joy-Con內置「HD震動」體驗逼真細膩臨場感

▉ 台灣公司貨，提供1年保固'
,2,10,1);

INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT002','集合啦！動物森友會',1790,'
主機平台：Nintendo Switch ( NS )

遊戲類型：其他

發售日期：2020-03-20

遊戲人數：多人

作品分級：保護級

製作廠商：Nintendo

發行廠商：Nintendo

代理廠商：香港任天堂

官方網站：https://www.nintendo.tw/switch/animal_crossing_new_horizons/'
,3,10,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT003','動物之森 支架 for Nintendo Switch ',550,'
■ Nintendo Switch 專用桌上型支架

■ 18mm超輕巧NS螢幕立架可折疊、輕巧好攜帶、三段式角度調整

■ 貼心充電孔、可一邊充電一邊遊玩'
,1,10,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT004','PS4 Pro 專業版 主機 極致黑 1TB',12980,'
■全新CUH-7200系列

■硬體容量為1TB

■支援 4K 超高解析度

■PS4 遊戲均以1080p 解像度呈現

■支援已發售及將會發售的所有PS4遊戲'
,5,10,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT005','湯姆克蘭西：全境封鎖 2',590,'
主機平台：PS4

遊戲類型：射擊

發售日期：2019年預定

遊戲人數：多人

作品分級：CERO D

製作廠商：Massive Entertainment

發行廠商：Ubisoft

官方網站：https://tomclancy-thedivision.ubisoft.com/game/en-gb/home'
,2,10,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT006','原廠無線手把',1780,'
適用於電腦和Xbox One

有線控制器

舒適度及操作度提升',3,10,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT007','Xbox One S',7980,'
▉ 全面數位化，個人遊戲庫

▉ 超值的價錢 豐富的遊戲和娛樂

▉ 效能依然強悍，支援4K與HDR

▉ 內含3款遊戲

▉ 本主機無藍光光碟機'
,4,10,1);
INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT008','絕地求生',839,'
遊戲類型：射擊

發售日期：2017-12-12

遊戲人數：多人

作品分級：CERO D

製作廠商：Bluehole,PlayerUnknown''s Battle Royale G

發行廠商：Microsoft Studios

代理廠商：台灣微軟

官方網站：https://playbattlegrounds.com/'
,1,10,1);

INSERT INTO PRODUCT(P_ID,PT_ID,P_NAME,P_PRICE,P_INFO,P_SALES,P_STOCK,P_STAT)
VALUES('P'||LPAD(TO_CHAR(SEQ_P_ID.NEXTVAL),3,'0'),'PT009','Xbox One 無線控制器(黑色)',1549,'
適用於電腦和Xbox One

有線控制器

舒適度及操作度提升',0,10,1);

---商城商品 PRODUCT---

---我的最愛．商城 FAVOURITE_PRODUCT---

INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P001','M000001');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P003','M000001');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P005','M000001');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P004','M000002');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P005','M000002');
INSERT INTO FAVOURITE_PRODUCT(P_ID,MEM_ID)
VALUES('P009','M000002');

---我的最愛．商城 FAVOURITE_PRODUCT---

-----------------------------新增訂單狀態種類-----------------------------

INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '訂單成立');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '待付款');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已付款,待出貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '未付款,待出貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已送達,待收貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已收貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已取消訂單');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '成立換貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '成立退貨');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '商品回收中');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '檢驗中');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '退款中');
INSERT INTO ORDSTAT (ORDSTAT_ID, ORDSTAT) VALUES (LPAD(to_char(ORDSTAT_SEQ.NEXTVAL), 3, '0'), '已退款');

-----------------------------新增訂單狀態種類-----------------------------

-----商城訂單 PRODUCT_ORDER---

INSERT INTO PRODUCT_ORDER(PO_ID,MEM_ID,ORDSTAT_ID)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||LPAD(TO_CHAR(SEQ_PO_ID.NEXTVAL),6,'0'),'M000001','002');
INSERT INTO PRODUCT_ORDER(PO_ID,MEM_ID,ORDSTAT_ID)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||LPAD(TO_CHAR(SEQ_PO_ID.NEXTVAL),6,'0'),'M000002','005');

-----商城訂單 PRODUCT_ORDER---

-----商城訂單明細 PRODUCT_ORDER_LIST---

INSERT INTO PRODUCT_ORDER_LIST(PO_ID,P_ID,ORDER_QUA,P_PRICE)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||'000001','P002',1,1790);
INSERT INTO PRODUCT_ORDER_LIST(PO_ID,P_ID,ORDER_QUA,P_PRICE)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||'000001','P003',1,550);
INSERT INTO PRODUCT_ORDER_LIST(PO_ID,P_ID,ORDER_QUA,P_PRICE)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||'000002','P005',1,590);
INSERT INTO PRODUCT_ORDER_LIST(PO_ID,P_ID,ORDER_QUA,P_PRICE)
VALUES(TO_CHAR(sysdate,'yyyy-mm-dd')||'-'||'000002','P009',2,1549);

-----商城訂單明細 PRODUCT_ORDER_LIST---

---限時優惠專案細項 DISCOUNT_LIST---

INSERT INTO DISCOUNT_LIST(P_ID,DIS_ID,DIS_PRICE)
VALUES('P001','DIS001',1111);
INSERT INTO DISCOUNT_LIST(P_ID,DIS_ID,DIS_PRICE)
VALUES('P002','DIS002',8888);
INSERT INTO DISCOUNT_LIST(P_ID,DIS_ID,DIS_PRICE)
VALUES('P003','DIS003',520);

---限時優惠專案細項 DISCOUNT_LIST---

-----------------------------新增文章類型-----------------------------

INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '心得');
INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '情報');
INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '閒聊');
INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '問題');
INSERT INTO ptype (ptype_id, type) VALUES (ptype_seq.NEXTVAL, '平台資訊');

-----------------------------新增文章類型-----------------------------

-----------------------------新增文章-----------------------------

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000001', 3, 1, '一直拉 從昨晚腹瀉了24小時怎麼辦？', '
大家好

我肥宅啦

昨天晚上突然猛拉

一開始覺得還好有點嚴重（我想說還好）

就吃新表飛鳴 跑去睡了

結果被屎意嚇醒 整床都是拉稀

昨天連續拉了一整天
好不容易晚上九點  控制一下 去看醫生

回家吃了一包藥 吃了雞湯粥

剛過十二點 想說睡覺時間差不多了

吃「一顆強力止瀉藥」

結果這短短一小時我又拉了四次

我是不是得到什麼病毒啊......

醫生也只說吃壞肚子而已嗚嗚嗚嗚
', SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000002', 3, 1, '為什麼才剛上班就有人在刷牙？', '
如題

為什麼才剛上班就有人在刷牙？

刷牙不是起床在家就刷玩了嗎？

同樣也是有人在上班剪指甲

在公司剪有什麼魔力嗎？

我很好奇
', SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000002', 3, 1, '8+9屁孩語錄有哪些？', '
大家安安

#Just do it

#莫忘初衷

#狼若回頭 不是報恩就是報仇

#OO在走 XX要有

8+9屁孩語錄還有哪些？
', SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000002', 3, 1, '只有台灣的牛排有麵嗎？', '
除了一些外國或高檔的餐廳以外

台灣本地不管是夜市或連鎖店、小牛排館的牛排大都是有附加麵的

台灣人從小也是很理所當然牛排有麵

但是其它國家的聽說都只有肉跟主菜而已，中國沒吃過不知道

有沒有全世界只有台灣的牛排有麵的八卦？
', SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000002', 3, 1, '在山上種田養豬雞牛羊自己自足要多少錢？', '
在山上，蓋間小屋，屋子四周，種田種地瓜馬玲薯各種菜葱薑蒜

再養些豬雞牛羊，想吃肉就殺一隻

過著盡量少花錢，自己自足的生活

從此不再被政客資本家銀行家剝削

醬要多少地多少錢啊

在山上種田養豬雞牛羊自己自足要多少錢？
', SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000001', 3, 1, '欸，白開水不是白色的啊？', '
長輩每次都說
你們小孩子啊，只會喝飲料
都不喝白開水

我想了想
不對啊

開水就不是白色的
是在白什麼？
', SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000001', 3, 1, '台南沙茶火鍋誰才是最強', '
乳啼

台南號稱美食聖地，是否有能屌打林聰明或是台中

汕頭沙茶鍋的沙茶火鍋呢？

小豪洲 和二月牌 夠格嗎？

還是又是我家巷口屌打？

有掛嗎？
', SYSDATE);

INSERT INTO post
(POST_ID, MEM_ID, PTYPE_ID, P_STATUS, P_TITLE, TEXT, LAST_EDIT)
VALUES
('POST'||LPAD(to_char(post_seq.NEXTVAL), 6, '0'), 'M000001', 3, 1, '出桶了該如何慶祝？！', '
大家晚安啊
是這樣的
我剛剛發現我出桶了

上個月因為不小心超貼問卦
所以被桶了一個月
真的是有夠智障

忍了一個月又可以在八卦發言
感覺真好
所以我該如何慶祝？
有卦嗎？
', SYSDATE);

-----------------------------新增文章-----------------------------

-----------------------------新增留言-----------------------------

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000001', 'M000002', 1, '真的學不到什麼東西 除非他玩蠻王之類的 不過大部分都練角 而且也很少看小地圖 也不會去預測jg位置 都是做效果居多 如果學他玩大機率會下去', SYSDATE);

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000001', 'M000005', 1, '謝謝各位的建議 我還在銅牌地獄慢慢往上爬....', SYSDATE);

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000001', 'M000002', 1, '這我覺得不行，他有些套路10場才成功一場，像是上路慨影，實況主都偏做效果', SYSDATE);

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000003', 'M000007', 1, '認同這個人跟玩遊戲是兩回事', SYSDATE);

INSERT INTO comm
(COMM_ID, POST_ID, MEM_ID, C_STATUS, TEXT, LAST_EDIT)
VALUES
('COMM'||LPAD(to_char(COMM_SEQ.NEXTVAL), 6, '0'), 'POST000003', 'M000006', 1, '經驗值曲線不知道有沒有調整,像上次一樣免費送大家幾星?', SYSDATE);

-----------------------------新增留言-----------------------------

-----------------------------新增收藏文章-----------------------------

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000001', 'POST000005');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000002', 'POST000003');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000003', 'POST000006');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000005', 'POST000002');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000008', 'POST000001');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000004', 'POST000007');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000002', 'POST000006');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000007', 'POST000006');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000008', 'POST000003');

INSERT INTO favorite_post
(MEM_ID, POST_ID)
VALUES
('M000010', 'POST000005');

-----------------------------新增收藏文章-----------------------------

-----------------------------新增CM-----------------------------
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000001','哈囉你好嗎請問方便嗎');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000002','哈囉你好嗎請問方便嗎');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000001','我要申訴');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000001','我買的東西壞掉了，我要退貨');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000001','請問怎麼上架商品到交易區');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),0,'M000002','在~~請問需要什麼服務嗎?');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),0,'M000001','在~~請問需要什麼服務嗎?');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),0,'M000003','
:┴┬┴┬／￣＼＿／￣＼
┬┴┬┴▏　　▏▔▔▔▔＼
┴┬┴／＼　／　　　　　　﹨
┬┴∕　　　　　　　／　　　）
┴┬▏　　　　　　　　●　　▏
┬┴▏　　　　　　　　　　　▔█◤
┴◢██◣　　　　　　 ＼＿＿／
┬█████◣　　　　　　　／
┴█████████████◣
◢██████████████▆▄
█◤◢██◣◥█████████◤＼
◥◢████　████████◤　　 ＼
┴█████　██████◤　　　　　 ﹨
┬│　　　│█████◤　　　　　　　　▏
┴│　　　│　　　　　　　　　　　　　　▏
┬∕　　　∕　　　　／▔▔▔＼　　　　 ∕
∕＿＿／﹨　　　∕　　　　　 ＼　　／＼
┬┴┬┴┬┴＼ 　　 ＼　　　　　﹨／　　﹨
┴┬┴┬┴┬┴ ＼＿＿＿＼　　　　 ﹨／▔＼﹨／▔＼
▲△▲▲╓╥╥╥╥╥╥╥╥＼　　 ∕　 ／▔﹨　／▔﹨
　＊＊＊╠╬╬╬╬╬╬╬╬＊﹨　　／　　／／　　／
（＼／）（＼／）＊＊　△▲▲﹨／＿＿／／＿＿');
insert into CUSTOMER_MESSAGE(CM_ID,CM_STATUS,CM_CUSTOMERID,CM_WORD) values('CM'||LPAD(to_char(cm_seq.NEXTVAL), 6, '0'),1,'M000003','
★︵＿＿＿︵☆
／　　　　　＼
︴●　　　●　︴大　家　天　天　快→樂　~
︴≡　﹏　≡　︴永　遠　幸　福　快　樂 唷　！～
＼＿＿＿＿＿／ 要　加　油　～～加　油！
╭灌水╮╭灌水╮╭灌水╮╭灌水╮
╰～～╯╰～～╯╰～～╯╰～～╯ ');

-----------------------------新增CM-----------------------------

-----------------------------新增CR-----------------------------
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'哈囉你好嗎請問方便嗎','M000001','M000002',1);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),
'☆ ．．．▍▍．☆█ ☆ ☆ ∵ ..../ .；☆
◥█▅▅██▅▅██▅▅▅▅▅██ ██ █ ◤
　◥███我開ㄌ一艘船來幫你灌水 ███◤
～~～~～~～~～~～~～～~～～～~～~～~～~～～~～~～','M000001','M000002',0);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'kono Dio ?','M000001','M000002',0);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'.............','M000001','M000002',1);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'
恩？＿＿＿＿＿
　／───　　＼
／　 ●　　───＼
︳　　　　　 ●    ︱
︳　　　　　　　  ︱
＼╭╮／＼　　　／
你｜╰－－－╮／有點
好｜　－┬－╯生氣哦
像｜　－╯','M000001','M000002',0);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'可以換個正常的人嗎?','M000001','M000002',1);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'我很正常喔','M000001','M000002',0);
insert into ONE_TO_ONE(CR_ID,CR_WORD,USER_ONE,USER_TWO,CR_STATUS) values('CR'||LPAD(to_char(CR_SEQ.NEXTVAL), 6, '0'),'那可以幫我取消那筆韓式烤肉醬的訂單嗎','M000001','M000002',1);

-----------------------------新增CR-----------------------------

-----------------------------新增紅利訂單狀態-----------------------------

INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '訂單成立' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '訂單取消' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '已出貨' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '已完成' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '待審核' );
INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT )
VALUES ( 'BS'||LPAD ( TO_CHAR( BOUNS_STATE_SEQ.NEXTVAL ) , 3 , '0' ) , '已退換' );

-----------------------------新增紅利訂單狀態-----------------------------

-----------------------------新增紅利商品-----------------------------

INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT005','碧藍幻想 Versus',169,'主機平台：PS4
遊戲類型：動作
發售日期：2020-02-06
遊戲人數：2人
作品分級：保護級
製作廠商：Arc System Works
發行廠商：Cygames
代理廠商：台灣世雅育樂
官方網站：https://versus.granbluefantasy.jp/',1,22,to_date('06-FEB-20','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT007','極限競速 7 終極版',279,'主機平台：XboxOne
遊戲類型：競速
發售日期：2017-10-03
遊戲人數：多人
作品分級：普遍級
製作廠商：Turn 10 Studios
發行廠商：Microsoft Game Studios
代理廠商：台灣微軟
官方網站：http://www.xbox.com/zh-TW/games/forza-7',1,33,to_date('03-OCT-17','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','RPG 製作大師 FES',165,'主機平台：3DS
遊戲類型：其他
發售日期：2016-11-24
遊戲人數：1人
作品分級：CERO A
製作廠商：KADOKAWA
發行廠商：KADOKAWA GAMES',1,13,to_date('24-NOV-16','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT005','Final Fantasy VII 重製版',179,'主機平台：PS4
遊戲類型：角色扮演
發售日期：2020-03-03
遊戲人數：1人
作品分級：輔12級
製作廠商：SQUARE ENIX
發行廠商：SQUARE ENIX
代理廠商：台灣索尼互動娛樂
官方網站：http://www.jp.square-enix.com/ffvii_remake/',1,47,to_date('03-MAR-20','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','瑪利歐賽車 8 豪華版',179,'主機平台：Nintendo Switch ( NS )
遊戲類型：競速
發售日期：2017-04-28
遊戲人數：多人
作品分級：保護級
製作廠商：任天堂株式会社
發行廠商：任天堂株式会社
代理廠商：展碁國際股份有限公司
官方網站：https://www.nintendo.co.jp/switch/aabpa/',2,50,to_date('28-APR-17','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','數碼寶貝世界 -Next Order-',169,'主機平台：PSV
遊戲類型：角色扮演
發售日期：2017-02-09
遊戲人數：1人
製作廠商：NAMCO BANDAI Games
發行廠商：NAMCO BANDAI Games',0,42,to_date('09-FEB-17','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','星之卡比 戰鬥豪華版！',135,'主機平台：3DS
遊戲類型：動作
發售日期：2017-11-30
遊戲人數：4人
作品分級：CERO A
製作廠商：HAL Laboratory
發行廠商：Nintendo
官方網站：https://www.nintendo.co.jp/3ds/aj8j/',2,11,to_date('30-NOV-17','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT002','航海王：海賊無雙 4 豪華版',259,'主機平台：Nintendo Switch ( NS )
遊戲類型：動作
發售日期：2020-03-26
遊戲人數：1人
作品分級：輔導級
發行廠商：BANDAI NAMCO Entertainment
代理廠商：台灣萬代南夢宮娛樂
官方網站：https://oppw4-20.bn-ent.net/',0,25,to_date('26-MAR-20','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT005','女神異聞錄 5 皇家版',179,'主機平台：PS4
遊戲類型：角色扮演
發售日期：2020-02-20
遊戲人數：1人
作品分級：輔導級
製作廠商：ATLUS
發行廠商：SEGA Games
代理廠商：台灣世雅育樂
官方網站：https://p5r.jp/',2,45,to_date('20-FEB-20','DD-MON-RR'),0);
INSERT INTO BOUNS_MALL
( BON_ID , PT_ID , BON_NAME , BON_PRICE , BON_INFO , BON_EXCHANGE , BON_STOCK , BON_ADDDATE , BON_STATUS )
VALUES
( 'B'||LPAD ( TO_CHAR ( BOUNS_MALL_SEQ.NEXTVAL ) , 6 , '0' ) , 'PT010','菲莉絲的鍊金工房 ～不可思議之旅的鍊金術士～',138,'主機平台：PSV
遊戲類型：角色扮演
遊戲人數：1人
作品分級：輔12級
製作廠商：GUST
發行廠商：KOEI TECMO GAMES
代理廠商：臺灣光榮特庫摩',0,47,to_date('02-NOV-16','DD-MON-RR'),0);

-----------------------------新增紅利商品-----------------------------

-----------------------------新增紅利訂單-----------------------------

INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000001','B000001',to_date('06-JUN-19','DD-MON-RR'),'BS004' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000002','B000002',to_date('16-JUL-19','DD-MON-RR'),'BS006' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000001','B000003',to_date('20-AUG-19','DD-MON-RR'),'BS004' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000001','B000004',to_date('24-SEP-19','DD-MON-RR'),'BS003' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000002','B000005',to_date('01-OCT-19','DD-MON-RR'),'BS005' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000003','B000007',to_date('13-NOV-19','DD-MON-RR'),'BS003' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000002','B000009',to_date('24-DEC-19','DD-MON-RR'),'BS001' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000003','B000005',to_date('14-JAN-20','DD-MON-RR'),'BS002' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000004','B000007',to_date('25-FEB-20','DD-MON-RR'),'BS001' );
INSERT INTO BOUNS_ORDER ( ORD_ID , MEM_ID , BON_ID , ORD_DATE , BS_ID )
VALUES
( 'BO'||LPAD ( TO_CHAR ( BOUNS_ORDER_SEQ.NEXTVAL ) , 8 , '0' ),'M000005','B000009',to_date('26-MAR-20','DD-MON-RR'),'BS001' );

-----------------------------新增紅利訂單-----------------------------

-----------------------------新增收藏紅利商品-----------------------------

INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000001' , 'B000001' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000001' , 'B000003' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000002' , 'B000002' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000003' , 'B000003' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000003' , 'B000004' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000002' , 'B000001' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000001' , 'B000002' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000011' , 'B000003' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000012' , 'B000004' );
INSERT INTO FAVOURITE_BOUNS ( MEM_ID , BON_ID ) VALUES ( 'M000001' , 'B000004' );

-----------------------------新增收藏紅利商品-----------------------------

-----------------------------新增交易區資料-----------------------------

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000001', null, 'PT002', '集合啦！動物森友會', to_timestamp('2020-06-04 12:52:42', 'syyyy-mm-dd hh24:mi:ss'), 
        to_timestamp('2020-06-18 12:52:42', 'syyyy-mm-dd hh24:mi:ss'), null, null, 1000, 50, '《動物森友會》系列最新作品《集合啦！動物森友會》將會重新詮釋動物森友會的傳統體驗方式。玩家將參加由 Nook Inc. 所策劃的「無人島移居計畫」，在以無人島為背景的遊戲中展開全新的生活。
在遊戲中可以悠閒地在海邊漫步、四處探索......在什麼都沒有的無人島展開自由自在的生活。另外，還有全新改造系統，讓玩家可以 DIY，將島上的材料收集起來，DIY 成家具及生活所需的道具等等。此外，還有園藝、釣魚、島上探索、居家環境佈置、與移居到島上的可愛動物們交流等多項體驗，讓玩家可以一面感受四季變化，一面享受悠閒生活。
下標前請先看關於我
特典內容依官方公佈,特典非所有軟體1:1,會依下標順序照排發放
不回答特典相關問題
預購商品會於3個工作天內出貨
超商取貨者商品約2-3天送達,宅配隔日送達(如遇國定例假日或特殊狀況依物流實際配送時間而定)', null, 0, 0, null, null, null, null, null, null);

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000002', null, 'PT004', ' PS4 Pro主機1TB 死亡擱淺同捆組，全新未拆，一元起標', to_timestamp('2020-05-12 18:03:58', 'syyyy-mm-dd hh24:mi:ss'), 
        to_timestamp('2020-05-26 18:03:58', 'syyyy-mm-dd hh24:mi:ss'), to_timestamp('2020-05-28 18:03:58', 'syyyy-mm-dd hh24:mi:ss'), null, 1000, 50, '朋友抽獎抽到的，託我幫售，歡迎面交
全新未拆，主機、配件該有的都有
手把是透明橘色的蠻好看', null, 1, 1, '006', to_timestamp('2020-05-27 22:07:30', 'syyyy-mm-dd hh24:mi:ss'), to_timestamp('2020-05-29 22:07:30', 'syyyy-mm-dd hh24:mi:ss'), '一定iPad溫開水', '0967890123', '桃園市平鎮區環南路三段100號');
  
----------------------  

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000003', null, 'PT002', 'Switch 巫師3 狂獵 完全版 中文版', to_timestamp('2020-07-22 10:05:30', 'syyyy-mm-dd hh24:mi:ss'),
       to_timestamp('2020-07-24 10:05:30', 'syyyy-mm-dd hh24:mi:ss'), null, null, 500, 50, '二手 台中南屯可面交', null, 0, 0, null, null, null, null, null, null);

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000004', null, 'PT001', 'Switch主機 動物森友會主機 電力加強版,全新未拆，一元起標!!!', to_timestamp('2020-07-21 23:06:35', 'syyyy-mm-dd hh24:mi:ss'),
       to_timestamp('2020-07-23 23:06:35', 'syyyy-mm-dd hh24:mi:ss'), null, null, 1, 1000, '＊單主機（沒有含遊戲）
 商品描述:
 1.電量加強版主機 ，遊戲時間加長!
2.最多連線8台主機，進行對戰或協力遊戲
 3.Joy-Con內置「HD震動」體驗逼真細膩臨場感
 4.多種遊戲模式：電視連接、掌上遊玩
                       
 盒裝內容物標準配備:
 Switch 主機1台
 Joy-Con(L)/( R) 各1支
 Switch 底座1個
 AC變壓器1個
 Joy-Con 握把1個
 Joy-Con 腕帶(黑色)1組
 HDMI Cable線 1條', null, 0,0, null, null, null, null, null, null);

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000006', null, 'PT001', '二手過保一般型switch 紅藍配色 盒裝配件完整', to_timestamp('2020-07-22 15:06:20', 'syyyy-mm-dd hh24:mi:ss'),
       to_timestamp('2020-07-24 15:06:20', 'syyyy-mm-dd hh24:mi:ss'), null, null, 6500, 500, '保存良好，8-9成新。外觀無明顯使用痕跡。
 可私訊聊聊看主機近照。
 功能皆正常，手把無飄移。附主機包。', null, 0,0, null, null, null, null, null, null);

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000004', null, 'PT005', 'PS4 魔物獵人 世界 Iceborne 中文版 亞版 全新未拆封', to_timestamp('2020-07-21 13:31:05', 'syyyy-mm-dd hh24:mi:ss'),
       to_timestamp('2020-07-23 13:31:05', 'syyyy-mm-dd hh24:mi:ss'), null, null, 750, 150, '全新未拆封 內附特典DLC［士林遊戲頻道］', null, 0, 0, null, null, null, null, null, null); 


INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000005', null, 'PT005', 'PS4 特惠遊戲組合包 惡靈古堡 2 重製版 + 噬神者3 中文版 全新品 現貨', to_timestamp('2020-07-21 11:21:37', 'syyyy-mm-dd hh24:mi:ss'),
       to_timestamp('2020-07-23 11:21:37', 'syyyy-mm-dd hh24:mi:ss'), null, null, 900, 100, '組合內容:
PS4 噬神者3
PS4 惡靈古堡 2 重製版
特典內容:(送完為止)
《惡靈古堡 2》豪華武器 “武士之刃 - 克里斯型”
《惡靈古堡 2》豪華武器 “武士之刃 - 吉兒型”
《惡靈古堡 2》PS4 專用佈景主題」', null, 0, 0, null, null, null, null, null, null);

INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000007', null, 'PT004', '二手主機 PS4 1207A 500G 主機', to_timestamp('2020-07-22 5:06:20', 'syyyy-mm-dd hh24:mi:ss'),
       to_timestamp('2020-07-24 5:06:20', 'syyyy-mm-dd hh24:mi:ss'), null, null, 6500, 50, '此為PS4 初代主機 型號1207賣場, 二手主機皆測試通過, 整理乾淨
點選商品選項, 就可以看到該主機的實品外觀

狀態：
主機狀態：二手主機皆測試通過, 配件齊全, 整理乾淨
主機顏色：請見商品選項
主機版本：6.50以上
主機容量：500G
保固狀態：1207為初代主機, 皆已無保固', null, 0, 0, null, null, null, null, null, null);


INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000003', null, 'PT009', 'XBOX 360 S 4GB 電玩主機 殺肉 零件機 肉雞 故障機', to_timestamp('2020-07-22 3:21:05', 'syyyy-mm-dd hh24:mi:ss'),
       to_timestamp('2020-07-24 3:21:05', 'syyyy-mm-dd hh24:mi:ss'), null, null, 250, 50, '2012出廠
開機鈕按下去有聲音，沒有燈號
含轉接線，主機板，機殼
一起賣300', null, 0, 0, null, null, null, null, null, null);


INSERT INTO AUCT (AUCT_ID, SALE_ID, BUY_ID, PT_ID, AUCT_NAME, AUCT_START, AUCT_END, ORD_END, IMMED_PRC, AUCT_PRC, AUCT_INC, AUCT_DESC, AUCT_PIC, AUCT_SOLD, AUCT_DOWN, ORDSTAT_ID, ORD_DATE, PAY_END, RCPT_NAME, RCPT_CEL, RCPT_ADD)
VALUES ('AUCT'||LPAD(to_char(AUCT_SEQ.NEXTVAL), 6, '0'), 'M000005', null, 'PT007', '3C XBOX ONE 360 CONSOLE 1540 1TB 黑色 /XBOX One Kinect 2.0', to_timestamp('2020-07-22 10:21:56', 'syyyy-mm-dd hh24:mi:ss'),
       to_timestamp('2020-07-24 10:21:56', 'syyyy-mm-dd hh24:mi:ss'), null, null, 5000, 500, '3C XBOX ONE 360 CONSOLE 1540 1TB 黑色 /XBOX One Kinect 2.0 體感主機/感應器/攝影機/控制器 

✔物品過大無法寄送超商
✔商品包含配件 附變壓器 附傳輸線 附電源線 附hdmi線 無其他配件
✔2手商品 功能都正常 物品過大無法寄送超商
✔2013年出廠已過原廠保固
✔兩個手把
✔所有商品沒有因為不能升級版本而退貨！
✔請麻煩看清楚商品照片以及商品狀況再確認才下單請勿隨意取消訂單 ', null, 0, 0, null, null, null, null, null, null);

-----------------------------新增交易區資料-----------------------------

-----------------------------新增競標出價資料-----------------------------

INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_DATE, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000001', 'M000002', 1150, to_timestamp('2020-06-13 22:34:20', 'syyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_DATE, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000001', 'M000003', 1200, to_timestamp('2020-06-15 09:10:40', 'syyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_DATE, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000006', 'M000007', 900, to_timestamp('2020-07-21 20:03:20', 'syyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_DATE, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000005', 'M000003', 7000, to_timestamp('2020-07-22 19:10:50', 'syyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_DATE, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000007', 'M000007', 1000, to_timestamp('2020-07-21 20:05:30', 'syyyy-mm-dd hh24:mi:ss'), 0);
INSERT INTO BID (BID_ID, AUCT_ID, BUY_ID, BID_PRC, BID_DATE, BID_WIN)
VALUES ('BID'||LPAD(to_char(BID_SEQ.NEXTVAL), 6, '0'), 'AUCT000006', 'M000005', 1050, to_timestamp('2020-07-21 22:10:30', 'syyyy-mm-dd hh24:mi:ss'), 0);

-----------------------------新增競標出價資料-----------------------------

-----------------------------新增折扣級距-----------------------------

INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '9','5');
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '8.5','10');
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '8','15');
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '9.5','5');
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '8.5','10');
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '8','15');
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '8.5','5');
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '7.8','10');
INSERT INTO REBATE(REB_NO, DISCOUNT, PEOPLE) VALUES ('R'||LPAD(REBATE_seq.NEXTVAL,9,'0'), '7.5','15');

-----------------------------新增折扣級距-----------------------------

-----------------------------新增團購案-----------------------------

INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME_DATE,PEOPLE,STATUS) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,9,'0'),'P001','R000000003','R000000009','R000000006','2020-8-01-16:30','2020-8-8-16:30',7,9,0);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME_DATE,PEOPLE,STATUS) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,9,'0'),'P002','R000000007','R000000008','R000000005','2020-11-11-13:20','2020-11-18-13:20',7,6,0);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME_DATE,MONEY,PEOPLE,STATUS) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,9,'0'),'P003','R000000003','R000000001','R000000002','2020-12-20-11:50','2020-12-27-11:50',7,666,20,1);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME_DATE,MONEY,PEOPLE,STATUS) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,9,'0'),'P004','R000000007','R000000006','R000000002','2020-10-20-11:50','2020-11-27-11:50',7,750,15,1);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME_DATE,PEOPLE,STATUS) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,9,'0'),'P005','R000000007','R000000002','R000000003','2020-11-15-12:00','2020-11-22-12:00',7,3,2);
INSERT INTO GROUPBUY(GRO_ID,P_ID,REB1_NO,REB2_NO,REB3_NO,START_DATE,END_DATE,GROTIME_DATE,PEOPLE,STATUS) VALUES ('G'||LPAD(GROUPBUY_seq.NEXTVAL,9,'0'),'P006','R000000003','R000000004','R000000005','2020-9-10-12:00','2020-9-17-12:00',7,2,2);

-----------------------------新增團購案-----------------------------

-----------------------------新增團購訂單-----------------------------

INSERT INTO GRO_ORDER(ORD_ID,MEM_ID,GRO_ID,ORDSTAT_ID,ADD_DATE) VALUES ('O'||LPAD(GRO_ORDER_seq.NEXTVAL,9,'0'),'M000001','G000000001','001','2020-8-8-16:30');
INSERT INTO GRO_ORDER(ORD_ID,MEM_ID,GRO_ID,ORDSTAT_ID,ADD_DATE) VALUES ('O'||LPAD(GRO_ORDER_seq.NEXTVAL,9,'0'),'M000002','G000000002','002','2020-11-18-13:20');
INSERT INTO GRO_ORDER(ORD_ID,MEM_ID,GRO_ID,ORDSTAT_ID,ADD_DATE) VALUES ('O'||LPAD(GRO_ORDER_seq.NEXTVAL,9,'0'),'M000003','G000000003','003','2020-12-12-09:20');
INSERT INTO GRO_ORDER(ORD_ID,MEM_ID,GRO_ID,ORDSTAT_ID,ADD_DATE) VALUES ('O'||LPAD(GRO_ORDER_seq.NEXTVAL,9,'0'),'M000004','G000000004','004','2020-12-20-18:26');

-----------------------------新增團購訂單-----------------------------

-----------------------------新增收藏團購-----------------------------

INSERT INTO FAVOURITE_GRO(MEM_ID,GRO_ID) VALUES ('M000001','G000000001');
INSERT INTO FAVOURITE_GRO(MEM_ID,GRO_ID) VALUES ('M000002','G000000002');
INSERT INTO FAVOURITE_GRO(MEM_ID,GRO_ID) VALUES ('M000003','G000000003');
INSERT INTO FAVOURITE_GRO(MEM_ID,GRO_ID) VALUES ('M000004','G000000004');

-----------------------------新增收藏團購-----------------------------

-----------------------------新增團購成員-----------------------------

INSERT INTO GRO_MEM(MEM_ID,GRO_ID) VALUES ('M000001','G000000001');
INSERT INTO GRO_MEM(MEM_ID,GRO_ID) VALUES ('M000002','G000000002');
INSERT INTO GRO_MEM(MEM_ID,GRO_ID) VALUES ('M000003','G000000003');
INSERT INTO GRO_MEM(MEM_ID,GRO_ID) VALUES ('M000004','G000000004');

-----------------------------新增團購成員-----------------------------

-----------------------------新增文章檢舉案-----------------------------

INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000001','POST000001','ad000006','圖文不符',1);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000002','POST000005','ad000004','置入性行銷',0);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000005','POST000003','ad000003','內容誇大不實',1);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000007','POST000004','ad000005','文章字數太少',0);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000003','POST000006','ad000001','含有色情內容',1);
INSERT INTO POSTACCUSE VALUES ('p'||LPAD(to_char(postaccuse_seq.NEXTVAL),6,'0'),'M000006','POST000002','ad000002','文字未排版',1);

-----------------------------新增文章檢舉案-----------------------------

-----------------------------新增會員檢舉案-----------------------------

INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000005','惡意言語攻擊',1,'M000003','M000001');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000002','上架不實商品',0,'M000001','M000006');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000001','亂標商品價格',1,'M000004','M000002');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000004','違規多次未停權',0,'M000005','M000007');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000003','言語帶有歧視',1,'M000003','M000008');
INSERT INTO MEMBERACCUSE VALUES ('ma'||LPAD(to_char(memberaccuse_seq.NEXTVAL),6,'0'),'ad000006','惡意競價',0,'M000001','M000004');

-----------------------------新增會員檢舉案-----------------------------

-----------------------------新增商品檢舉案-----------------------------

INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000003','AUCT000002','ad000004','商品毀損',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000005','AUCT000006','ad000003','價錢太高',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000004','AUCT000005','ad000001','與圖片差異太大',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000001','AUCT000004','ad000002','仿冒品',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000002','AUCT000003','ad000005','違禁品',1);
INSERT INTO AUCTACCUSE VALUES ('a'||LPAD(to_char(auctaccuse_seq.NEXTVAL),6,'0'),'M000007','AUCT000001','ad000006','含色情成分',1);

-----------------------------新增商品檢舉案-----------------------------

-----------------------------新增Q&A-----------------------------

insert into question(QA_ID,ANS,QUE) values('Q1','您於登入會員後，至『我的帳戶』→『訂單管理』查詢配送狀況，訂單狀態：配送中-表示已通知廠商出貨；已配送-表示廠商已送交郵局或貨運寄送。若您當時選擇首次購買，則於此頁面下方依訂單編號進行訂單查詢，一樣可以確認訂單配送狀態。','我要如何查詢配送進度？');
insert into question(QA_ID,ANS,QUE) values('Q2','您可以在填寫訂單資料時的收件人欄位，輸入您指定的送貨地址，有「速」標誌的商品皆可離島地區配送，(另有材積及重量限制)','我可以指定送貨地點嗎？');
insert into question(QA_ID,ANS,QUE) values('Q3','有「速」標誌商品皆可離島全區配送，單一商品材積限制：長+寬+高需低於120公分; 單一商品重量限制：需低於20公斤; 運費：每張訂單加收運費200元; 配送時間：約3個工作天。','請問可以離島配送嗎?');
insert into question(QA_ID,ANS,QUE) values('Q4','紅利金視同現金，每一點紅利金等同於新台幣一元，可使用於FSG(但不包含旅遊商品)、專人訂購、語音訂購，以紅利金兌換之商品，同樣可享有猶豫期等相關客戶權益。','什麼是紅利金？');
insert into question(QA_ID,ANS,QUE) values('Q5','FSG將會不定時於網站或購物台舉辦促銷活動，請您多多參考。行銷活動贈送之紅利金將以訂單之成立與否為給獎認定標準，若該筆訂單事後取消，本公司得主張扣回贈送之紅利金。','我要如何獲得紅利金？');
insert into question(QA_ID,ANS,QUE) values('Q6','您可以於客戶登入後，至『我的帳戶』→『紅利金管理』中查詢紅利金金額','我要如何查詢紅利金？');
insert into question(QA_ID,ANS,QUE) values('Q7','FSG包裝出貨已全程攝影，在您收到訂購商品時，我們隨貨為您附上了「商品明細表」，為確保消費者權益，請您於開啟商品外箱時全程攝影，依表核對包裝箱內的商品內容，若有不符或短少，請於24小時內於網頁「聯絡客服」中反應，由網路客服人員為您服務，我們將為您作紀錄並進行處理。商品明細表為退換貨憑證之一，請您在7天猶豫期內，妥善保管勿毀損丟棄。','收到商品後，我需要注意什麼事項，以確保我的購物權益呢？');
insert into question(QA_ID,ANS,QUE) values('Q8','若您發現商品有短缺的現象，請您至「客服中心」與我們聯絡。','如我收到商品有缺件，應該如何處理？');
insert into question(QA_ID,ANS,QUE) values('Q9','『我的帳戶』內包含了客戶資料修改、密碼修改、訂單查詢、紅利金管理、暫收款管理、折價券管理、中獎記錄、追蹤清單，利用以上的介面可查詢到個人的訂購狀況。','什麼是『我的帳戶』？');
insert into question(QA_ID,ANS,QUE) values('Q10','FSG可接受VISA、Master、JCB、銀聯卡等四家國際發卡組織之信用卡。 可使用分期付款之發卡銀行如下：台北富邦、中國信託、聯邦、日盛、永豐、遠東、安泰、第一、臺灣新光、大眾、國泰世華、澳盛、玉山、凱基、合作金庫、兆豐、花旗台灣、上海、陽信、渣打、台新、元大、華泰、台灣永旺、台灣中小企銀、匯豐、台中商銀、華南、三信等家，真正提供無息分期優惠。','信用卡付款有卡別或發卡銀行的限制嗎？');

-----------------------------新增Q&A-----------------------------

COMMIT;