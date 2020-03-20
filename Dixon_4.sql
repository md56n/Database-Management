/*
Dawn Dixon
3-19-2020
CS 470
HW 4
*/

/* STEP 3 */
CREATE SCHEMA hw4;


/* STEP 4 */
USE hw4;


/* STEP 5 */
CREATE TABLE runner (
	RunnerID INT NOT NULL,
    First VARCHAR(30) NOT NULL,
    Last VARCHAR(45) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Password VARCHAR(32) NOT NULL,
    PRIMARY KEY (RunnerID),
    UNIQUE INDEX (Email));


/* STEP 6 */
INSERT INTO runner(RunnerID, First, Last, Email, Password)
	VALUES (1, 'Ada', 'Lovelace', 'lovelacea@umkc.com', 'abc123');

SELECT RunnerID, First, Last, Email, Password FROM runner;

/*INSERT INTO runner(RunnerID, First, Last, Email, Password)
	VALUES (null, 'Ada', 'Lovelace', 'lovelacea2@umkc.com', 'abc123');
*/
/*INSERT INTO runner(RunnerID, First, Last, Email, Password)
	VALUES (2, 'Ad', 'Love', 'lovelacea@umkc.com', 'abc');
*/

/* STEP 7 */
INSERT INTO runner(RunnerID, First, Last, Email, Password)
	VALUES (2, 'Alan', 'Turing', 'ta@umkc.com', 'enigma');

INSERT INTO runner(RunnerID, First, Last, Email, Password)
	VALUES (3, 'Albert', 'Einstein', 'ae@umkc.com', 'Relativity');


/* STEP 8 */
CREATE TABLE event (
	event_id INT NOT NULL,
    event_name VARCHAR(30) NOT NULL,
    event_date DATE NOT NULL,
    address VARCHAR(200),
    charity VARCHAR(100),
    PRIMARY KEY (event_id));
 
 
/* STEP 9 */   
CREATE UNIQUE INDEX event_name_idx ON event(event_name ASC);

CREATE INDEX event_date_idx ON event(event_date ASC);


/* STEP 10 */   
INSERT INTO event(event_id, event_name, event_date, address, charity)
	VALUES (1, 'RooUP', '2020-04-01', 'KC', NULL);

INSERT INTO event(event_id, event_name, event_date, address, charity)
	VALUES (2, 'Star wars race', '2020-05-04', 'Leawood', 'CM');

INSERT INTO event(event_id, event_name, event_date, address, charity)
	VALUES (3, 'Towel Day races', '2020-05-25', 'Blue Spring', 'Zaphod House');

/* STEP 11 */
/*INSERT INTO event(event_id, event_name, event_date, address, charity)
	VALUES (4, 'Towel Day races', '05/25/2020', 'Blue Spring', 'Zaphod House');
*/

/* STEP 12 */
SELECT event_id, event_name, event_date, address, charity FROM event;


/* STEP 13 */
CREATE TABLE race (
	race_id INT NOT NULL,
    unit INT,
    distance decimal(10, 2),
    event_id INT,
    PRIMARY KEY (race_id));

INSERT INTO race(race_id, unit, distance, event_id)
	VALUES (1, 1, 5, 1);

INSERT INTO race(race_id, unit, distance, event_id)
	VALUES (2, 0, 26.2, 2);

INSERT INTO race(race_id, unit, distance, event_id)
	VALUES (3, 1, 10, 2);

INSERT INTO race(race_id, unit, distance, event_id)
	VALUES (4, 1, 5, 2);

INSERT INTO race(race_id, unit, distance, event_id)
	VALUES (5, 1, 5, 3);


/* STEP 14 */
INSERT INTO race(race_id, unit, distance, event_id)
	VALUES(6, 1, 5, 20);

DELETE FROM race WHERE race_id = 6;


/* STEP 15 */
ALTER TABLE race ADD CONSTRAINT FK_race_eventid FOREIGN KEY (event_id) REFERENCES event(event_id);

/*INSERT INTO race(race_id, unit, distance, event_id)
	VALUES(10, 1, 5, 30);
*/

/* STEP 16 */
CREATE TABLE runner_race (
	RunnerID INT NOT NULL,
	Race_id INT NOT NULL,
    race_time decimal(10, 4),
    PRIMARY KEY (RunnerID, Race_id),
    FOREIGN KEY (RunnerID) REFERENCES runner(RunnerID),
    FOREIGN KEY (Race_id) REFERENCES race(race_id));
    
INSERT INTO runner_race(RunnerID, Race_id, race_time)
	VALUES(1, 1, 15.35);
    
INSERT INTO runner_race(RunnerID, Race_id, race_time)
	VALUES(1, 2, 258.2215);

INSERT INTO runner_race(RunnerID, Race_id, race_time)
	VALUES(2, 1, 18.23);

INSERT INTO runner_race(RunnerID, Race_id, race_time)
	VALUES(3, 4, 22.581);

INSERT INTO runner_race(RunnerID, Race_id, race_time)
	VALUES(2, 5, NULL);
    

/* STEP 17 */
SELECT RunnerID, First, Last, Email FROM runner ORDER BY Last;

/* STEP 18 */
SELECT RunnerID, First, Last, Email FROM runner WHERE (LOCATE('e', LAST) > 0) ORDER BY Last;

/* STEP 19 */
SELECT event_id, event_name, event_date FROM event WHERE (event_date BETWEEN '2020-04-01' AND '2020-04-30');

/* STEP 20 */
SELECT event_name, event_date, race_id FROM event, race WHERE (race.unit = 0 AND race.distance = 5.00 AND event.event_id = race.event_id) GROUP BY race.event_id;

/* STEP 21 */
SELECT First, Last, Email, runner.RunnerID, COUNT(*) FROM runner_race, runner WHERE runner.RunnerID = runner_race.RunnerID GROUP BY runner_race.RunnerID;

/* STEP 22 */
SELECT First, Last, Email FROM runner_race, runner, event, race WHERE runner.RunnerID = runner_race.RunnerID AND runner_race.Race_id = race.race_id AND race.event_id = event.event_id AND event.event_name = 'RooUP';

/* STEP 23 */
SELECT First, Last, Email FROM runner_race, runner, event, race WHERE runner.RunnerID = runner_race.RunnerID AND runner_race.Race_id = race.race_id AND race.event_id = event.event_id AND First NOT IN (SELECT DISTINCT(First) FROM runner_race, runner, event, race WHERE runner.RunnerID = runner_race.RunnerID AND runner_race.Race_id = race.race_id AND race.event_id = event.event_id AND event.event_name = 'RooUP');

/*STEP 24 */
SELECT runner.RunnerID, First, Last, event_name, race_time, race.race_id FROM runner_race, runner, event, race WHERE runner.RunnerID = runner_race.RunnerID AND runner_race.Race_id = race.race_id AND race.event_id = event.event_id AND runner_race.race_time IS NULL;

/* STEP 25 */
SELECT event_name, distance, unit, COUNT(*), MIN(race_time) FROM runner_race, runner, event, race WHERE runner.RunnerID = runner_race.RunnerID AND runner_race.Race_id = race.race_id AND race.event_id = event.event_id GROUP BY event_name, distance;
