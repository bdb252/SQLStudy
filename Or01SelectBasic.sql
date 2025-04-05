/*
파일명 : Or01SelectBasic.sql
처음으로 실행해보는 질의어(SQL문 혹은 Query문이라고 함)
개발자들 사이에서는 '시퀄'이라고 표현하기도 한다.
설명 : select, where, order by 등 가장 기본적인 SQL문 사용해보기
*/

/*
SQL Developer에서 주석 사용하기
    블록단위주석 : 자바와 동일
    라인단위주석 : --실행문장. 하이픈 2개의 연속해서 기술한다.
*/
--select문 : 테이블에 저장된 레코드를 조회하는 SQL문.
/*
형식] select 컬럼1, 컬럼2... 혹은 *
        from 테이블명
        where 조건1 and 조건2 or 조건3
        order by 정렬할 컬럼 asc(오름차순), desc(내림차순);
*/
--사원테이블에 저장된 모든 레코드를 대상으로 전체 컬럼을 조회
select * from employees;
--쿼리는 대소문자를 구분하지 않는다.
SELECT * FROM EMPLOYEES;

/*
컬럼명을 지정해서 조회하고 싶은 컬럼만 조회
 => 사원번호, 이름, 이메일, 부서번호 조회하기
 */
 select employee_id, first_name, last_name, email, department_id
    from employees; --하나의 쿼리문이 끝날 때 ;을 반드시 명시해야 한다.
    
/*
테이블의 구조와 컬럼별 자료형 및 크기를 출력해준다. 즉 테이블의 스키마(구조)를 알 수 있다.
*/
desc employees;

/*
컬럼이 숫자형(number)인 경우 산술연산 가능
    => 100불 인상된 직원의 급여를 조회하시오
*/
select employee_id, first_name, salary, salary+100
    from employees;

--number(숫자)타입의 컬럼끼리는 산술연산을 할 수 있다.
select first_name, salary, salary+commission_pct
    from employees; --null 과 숫자의 연산은 계산이 불가하여 null의 결과가 출력된다.
    
/*
AS(알리아스) : 테이블 혹은 컬럼에 별칭(별명)을 부여할 때 사용. 
              내가 원하는 이름(영문, 한글)으로 변경한 후 결과를 인출할 수 있다. 
    활용] 급여+성과급율 => salComm 과 같은 형태로 별팅을 부여함.
*/
--별칭은 한글로 설정할 수 있다.
select employee_id, first_name, salary, salary+100 as "급여100증가"
    from employees;

--하지만 별칭은 영문으로 기술하는 것을 권장한다.
select first_name, salary, commission_pct,
    salary+(salary*commission_pct) as SalCom
    from employees;

--as는 생략할 수 있다.
select employee_id "사원번호", first_name "이름", last_name "성"
    from employees where first_name = 'William';

/*
오라클은 기본적으로 대소문자를 구분하지 않는다. 예약어의 경우 대소문자 구분없이 사용할 수 있다.
*/
SELECT employee_id "사원번호", first_name "이름", last_name "성"
    FROM employees WHERE first_name = 'William';

/*
단, 레코드인 경우 대소문자를 구분한다. 
따라서 아래 SQL문을 실행함녀 에러가 발생하진 않지만 아무런 결과도 인출되지 않는다.
*/
select employee_id "사원번호", first_name "이름", last_name "성"
    from employees where first_name = 'william';

/*
where절을 이용해서 조건에 맞는 레코드 인출
    => last_name이 Smith인 레코드를 인출하시오
*/
select * from employees where last_name='Smith';

/*
where절에 2개 이상의 조건이 필요하면 and 혹은 or을 사용할 수 있다.
    => last_name이 Smith이면서 급여가 8000인 사원을 인출하시오
*/
--컬럼이 문자형이면 싱글쿼테이션으로 감싸준다. 숫자라면 생략한다.
select * from employees where last_name='Smith' and salary=8000;
--숫자인 경우 생략이 기본이지만, 쓰더라도 에러가 발생하지는 않는다.
select * from employees where last_name='Smith' and salary='8000';
--문자형은 싱글쿼테이션을 생략할 수 없다. 에러가 발생한다.
select * from employees where last_name=Smith and salary=8000;

