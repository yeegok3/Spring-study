create table myboard(
	idx int not null auto_increment,
	memID varchar(20) not null,
	title varchar(100) not null,
	content varchar(500) not null,
	writer varchar(20) not null,
	indate datetime default now(),
	count int default 0,
	primary key(idx)
);

drop table myboard;

insert into myboard(title, content, writer) values('게시판 연습1', '게시판 연습합니다.', '관리자');
insert into myboard(title, content, writer) values('게시판 연습2', '게시판 글쓰기입니다..', '김규성');
insert into myboard(title, content, writer) values('게시판 연습3', '게시판 테스트입니다..', '선생님');

select * from myboard order by idx desc;

