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

drop table myboard;
delete from myboard;

insert into myboard(memID, title, content, writer) values('admin', '게시판 연습1', '게시판 연습합니다.', '관리자');


select * from myboard order by idx desc;


