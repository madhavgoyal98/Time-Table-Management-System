/*###############cusror - vacant_room################*/
declare
	timeslot2 varchar2(10);
	day2 varchar2(20);

	cursor vacant_room(timeslot1 varchar2, day1 varchar2) is select rid from room minus select rid from allotted where timeslot=timeslot1 and day=day1;

begin
	timeslot2 := &timeslot;
	day2 := &day1;

	for rid1 in vacant_room(timeslot2, day2) loop
		dbms_output.put_line(rid1);
	end loop;
end;
/*############################################*/



/*##################time_table_student#####################*/
DECLARE
	name_c varchar2(25);
	name_t varchar2(25);
	rid1 varchar2(10);
	day2 varchar2(20);
	bid2 varchar2(10);
	cursor time_table_student(day1 varchar2, bid1 varchar2) is select tid, cid, timeslot from belongs_to where day=day1 and bid=bid1;
BEGIN
	day2 := &day;
	bid2 := &bid;
	
	for rec in time_table_student(day2, bid2) loop
		select name into name_c from course where cid=rec.cid;
		select name into name_t from teacher where tid=rec.tid;
		select rid into rid1 from allotted where timeslot=rec.timeslot and ttid=bid2 and day=day2;
		dbms_output.put_line('TIMESLOT: ' || rec.timeslot);
		dbms_output.put_line('COURSE ID: ' || rec.cid);
		dbms_output.put_line('COURSE NAME: ' || name_c);
		dbms_output.put_line('TEACHER ID: ' || rec.tid);
		dbms_output.put_line('TEACHER NAME: ' || name_t);
		dbms_output.put_line('ROOM: ' || rid1);
		dbms_output.put_line(' ');
	end loop;
END;
/*########################################################*/



/*##################time_table_teacher#####################*/
DECLARE
	name_c varchar2(25);
	rid1 varchar2(10);
	day2 varchar2(20);
	tid2 varchar2(10);
	cursor time_table_teacher(day1 varchar2, tid1 varchar2) is select bid, cid, timeslot from belongs_to where day=day1 and tid=tid1;
BEGIN
	day2 := &day;
	tid2 := &tid;
	
	for rec in time_table_teacher(day2, tid2) loop
		select name into name_c from course where cid=rec.cid;
		select rid into rid1 from allotted where timeslot=rec.timeslot and ttid=rec.bid and day=day2;
		dbms_output.put_line('TIMESLOT: ' || rec.timeslot);
		dbms_output.put_line('BATCH ID: ' || rec.bid);
		dbms_output.put_line('COURSE ID: ' || rec.cid);
		dbms_output.put_line('COURSE NAME: ' || name_c);
		dbms_output.put_line('ROOM: ' || rid1);
		dbms_output.put_line(' ');
	end loop;
END;
/*########################################################*/