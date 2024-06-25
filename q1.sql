SET search_path TO recording;
DROP TABLE IF EXISTS q1 CASCADE;

-- For each studioID, report the pID and pname of its current manager, 
-- and the number of albums it has contributed to. 
-- A studio contributed to an album iff 
-- at least one recording segment recorded there is part of that album.
CREATE TABLE q1 (
	studioID int NOT NULL,
	pID int NOT NULL,
	pname text NOT NULL,
	num_album int NOT NULL
);

-- Temporary step in getting pID and pname of current manager for every Studio.
DROP VIEW IF EXISTS TmpStudioCurrentManager CASCADE;

CREATE VIEW TmpStudioCurrentManager AS
select studioID, max(start_date) as start_date
from ManageStudio
group by studioID;


-- Getting pID and pname of current manager for every Studio.
DROP VIEW IF EXISTS StudioCurrentManager CASCADE;

CREATE VIEW StudioCurrentManager AS
select studioID, pID, pname
from TmpStudioCurrentManager natural join ManageStudio natural join Person;


-- Number of albums every studio has contributed to.
DROP VIEW IF EXISTS StudioAlbum CASCADE;

CREATE VIEW StudioAlbum AS
select studioID, count(distinct albumID) as num_album
from AlbumTrack natural join RecordingSegmentTrack 
natural join RecordingSegment natural join Session 
natural right join Studio
group by studioID;


-- Getting all attributes wanted.
DROP VIEW IF EXISTS Answer CASCADE;

CREATE VIEW Answer AS
select studioID, pID, pname, num_album
from StudioCurrentManager natural join StudioAlbum;

INSERT INTO q1 (select * from Answer);