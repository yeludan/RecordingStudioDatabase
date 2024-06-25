SET search_path TO recording;
DROP TABLE IF EXISTS q3 CASCADE;

-- Find the recording session that produced 
-- the greatest total number of seconds of recording segments. 
-- Report the ID and name of everyone who played at that session, 
-- whether as part of a band or in a solo capacity.
CREATE TABLE q3 (
	pID int NOT NULL,
	pname text NOT NULL
);

-- Getting sessionID with total length of their recording segments. 
DROP VIEW IF EXISTS SessionTotalLength CASCADE;

CREATE VIEW SessionTotalLength AS
select sessionID, sum(length) as total_length
from RecordingSegment
group by sessionID;


-- Getting max total length among all sessions.
DROP VIEW IF EXISTS MaxTotalLength CASCADE;

CREATE VIEW MaxTotalLength AS
select max(total_length) as max_total_length
from SessionTotalLength;


-- Getting sessionID of the session that produced 
-- the greatest total number of seconds of recording segments.
DROP VIEW IF EXISTS SessionWanted CASCADE;

CREATE VIEW SessionWanted AS
select SessionTotalLength.sessionID
from SessionTotalLength join MaxTotalLength 
on SessionTotalLength.total_length = MaxTotalLength.max_total_length;


-- Getting all attributes wanted.
DROP VIEW IF EXISTS Answer CASCADE;

CREATE VIEW Answer AS
select pID, pname
from SessionWanted natural join SessionPersonPlay natural join Person;

INSERT INTO q3 (select * from Answer);