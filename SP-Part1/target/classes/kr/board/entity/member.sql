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

delete from mem_table;
select * from mem_table;


select * from security_member;
delete from security_member;

select * from auth_member;
delete from auth_member;

drop table member_auth;