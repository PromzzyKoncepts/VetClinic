/* Database schema to keep the structure of entire database. */

CREATE TABLE animal (
    id INT GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);

-- DAY 2
alter table animal add column specie varchar(255);

-- DAY 3

/*Create a table named owner with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
full_name: string
age: integer
*/
CREATE TABLE owner(id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR(50), age INT, PRIMARY KEY(id));

/*
Create a table named specie with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string
*/
CREATE TABLE specie(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(50), PRIMARY KEY(id));

/*
Modify animal table:
Make sure that id is set as autoincremented PRIMARY KEY
Remove column specie
Add column specie_id which is a foreign key referencing specie table
Add column owner_id which is a foreign key referencing the owner table
*/
ALTER TABLE animal DROP COLUMN specie;
ALTER TABLE animal ADD COLUMN specie_id INT REFERENCES specie (id);
ALTER TABLE animal ADD COLUMN owner_id INT REFERENCES owner(id);
