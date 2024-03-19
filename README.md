# PL/SQL Project

# PL/SQL First Code Script for Managing Sequences and Primary Keys

## Overview

This PL/SQL script is designed to manage sequences and primary keys within the HR schema of an Oracle database. It provides functionality to delete existing sequences and create new ones, as well as to generate triggers for automatically populating primary key columns with sequence values upon insertion.

## Usage

1. **Prerequisites:**
   - Access to an Oracle database with the HR schema.
   - Appropriate privileges to execute DDL (Data Definition Language) statements.

2. **Execution:**
   - Execute the script in an Oracle SQL client or IDE connected to the target database.

3. **Script Logic:**
   - The script first declares two cursors:
     - `seq_cursor` to fetch sequence names owned by the 'HR' schema.
     - `primary_cursor` to fetch primary key column names and their corresponding tables.

4. **Sequence Deletion:**
   - The script iterates through the `seq_cursor` and drops each sequence found in the HR schema.

5. **Primary Key Handling:**
   - For each primary key column retrieved by the `primary_cursor`, the script:
     - Fetches the maximum value of the primary key column from its corresponding table.
     - Increments the maximum value by 1 and ensures it's not null.
     - Creates a new sequence for the table if it doesn't exist, starting from the incremented value.
     - Generates a trigger for the table to automatically populate the primary key column with the next value from the sequence upon insert.

6. **Error Handling:**
   - Error handling is implicitly done using PL/SQL's exception mechanism. Any errors occurring during sequence dropping, sequence creation, or trigger creation will be displayed.


# PL/SQL Second Code Script for Importing Employee Data

## Overview

This PL/SQL script is designed to import employee data from a temporary table `employees_temp` into the main `employees` table. It performs data transformation and insertion while handling exceptions gracefully. The script extracts employee details such as first name, last name, hire date, email, salary, job title, department name, and city from the temporary table and inserts them into the main table after processing.

## Usage

1. **Prerequisites:**
   - Access to an Oracle database containing the temporary and main employee tables.
   - Appropriate privileges to execute DML (Data Manipulation Language) statements.

2. **Execution:**
   - Execute the script in an Oracle SQL client or IDE connected to the target database.

3. **Script Logic:**
   - The script begins by declaring a cursor `temp_cur` to select employee data from the `employees_temp` table.
   - Employee details are fetched from the cursor and stored in variables for further processing.
   - For each employee record, the script performs the following actions:
     - Extracts job ID from the `jobs` table based on the job title. If the job title is not found, a new entry is inserted into the `jobs` table.
     - Extracts location ID from the `locations` table based on the city. If the city is not found, a new entry is inserted into the `locations` table.
     - Extracts department ID from the `departments` table based on the department name. If the department name is not found, a new entry is inserted into the `departments` table.
     - Inserts the employee details into the `employees` table, including first name, last name, hire date, email, salary, job ID, and department ID.

4. **Error Handling:**
   - Error handling is implemented using PL/SQL's exception mechanism. If a required lookup value (job title, city, department name) is not found in the respective tables, the script gracefully handles the exception by inserting a new entry.

## License

This script is provided under the [MIT License](LICENSE).
