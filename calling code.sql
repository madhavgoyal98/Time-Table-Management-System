/*#######################insert_room####################*/
DECLARE
    rid1 room.rid%type;
    capacity1 room.capacity%type;
    type2 room.type1%type;

BEGIN
    rid1 := &rid;
    capacity1 := &capacity;
    type2 := &type1;
    
    insert_room(rid1, capacity1, type2);
    
END;
/*#######################################################*/


/*####################insert_course#####################*/
DECLARE
    cid1 course.cid%type;
    name1 course.name%type;

BEGIN
    cid1 := &cid;
    name1 := &name;
    
    insert_course(cid1, name1);
    
END;
/*########################################################*/


/*###########################reset_time_table###################*/
DECLARE
    day1 time_table.day%type;

BEGIN
    day1 := &day;
    
    reset_time_table(day1);
    
END;
/*#############################################################*/


/*###########################insert_teacher###################*/

DECLARE
    tid1 teacher.tid%type;
    name1 teacher.name%type;
    designation1 teacher.designation%type;
    lect teacher.lect_per_week%type;

BEGIN
    tid1 := &tid;
    name1 := &name;
    designation1 := &designation;
    lect := &lect_per_week;
    
    insert_teacher(tid1, name1, designation1, lect);
    
END;
/*#############################################################*/


/*###########################reset_allotted###################*/

DECLARE
    day1 allotted.day%type;

BEGIN
    day1 := &day;
    
    reset_allotted(day1);
    
END;
/*#############################################################*/


/*###########################insert_batch###################*/
DECLARE
    bid1 batch.bid%type;
    group1 batch.group1%type;
    capacity1 batch.capacity%type;

BEGIN
    bid1 := &bid;
    group1 := &group;
    capacity1 := &capacity;
    
    insert_batch(bid1, group1, capacity1);
    
END;
/*#############################################################*/


/*###########################insert_teaches###################*/
DECLARE
    bid1 teaches.bid%type;
    cid1 teaches.cid%type;
    tid1 teaches.tid%type;

BEGIN
    bid1 := &bid;
    cid1 := &cid;
    tid1 := &tid;
    
    insert_teaches(tid1, cid1, bid1);
    
END;
/*#############################################################*/


/*###########################insert_belongs###################*/
DECLARE
    bid1 belongs_to.bid%type;
    cid1 belongs_to.cid%type;
    tid1 belongs_to.tid%type;
    day1 belongs_to.day%type;
    timeslot1 belongs_to.timeslot%type;

BEGIN
    bid1 := &bid;
    cid1 := &cid;
    tid1 := &tid;
    day1 := &day;
    timeslot1 := &timeslot;
    
    insert_belongs(tid1, cid1, bid1, day1, timeslot1);
    
END;
/*#############################################################*/


/*###########################insert_time_table_master###################*/
DECLARE
    bid1 time_table_master.bid%type;
    rid1 time_table_master.rid%type;
    cid1 teacher_course.cid%type;
    tid1 time_table_master.tid%type;
    day1 time_table_master.day%type;
    timeslot1 time_table_master.timeslot%type;

BEGIN
    bid1 := &bid;
    rid1 := &rid;
    cid1 := &cid;
    tid1 := &tid;
    day1 := &day;
    timeslot1 := &timeslot;
    
    insert_time_table_master(day1, timeslot1, bid1, cid1, tid1, rid1);
    
END;
/*#############################################################*/


/*###########################book_room###################*/
DECLARE
    bid1 time_table_master.bid%type;
    rid1 time_table_master.rid%type;
    day1 time_table_master.day%type;
    timeslot1 time_table_master.timeslot%type;

BEGIN
    bid1 := &bid;
    rid1 := &rid;
    day1 := &day;
    timeslot1 := &timeslot;
    
    book_room(rid1, timeslot1, bid1, day1);
    
END;
/*#############################################################*/


/*###########################release_room###################*/
DECLARE
    bid1 time_table_master.bid%type;
    rid1 time_table_master.rid%type;
    day1 time_table_master.day%type;
    timeslot1 time_table_master.timeslot%type;

BEGIN
    bid1 := &bid;
    rid1 := &rid;
    day1 := &day;
    timeslot1 := &timeslot;
    
    release_room(rid1, timeslot1, bid1, day1);
    
END;
/*#############################################################*/


/*###########################check_room###################*/
DECLARE
    choice number(1);
    timeslot1 allotted.timeslot%type;
    day1 allotted.day%type;
    rid1 allotted.rid%type;
    type1 room.type1%type;
    capacity1 room.capacity%type;
    
BEGIN
    dbms_output.put_line('1. CHECK ROOM USING ROOM ID');
    dbms_output.put_line('2. CHECK ROOM USING TYPE AND CAPACITY');
    dbms_output.put_line('ENTER CHOICE (1/2)');
    
    choice := &choice;
    timeslot1 := &timeslot;
    day1 := &day;
    
    if choice=1 then
      rid1 := &rid;
      check_room(choice, timeslot1, day1, rid1, NULL, NULL);
    elsif choice=2 then
      type1 := &type1;
      capacity1 := &capacity;
      check_room(choice, timeslot1, day1, NULL, type1, capacity1);
	end if;
END;
/*#############################################################*/