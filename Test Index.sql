USE test_index;
SELECT *
FROM main_table
WHERE DATA = 1234567;
ALTER TABLE main_table ADD INDEX indexes (data);