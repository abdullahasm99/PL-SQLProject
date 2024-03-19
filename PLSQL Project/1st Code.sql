declare
    cursor seq_cursor is
        select sequence_name
        from all_sequences
        where sequence_owner = 'HR';
        
    cursor primary_cursor is 
        select acc.table_name, acc.column_name
        from all_cons_columns acc
        join all_tab_columns atc on acc.table_name = atc.table_name and acc.column_name = atc.column_name
        where acc.constraint_name in (
                select constraint_name
                from all_constraints
                where table_name in (
                        select object_name
                        from user_objects
                        where object_type = 'TABLE'
                        )
                  and constraint_type = 'P'
            )
          and acc.owner = 'HR'
          and atc.data_type = 'NUMBER' 
          and not exists (
                select 1
                from all_cons_columns comp_acc
                where comp_acc.table_name = acc.table_name
                  and comp_acc.constraint_name = acc.constraint_name
                  and comp_acc.column_name <> acc.column_name
            );
    
    max_value number;

begin

    for seq_records in seq_cursor loop
        
        execute immediate 'drop sequence '||seq_records.sequence_name;
        
    end loop;
    
    for primary_records in primary_cursor loop
        
        execute immediate 'SELECT MAX(' || primary_records.column_name || ') FROM ' || primary_records.table_name
                          into max_value;
                           
        max_value := nvl(max_value, 0) + 1;
        
        execute immediate 'create sequence ' || primary_records.table_name || '_SEQ START WITH ' || max_value || ' MAXVALUE 999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER';
        
         execute immediate '
            CREATE OR REPLACE TRIGGER ' || primary_records.table_name || '_TRG
            BEFORE INSERT
            ON ' || primary_records.table_name || '
            REFERENCING NEW AS New OLD AS Old
            FOR EACH ROW
            BEGIN
                :new.' || primary_records.column_name || ' := ' || primary_records.table_name || '_SEQ.nextval;
            END;';
        
    end loop;
    
end;
show errors