/*
비교연산자를 통한 쿼리문 작성
: 이상, 이하와 같은 조건에 >,<=와 같은 비교연산자를 사용할 수 있다.
날짜인 경우 이전, 이후와 같은 조건도 가능하다.
*/
--급여가 5000이상인 사원의 정보를 인출하시오
select * from employees where salary>=5000;
--입사일이 04년 1월1일 이후인 사원의 정보를 인출하시오.
select * from employees where hire_date>='04/01/01';

/*
in연산자
: or연산자와 같이 하나의 컬럼에 여러개의 값으로 조건을 걸고싶을 때 사용
==> 급여가 4200, 6400, 8000인 사원의 정보를 인출하시오
*/
--방법1 : or을 사용. 이 경우 컬럼명을 반복적으로 사용해야 하므로 불편하다.
select * from employees where salary=4200 or salary=6400 or salary=8000;
--방법2 : in을 사용. 컬럼명을 한번만 기술하면 되므로 편리하다.
select * from employees where salary in (4200,6400,8000);

/*
not연산자
: 해당 조건이 아닌 레코드를 인출한다.
=> 부서번호가 50이아닌 사원정보를 인출하시오.
*/
--아래 3개의 문장은 모두 동일한 의미로 사용됨
select * from employees where department_id<>50;
select * from employees where department_id!=50;
select * from employees where not (department_id=50);

/*
between and 연산자
: 컬럼의 구간을 정해 검색할 때 사용한다.
=> 급여가 4000~8000사이의 사원을 인출하시오
*/
select * from employees where salary>=4000 and salary <= 8000;
select * from employees where salary between 4000 and 8000;

/*
distinct연산자
: 컬럼에서 중복되는 레코드를 제거할 때 사용한다.
특정 조건으로 select했을 때 하나의 컬럼에서 중복되는 값이 있는 경우 중복값을 제거한 후 결과를 출력할 수 있다.
=> 담당업무 아이디를 중복을 제거한 후 인출하시오
*/
select job_id from employees;
select distinct job_id from employees;

/*
like 연산자
: 특정 키워드를 통한 문자열을 검색할 때 사용
형식] 컬럼명 like '%검색어%'
    와일드카드 사용법
    % : 모든 문자 혹은 문자열을 대체
        Ex) D로 시작하는 단어 : D% -> Da, Dae, Daewoo
            Z로 끝나는 단어 : %Z -> aZ, abxZ
            C가 포함되는 단어 : %C% -> aCb, abCde
    _ : 언더바는 하나의 문자를 대체
        Ex) D로 시작하는 3글자의 단어 : D___ -> Dab, Ddd, Dxy
            A가 중간에 들어가는 3글자의 단어 : _A_ - >aAa, xAy
*/
--이름이 'D'로 시작하는 직원을 인출하시오
select * from employees where first_name like 'D%';
--이름의 세번째 문자가 'a'인 직원을 인출하시오
select * from employees where first_name like '__a%';
--이름이 'y'로 끝나는 직원을 인출하시오
select * from employees where last_name like '%y';
--전화번호에 1344가 포함된 직원을 인출하시오
select * from employees where phone_number like '%1344%';

/*
퀴즈] 년도에 상관없이 2월에 입사한 사원을 인출하시오
*/
select * from employees where hire_date like '___02___';

/*
레코드 정렬하기(Sorting)
    오름차순 정렬 : order by 컬럼명 asc (혹은 생략 가능)
    내림차순 정렬 : order by 컬럼명 desc
2개 이상의 컬럼으로 정렬해야 할 경우 콤마로 구분해서 정렬한다.
이 경우 첫번째 컬럼으로 정렬된 상태에서 두번째 컬럼이 정렬된다.
*/

