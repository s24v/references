LOAD DATA
INFILE dependents.dat
INTO TABLE dependents
REPLACE
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
(
dep_id,
first_name,
last_name,
birthdate,
relation,
relative_id,
benefits
)