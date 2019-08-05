CREATE TABLE  "ROOM" 
   (	"RID" VARCHAR2(10), 
	"CAPACITY" NUMBER(4,0) NOT NULL , 
	"TYPE1" VARCHAR2(20) NOT NULL , 
	 PRIMARY KEY ("RID") 
   );
   
   CREATE TABLE  "TIME_TABLE" 
   (	"DAY" VARCHAR2(20), 
	"TIMESLOT" VARCHAR2(20), 
	"TTID" VARCHAR2(10), 
	 PRIMARY KEY ("DAY", "TIMESLOT", "TTID") 
   );
   
   CREATE TABLE  "ALLOTTED" 
   (	"RID" VARCHAR2(10) REFERENCES  "ROOM" ("RID"), 
	"TIMESLOT" VARCHAR2(20), 
	"TTID" VARCHAR2(10), 
	"DAY" VARCHAR2(20)
	FOREIGN KEY ("DAY", "TIMESLOT", "TTID") REFERENCES  "TIME_TABLE" ("DAY", "TIMESLOT", "TTID") ON DELETE CASCADE
   );
   
   CREATE TABLE  "BATCH" 
   (	"BID" VARCHAR2(10), 
	"GROUP1" VARCHAR2(10) NOT NULL , 
	"CAPACITY" NUMBER(3,0) NOT NULL , 
	 PRIMARY KEY ("BID") 
   );
   
   CREATE TABLE  "COURSE" 
   (	"CID" VARCHAR2(10), 
	"NAME" VARCHAR2(25) NOT NULL , 
	 PRIMARY KEY ("CID") 
   );
   
   CREATE TABLE  "TEACHER" 
   (	"TID" VARCHAR2(10), 
	"NAME" VARCHAR2(25) NOT NULL , 
	"DESIGNATION" VARCHAR2(30) NOT NULL , 
	"LECT_PER_WEEK" NUMBER(2,0) NOT NULL , 
	 PRIMARY KEY ("TID") 
   );
   
   CREATE TABLE  "BELONGS_TO" 
   (	"TID" VARCHAR2(10) REFERENCES  "TEACHER" ("TID") ON DELETE SET NULL, 
	"CID" VARCHAR2(10) REFERENCES  "COURSE" ("CID") ON DELETE CASCADE, 
	"BID" VARCHAR2(10) REFERENCES  "BATCH" ("BID") ON DELETE CASCADE, 
	"DAY" VARCHAR2(20), 
	"TIMESLOT" VARCHAR2(20), 
	"TTID" VARCHAR2(10),
	FOREIGN KEY ("DAY", "TIMESLOT", "TTID") REFERENCES  "TIME_TABLE" ("DAY", "TIMESLOT", "TTID") ON DELETE CASCADE
   );
   
   CREATE TABLE  "TEACHER_COURSE" 
   (	"TID" VARCHAR2(10), 
	"CID" VARCHAR2(10) NOT NULL , 
	 PRIMARY KEY ("TID") 
   );
   
   CREATE TABLE  "TEACHES" 
   (	"TID" VARCHAR2(10) REFERENCES  "TEACHER" ("TID") ON DELETE SET NULL, 
	"CID" VARCHAR2(10) REFERENCES  "COURSE" ("CID") ON DELETE CASCADE, 
	"BID" VARCHAR2(10) REFERENCES  "BATCH" ("BID") ON DELETE CASCADE
   );
   
   CREATE TABLE  "TIME_TABLE_MASTER" 
   (	"DAY" VARCHAR2(20), 
	"TIMESLOT" VARCHAR2(20), 
	"BID" VARCHAR2(10), 
	"RID" VARCHAR2(10) NOT NULL , 
	"TID" VARCHAR2(10) NOT NULL REFERENCES  "TEACHER_COURSE" ("TID"), 
	 PRIMARY KEY ("DAY", "TIMESLOT", "BID") 
   );
   

CREATE OR REPLACE PROCEDURE  "RESET_TIME_TABLE" (day1 in varchar2) is

begin
delete from time_table where day=day1;

insert into time_table select day, timeslot, bid from time_table_master where day=day1;

end;
/
/
CREATE OR REPLACE PROCEDURE  "RESET_ALLOTTED" (day1 in varchar2) is

begin
delete from allotted where day=day1;

insert into allotted select rid, timeslot, bid, day from time_table_master where day=day1;

end;
/
/
CREATE OR REPLACE PROCEDURE  "RELEASE_ROOM" (rid1 in varchar2, timeslot1 in varchar2, ttid1 in varchar2, day1 in varchar2) is
rid2 varchar2(10);

