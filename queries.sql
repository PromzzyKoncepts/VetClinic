SELECT * FROM animal WHERE name LIKE '%mon';
SELECT name FROM animal WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animal WHERE neutered = true AND escape_attempts<3;

SELECT date_of_birth FROM animal WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animal WHERE weight_kg>10.5;

SELECT * FROM animal WHERE neutered = true;

SELECT * FROM animal WHERE name != 'Gabumon';

SELECT * FROM animal WHERE weight_kg BETWEEN 10.4 AND 17.3;



/*
Inside a transaction:
Update the animal table by setting the species column to unspecified. Verify that change was made.
Then roll back the change and verify that the species columns went back to the state before the transaction.
*/

BEGIN TRANSACTION;
UPDATE animal SET species = 'unspecified';
SELECT * FROM animal;
ROLLBACK;
SELECT * FROM animal;


/*
Inside a transaction:
Update the animal table by setting the species column to digimon for all animal that have a name ending in mon.
Update the animal table by setting the species column to pokemon for all animal that don't have species already set.
Commit the transaction.
Verify that change was made and persists after commit.
*/

BEGIN TRANSACTION;
UPDATE animal SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animal;
UPDATE animal SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animal;
COMMIT;
SELECT * FROM animal;


/*
Inside a transaction:
Delete all records in the animal table, then roll back the transaction.
After the rollback verify if all records in the animal table still exists.
*/
BEGIN TRANSACTION;
DELETE FROM animal;
SELECT * FROM animal;
ROLLBACK;
SELECT * FROM animal;

/*
Inside a transaction:
Delete all animal born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animal' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animal' weights that are negative to be their weight multiplied by -1.
Commit transaction
*/

BEGIN TRANSACTION;
DELETE FROM animal WHERE date_of_birth > '2022-01-01';
SELECT * FROM animal;
SAVEPOINT delete_20220101_dob;
UPDATE animal SET weight_kg=weight_kg*-1;
SELECT * FROM animal;
ROLLBACK TO delete_20220101_dob;
UPDATE animal SET weight_kg=weight_kg*-1 where weight_kg<0;
SELECT * FROM animal;
COMMIT;


-- How many animal are there?
SELECT COUNT(*) AS TOTAL_animal FROM animal;

-- How many animal have never tried to escape?
SELECT COUNT(*) AS ZERO_ESCAPE_ATTEMPTS FROM animal WHERE escape_attempts=0;

-- What is the average weight of animal?
SELECT AVG(weight_kg) AS AVG_WEIGHT FROM animal;

-- Who escapes the most, neutered or not neutered animal?
SELECT neutered, SUM(escape_attempts) AS MOST_ESCAPE_ATTEMPTS_GROUP_BY_NEUTERED FROM animal GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS MIN_WEIGHT, MAX(weight_kg) AS MAX_WEIGHT FROM animal GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS AVG_ESCAPE_ATTEMPTS FROM animal WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;