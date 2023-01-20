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


-- DAY 4


/*Create a table named vets with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string
age: integer
date_of_graduation: date
*/
CREATE TABLE vet(id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR(50), age INT, date_of_graduation DATE, PRIMARY KEY(id));

/*
There is a many-to-many relationship between the tables species and vets:
a vet can specialize in multiple species,
and a species can have multiple vets specialized in it.
Create a "join table" called specializations to handle this relationship.
*/
CREATE TABLE specialization(vet_id INT REFERENCES vet (id), specie_id INT REFERENCES specie (id));

/*
There is a many-to-many relationship between the tables animals and vets:
an animal can visit multiple vets
and one vet can be visited by multiple animals.
Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit. */

CREATE TABLE visits(vet_id INT REFERENCES vet(id), animal_id INT REFERENCES animal (id), visit_date DATE );