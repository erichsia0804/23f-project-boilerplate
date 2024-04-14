-- This file is to bootstrap a database for the CS3200 project.

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith
-- data source creation.
DROP DATABASE IF EXISTS cool_db;
create database cool_db;

-- Via the Docker Compose file, a special user called webapp will
-- be created in MySQL. We are going to grant that user
-- all privilages to the new database we just created.
-- TODO: If you changed the name of the database above, you need
-- to change it here too.
grant all privileges on cool_db.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too.
use cool_db;

-- Put your DDL
CREATE TABLE IF NOT EXISTS Language(
    LanguageID INT PRIMARY KEY,
    DifficultyLevel VARCHAR(50) NOT NULL,
    Name VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS LearningMaterials(
    MaterialID INT PRIMARY KEY,
    MaterialType VARCHAR(100) NOT NULL,
    LanguageID INT NOT NULL,
    ComplexityLevel VARCHAR(50) NOT NULL,
    FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID)
);

CREATE TABLE IF NOT EXISTS Traveler(
    TravelerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CountryOfOrigin VARCHAR(100) NOT NULL,
    NativeLanguage VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Country(
    CountryID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Language VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Teacher(
    TeacherID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Education VARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    NativeLanguage VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Student(
    StudentID INT PRIMARY KEY,
    Grades DECIMAL(5, 2),
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CountryOfOrigin VARCHAR(100) NOT NULL,
    NativeLanguage VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Class(
    ClassID INT PRIMARY KEY,
    Duration INT NOT NULL,
    DateTime DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS Learner(
    LearnerID INT PRIMARY KEY,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CountryOfOrigin VARCHAR(100) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    NativeLanguage VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Community(
    CommunityID INT PRIMARY KEY,
    Language VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Has (
    MaterialID INT NOT NULL,
    LanguageID INT NOT NULL,
    PRIMARY KEY (MaterialID, LanguageID),
    FOREIGN KEY (MaterialID) REFERENCES LearningMaterials(MaterialID),
    FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID)
);

CREATE TABLE IF NOT EXISTS Learns (
    ProficiencyLevel INT,
    StudentID INT NOT NULL,
    LanguageID INT NOT NULL,
    LearnerID INT NOT NULL,
    TravelerID INT NOT NULL,
    PRIMARY KEY (StudentID, LanguageID, LearnerID, TravelerID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (TravelerID) REFERENCES Traveler(TravelerID)
);

CREATE TABLE IF NOT EXISTS Country_language (
    Language VARCHAR(100) NOT NULL,
    CountryID INT NOT NULL,
    PRIMARY KEY (Language, CountryID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

CREATE TABLE IF NOT EXISTS Travels_to (
    TravelDuration INT NOT NULL,
    TravelerID INT NOT NULL,
    CountryID INT NOT NULL,
    PRIMARY KEY (TravelerID, CountryID),
    FOREIGN KEY (TravelerID) REFERENCES Traveler(TravelerID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

CREATE TABLE IF NOT EXISTS Traveler_nativelanguage (
    NativeLanguage VARCHAR(100) NOT NULL,
    TravelerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CountryOfOrigin VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Teaches (
    TeacherID INT NOT NULL,
    LanguageID INT NOT NULL,
    PRIMARY KEY (TeacherID, LanguageID),
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID),
    FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID)
);

CREATE TABLE IF NOT EXISTS Teacher_education (
    Education VARCHAR(100) NOT NULL,
    TeacherID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CountryOfOrigin VARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    NativeLanguage VARCHAR(100) NOT NULL,
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID)
);

CREATE TABLE IF NOT EXISTS TeacherNativelanguage (
    NativeLanguage VARCHAR(100) NOT NULL,
    TeacherID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CountryOfOrigin VARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    Education VARCHAR(100) NOT NULL,
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID)
);

CREATE TABLE IF NOT EXISTS Supports (
    ClassID INT NOT NULL,
    MaterialID INT NOT NULL,
    LanguageID INT NOT NULL,
    PRIMARY KEY (ClassID, MaterialID, LanguageID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    FOREIGN KEY (MaterialID) REFERENCES LearningMaterials(MaterialID),
    FOREIGN KEY (LanguageID) REFERENCES Language(LanguageID)
);

CREATE TABLE IF NOT EXISTS Attends (
    ClassID INT NOT NULL,
    StudentID INT NOT NULL,
    PRIMARY KEY (ClassID, StudentID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

CREATE TABLE IF NOT EXISTS Holds (
    ClassID INT NOT NULL,
    TeacherID INT NOT NULL,
    PRIMARY KEY (ClassID, TeacherID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID)
);

CREATE TABLE IF NOT EXISTS Student_nativelanguage (
    NativeLanguage VARCHAR(100) NOT NULL,
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CountryOfOrigin VARCHAR(100) NOT NULL,
    Grade INT NOT NULL

);

CREATE TABLE IF NOT EXISTS Joins (
    LearnerID INT NOT NULL,
    CommunityID INT NOT NULL,
    PRIMARY KEY (LearnerID, CommunityID),
    FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID),
    FOREIGN KEY (CommunityID) REFERENCES Community(CommunityID)
);

CREATE TABLE IF NOT EXISTS LearnerNativelanguage (
    NativeLanguage VARCHAR(100) NOT NULL,
    LearnerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    CountryOfOrigin VARCHAR(100) NOT NULL
);


# Altering Missed Keys
ALTER TABLE Student_nativelanguage
ADD CONSTRAINT fk_01
FOREIGN KEY (StudentID) REFERENCES Student(StudentID);

ALTER TABLE LearnerNativelanguage
ADD CONSTRAINT fk_02
FOREIGN KEY (LearnerID) REFERENCES Learner(LearnerID);

ALTER TABLE Traveler_nativelanguage
ADD CONSTRAINT fk_03
FOREIGN KEY (TravelerID) REFERENCES Traveler(TravelerID);

-- Add sample data.

insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (1, 3, 'Alfredo', 26, 'aexter0@sphinn.com', 16, 39);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (2, 2, 'Kathlin', 20, 'kchasmor1@admin.ch', 18, 36);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (3, 2, 'Waylin', 26, 'wstoppe2@edublogs.org', 17, 36);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (4, 1, 'Cassondra', 21, 'ctuckey3@arizona.edu', 34, 44);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (5, 2, 'Dunc', 22, 'djime4@cocolog-nifty.com', 13, 30);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (6, 4, 'Sutherlan', 22, 'scuchey5@xrea.com', 32, 4);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (7, 2, 'Devan', 20, 'dfogt6@jigsy.com', 45, 7);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (8, 2, 'Darb', 21, 'dtowsie7@army.mil', 13, 40);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (9, 2, 'Fanya', 20, 'fmarkey8@time.com', 37, 6);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (10, 3, 'Binky', 22, 'bflorio9@baidu.com', 31, 13);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (11, 3, 'Lily', 24, 'lcleatherowa@xing.com', 7, 20);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (12, 4, 'Edgard', 20, 'etidballb@paypal.com', 36, 41);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (13, 2, 'Lee', 19, 'lpadburyc@state.tx.us', 4, 13);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (14, 2, 'Gabriell', 24, 'golochand@tamu.edu', 7, 17);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (15, 1, 'Hanson', 27, 'hquartermaine@shop-pro.jp', 26, 38);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (16, 2, 'Ravid', 23, 'rjakovijevicf@cnbc.com', 27, 44);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (17, 2, 'Natale', 19, 'ndobesong@youku.com', 31, 7);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (18, 3, 'Dorolisa', 21, 'ddorosarioh@si.edu', 22, 2);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (19, 4, 'Lucila', 27, 'ljerzykiewiczi@ca.gov', 6, 5);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (20, 3, 'Lem', 28, 'lpadgintonj@slate.com', 37, 48);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (21, 1, 'Crissie', 21, 'chaynesfordk@1und1.de', 45, 45);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (22, 3, 'Huey', 28, 'hwaylettl@sitemeter.com', 38, 41);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (23, 1, 'Vittorio', 28, 'vhaslehurstm@weather.com', 48, 37);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (24, 2, 'Karee', 26, 'kmoenn@digg.com', 47, 9);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (25, 3, 'Elbert', 25, 'ekindleo@zdnet.com', 2, 7);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (26, 2, 'Clara', 25, 'crainsp@imageshack.us', 10, 7);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (27, 2, 'Anthia', 18, 'arenneq@ovh.net', 24, 50);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (28, 2, 'Regan', 18, 'rtankusr@gmpg.org', 21, 46);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (29, 2, 'Reinaldos', 27, 'rskipseas@usgs.gov', 33, 24);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (30, 2, 'Hansiain', 28, 'hsheathert@drupal.org', 6, 28);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (31, 1, 'Perkin', 22, 'pfeyeu@aboutads.info', 6, 30);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (32, 1, 'Raquel', 27, 'rbastiev@mit.edu', 37, 5);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (33, 1, 'Ryan', 18, 'rilchukw@zimbio.com', 27, 31);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (34, 3, 'Karlis', 26, 'kmarringtonx@loc.gov', 37, 36);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (35, 1, 'Wally', 22, 'weastabrooky@ca.gov', 12, 22);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (36, 3, 'Mandi', 23, 'mruberyz@github.com', 14, 13);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (37, 4, 'Enid', 28, 'elemonnier10@msn.com', 20, 26);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (38, 2, 'Jacklin', 28, 'jgagan11@ucoz.com', 32, 47);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (39, 1, 'Rafaelita', 27, 'rmaughan12@yale.edu', 33, 21);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (40, 2, 'Rhonda', 19, 'rtofanelli13@pcworld.com', 22, 34);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (41, 3, 'Paola', 21, 'pkerslake14@mashable.com', 49, 48);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (42, 1, 'Vick', 26, 'vduckerin15@mail.ru', 47, 45);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (43, 2, 'Valeda', 28, 'vmcdonough16@mediafire.com', 34, 33);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (44, 3, 'Bary', 27, 'bhanmore17@freewebs.com', 6, 1);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (45, 3, 'Coop', 27, 'cmclellan18@timesonline.co.uk', 5, 20);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (46, 1, 'Jemie', 19, 'jcashin19@com.com', 8, 21);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (47, 4, 'Lynette', 19, 'lmilhench1a@google.pl', 23, 42);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (48, 3, 'Loren', 22, 'lhalliberton1b@tinypic.com', 14, 37);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (49, 1, 'Mariska', 24, 'mkamiyama1c@dion.ne.jp', 24, 36);
insert into Student (studentid, grades, name, age, email, countryoforigin, nativelanguage) values (50, 4, 'Codie', 23, 'cblanchflower1d@dropbox.com', 22, 35);


insert into Language (languageid, difficultylevel, name) values (1, 5, 'Liesa');
insert into Language (languageid, difficultylevel, name) values (2, 5, 'Kayle');
insert into Language (languageid, difficultylevel, name) values (3, 1, 'Brenden');
insert into Language (languageid, difficultylevel, name) values (4, 4, 'Edy');
insert into Language (languageid, difficultylevel, name) values (5, 3, 'Hayden');
insert into Language (languageid, difficultylevel, name) values (6, 4, 'Nelle');
insert into Language (languageid, difficultylevel, name) values (7, 2, 'Lonni');
insert into Language (languageid, difficultylevel, name) values (8, 3, 'Stephan');
insert into Language (languageid, difficultylevel, name) values (9, 5, 'Valentino');
insert into Language (languageid, difficultylevel, name) values (10, 4, 'Sherwin');
insert into Language (languageid, difficultylevel, name) values (11, 5, 'Gayle');
insert into Language (languageid, difficultylevel, name) values (12, 5, 'Kenneth');
insert into Language (languageid, difficultylevel, name) values (13, 4, 'Culver');
insert into Language (languageid, difficultylevel, name) values (14, 4, 'Padraig');
insert into Language (languageid, difficultylevel, name) values (15, 2, 'Meredith');
insert into Language (languageid, difficultylevel, name) values (16, 4, 'Nadeen');
insert into Language (languageid, difficultylevel, name) values (17, 2, 'Sebastien');
insert into Language (languageid, difficultylevel, name) values (18, 5, 'Neal');
insert into Language (languageid, difficultylevel, name) values (19, 5, 'Sukey');
insert into Language (languageid, difficultylevel, name) values (20, 1, 'Winifield');
insert into Language (languageid, difficultylevel, name) values (21, 5, 'Henry');
insert into Language (languageid, difficultylevel, name) values (22, 5, 'Rodrigo');
insert into Language (languageid, difficultylevel, name) values (23, 3, 'Maxim');
insert into Language (languageid, difficultylevel, name) values (24, 5, 'Linoel');
insert into Language (languageid, difficultylevel, name) values (25, 5, 'Benedicto');
insert into Language (languageid, difficultylevel, name) values (26, 1, 'Lyndy');
insert into Language (languageid, difficultylevel, name) values (27, 2, 'Nehemiah');
insert into Language (languageid, difficultylevel, name) values (28, 3, 'Lewie');
insert into Language (languageid, difficultylevel, name) values (29, 2, 'Emeline');
insert into Language (languageid, difficultylevel, name) values (30, 1, 'Ganny');
insert into Language (languageid, difficultylevel, name) values (31, 4, 'Ewan');
insert into Language (languageid, difficultylevel, name) values (32, 4, 'Haywood');
insert into Language (languageid, difficultylevel, name) values (33, 3, 'Loutitia');
insert into Language (languageid, difficultylevel, name) values (34, 4, 'Mella');
insert into Language (languageid, difficultylevel, name) values (35, 3, 'Shirline');
insert into Language (languageid, difficultylevel, name) values (36, 1, 'Cory');
insert into Language (languageid, difficultylevel, name) values (37, 2, 'Scotty');
insert into Language (languageid, difficultylevel, name) values (38, 2, 'Niles');
insert into Language (languageid, difficultylevel, name) values (39, 2, 'Vicky');
insert into Language (languageid, difficultylevel, name) values (40, 2, 'Alicea');
insert into Language (languageid, difficultylevel, name) values (41, 3, 'Armstrong');
insert into Language (languageid, difficultylevel, name) values (42, 1, 'Carma');
insert into Language (languageid, difficultylevel, name) values (43, 2, 'Arlyne');
insert into Language (languageid, difficultylevel, name) values (44, 2, 'Kara-lynn');
insert into Language (languageid, difficultylevel, name) values (45, 3, 'Damaris');
insert into Language (languageid, difficultylevel, name) values (46, 4, 'Randi');
insert into Language (languageid, difficultylevel, name) values (47, 2, 'Terri');
insert into Language (languageid, difficultylevel, name) values (48, 1, 'Carleen');
insert into Language (languageid, difficultylevel, name) values (49, 1, 'Rosana');
insert into Language (languageid, difficultylevel, name) values (50, 1, 'Hatti');



insert into Student_nativelanguage (nativelanguage, studentid, name, age, email, countryoforigin, grade) values (23, 1, 'Carla', 18, 'cwallerbridge0@virginia.edu', 23, 2);
insert into Student_nativelanguage (nativelanguage, studentid, name, age, email, countryoforigin, grade) values (20, 2, 'Shirlene', 25, 'stawse1@spotify.com', 14, 1);
insert into Student_nativelanguage (nativelanguage, studentid, name, age, email, countryoforigin, grade) values (35, 3, 'Randi', 26, 'rroan2@topsy.com', 2, 2);



insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (1, 20, 'mcoggon0@cnn.com', 24, 'Margery', 6);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (2, 21, 'tferrero1@examiner.com', 29, 'Timmie', 21);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (3, 27, 'bwybern2@yolasite.com', 33, 'Bettye', 48);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (4, 29, 'fdarmody3@shutterfly.com', 7, 'Frieda', 19);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (5, 26, 'lmilvarnie4@yahoo.co.jp', 14, 'Leandra', 15);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (6, 29, 'mguise5@storify.com', 13, 'Mersey', 14);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (7, 33, 'ldytham6@indiatimes.com', 14, 'Laurie', 14);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (8, 25, 'fcoysh7@about.com', 46, 'Ferguson', 5);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (9, 24, 'gheningam8@hp.com', 34, 'Guido', 10);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (10, 22, 'clidgate9@soundcloud.com', 40, 'Cody', 36);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (11, 26, 'blamonbya@dot.gov', 13, 'Brigit', 33);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (12, 26, 'lrosoneb@ow.ly', 9, 'Lawton', 48);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (13, 28, 'lruggc@bbc.co.uk', 40, 'Lib', 13);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (14, 29, 'csheald@cisco.com', 25, 'Cindra', 21);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (15, 26, 'nsherwine@patch.com', 26, 'Nell', 14);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (16, 20, 'cundrellf@ftc.gov', 1, 'Cosimo', 48);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (17, 26, 'hstainingg@stanford.edu', 19, 'Harri', 10);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (18, 23, 'egyverh@harvard.edu', 49, 'Ernestus', 46);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (19, 22, 'gsmalridgei@wired.com', 13, 'Gardner', 7);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (20, 18, 'fbaberj@fastcompany.com', 5, 'Faustine', 20);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (21, 32, 'hburlk@github.io', 22, 'Hogan', 17);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (22, 21, 'iemerl@github.io', 29, 'Ignacius', 15);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (23, 19, 'lcuddem@chronoengine.com', 4, 'Lacy', 26);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (24, 28, 'bpersichn@kickstarter.com', 30, 'Berty', 16);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (25, 25, 'smatashkino@house.gov', 9, 'Shawn', 12);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (26, 32, 'tclemowp@nasa.gov', 44, 'Terra', 41);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (27, 24, 'jbrittq@springer.com', 47, 'Jesse', 45);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (28, 18, 'mlawelesr@mysql.com', 30, 'Mercedes', 49);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (29, 33, 'usamarts@tamu.edu', 30, 'Uri', 39);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (30, 24, 'zbullast@ihg.com', 9, 'Zonnya', 43);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (31, 22, 'ldemchenu@privacy.gov.au', 5, 'Lianne', 49);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (32, 21, 'klyonv@pcworld.com', 27, 'Kit', 1);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (33, 18, 'tstandidgew@discovery.com', 38, 'Terry', 3);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (34, 25, 'ebeechx@irs.gov', 31, 'Ellynn', 31);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (35, 26, 'kakselly@mashable.com', 23, 'Kaycee', 27);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (36, 27, 'amartinelliz@oaic.gov.au', 43, 'Arney', 40);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (37, 28, 'ctrahear10@webmd.com', 36, 'Camile', 18);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (38, 22, 'shaddrell11@alexa.com', 30, 'Salomo', 2);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (39, 27, 'mcometti12@toplist.cz', 20, 'Melantha', 3);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (40, 18, 'ijankiewicz13@webeden.co.uk', 33, 'Ibbie', 50);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (41, 23, 'cblackmore14@mapquest.com', 27, 'Cletis', 23);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (42, 29, 'kgabb15@msn.com', 48, 'Kingsley', 23);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (43, 28, 'cstidworthy16@yellowbook.com', 32, 'Clerc', 22);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (44, 24, 'fdeacon17@51.la', 18, 'Falito', 31);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (45, 21, 'emckeaney18@google.pl', 36, 'Eleonora', 44);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (46, 26, 'gochterlony19@ucoz.com', 38, 'Gabriel', 50);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (47, 28, 'ibraim1a@state.gov', 37, 'Imogen', 13);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (48, 31, 'usilverston1b@engadget.com', 36, 'Ulises', 15);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (49, 18, 'bseiffert1c@histats.com', 34, 'Bette-ann', 8);
insert into Learner (learnerid, age, email, countryoforigin, name, nativelanguage) values (50, 33, 'hleadbeatter1d@phpbb.com', 36, 'Hilliard', 46);


insert into Class (classid, duration, datetime) values (1, 63, '2023-11-22');
insert into Class (classid, duration, datetime) values (2, 92, '2024-01-22');
insert into Class (classid, duration, datetime) values (3, 97, '2023-09-28');
insert into Class (classid, duration, datetime) values (4, 82, '2023-04-26');
insert into Class (classid, duration, datetime) values (5, 63, '2023-07-08');
insert into Class (classid, duration, datetime) values (6, 25, '2023-08-28');
insert into Class (classid, duration, datetime) values (7, 84, '2023-08-31');
insert into Class (classid, duration, datetime) values (8, 25, '2023-11-27');
insert into Class (classid, duration, datetime) values (9, 54, '2023-12-21');
insert into Class (classid, duration, datetime) values (10, 90, '2024-04-02');
insert into Class (classid, duration, datetime) values (11, 61, '2024-03-02');
insert into Class (classid, duration, datetime) values (12, 38, '2024-01-04');
insert into Class (classid, duration, datetime) values (13, 27, '2023-12-23');
insert into Class (classid, duration, datetime) values (14, 26, '2023-08-07');
insert into Class (classid, duration, datetime) values (15, 81, '2024-01-14');
insert into Class (classid, duration, datetime) values (16, 82, '2024-01-30');
insert into Class (classid, duration, datetime) values (17, 94, '2023-05-15');
insert into Class (classid, duration, datetime) values (18, 67, '2024-02-23');
insert into Class (classid, duration, datetime) values (19, 27, '2023-12-20');
insert into Class (classid, duration, datetime) values (20, 87, '2023-12-25');
insert into Class (classid, duration, datetime) values (21, 37, '2023-05-05');
insert into Class (classid, duration, datetime) values (22, 43, '2024-01-05');
insert into Class (classid, duration, datetime) values (23, 96, '2023-11-02');
insert into Class (classid, duration, datetime) values (24, 28, '2024-01-21');
insert into Class (classid, duration, datetime) values (25, 41, '2023-04-19');
insert into Class (classid, duration, datetime) values (26, 51, '2023-10-24');
insert into Class (classid, duration, datetime) values (27, 94, '2023-08-22');
insert into Class (classid, duration, datetime) values (28, 78, '2023-10-02');
insert into Class (classid, duration, datetime) values (29, 40, '2023-11-16');
insert into Class (classid, duration, datetime) values (30, 26, '2024-04-04');
insert into Class (classid, duration, datetime) values (31, 28, '2023-09-27');
insert into Class (classid, duration, datetime) values (32, 67, '2023-06-25');
insert into Class (classid, duration, datetime) values (33, 52, '2024-02-25');
insert into Class (classid, duration, datetime) values (34, 81, '2023-06-18');
insert into Class (classid, duration, datetime) values (35, 61, '2024-01-08');
insert into Class (classid, duration, datetime) values (36, 54, '2024-01-23');
insert into Class (classid, duration, datetime) values (37, 50, '2024-03-08');
insert into Class (classid, duration, datetime) values (38, 41, '2023-05-03');
insert into Class (classid, duration, datetime) values (39, 25, '2023-12-21');
insert into Class (classid, duration, datetime) values (40, 24, '2024-03-10');
insert into Class (classid, duration, datetime) values (41, 50, '2023-04-03');
insert into Class (classid, duration, datetime) values (42, 54, '2024-01-01');
insert into Class (classid, duration, datetime) values (43, 85, '2024-01-29');
insert into Class (classid, duration, datetime) values (44, 64, '2023-08-13');
insert into Class (classid, duration, datetime) values (45, 86, '2023-11-16');
insert into Class (classid, duration, datetime) values (46, 47, '2023-12-05');
insert into Class (classid, duration, datetime) values (47, 23, '2023-09-12');
insert into Class (classid, duration, datetime) values (48, 40, '2023-08-06');
insert into Class (classid, duration, datetime) values (49, 71, '2024-02-21');
insert into Class (classid, duration, datetime) values (50, 76, '2023-11-26');



insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (1, 'Traci', 37, 'thendriks0@ucsd.edu', 'doctor', 7703, 47);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (2, 'Nanette', 58, 'nbosse1@rediff.com', 'doctor', 7438, 27);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (3, 'Sophi', 53, 'sthackham2@java.com', 'master', 4773, 44);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (4, 'Nariko', 52, 'ndutt3@blogtalkradio.com', 'master', 4232, 47);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (5, 'Merrill', 55, 'mfiltness4@salon.com', 'doctor', 3804, 22);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (6, 'Tonya', 64, 'tloftie5@marketwatch.com', 'doctor', 3959, 8);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (7, 'Von', 44, 'vfleet6@cpanel.net', 'master', 6298, 2);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (8, 'Vicki', 30, 'vpostlethwaite7@cnet.com', 'bachelor', 7664, 31);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (9, 'Corliss', 58, 'cdowse8@apache.org', 'bachelor', 5568, 50);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (10, 'Salem', 29, 'sshitliffe9@google.nl', 'master', 8548, 11);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (11, 'Andria', 60, 'afairhama@networksolutions.com', 'master', 6744, 44);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (12, 'Earvin', 54, 'eperksb@amazon.co.jp', 'master', 4568, 50);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (13, 'Eula', 42, 'egreadyc@engadget.com', 'doctor', 3334, 44);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (14, 'Leopold', 46, 'lrickardssond@hatena.ne.jp', 'bachelor', 4164, 7);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (15, 'Willyt', 69, 'wpadricke@npr.org', 'bachelor', 6361, 21);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (16, 'Ganny', 62, 'gdunridgef@walmart.com', 'master', 4984, 21);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (17, 'Kippie', 52, 'kziemg@icio.us', 'doctor', 6264, 8);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (18, 'Artur', 48, 'aodreainh@diigo.com', 'bachelor', 6066, 3);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (19, 'Myrtie', 60, 'mbrozeki@salon.com', 'bachelor', 9870, 48);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (20, 'Estevan', 70, 'etansleyj@freewebs.com', 'master', 7172, 11);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (21, 'Gertruda', 56, 'gcreavenk@accuweather.com', 'master', 9605, 29);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (22, 'Olive', 38, 'obarlacel@smh.com.au', 'doctor', 9337, 28);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (23, 'Sibley', 52, 'shamfleetm@nih.gov', 'doctor', 6643, 12);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (24, 'Roman', 46, 'rcortenn@omniture.com', 'bachelor', 2639, 39);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (25, 'Heda', 57, 'hthewlesso@ocn.ne.jp', 'doctor', 7996, 19);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (26, 'Edyth', 40, 'efurnellp@tuttocitta.it', 'doctor', 9357, 41);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (27, 'Derk', 32, 'dgascoigneq@rakuten.co.jp', 'doctor', 7748, 42);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (28, 'Doe', 48, 'dcollimorer@com.com', 'master', 8044, 8);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (29, 'Susanne', 44, 'sjosskovitzs@cornell.edu', 'master', 3232, 19);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (30, 'Jerry', 65, 'jterreyt@csmonitor.com', 'bachelor', 4289, 44);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (31, 'Bessy', 37, 'bstonebanksu@mail.ru', 'master', 2709, 2);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (32, 'Darb', 65, 'ddignanv@cmu.edu', 'master', 4051, 2);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (33, 'Darbee', 35, 'dmaruskaw@list-manage.com', 'bachelor', 3482, 24);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (34, 'Darrelle', 47, 'drealyx@netscape.com', 'doctor', 4211, 49);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (35, 'Afton', 54, 'amacwhany@4shared.com', 'master', 7770, 29);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (36, 'Zaria', 30, 'zlavertyz@virginia.edu', 'bachelor', 4685, 19);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (37, 'Jessi', 42, 'jstiant10@cornell.edu', 'doctor', 4785, 28);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (38, 'Hussein', 34, 'hcosford11@is.gd', 'master', 7499, 18);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (39, 'Moselle', 42, 'mskoggins12@ucla.edu', 'master', 2775, 6);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (40, 'Maritsa', 62, 'mbeak13@theguardian.com', 'doctor', 7902, 41);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (41, 'Dene', 29, 'dfilipovic14@nature.com', 'master', 2172, 47);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (42, 'Blayne', 45, 'basker15@aol.com', 'bachelor', 8436, 28);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (43, 'Chevy', 70, 'cberi16@umich.edu', 'doctor', 2459, 4);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (44, 'Rurik', 64, 'raykroyd17@liveinternet.ru', 'doctor', 2668, 4);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (45, 'Fayre', 41, 'fmanuel18@studiopress.com', 'bachelor', 3827, 36);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (46, 'Raphaela', 57, 'ryansons19@mapquest.com', 'bachelor', 7355, 30);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (47, 'Torin', 34, 'twebb1a@gravatar.com', 'bachelor', 2426, 40);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (48, 'Tito', 42, 'tgeydon1b@addtoany.com', 'doctor', 8655, 32);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (49, 'Lamond', 34, 'lmarling1c@nationalgeographic.com', 'bachelor', 2214, 39);
insert into Teacher (teacherid, name, age, email, education, salary, nativelanguage) values (50, 'Carma', 64, 'cbernolet1d@pcworld.com', 'bachelor', 7218, 42);





insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (1, 'Sansone', 41, 'sdorrington0@engadget.com', 30, 48);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (2, 'Maxie', 52, 'maires1@sbwire.com', 32, 19);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (3, 'Guss', 27, 'gtruwert2@ycombinator.com', 42, 6);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (4, 'Jerome', 37, 'jedginton3@jimdo.com', 22, 42);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (5, 'Pate', 63, 'pcarpenter4@hc360.com', 2, 25);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (6, 'Viola', 64, 'vdavy5@harvard.edu', 1, 1);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (7, 'Gonzalo', 23, 'gnance6@uiuc.edu', 46, 25);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (8, 'Tim', 62, 'tdanjoie7@house.gov', 22, 30);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (9, 'Maura', 26, 'mkording8@posterous.com', 40, 21);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (10, 'Yasmin', 57, 'ydecaville9@woothemes.com', 22, 16);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (11, 'Jakob', 57, 'jhallborda@google.cn', 44, 2);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (12, 'Bernard', 51, 'bhenfreb@prweb.com', 13, 32);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (13, 'Robbi', 46, 'rpietranekc@foxnews.com', 36, 13);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (14, 'Cosette', 20, 'cboxerd@wikispaces.com', 7, 24);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (15, 'Hermie', 41, 'hsympsone@sciencedaily.com', 41, 3);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (16, 'Talbot', 23, 'tleadbetterf@state.gov', 26, 9);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (17, 'Norri', 69, 'ntabartg@sakura.ne.jp', 2, 37);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (18, 'Brewster', 47, 'bbowenh@va.gov', 28, 16);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (19, 'Darcie', 25, 'dkarlemani@shutterfly.com', 31, 46);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (20, 'Frankie', 58, 'ffrankemaj@bbc.co.uk', 30, 5);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (21, 'Domenico', 34, 'dnairnk@tamu.edu', 23, 10);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (22, 'Cosmo', 42, 'cstapyltonl@dell.com', 36, 39);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (23, 'Denyse', 19, 'dtiesmanm@nifty.com', 13, 48);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (24, 'Warren', 61, 'wwettern@fema.gov', 13, 35);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (25, 'Odell', 28, 'oseelero@yale.edu', 8, 5);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (26, 'Bonita', 62, 'btattoop@noaa.gov', 1, 19);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (27, 'Roana', 57, 'rgeldartq@utexas.edu', 3, 29);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (28, 'Austin', 21, 'abouldstridger@webnode.com', 8, 26);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (29, 'Cordell', 40, 'cstodits@ucla.edu', 24, 14);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (30, 'Zackariah', 38, 'zcauntt@spiegel.de', 13, 49);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (31, 'Junie', 59, 'jstateu@nyu.edu', 42, 31);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (32, 'Selene', 20, 'sbaterv@shop-pro.jp', 11, 8);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (33, 'Tilda', 35, 'tpirriw@paypal.com', 14, 24);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (34, 'Nerta', 60, 'ndrayseyx@reuters.com', 5, 35);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (35, 'Stern', 18, 'sduranty@spotify.com', 37, 29);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (36, 'Genevieve', 49, 'gnelseyz@friendfeed.com', 49, 31);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (37, 'Christoper', 39, 'chanselmann10@t-online.de', 30, 3);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (38, 'Nickolai', 40, 'nschimke11@shop-pro.jp', 42, 4);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (39, 'Mozes', 21, 'mlavell12@eepurl.com', 35, 46);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (40, 'Catarina', 52, 'ceastam13@nyu.edu', 37, 22);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (41, 'Kori', 57, 'kalcide14@t-online.de', 38, 21);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (42, 'Wenonah', 61, 'wthorsby15@china.com.cn', 26, 34);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (43, 'Wendy', 37, 'wokane16@bloglines.com', 49, 5);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (44, 'Becky', 67, 'bheers17@xing.com', 28, 6);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (45, 'Sherilyn', 24, 'shavercroft18@engadget.com', 40, 49);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (46, 'Nickie', 26, 'nsomes19@nsw.gov.au', 13, 21);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (47, 'Terrye', 47, 'tcazin1a@about.com', 12, 11);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (48, 'Bebe', 20, 'bcaudelier1b@statcounter.com', 30, 33);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (49, 'Kiel', 49, 'ktett1c@phoca.cz', 18, 41);
insert into Traveler (travelerid, name, age, email, countryoforigin, nativelanguage) values (50, 'Kaylil', 64, 'kgreaser1d@hc360.com', 44, 7);


insert into Country (countryid, name, language) values (1, 'United States', 'Finnish');
insert into Country (countryid, name, language) values (2, 'Canada', 'Chinese');
insert into Country (countryid, name, language) values (3, 'Australia', 'Spanish');
insert into Country (countryid, name, language) values (4, 'Germany', 'Kashmiri');
insert into Country (countryid, name, language) values (5, 'France', 'Hebrew');
insert into Country (countryid, name, language) values (6, 'Japan', 'Bengali');
insert into Country (countryid, name, language) values (7, 'South Korea', 'Tswana');
insert into Country (countryid, name, language) values (8, 'Brazil', 'Gagauz');
insert into Country (countryid, name, language) values (9, 'India', 'Assamese');
insert into Country (countryid, name, language) values (10, 'China', 'Oriya');
insert into Country (countryid, name, language) values (11, 'Italy', 'Gagauz');
insert into Country (countryid, name, language) values (12, 'Spain', 'Yiddish');
insert into Country (countryid, name, language) values (13, 'Russia', 'Polish');
insert into Country (countryid, name, language) values (14, 'United Kingdom', 'Malayalam');
insert into Country (countryid, name, language) values (15, 'Argentina', 'Lithuanian');
insert into Country (countryid, name, language) values (16, 'Belgium', 'Macedonian');
insert into Country (countryid, name, language) values (17, 'Chile', 'Swati');
insert into Country (countryid, name, language) values (18, 'Denmark', 'Northern Sotho');
insert into Country (countryid, name, language) values (19, 'Egypt', 'Yiddish');
insert into Country (countryid, name, language) values (20, 'Finland', 'Filipino');
insert into Country (countryid, name, language) values (21, 'Greece', 'Gujarati');
insert into Country (countryid, name, language) values (22, 'Hungary', 'Malagasy');
insert into Country (countryid, name, language) values (23, 'Indonesia', 'Māori');
insert into Country (countryid, name, language) values (24, 'Ireland', 'Kurdish');
insert into Country (countryid, name, language) values (25, 'Jordan', 'Italian');
insert into Country (countryid, name, language) values (26, 'Kenya', 'Dhivehi');
insert into Country (countryid, name, language) values (27, 'Luxembourg', 'Fijian');
insert into Country (countryid, name, language) values (28, 'Malaysia', 'Ndebele');
insert into Country (countryid, name, language) values (29, 'Netherlands', 'Ndebele');
insert into Country (countryid, name, language) values (30, 'Norway', 'Armenian');
insert into Country (countryid, name, language) values (31, 'Oman', 'Burmese');
insert into Country (countryid, name, language) values (32, 'Peru', 'Persian');
insert into Country (countryid, name, language) values (33, 'Qatar', 'Marathi');
insert into Country (countryid, name, language) values (34, 'Romania', 'Filipino');
insert into Country (countryid, name, language) values (35, 'Sweden', 'Malayalam');
insert into Country (countryid, name, language) values (36, 'Thailand', 'Tamil');
insert into Country (countryid, name, language) values (37, 'Turkey', 'Filipino');
insert into Country (countryid, name, language) values (38, 'Ukraine', 'Swati');
insert into Country (countryid, name, language) values (39, 'Vietnam', 'Malagasy');
insert into Country (countryid, name, language) values (40, 'Zimbabwe', 'Kannada');
insert into Country (countryid, name, language) values (41, 'Algeria', 'Burmese');
insert into Country (countryid, name, language) values (42, 'Bahamas', 'Swati');
insert into Country (countryid, name, language) values (43, 'Cambodia', 'Dutch');
insert into Country (countryid, name, language) values (44, 'Djibouti', 'Yiddish');
insert into Country (countryid, name, language) values (45, 'Ecuador', 'Montenegrin');
insert into Country (countryid, name, language) values (46, 'Fiji', 'French');
insert into Country (countryid, name, language) values (47, 'Ghana', 'Tsonga');
insert into Country (countryid, name, language) values (48, 'Haiti', 'Kannada');
insert into Country (countryid, name, language) values (49, 'Iceland', 'Greek');
insert into Country (countryid, name, language) values (50, 'Jamaica', 'Hindi');




insert into Community (communityid, language) values (1, 5);
insert into Community (communityid, language) values (2, 26);
insert into Community (communityid, language) values (3, 25);
insert into Community (communityid, language) values (4, 9);
insert into Community (communityid, language) values (5, 16);
insert into Community (communityid, language) values (6, 2);
insert into Community (communityid, language) values (7, 9);
insert into Community (communityid, language) values (8, 20);
insert into Community (communityid, language) values (9, 33);
insert into Community (communityid, language) values (10, 43);
insert into Community (communityid, language) values (11, 19);
insert into Community (communityid, language) values (12, 25);
insert into Community (communityid, language) values (13, 37);
insert into Community (communityid, language) values (14, 4);
insert into Community (communityid, language) values (15, 14);
insert into Community (communityid, language) values (16, 5);
insert into Community (communityid, language) values (17, 39);
insert into Community (communityid, language) values (18, 13);
insert into Community (communityid, language) values (19, 21);
insert into Community (communityid, language) values (20, 18);
insert into Community (communityid, language) values (21, 16);
insert into Community (communityid, language) values (22, 2);
insert into Community (communityid, language) values (23, 4);
insert into Community (communityid, language) values (24, 22);
insert into Community (communityid, language) values (25, 20);
insert into Community (communityid, language) values (26, 20);
insert into Community (communityid, language) values (27, 32);
insert into Community (communityid, language) values (28, 8);
insert into Community (communityid, language) values (29, 30);
insert into Community (communityid, language) values (30, 45);
insert into Community (communityid, language) values (31, 4);
insert into Community (communityid, language) values (32, 14);
insert into Community (communityid, language) values (33, 15);
insert into Community (communityid, language) values (34, 11);
insert into Community (communityid, language) values (35, 39);
insert into Community (communityid, language) values (36, 29);
insert into Community (communityid, language) values (37, 34);
insert into Community (communityid, language) values (38, 40);
insert into Community (communityid, language) values (39, 31);
insert into Community (communityid, language) values (40, 17);
insert into Community (communityid, language) values (41, 29);
insert into Community (communityid, language) values (42, 6);
insert into Community (communityid, language) values (43, 14);
insert into Community (communityid, language) values (44, 19);
insert into Community (communityid, language) values (45, 19);
insert into Community (communityid, language) values (46, 15);
insert into Community (communityid, language) values (47, 8);
insert into Community (communityid, language) values (48, 42);
insert into Community (communityid, language) values (49, 45);
insert into Community (communityid, language) values (50, 24);
insert into Community (communityid, language) values (51, 34);
insert into Community (communityid, language) values (52, 39);
insert into Community (communityid, language) values (53, 37);
insert into Community (communityid, language) values (54, 8);
insert into Community (communityid, language) values (55, 41);
insert into Community (communityid, language) values (56, 15);
insert into Community (communityid, language) values (57, 46);
insert into Community (communityid, language) values (58, 43);
insert into Community (communityid, language) values (59, 6);
insert into Community (communityid, language) values (60, 49);
insert into Community (communityid, language) values (61, 47);
insert into Community (communityid, language) values (62, 16);
insert into Community (communityid, language) values (63, 3);
insert into Community (communityid, language) values (64, 13);
insert into Community (communityid, language) values (65, 29);
insert into Community (communityid, language) values (66, 21);
insert into Community (communityid, language) values (67, 21);
insert into Community (communityid, language) values (68, 9);
insert into Community (communityid, language) values (69, 18);
insert into Community (communityid, language) values (70, 7);
insert into Community (communityid, language) values (71, 29);
insert into Community (communityid, language) values (72, 48);
insert into Community (communityid, language) values (73, 49);
insert into Community (communityid, language) values (74, 14);
insert into Community (communityid, language) values (75, 9);
insert into Community (communityid, language) values (76, 24);
insert into Community (communityid, language) values (77, 5);
insert into Community (communityid, language) values (78, 28);
insert into Community (communityid, language) values (79, 47);
insert into Community (communityid, language) values (80, 39);
insert into Community (communityid, language) values (81, 28);
insert into Community (communityid, language) values (82, 11);
insert into Community (communityid, language) values (83, 9);
insert into Community (communityid, language) values (84, 44);
insert into Community (communityid, language) values (85, 40);
insert into Community (communityid, language) values (86, 50);
insert into Community (communityid, language) values (87, 43);
insert into Community (communityid, language) values (88, 25);
insert into Community (communityid, language) values (89, 48);
insert into Community (communityid, language) values (90, 41);
insert into Community (communityid, language) values (91, 38);
insert into Community (communityid, language) values (92, 4);
insert into Community (communityid, language) values (93, 1);
insert into Community (communityid, language) values (94, 11);
insert into Community (communityid, language) values (95, 38);
insert into Community (communityid, language) values (96, 47);
insert into Community (communityid, language) values (97, 10);
insert into Community (communityid, language) values (98, 41);
insert into Community (communityid, language) values (99, 46);
insert into Community (communityid, language) values (100, 48);
insert into Community (communityid, language) values (101, 31);
insert into Community (communityid, language) values (102, 14);
insert into Community (communityid, language) values (103, 20);
insert into Community (communityid, language) values (104, 8);
insert into Community (communityid, language) values (105, 9);
insert into Community (communityid, language) values (106, 15);
insert into Community (communityid, language) values (107, 16);
insert into Community (communityid, language) values (108, 20);
insert into Community (communityid, language) values (109, 40);
insert into Community (communityid, language) values (110, 5);
insert into Community (communityid, language) values (111, 43);
insert into Community (communityid, language) values (112, 16);
insert into Community (communityid, language) values (113, 19);
insert into Community (communityid, language) values (114, 12);
insert into Community (communityid, language) values (115, 50);
insert into Community (communityid, language) values (116, 23);
insert into Community (communityid, language) values (117, 5);
insert into Community (communityid, language) values (118, 36);
insert into Community (communityid, language) values (119, 26);
insert into Community (communityid, language) values (120, 1);
insert into Community (communityid, language) values (121, 48);
insert into Community (communityid, language) values (122, 41);
insert into Community (communityid, language) values (123, 21);
insert into Community (communityid, language) values (124, 4);
insert into Community (communityid, language) values (125, 17);
insert into Community (communityid, language) values (126, 1);
insert into Community (communityid, language) values (127, 45);
insert into Community (communityid, language) values (128, 11);
insert into Community (communityid, language) values (129, 30);
insert into Community (communityid, language) values (130, 33);
insert into Community (communityid, language) values (131, 40);
insert into Community (communityid, language) values (132, 28);
insert into Community (communityid, language) values (133, 9);
insert into Community (communityid, language) values (134, 5);
insert into Community (communityid, language) values (135, 43);
insert into Community (communityid, language) values (136, 28);
insert into Community (communityid, language) values (137, 47);
insert into Community (communityid, language) values (138, 17);
insert into Community (communityid, language) values (139, 19);
insert into Community (communityid, language) values (140, 12);
insert into Community (communityid, language) values (141, 22);
insert into Community (communityid, language) values (142, 9);
insert into Community (communityid, language) values (143, 6);
insert into Community (communityid, language) values (144, 19);
insert into Community (communityid, language) values (145, 21);
insert into Community (communityid, language) values (146, 24);
insert into Community (communityid, language) values (147, 18);
insert into Community (communityid, language) values (148, 13);
insert into Community (communityid, language) values (149, 45);
insert into Community (communityid, language) values (150, 45);
insert into Community (communityid, language) values (151, 47);
insert into Community (communityid, language) values (152, 33);
insert into Community (communityid, language) values (153, 15);
insert into Community (communityid, language) values (154, 34);
insert into Community (communityid, language) values (155, 45);
insert into Community (communityid, language) values (156, 33);
insert into Community (communityid, language) values (157, 5);
insert into Community (communityid, language) values (158, 37);
insert into Community (communityid, language) values (159, 22);
insert into Community (communityid, language) values (160, 38);
insert into Community (communityid, language) values (161, 38);
insert into Community (communityid, language) values (162, 10);
insert into Community (communityid, language) values (163, 6);
insert into Community (communityid, language) values (164, 7);
insert into Community (communityid, language) values (165, 20);
insert into Community (communityid, language) values (166, 29);
insert into Community (communityid, language) values (167, 36);
insert into Community (communityid, language) values (168, 2);
insert into Community (communityid, language) values (169, 36);
insert into Community (communityid, language) values (170, 10);
insert into Community (communityid, language) values (171, 2);
insert into Community (communityid, language) values (172, 25);
insert into Community (communityid, language) values (173, 22);
insert into Community (communityid, language) values (174, 29);
insert into Community (communityid, language) values (175, 49);
insert into Community (communityid, language) values (176, 15);
insert into Community (communityid, language) values (177, 40);
insert into Community (communityid, language) values (178, 18);
insert into Community (communityid, language) values (179, 28);
insert into Community (communityid, language) values (180, 30);
insert into Community (communityid, language) values (181, 39);
insert into Community (communityid, language) values (182, 1);
insert into Community (communityid, language) values (183, 42);
insert into Community (communityid, language) values (184, 33);
insert into Community (communityid, language) values (185, 1);
insert into Community (communityid, language) values (186, 7);
insert into Community (communityid, language) values (187, 39);
insert into Community (communityid, language) values (188, 30);
insert into Community (communityid, language) values (189, 14);
insert into Community (communityid, language) values (190, 4);
insert into Community (communityid, language) values (191, 50);
insert into Community (communityid, language) values (192, 5);
insert into Community (communityid, language) values (193, 42);
insert into Community (communityid, language) values (194, 37);
insert into Community (communityid, language) values (195, 5);
insert into Community (communityid, language) values (196, 13);
insert into Community (communityid, language) values (197, 29);
insert into Community (communityid, language) values (198, 42);
insert into Community (communityid, language) values (199, 28);
insert into Community (communityid, language) values (200, 22);




insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (1, 'reading', 14, 5);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (2, 'writing', 47, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (3, 'writing', 28, 1);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (4, 'writing', 47, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (5, 'listening', 31, 1);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (6, 'listening', 47, 5);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (7, 'listening', 44, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (8, 'listening', 34, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (9, 'listening', 27, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (10, 'reading', 8, 5);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (11, 'reading', 12, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (12, 'writing', 36, 8);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (13, 'listening', 41, 2);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (14, 'listening', 4, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (15, 'reading', 8, 7);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (16, 'reading', 38, 9);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (17, 'listening', 43, 5);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (18, 'reading', 3, 2);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (19, 'writing', 7, 4);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (20, 'writing', 30, 8);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (21, 'writing', 37, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (22, 'listening', 11, 4);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (23, 'writing', 19, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (24, 'listening', 29, 6);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (25, 'reading', 28, 4);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (26, 'listening', 37, 7);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (27, 'writing', 5, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (28, 'writing', 19, 6);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (29, 'writing', 39, 2);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (30, 'reading', 16, 7);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (31, 'reading', 1, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (32, 'writing', 41, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (33, 'reading', 20, 2);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (34, 'writing', 25, 5);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (35, 'reading', 38, 1);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (36, 'writing', 23, 4);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (37, 'reading', 32, 9);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (38, 'reading', 8, 1);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (39, 'listening', 50, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (40, 'reading', 9, 5);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (41, 'writing', 7, 8);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (42, 'reading', 5, 6);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (43, 'listening', 4, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (44, 'reading', 8, 4);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (45, 'listening', 5, 6);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (46, 'writing', 36, 4);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (47, 'reading', 33, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (48, 'writing', 2, 8);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (49, 'reading', 1, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (50, 'writing', 42, 1);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (51, 'listening', 36, 7);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (52, 'listening', 4, 8);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (53, 'writing', 24, 1);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (54, 'reading', 3, 8);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (55, 'reading', 44, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (56, 'reading', 23, 10);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (57, 'writing', 2, 3);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (58, 'listening', 20, 6);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (59, 'listening', 12, 2);
insert into LearningMaterials (materialid, materialtype, languageid, complexitylevel) values (60, 'writing', 49, 10);


insert into Traveler_nativelanguage (nativelanguage, travelerid, name, age, email, countryoforigin) values (21, 1, 'Hewie', 21, 'hbacke0@ted.com', 47);
insert into Traveler_nativelanguage (nativelanguage, travelerid, name, age, email, countryoforigin) values (42, 2, 'Mack', 25, 'mlarkkem1@nyu.edu', 9);
insert into Traveler_nativelanguage (nativelanguage, travelerid, name, age, email, countryoforigin) values (8, 3, 'Kordula', 23, 'kdowney2@nytimes.com', 16);



insert into Country_language (language, countryid) values (12, 1);
insert into Country_language (language, countryid) values (42, 2);
insert into Country_language (language, countryid) values (6, 3);


insert into Travels_to (travelduration, travelerid, countryid) values (9, 1, 18);
insert into Travels_to (travelduration, travelerid, countryid) values (29, 2, 3);
insert into Travels_to (travelduration, travelerid, countryid) values (4, 3, 48);



insert into Teaches (teacherid, languageid) values (388, 30);
insert into Teaches (teacherid, languageid) values (538, 42);
insert into Teaches (teacherid, languageid) values (237, 16);

insert into Has (materialid, languageid) values (55, 22);
insert into Has (materialid, languageid) values (31, 36);
insert into Has (materialid, languageid) values (25, 38);


insert into Joins (learnerid, communityid) values (35, 54);
insert into Joins (learnerid, communityid) values (39, 54);
insert into Joins (learnerid, communityid) values (32, 74);


insert into TeacherNativelanguage (nativelanguage, teacherid, name, age, email, countryoforigin, salary, education) values (18, 1, 'Ethelda', 38, 'esnufflebottom0@studiopress.com', 11, 8839, 'doctor');
insert into TeacherNativelanguage (nativelanguage, teacherid, name, age, email, countryoforigin, salary, education) values (37, 2, 'Arlyne', 25, 'awyson1@newsvine.com', 41, 3377, 'doctor');
insert into TeacherNativelanguage (nativelanguage, teacherid, name, age, email, countryoforigin, salary, education) values (30, 3, 'Huntley', 37, 'hmanns2@prnewswire.com', 48, 4987, 'bachelor');


insert into LearnerNativelanguage (nativelanguage, learnerid, name, age, email, countryoforigin) values (32, 1, 'Barbara-anne', 23, 'bgiraudoux0@nationalgeographic.com', 48);
insert into LearnerNativelanguage (nativelanguage, learnerid, name, age, email, countryoforigin) values (4, 2, 'Elisha', 24, 'estandrin1@imgur.com', 32);
insert into LearnerNativelanguage (nativelanguage, learnerid, name, age, email, countryoforigin) values (46, 3, 'Maddie', 18, 'metteridge2@omniture.com', 2);


insert into Learns (proficiencylevel, studentid, languageid, learnerid, travelerid) values (5, 28, 12, 1, 31);
insert into Learns (proficiencylevel, studentid, languageid, learnerid, travelerid) values (2, 39, 32, 48, 28);
insert into Learns (proficiencylevel, studentid, languageid, learnerid, travelerid) values (4, 41, 41, 45, 22);



insert into Holds (classid, teacherid) values (1, 46);
insert into Holds (classid, teacherid) values (2, 24);
insert into Holds (classid, teacherid) values (3, 16);


insert into Attends (classid, studentid) values (5, 50);
insert into Attends (classid, studentid) values (10, 40);
insert into Attends (classid, studentid) values (12, 29);


insert into Supports (classid, materialid, languageid) values (30, 47, 38);
insert into Supports (classid, materialid, languageid) values (46, 6, 30);
insert into Supports (classid, materialid, languageid) values (25, 37, 43);



insert into Teacher_education (education, teacherid, name, age, email, countryoforigin, salary, nativelanguage) values ('doctor', 1, 'Joshia', 45, 'jgyngell0@diigo.com', 4, 7020, 48);
insert into Teacher_education (education, teacherid, name, age, email, countryoforigin, salary, nativelanguage) values ('bachelor', 2, 'Leola', 28, 'lrobic1@tiny.cc', 46, 6618, 17);
insert into Teacher_education (education, teacherid, name, age, email, countryoforigin, salary, nativelanguage) values ('bachelor', 3, 'Brit', 29, 'bboise2@godaddy.com', 40, 3483, 34);