/*
시나리오] 사원정보 테이블에서 급여가 낮은 순서대로 높은 순서로 정렬하여 인출하시오.
*/
select first_name, salary, email, phone_number from employees
    order by salary asc;
select first_name, salary, email, phone_number from employees
    order by salary; --오름차순 정렬의 경우 asc를 생략할 수 있다.

/*
시나리오] 부서번호를 내림차순으로 정렬한 후 해당 부서에서 낮은 급여를 받는 직원이 먼저 출력되도록 SQL문을 작성하시오
출력항목 : 사원번호, 이름, 성, 급여, 부서번호
*/
select employee_id, first_name, last_name, salary, department_id from employees
    order by department_id desc, salary; --asc생략가능
select employee_id, first_name, last_name, salary, department_id from employees
    order by department_id desc, salary asc;

/*
is null 혹은 is not null
: 값이 null이거나 null이 아닌 레코드 인출
컬럼중 null값을 허용하는 경우 값을 입력하지 않으면 null값이 입력되는데 이를 대상으로 select할 때 사용한다.
*/
--보너스율이 없는 사원을 조회하시오.
select * from employees where commission_pct is null;

--영업사원이면서 급여가 8000이상인 사원을 조회하시오.
select * from employees where salary>=8000
    and commission_pct is not null;

-------------------------------------------
--1. 덧셈 연산자를 이용하여 모든 사원에 대해서 $300의 급여인상을 계산한후 이름, 급여, 인상된 급여를 출력하시오.
select ename, sal, sal+300 from emp;

--2. 사원의 이름, 급여, 연봉을 수입이 많은것부터 작은순으로 출력하시오. 연봉은 월급에 12를 곱한후 $100을 더해서 계산하시오.
select ename, sal, (sal*12+100) from emp order by sal desc;

--3. 급여가  2000을 넘는 사원의 이름과 급여를 내림차순으로 정렬하여 출력하시오
select ename, sal from emp where sal>2000 order by sal desc; 

--4. 사원번호가  7782인 사원의 이름과 부서번호를 출력하시오.
select ename, deptno from emp where empno=7782;

--5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.
select ename, sal from emp where not (sal>2000 and sal <3000);

--6. 입사일이 81년2월20일 부터 81년5월1일 사이인 사원의 이름, 담당업무, 입사일을 출력하시오.
select ename, job, hiredate from emp where hiredate between '81/02/20' and '81/05/01';

--7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오
select ename, deptno from emp 
where sal between 2000 and 3000 
order by ename desc;

--8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름순(오름차순)으로 출력하시오
select ename, sal, deptno from emp 
where 
    sal between 2000 and 3000
    and (deptno=20 or deptno=30)
order by ename;

--9. 1981년도에 입사한 사원의 이름과 입사일을 출력하시오. (like 연산자와 와일드카드 사용)
select ename, hiredate from emp
where hiredate like '81%';

--10. 관리자가 없는 사원의 이름과 담당업무를 출력하시오. 
select ename, job from emp
where mgr is null;

--11. 커미션을 받을수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여 및 커미션을 기준으로 내림차순으로 정렬하여 출력하시오.
select ename, sal, comm from emp
where comm is not null
order by (sal + comm) desc;
--order by sal desc, comm desc;

--12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.
select ename from emp
where ename like '__R%';

--13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.
select ename from emp
where ename like '%A%E%'; --or ename like '%E%A%';

--14. 담당업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서 급여가 $1600, $950, $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오. 
select ename, sal from emp
where
    job='CLERK' or job='SALESMAN' 
    and not (sal=1600 or sal=950 and sal=1300);
    
--15. 커미션이 $500 이상인 사원의 이름과 급여 및 커미션을 출력하시오. 
select ename, sal, comm from emp
where comm>=500;

