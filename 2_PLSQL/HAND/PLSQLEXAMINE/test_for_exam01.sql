--1.b
DECLARE
	aaa NUMBER;
BEGIN
	--DECODE(department_id,10,'����10', 20,'����20', '����30')
	aaa:=DECODE('&NUM','aaa',1,'bbb',2,3);
	dbms_output.put_line('-->'||aaa);
END;
/
SELECT DECODE(&department_id,10,'����10', 20,'����20', '����30') FROM dual;


DECLARE
	stu hand_student%ROWTYPE;
	CURSOR stuc IS SELECT * FROM hand_student;
BEGIN
	FOR st IN stuc LOOP
    	st.student_no:='ccccc';
        dbms_output.put_line('>>>'||st.student_no);
	END LOOP;
END;
/


CREATE TABLE test01(
	test_no VARCHAR(20),
    test_name VARCHAR(20)
);

SELECT * FROM user_tables;

ALTER TABLE test01 ADD  test_a01 NUMBER;
INSERT INTO test01 VALUES('aaa','xiaoming',89);
INSERT INTO test01 VALUES('bbb','xiaoming2',99);
INSERT INTO test01 VALUES('ccc','xiaoming3',100);


TRUNCATE TABLE test01;


SELECT * FROM test01;

--ѡ����.5
DECLARE
	
BEGIN
	--ALTER TABLE test01 ADD  test_a02 NUMBER;
    --INSERT INTO test01 VALUES('ddd','xiaoming4',80);
	TRUNCATE TABLE test01;
END;
/



--������
CREATE OR REPLACE PACKAGE HELLO1 IS
	--�������й��̺ͺ���
	FUNCTION HELLO_FUN(ANAME IN VARCHAR2) RETURN VARCHAR2;
	PROCEDURE HELLO_PRO(BNAME IN VARCHAR2);
END HELLO1;
/
--3.2 package��ʹ��,body
CREATE OR REPLACE PACKAGE BODY HELLO1 IS
	--��������˽�еı���
	--�������й���/˽�й��̺ͷ���

	--����01  ���hello
	FUNCTION HELLO_FUN(ANAME IN VARCHAR2) RETURN VARCHAR2 IS
	BEGIN
		RETURN('hello ' || ANAME || ', im function of package!');
	END HELLO_FUN;

	--����01,���ú���hello
	PROCEDURE HELLO_PRO(BNAME IN VARCHAR2) IS
	BEGIN
		DBMS_OUTPUT.PUT_LINE('hello' || BNAME ||
							 ', im procedure of package!');
	END HELLO_PRO;
END HELLO1;
/--���ð��ĺ���
SELECT hello1.HELLO_FUN('naruto')  FROM dual;
--���ð��Ĵ洢����
BEGIN
  HELLO1.HELLO_PRO('naruto');
END;
/







SELECT STU.STUDENT_NO,
	   STU.STUDENT_NAME,
	   STU.STUDENT_AGE,
	   STU.STUDENT_GENDER,
	   COUR.COURSE_NO,
	   COUR.COURSE_NAME,
	   TEA.TEACHER_NAME,
	   MCORE.CORE
  FROM HAND_STUDENT      STU,
	   HAND_COURSE       COUR,
	   HAND_TEACHER      TEA,
	   HAND_STUDENT_CORE MCORE
 WHERE STU.STUDENT_NO = MCORE.STUDENT_NO
   AND COUR.COURSE_NO = MCORE.COURSE_NO
   AND COUR.TEACHER_NO = TEA.TEACHER_NO
	and	mcore.core < (SELECT AVG(CORE) FROM hand_student_core GROUP BY course_no HAVING course_no=COUR.COURSE_NO)
    AND	COUR.COURSE_NO='&abc';
  
SELECT COUR.COURSE_NO, AVG(MCORE.CORE)
  FROM HAND_STUDENT      STU,
	   HAND_COURSE       COUR,
	   HAND_TEACHER      TEA,
	   HAND_STUDENT_CORE MCORE
 WHERE STU.STUDENT_NO = MCORE.STUDENT_NO
   AND COUR.COURSE_NO = MCORE.COURSE_NO
   AND COUR.TEACHER_NO = TEA.TEACHER_NO
 GROUP BY COUR.COURSE_NO;







SELECT * FROM user_tables;

SELECT * FROM hand_student;--(student_no,student_name,student_age,student_gender)
SELECT * FROM hand_teacher;--(teacher_no,teacher_name,manager_no)
SELECT * FROM hand_course;--(course_no,course_name,teacher_no)
SELECT * FROM hand_student_core;--(student_no,course_no,core)