DROP TABLE FAVOURITE_BOUNS;
DROP TABLE BOUNS_ORDER;
DROP TABLE BOUNS_STATE;
DROP TABLE BOUNS_MALL;
DROP SEQUENCE BOUNS_STATE_SEQ;
DROP SEQUENCE BOUNS_MALL_SEQ;
DROP SEQUENCE BOUNS_ORDER_SEQ;

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

CREATE SEQUENCE BOUNS_STATE_SEQ
START WITH 1
INCREMENT BY 1;

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

--INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT ) VALUES ( BOUNS_STATE_SEQ.NEXTVAL , '訂單成立' );
--INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT ) VALUES ( BOUNS_STATE_SEQ.NEXTVAL , '訂單取消' );
--INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT ) VALUES ( BOUNS_STATE_SEQ.NEXTVAL , '已出貨' );
--INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT ) VALUES ( BOUNS_STATE_SEQ.NEXTVAL , '已完成' );
--INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT ) VALUES ( BOUNS_STATE_SEQ.NEXTVAL , '待審核' );
--INSERT INTO BOUNS_STATE ( BS_ID , BS_STAT ) VALUES ( BOUNS_STATE_SEQ.NEXTVAL , '已退換' );

CREATE SEQUENCE BOUNS_MALL_SEQ
START WITH 1
INCREMENT BY 1;

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

CREATE SEQUENCE BOUNS_ORDER_SEQ
START WITH 1
INCREMENT BY 1;

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
