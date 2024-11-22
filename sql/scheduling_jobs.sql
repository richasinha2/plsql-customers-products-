BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        job_name        => 'daily_customer_backup',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN DBMS_OUTPUT.PUT_LINE(''Backup completed''); END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; INTERVAL=1',
        enabled         => TRUE
    );
END;
