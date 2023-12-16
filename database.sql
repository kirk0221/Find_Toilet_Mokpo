create sequence seq_board;

create table tbl_board (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate,
  replyCnt Number
);

alter table tbl_board add constraint pk_board 
primary key (bno);

create table tbl_reply (
  rno number(10,0), 
  bno number(10,0) not null,
  reply varchar2(1000) not null,
  replyer varchar2(50) not null, 
  replyDate date default sysdate, 
  updateDate date default sysdate
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply  add constraint fk_reply_board  
foreign key (bno)  references  tbl_board (bno); 

create table tbl_attach ( 
  uuid varchar2(100) not null,
  uploadPath varchar2(200) not null,
  fileName varchar2(100) not null, 
  filetype char(1) default 'I',
  bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid); 

alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);

create table users(
      username varchar2(50) not null primary key,
      password varchar2(50) not null,
      enabled char(1) default '1');

      
 create table authorities (
      username varchar2(50) not null,
      authority varchar2(50) not null,
      constraint fk_authorities_users foreign key(username) references users(username));
      
 create unique index ix_auth_username on authorities (username,authority);


insert into users (username, password) values ('user00','pw00');
insert into users (username, password) values ('member00','pw00');
insert into users (username, password) values ('admin00','pw00');

insert into authorities (username, authority) values ('user00','ROLE_USER');
insert into authorities (username, authority) values ('member00','ROLE_MANAGER'); 
insert into authorities (username, authority) values ('admin00','ROLE_MANAGER'); 
insert into authorities (username, authority) values ('admin00','ROLE_ADMIN');
commit;


select * from users;

select * from authorities order by authority;

create table tbl_member(
      userid varchar2(50) not null primary key,
      userpw varchar2(100) not null,
      username varchar2(100) not null,
      regdate date default sysdate, 
      updatedate date default sysdate,
      enabled char(1) default '1');


create table tbl_member_auth (
     userid varchar2(50) not null,
     auth varchar2(50) not null,
     constraint fk_member_auth foreign key(userid) references tbl_member(userid)
);

