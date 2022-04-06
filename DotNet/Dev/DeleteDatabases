select distinct concat('drop database if exists ', table_schema, ';')
from information_schema.tables
where table_schema not in
(
    'sys',
    'mysql',
    'information_schema',
    'performance_schema'
)