-- Could not be enforced without assertions or triggers:
-- Every sessionID in Session must appear in SessionEngineer 
-- at least once and at most 3 times. 
-- (Each session has at least 1 and at most 3 engineers.)
-- Every sessionID in Session must appear in SessionPersonPlay. 
-- (At least 1 person playing on each session.)
-- Every bandID in Band must appear in Membership. 
-- (Every band has at least one person in it.)
-- Every studioID in Studio must appear in ManageStudio.
-- Every albumID in Album must appear in AlbumTrack for at least twice. 
-- (Each album has at least 2 tracks.)
-- Every trackID in Track must appear in AlbumTrack for at least once. 
-- (Each track must appear on at least one album).

-- Did not:
-- Every session has at least 1 engineers. 
-- I could alter table and add foreign key constraint of sessionID 
-- in Session referencing to SessionEngineer. But I did not do that. 
-- Since if I did that, there would be a circular for foreign key constraints 
-- between Session and SessionEngineer, making troubles in inserting new values.
-- The same for at least 1 person playing on each session. 
-- Circular between Session and SessionPersonPlay.
-- The same for every studioID in Studio must appear in ManageStudio.
-- Circular between Studio and ManageStudio.
-- The same for each track must appearing on at least one album. 
-- Circular between Track and AlbumTrack.

-- Assumptions:
-- studioID, sessionID, bandID, recordID, trackID, and albumID 
-- can be deleted but cannot be updated.
-- pID cannot be deleted or updated.
-- sessionID cannot be deleted as long as there is a person 
-- has played in this session (the start_time has passed).
-- studioID cannot be deleted as long as there is a session already happened. 
-- Use boolean attribute in_business to indicate whether this studio is in business or not.

drop schema if exists recording cascade;
create schema recording;
set search_path to recording;

-- Every studio has a studioID as primary key.
-- It has studio_name, address, and whether it is in business (default in true). 
-- studio_name and address together is unique.
CREATE TABLE Studio (
    studioID serial PRIMARY KEY,
    studio_name text NOT NULL,
    address text NOT NULL,
    in_business bool NOT NULL DEFAULT true,
    UNIQUE (studio_name, address)
);

-- Every recording session has sessionID as primary key.
-- Every session is associated with one studio.
-- Two sessions mustn’t start at the same time in the same studio.
-- That is, studioID and start_time together is unique.
-- Every session also has end_time and fee.
CREATE TABLE Session (
    sessionID serial PRIMARY KEY,
    studioID int NOT NULL REFERENCES Studio,
    start_time timestamp NOT NULL,
    end_time timestamp NOT NULL,
    fee int NOT NULL,
    UNIQUE (studioID, start_time)
);

-- phone_number is comprised of 1-character country_code, 
-- 3-character area comprised, and 7-character local_number.
CREATE TYPE phone_number AS (
    country_code char(1),
    area_code char(3),
    local_number char(7)
); 

-- Every person has pID as primary key.
-- Every person also has a pname, an email, and a phone_number.
CREATE TABLE Person (
    pID int NOT NULL PRIMARY KEY,
    pname text NOT NULL,
    email text NOT NULL,
    phone phone_number NOT NULL
);

-- Every engineer has a pID as primary key.
CREATE TABLE Engineer (
    pID int NOT NULL PRIMARY KEY REFERENCES Person
);

-- Engineers may have one or more certifications.
CREATE TABLE EngineerCertificate (
    pID int NOT NULL REFERENCES Engineer,
    certification text NOT NULL,
    PRIMARY KEY (pID, certification)
);

-- Every sessionID in Session must appear in SessionEngineer 
-- at least once and at most 3 times. 
-- (Each session has at least 1 and at most 3 engineers.)
CREATE TABLE SessionEngineer (
    sessionID int NOT NULL REFERENCES Session ON DELETE CASCADE,
    pID int NOT NULL REFERENCES Person,
    PRIMARY KEY (sessionID, pID)
);

-- Every band has bandID as primary key. It also has a band_name.
CREATE TABLE Band (
    bandID serial PRIMARY KEY,
    band_name text NOT NULL
);

-- Every bandID in Band must appear in BandMembership. 
-- (Every band has at least one person in it.)
CREATE TABLE BandMembership (
    bandID int NOT NULL REFERENCES Band ON DELETE CASCADE,
    pID int NOT NULL REFERENCES Person,
    PRIMARY KEY (bandID, pID)
);

-- Some session has a band played on.
CREATE TABLE SessionBandPlay (
    sessionID int NOT NULL REFERENCES Session ON DELETE CASCADE,
    bandID int NOT NULL REFERENCES Band ON DELETE CASCADE,
    PRIMARY KEY (sessionID, bandID)
);

-- Every sessionID in Session must appear in SessionPersonPlay. 
-- (At least 1 person playing on each session.)
CREATE TABLE SessionPersonPlay (
    sessionID int NOT NULL REFERENCES Session ON DELETE CASCADE,
    pID int NOT NULL REFERENCES Person,
    PRIMARY KEY (sessionID, pID)
);

-- Every studioID in Studio must appear in ManageStudio.
-- Each studio has one manager at any one time, 
-- but that manager can change over time. 
-- We record the history of a studio’s managers by recording their start dates. 
-- You can assume that there are no gaps in management; 
-- a manager is in their role until the day when the next manager begins.
-- That is, studioID and start_date together is unique.
CREATE TABLE ManageStudio (
    studioID int NOT NULL REFERENCES Studio ON DELETE CASCADE,
    start_date date NOT NULL,
    pID int NOT NULL REFERENCES Person,
    PRIMARY KEY (studioID, start_date)
);

-- Every recording segment has recordID as primary key.
-- It also has a length in seconds, a format.
-- A recording segment is the product of exactly 1 recording session.
-- Everyone plays at that session is considered to have played 
-- on every segment recorded during that session.
CREATE TABLE RecordingSegment (
    recordID serial PRIMARY KEY,
    length int NOT NULL,
    format text NOT NULL,
    sessionID int NOT NULL REFERENCES Session
);

-- Every track has trackID as its primary key. It also has a track_name.
CREATE TABLE Track (
    trackID serial PRIMARY KEY,
    track_name text NOT NULL
);

-- A record segment may be used on multiple tracks or on none. 
-- A track usually includes multiple segments.
-- So we have recordID and trackID together as primary key.
CREATE TABLE RecordingSegmentTrack (
    recordID int NOT NULL REFERENCES RecordingSegment ON DELETE CASCADE,
    trackID int NOT NULL REFERENCES Track ON DELETE CASCADE,
    PRIMARY KEY (recordID, trackID)
);

-- Every album has albumID as primary key. It also has an album_name and release_date.
CREATE TABLE Album (
    albumID int NOT NULL PRIMARY KEY,
    album_name text NOT NULL,
    release_date date NOT NULL
);

-- Every albumID in Album must appear in AlbumTrack for at least twice. 
-- (Each album has at least 2 tracks.)
-- Every trackID in Track must appear in AlbumTrack for at least once. 
-- (Each track must appear on at least one album).
CREATE TABLE AlbumTrack (
    albumID int NOT NULL REFERENCES Album ON DELETE CASCADE,
    trackID int NOT NULL REFERENCES Track ON DELETE CASCADE,
    PRIMARY KEY (albumID, trackID)
);
