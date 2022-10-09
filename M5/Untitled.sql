CREATE OR REPLACE Function TotalIncome
   ( name IN varchar2 )
   RETURN varchar2
IS
   total_val number(6);

   cursor c1 is
     SELECT employees.salary
     FROM employees
     WHERE first_name = name;

BEGIN

   total_val := 0;

   FOR employee in c1
   LOOP
      total_val := total_val + employee.salary;
   END LOOP;

   RETURN total_val;

END;

select employees.employee_id, totalincome('Luis') from employees;