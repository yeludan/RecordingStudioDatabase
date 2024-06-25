SET search_path TO recording;
DROP TABLE IF EXISTS q4 CASCADE;

-- Find the album that required the greatest number of recording sessions. 
-- Report the album ID and name, the number of recording sessions, 
-- and the number of different people who played on the album. 
-- If a person played both as part of a band and in a solo capacity, count them only once.
CREATE TABLE q4 (
	albumID int NOT NULL,
	album_name text NOT NULL,
    num_session int NOT NULL,
    num_people_played int NOT NULL
);

-- albumID with their number of recording sessions, 
-- and the number of their recording sessions, 
-- and the number of different people who played on those albums.
DROP VIEW IF EXISTS AlbumSessionPeople CASCADE;

CREATE VIEW AlbumSessionPeople AS
select albumID, count(distinct sessionID) as num_session, 
count(distinct pID) as num_people_played
from AlbumTrack natural join RecordingSegmentTrack 
natural join RecordingSegment natural join SessionPersonPlay
group by albumID;


-- Getting the max number of sessions.
DROP VIEW IF EXISTS MaxSession CASCADE;

CREATE VIEW MaxSession AS
select max(num_session) as max_num_session
from AlbumSessionPeople;


-- The albumID with the max number of recording sessions, 
-- and the number of its recording sessions, 
-- and the number of different people who played on that album.
DROP VIEW IF EXISTS AlbumMaxSessionPeople CASCADE;

CREATE VIEW AlbumMaxSessionPeople AS
select a.albumID, a.num_session, a.num_people_played
from MaxSession m join AlbumSessionPeople a on m.max_num_session = a.num_session;


-- Getting all attributes wanted.
DROP VIEW IF EXISTS Answer CASCADE;

CREATE VIEW Answer AS
select albumID, album_name, num_session, num_people_played
from AlbumMaxSessionPeople natural join Album;

INSERT INTO q4 (select * from Answer);