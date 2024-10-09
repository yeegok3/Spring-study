create table mem_table(
	memIdx int auto_increment,
	memID varchar(20) not null,
	memPassword varchar(20) not null,
	memName varchar(20) not null,
	memAge int,
	memGender varchar(10),
	memEmail varchar(50),
	memProfile varchar(50),
	primary key(memIdx)
);

delete from mem_table;


select * from mem_table;
