SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP DATABASE IF EXISTS BABBLEBUDDIES;
CREATE DATABASE BABBLEBUDDIES;
USE BABBLEBUDDIES;

-- Create Tables for Relational Diagram
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







SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
