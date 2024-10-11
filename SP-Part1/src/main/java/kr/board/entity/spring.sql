create table myboard(
	idx int not null auto_increment,
	memID varchar(20) not null,
	title varchar(100) not null,
	content varchar(500) not null,
	writer varchar(20) not null,
	indate datetime default now(),
	count int default 0,
	primary key(memID)
);

create table security_member(
	memIdx int not null,
	memID varchar(20) not null,
	memPassword varchar(70) not null,
	memName varchar(20) not null,
	memAge int,
	memGender varchar(10),
	memEmail varchar(50),
	memProfile varchar(50),
	primary key(memID)
);

create table auth_member (
	no int not null auto_increment,
	memID varchar(20) not null,
	auth varchar(20) not null,
	primary key(no),
	constraint fk_member_auth foreign key(memID) references security_member(memID)
);


delete from myboard;
delete from auth_member;
delete from security_member;


insert into myboard(memID, title, content, writer) values('admin', '게시판 연습1', '게시판 연습합니다.', '관리자');


select * from myboard order by idx desc;
select * from auth_member;
select * from security_member;
