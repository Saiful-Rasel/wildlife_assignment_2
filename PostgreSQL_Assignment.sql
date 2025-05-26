-- Active: 1747806728960@@127.0.0.1@5432@conservation_db@public
--create table ranger\
CREATE Table rangers(
ranger_id SERIAL PRIMARY KEY,
name VARCHAR(50),
region VARCHAR(50)
);
INSERT INTO rangers
VALUES
(2, 'Asha Singh', 'Himalayan Foothills'),
(3, 'Carlos Mendez', 'Amazon Basin'),
(4, 'Fatima Noor', 'Sundarbans'),
(5, 'Liam O’Connor', 'Western Ghats'),
(6, 'Nina Patel', 'Kaziranga National Park');



-- create table species
CREATE Table species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(30)
);

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES
('Bengal Tiger', 'Panthera tigris tigris', '1900-03-15', 'Endangered'),
('Asian Elephant', 'Elephas maximus', '1800-05-22', 'Vulnerable'),
('Red Panda', 'Ailurus fulgens', '1825-09-10', 'Endangered'),
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Vulnerable'),
('Indian Peacock', 'Pavo cristatus', '1758-07-04', 'Least Concern');
select * from species;

-- create sightings table
CREATE Table sightings (
    sighting_id  SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location   VARCHAR(30), 
    sighting_time  TIMESTAMP WITH TIME ZONE,
    notes TEXT                 
);

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 2, 'North Forest', '2025-05-20 08:30:00+00', 'Saw a group near the river.'),
(2, 3, 'East Hills', '2025-05-21 14:15:00+00', 'Single animal grazing.'),
(1, 1, 'South Plains', '2025-05-22 10:00:00+00', 'Very active in the morning.'),
(3, 2, 'West Valley', '2025-05-23 16:45:00+00', 'Resting under a tree.'),
(4, 4, 'Central Lake', '2025-05-24 12:00:00+00', 'Seen near water.'),
(2, 1, 'North Forest', '2025-05-25 09:30:00+00', 'Heard calls but no direct sighting.'),
(3, 3, 'South Plains', '2025-05-25 18:00:00+00', 'Pack moving southwards.');
SELECT * from sightings;


--problem 1 

INSERT INTO  rangers VALUES(1,'Derek Fox','Coastal Plains');
SELECT * from rangers;

--problem 2 
SELECT DISTINCT count(*) as unique_species_count from species;
unique_species_count

--problem 3
SELECT * from sightings;
SELECT * from sightings WHERE location ilike   '%lake%';

--problem 4 
SELECT name,count(sighting_time) from sightings join rangers
 on rangers.ranger_id = sightings.sighting_id GROUP BY name;
select * from sightings;
 --problem 5
 select common_name from species LEFT join sightings
  on species.species_id = sightings.sighting_id WHERE sighting_id is null;

 --problem 6
 SELECT * from sightings;
 select sighting_time from sightings ORDER BY sighting_time ASC limit 2;


--problem 7
alter TABLE species ADD COLUMN status VARCHAR(50);
UPDATE species SET status = 'historic'  WHERE discovery_date <= '1800-01-01';
SELECT * FROM sightings;

--problem 8
SELECT sighting_id, to_char(sighting_time,'hh12:MI am'),
CASE 
    WHEN extract(hour from sighting_time) < 12 THEN  'moring'
   WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE  'evening'
END from sightings  ;

--problem 9
SELECT * from sightings WHERE species_id is null;
DELETE from  sightings WHERE species_id is null;
  