CREATE TABLE info (
    id NUMBER PRIMARY KEY,
    title VARCHAR2(50),
    lat NUMBER,
    lng NUMBER,
    address VARCHAR2(200),
    update_date date default sysdate
);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (0, '목포시청', 34.8118309291849, 126.39223316548866, '전라남도 목포시 양을로 203', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (1, '목포역', 34.79115650080805, 126.3866567192007, '전라남도 목포시 영산로 98', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (2, '목포 버스터미널', 34.8127853844176, 126.41783346036843, '전라남도 목포시 영산로 525', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (3, '달맞이공원', 34.79356511675937, 126.42632481851312, '전라남도 목포시 상동 1151', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (4, '평화광장 2호매점', 34.795866412135275, 126.43219310247406, '전라남도 목포시 상동 1157', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (5, '평화광장 1호매점', 34.796642363465, 126.43380500356332, '전라남도 목포시 상동 1157', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (6, '평화광장공원(평화다리 앞)', 34.798606885863315, 126.43855593182505, '전라남도 목포시 옥암동 1100', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (7, '카누경기장', 34.80180714456387, 126.44205027092681, '전라남도 목포시 옥암동 1375', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (8, '부흥산공원(만남의 폭포)', 34.803879761248666, 126.43897916066479, '전라남도 목포시 옥암동 538-12', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (9, '둥근근린공원(부흥동사무소옆)', 34.80430904140245, 126.43483720277274, '전라남도 목포시 옥암동 1021', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (10, '부영어린이공원(부영5차옆)', 34.803678153708624, 126.43437160089888, '전라남도 목포시 옥암동 1025', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (11, '입암산내등산로', 34.79738565536757, 126.42269509090625, '전라남도 목포시 상동 산102-33', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (12, '문화예술회관야외', 34.79209591430474, 126.42015875475134, '전라남도 목포시 용해동 924-1', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (13, '갓바위해양관광지', 34.793599886397665, 126.41798472854458, '전라남도 목포시 용해동 11-4', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (14, '중화어린이공원(상동현대@앞)', 34.811533070549416, 126.41467555506077, '전라남도 목포시 용해동 338-2', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (15, '수원지웰빙공원', 34.822366592286166, 126.41115033786713, '전라남도 목포시 상동 349-7', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (16, '용해어린이공원', 34.81902451757934, 126.39640208629959, '전라남도 목포시 용해동 998', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (17, '양을산체육공원', 34.811348322735654, 126.40584888582636, '전라남도 목포시 용해동 338-2', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (18, '양을체육(테니스)공원', 34.81183209812421, 126.40570060196379, '전라남도 목포시 용해동 산34-3', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (19, '동목포근린공원', 34.80945791698712, 126.39266588415155, '전라남도 목포시 용당동 881', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (20, '청호근린공원(동초등학교 밑)', 34.80753559164996, 126.3872512167638, '전라남도 목포시 산정동 267-13', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (21, '삼학도성당', 34.793303955333144, 126.39202221661502, '전라남도 목포시 산정동 1098-1', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (22, '삼학도중앙공연장', 34.78433107353347, 126.3943878848356, '전라남도 목포시 산정동 1487', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (23, '삼학도물양장', 34.785963356240615, 126.392278213345, '전라남도 목포시 산정동 1428', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (24, '연안여객선터미널 1층', 34.7820378061742, 126.3842141543786, '전라남도 목포시 항동 6-10', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (25, '국도시점놀이터(유달동)', 34.78709705243033, 126.38202142464473, '전라남도 목포시 대의동2가1-127', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (26, '인어바위', 34.78230101517544, 126.36872840625107, '전라남도 목포시 온금동 165-16', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (27, '유달유원지 B(원형)', 34.78773122547153, 126.3672912426623, '전라남도 목포시 죽교동 462', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (28, '유달유원지 A(기와)', 34.78811815703288, 126.36716263863914, '전라남도 목포시 죽교동 465-142', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (29, '북항물양장(2부두)', 34.80153832665657, 126.36383093640528, '전라남도 목포시 죽교동 674', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (30, '북항주차장', 34.8030535937114, 126.36790089017246, '전라남도 목포시 죽교동 620-112', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (31, '북항횟집거리', 34.80403539685983, 126.3668962058978, '전라남도 목포시 죽교동 620-225', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (32, '옥암지구 어린이공원', 34.80919207080617, 126.45654131618686, '전라남도 목포시 옥암동 1318', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (33, '대죽도근린공원', 34.8082445878687, 126.46087257567862, '전라남도 무안군 삼향읍 남악리 2286', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (34, '남악수변공원', 34.808295074613845, 126.46721910464056, '전라남도 무안군 삼향읍 남악리 2321', SYSDATE);

CREATE TABLE tbl_sequrity (
    code VARCHAR(50) PRIMARY KEY
);

INSERT INTO TBL_SEQURITY info (code) VALUES ('00000000');

CREATE TABLE tbl_favorite (
    infoid NUMBER,
    userid VARCHAR2(50)
);

-- infoid, score 열 추가
ALTER TABLE tbl_board ADD infoid NUMBER;
ALTER TABLE tbl_board ADD score NUMBER;
ALTER TABLE info ADD infoscore NUMBER;

-- 외래 키 제약 추가
ALTER TABLE tbl_board
ADD CONSTRAINT fk_tbl_board
FOREIGN KEY (infoid)
REFERENCES info(id);

--replycnt, score, infoscore 기본값 변경
ALTER TABLE TBL_BOARD
MODIFY replycnt NUMBER(10, 0) DEFAULT 0;
ALTER TABLE TBL_BOARD
MODIFY score NUMBER(3, 1) DEFAULT 0;
ALTER TABLE INFO
MODIFY infoscore NUMBER(3, 1) DEFAULT 0;
