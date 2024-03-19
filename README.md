# PL/SQL Projects

# PL/SQL First Project Script for Managing Sequences and Primary Keys

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

## Contribution

Contributions to improve or expand the functionality of this script are welcome. Please fork the repository, make your changes, and submit a pull request.

## License

This script is provided under the [MIT License](LICENSE).
