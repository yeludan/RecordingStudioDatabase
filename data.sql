SET SEARCH_PATH TO recording;


INSERT INTO 
	Studio(studio_name, address) 
VALUES
	('Pawnee Recording Studio', '123 Valley spring lane, Pawnee, Indiana'),
    ('Pawnee Sound', '353 Western Ave, Pawnee, Indiana'),
    ('Eagleton Recording Studio', '829 Division, Eagleton, Indiana');


INSERT INTO
    Person(pID, pname, email, phone)
VALUES
    (1231, 'April Ludgate', 'april_ludgate@gmail.com', ('1', '437', '9748888')),
    (1232, 'Leslie Knope', 'leslie_knope@gmail.com', ('1', '514', '9631234')),
    (1233, 'Donna Meagle', 'donna_meagle@gmail.com', ('1', '520', '2340098')),
    (1234, 'Tom Haverford', 'tom_haverford@gmail.com', ('1', '436', '9838887')),
    (5678, 'Ben Wyatt', 'ben_wyatt@gmail.com', ('1', '438', '7657788')),
    (6521, 'Chris Traeger', 'chris_traeger@gmail.com', ('1', '411', '8763221')),
    (9942, 'Ann Perkins', 'ann_perkins@gmail.com', ('1', '512', '9864321')),
    (1000, 'Duke Silver', 'duke_silver@gmail.com', ('1', '437', '8761111')),
    (2224, 'Michael Chang','michael_chang@gmail.com', ('1', '434', '9998765')),
    (4523, 'Andrew Burlinson', 'andrew_burlinson@gmail.com', ('1' ,'524', '8756765')),
    (6754, 'Andy Dwyer', 'andy_dwyer@gmail.com', ('1', '476', '2348887')),
    (7832, 'James Pierson', 'james_pierson@gmail.com', ('1', '467', '8973333'));


INSERT INTO
    ManageStudio(studioID, start_date, pID)
VALUES
    (1, '2008-03-21', 1231),
    (1, '2017-01-13', 1234),
    (1, '2018-12-02', 1233),
    (2, '2011-05-07', 1233),
    (3, '2010-09-05', 1232),
    (3, '2016-09-05', 1234),
    (3, '2020-09-05', 1232);


INSERT INTO
    Engineer(pID)
VALUES
    (5678),
    (6521),
    (9942);


INSERT INTO
    EngineerCertificate(pID, certification)
VALUES
    (5678, 'ABCDEFGH-123I'),
    (5678, 'JKLMNOPQ-456R'),
    (9942, 'SOUND-123-AUDIO');


INSERT INTO
    Band(band_name)
VALUES
    ('Mouse Rat');


INSERT INTO
    BandMembership(bandID, pID)
VALUES
    (1, 6754),
    (1, 4523),
    (1, 2224),
    (1, 7832);


INSERT INTO
    Session(studioID, start_time, end_time, fee)
VALUES
    (1, '2023-01-08 10:00:00', '2023-01-08 15:00:00', 1500),
    (1, '2023-01-10 13:00:00', '2023-01-11 14:00:00', 1500),
    (1, '2023-01-12 18:00:00', '2023-01-13 20:00:00', 1500),
    (1, '2023-03-10 11:00:00', '2023-03-10 23:00:00', 2000),
    (1, '2023-03-11 13:00:00', '2023-03-12 15:00:00', 2000),
    (1, '2023-03-13 10:00:00', '2023-03-13 20:00:00', 1000),
    (3, '2023-09-25 11:00:00', '2023-09-26 23:00:00', 1000),
    (3, '2023-09-29 11:00:00', '2023-09-30 23:00:00', 1000);


INSERT INTO
    SessionEngineer(sessionID, pID)
VALUES
    (1, 5678),
    (1, 9942),
    (2, 5678),
    (2, 9942),
    (3, 5678),
    (3, 9942),
    (4, 5678),
    (5, 5678),
    (6, 6521),
    (7, 5678),
    (8, 5678);


INSERT INTO
    SessionBandPlay(sessionID, bandID)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1);


INSERT INTO
    SessionPersonPlay(sessionID, pID)
VALUES
    (1, 6754),
    (1, 4523),
    (1, 2224),
    (1, 7832),
    (1, 1000),
    (2, 6754),
    (2, 4523),
    (2, 2224),
    (2, 7832),
    (2, 1000),
    (3, 6754),
    (3, 4523),
    (3, 2224),
    (3, 7832),
    (3, 1000),
    (4, 6754),
    (4, 4523),
    (4, 2224),
    (4, 7832),
    (5, 6754),
    (5, 4523),
    (5, 2224),
    (5, 7832),
    (6, 6754),
    (6, 1234),
    (7, 6754),
    (8, 6754);


INSERT INTO
    RecordingSegment(length, format, sessionID)
VALUES
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 1),
    (60, 'WAV', 2),
    (60, 'WAV', 2),
    (60, 'WAV', 2),
    (60, 'WAV', 2),
    (60, 'WAV', 2),
    (60, 'WAV', 3),
    (60, 'WAV', 3),
    (60, 'WAV', 3),
    (60, 'WAV', 3),
    (120, 'WAV', 4),
    (120, 'WAV', 4),
    (60, 'WAV', 6),
    (60, 'WAV', 6),
    (60, 'WAV', 6),
    (60, 'WAV', 6),
    (60, 'WAV', 6),
    (180, 'AIFF', 7),
    (180, 'AIFF', 7),
    (180, 'AIFF', 7),
    (180, 'AIFF', 7),
    (180, 'AIFF', 7),
    (180, 'AIFF', 7),
    (180, 'AIFF', 7),
    (180, 'AIFF', 7),
    (180, 'AIFF', 7),
    (180, 'WAV', 8),
    (180, 'WAV', 8),
    (180, 'WAV', 8),
    (180, 'WAV', 8),
    (180, 'WAV', 8),
    (180, 'WAV', 8);


INSERT INTO
    Track(track_name)
VALUES
    ('5,000 Candles in the Wind'),
    ('Catch Your Dream'),
    ('May Song'),
    ('The Pit'),
    ('Remember'),
    ('The Way You Look Tonight'),
    ('Another Song');


INSERT INTO
    RecordingSegmentTrack(recordID, trackID)
VALUES
    (11, 1),
    (12, 1),
    (13, 1),
    (14, 1),
    (15, 1),
    (16, 2),
    (17, 2),
    (18, 2),
    (19, 2),
    (20, 2),
    (21, 2),
    (22, 1),
    (23, 1),
    (24, 1),
    (25, 1),
    (26, 1),
    (22, 2),
    (23, 2),
    (24, 2),
    (25, 2),
    (26, 2),
    (32, 3),
    (33, 3),
    (34, 4),
    (35, 4),
    (36, 5),
    (37, 5),
    (38, 6),
    (39, 6),
    (40, 7),
    (41, 7);


INSERT INTO
    Album(albumID, album_name, release_date)
VALUES
    (1, 'The Awesome Album', '2023-05-25'),
    (2, 'Another Awesome Album', '2023-10-29');


INSERT INTO
    AlbumTrack(albumID, trackID)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (2, 5),
    (2, 6),
    (2, 7);