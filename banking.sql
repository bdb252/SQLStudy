--테이블 생성
create table banking(
    acc_idx number primary key,
    account_num varchar2(50) not null,
    name varchar2(50) not null,
    money number,
    interest number
);
desc banking;
--시퀀스 생성
create sequence seq_banking_idx
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
commit;
--프로시저생성
create or replace procedure DeleteAccount(
    a_num in varchar2,
    returnVal out varchar2)
is
begin
    delete from banking where account_num=a_num;
    
    if sql%found then
        returnVal := 'delete success';
        commit;
    else
        returnVal := 'not exist';
    end if;
end;
/

insert into banking values(1, '111-111','홍길동',10000,2);

commit;