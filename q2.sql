SET search_path TO recording;
DROP TABLE IF EXISTS q2 CASCADE;

-- For each person in the database, 
-- report their ID and the number of recording sessions they have played at. 
-- Include everyone, even if they are a manager or engineer, 
-- and even if they never played at any sessions.
CREATE TABLE q2 (
	pID int NOT NULL,
	num_session int NOT NULL
);

-- Getting all attributes wanted.
DROP VIEW IF EXISTS Answer CASCADE;

CREATE VIEW Answer AS
select pID, count(sessionID) as num_session
from Person natural left join SessionPersonPlay
group by pID;

INSERT INTO q2 (select * from Answer);