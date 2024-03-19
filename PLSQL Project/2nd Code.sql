declare
     
    cursor temp_cur is
        select first_name, last_name, hire_date, email, salary, job_title, department_name, city from employees_temp
        where regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$');

    v_first_name varchar2(25);
    v_last_name varchar2(25);
    v_hire_date date;
    v_email varchar2(100);
    v_salary number;
    v_job_title varchar2(100);
    v_job_id varchar2(100);
    v_department_name varchar2(100);
    v_department_id number;
    v_city varchar2(100);
    v_location_id number;

begin
     
    for v_temp_record in temp_cur loop
         
    v_first_name := v_temp_record.first_name;
    v_last_name := v_temp_record.last_name;
    v_hire_date := to_date(v_temp_record.hire_date, 'DD/MM/YYYY');
    v_email := v_temp_record.email;
    v_salary := v_temp_record.salary;
    v_job_title := v_temp_record.job_title;
    v_department_name := v_temp_record.department_name;
    v_city := v_temp_record.city;
        
        begin

            select job_id  into v_job_id from jobs where job_title = v_job_title;
            
           exception
            when NO_DATA_FOUND then
            insert into jobs (job_id, job_title) values (UPPER(SUBSTR(v_job_title, 0, 3)), v_job_title);

            select job_id  into v_job_id from jobs where job_title = v_job_title;

        end;
        
        
        begin
            
            select location_id into v_location_id from locations where city = v_city;
            
            exception
            when NO_DATA_FOUND then
            insert into locations (city) values(v_city);
            
            select location_id into v_location_id from locations where city = v_city;
            
        end;
        
        
        begin
            
            select department_id into v_department_id from departments where department_name = v_department_name;
            
            exception
            when NO_DATA_FOUND then
            insert into departments (department_name, location_id) values ( v_department_name, v_location_id);
            
            select department_id into v_department_id from departments where department_name = v_department_name;
            
        end;

    insert into employees (first_name, last_name, hire_date, email, salary, job_id, department_id) 
                       values(v_first_name, v_last_name, v_hire_date, v_email, v_salary, v_job_id, v_department_id);
         
    end loop;
     
end;