begin
select rid into rid2 from allotted where rid=rid1 and timeslot=timeslot1 and ttid=ttid1 and day=day1;

delete from allotted where rid=rid1 and timeslot=timeslot1 and ttid=ttid1 and day=day1;
delete from time_table where day=day1 and timeslot=timeslot1 and ttid=ttid1;
dbms_output.put_line('ROOM RELEASED');

exception
when no_data_found then
dbms_output.put_line('ROOM ALREADY VACANT');

end;
/
/
CREATE OR REPLACE PROCEDURE  "INSERT_TIME_TABLE_MASTER" (day in varchar2, timeslot in varchar2, bid in varchar2, cid in varchar2, tid in varchar2, rid in varchar2) is

begin
insert into time_table_master values(day, timeslot, bid, rid, tid);
insert into teacher_course values(tid, cid);

end;
/
/
CREATE OR REPLACE PROCEDURE  "INSERT_TEACHES" (tid in varchar2, cid in varchar2, bid in varchar2) is

begin
insert into teaches values(tid, cid, bid);

end;
/
/
CREATE OR REPLACE PROCEDURE  "INSERT_TEACHER" (tid in varchar2, name in varchar2, designation in varchar2, lect in number) is

begin
insert into teacher values(tid, name, designation, lect);

end;
/
/
CREATE OR REPLACE PROCEDURE  "INSERT_ROOM" (rid in varchar2, capacity in number, type1 in varchar2) is
begin
    insert into room values(rid, capacity, type1);
end;
/
/
CREATE OR REPLACE PROCEDURE  "INSERT_COURSE" (cid in varchar2, name in varchar2) is

begin
insert into course values(cid, name);

end;
/
/
CREATE OR REPLACE PROCEDURE  "INSERT_BELONGS" (tid in varchar2, cid in varchar2, bid in varchar2, day1 in varchar2, timeslot in varchar2, ttid in varchar2) is

begin
insert into belongs_to values(tid, cid, bid, day1, timeslot, ttid);

end;
/
/
CREATE OR REPLACE PROCEDURE  "INSERT_BATCH" (bid in varchar2, group1 in varchar2, capacity1 in number) is

begin
insert into batch values(bid, group1,capacity1);

end;
/
/
CREATE OR REPLACE PROCEDURE  "CHECK_ROOM" (choice in number, timeslot1 in varchar2, day1 in varchar2, rid1 in varchar2, type1 in varchar2, capacity1 in number) as
rid2 varchar2(10);

begin
if choice=1 then
select rid into rid2 from allotted where rid=rid1 and timeslot=timeslot1 and day=day1;
dbms_output.put_line('ROOM IS OCCUPIED');

elsif choice=2 then
select a.rid into rid2 from allotted a, room r where (a.timeslot=timeslot1 and a.day=day1) and (r.capacity=capacity1 and r.type1=type1) and a.rid=r.rid;
dbms_output.put_line('ROOM IS OCCUPIED');

end if;

exception
when no_data_found then
dbms_output.put_line('ROOM IS VACANT');

end;
/
/
CREATE OR REPLACE PROCEDURE  "BOOK_ROOM" (rid1 in varchar2, timeslot1 in varchar2, ttid1 in varchar2, day1 in varchar2) is
rid2 varchar2(10);

begin
select rid into rid2 from allotted where rid=rid1 and timeslot=timeslot1 and ttid=ttid1 and day=day1;
raise_application_error(-20001, 'ROOM ALREADY BOOKED');

exception
when no_data_found then
insert into allotted values(rid1, timeslot1, ttid1, day1);
insert into time_table values(day1, timeslot1, ttid1);
dbms_output.put_line('ROOM BOOKED');

end;
/
/

CREATE OR REPLACE TRIGGER  "INSERT_TIME_TABLE" after insert on time_table_master
for each row
declare
bid1 time_table_master.bid%type;
begin
select bid into bid1 from time_table_master where bid=:new.bid;
insert into time_table values(:new.day, :new.timeslot, :new.bid);
exception
when no_data_found then
null;
end;
/

CREATE OR REPLACE TRIGGER  "INSERT_ALLOTTED" after insert on time_table_master
for each row
declare
rid1 time_table_master.rid%type;
begin
select rid into rid1 from time_table_master where rid=:new.rid;
insert into allotted values(:new.rid, :new.timeslot, :new.bid, :new.day);
exception
when no_data_found then
null;
end;
/

