use mysql;
set global general_log = 'OFF';
rename table general_log to general_log_temp;
delete from general_log_temp;
rename table general_log_temp to general_log;
set global general_log = 'ON';