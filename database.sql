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
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (0, '������û', 34.8118309291849, 126.39223316548866, '���󳲵� ������ ������ 203', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (1, '������', 34.79115650080805, 126.3866567192007, '���󳲵� ������ ����� 98', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (2, '���� �����͹̳�', 34.8127853844176, 126.41783346036843, '���󳲵� ������ ����� 525', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (3, '�޸��̰���', 34.79356511675937, 126.42632481851312, '���󳲵� ������ �� 1151', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (4, '��ȭ���� 2ȣ����', 34.795866412135275, 126.43219310247406, '���󳲵� ������ �� 1157', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (5, '��ȭ���� 1ȣ����', 34.796642363465, 126.43380500356332, '���󳲵� ������ �� 1157', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (6, '��ȭ�������(��ȭ�ٸ� ��)', 34.798606885863315, 126.43855593182505, '���󳲵� ������ ���ϵ� 1100', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (7, 'ī�������', 34.80180714456387, 126.44205027092681, '���󳲵� ������ ���ϵ� 1375', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (8, '��������(������ ����)', 34.803879761248666, 126.43897916066479, '���󳲵� ������ ���ϵ� 538-12', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (9, '�ձٱٸ�����(���ﵿ�繫�ҿ�)', 34.80430904140245, 126.43483720277274, '���󳲵� ������ ���ϵ� 1021', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (10, '�ο���̰���(�ο�5����)', 34.803678153708624, 126.43437160089888, '���󳲵� ������ ���ϵ� 1025', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (11, '�Ծϻ곻����', 34.79738565536757, 126.42269509090625, '���󳲵� ������ �� ��102-33', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (12, '��ȭ����ȸ���߿�', 34.79209591430474, 126.42015875475134, '���󳲵� ������ ���ص� 924-1', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (13, '�������ؾ������', 34.793599886397665, 126.41798472854458, '���󳲵� ������ ���ص� 11-4', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (14, '��ȭ��̰���(������@��)', 34.811533070549416, 126.41467555506077, '���󳲵� ������ ���ص� 338-2', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (15, '��������������', 34.822366592286166, 126.41115033786713, '���󳲵� ������ �� 349-7', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (16, '���ؾ�̰���', 34.81902451757934, 126.39640208629959, '���󳲵� ������ ���ص� 998', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (17, '������ü������', 34.811348322735654, 126.40584888582636, '���󳲵� ������ ���ص� 338-2', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (18, '����ü��(�״Ͻ�)����', 34.81183209812421, 126.40570060196379, '���󳲵� ������ ���ص� ��34-3', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (19, '�������ٸ�����', 34.80945791698712, 126.39266588415155, '���󳲵� ������ ��絿 881', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (20, 'ûȣ�ٸ�����(���ʵ��б� ��)', 34.80753559164996, 126.3872512167638, '���󳲵� ������ ������ 267-13', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (21, '���е�����', 34.793303955333144, 126.39202221661502, '���󳲵� ������ ������ 1098-1', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (22, '���е��߾Ӱ�����', 34.78433107353347, 126.3943878848356, '���󳲵� ������ ������ 1487', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (23, '���е�������', 34.785963356240615, 126.392278213345, '���󳲵� ������ ������ 1428', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (24, '���ȿ������͹̳� 1��', 34.7820378061742, 126.3842141543786, '���󳲵� ������ �׵� 6-10', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (25, '��������������(���޵�)', 34.78709705243033, 126.38202142464473, '���󳲵� ������ ���ǵ�2��1-127', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (26, '�ξ����', 34.78230101517544, 126.36872840625107, '���󳲵� ������ �±ݵ� 165-16', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (27, '���������� B(����)', 34.78773122547153, 126.3672912426623, '���󳲵� ������ �ױ��� 462', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (28, '���������� A(���)', 34.78811815703288, 126.36716263863914, '���󳲵� ������ �ױ��� 465-142', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (29, '���׹�����(2�ε�)', 34.80153832665657, 126.36383093640528, '���󳲵� ������ �ױ��� 674', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (30, '����������', 34.8030535937114, 126.36790089017246, '���󳲵� ������ �ױ��� 620-112', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (31, '����Ƚ���Ÿ�', 34.80403539685983, 126.3668962058978, '���󳲵� ������ �ױ��� 620-225', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (32, '�������� ��̰���', 34.80919207080617, 126.45654131618686, '���󳲵� ������ ���ϵ� 1318', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (33, '���׵��ٸ�����', 34.8082445878687, 126.46087257567862, '���󳲵� ���ȱ� ������ ���Ǹ� 2286', SYSDATE);
INSERT INTO info (id, title, lat, lng, address, update_date) VALUES (34, '���Ǽ�������', 34.808295074613845, 126.46721910464056, '���󳲵� ���ȱ� ������ ���Ǹ� 2321', SYSDATE);
