-- Database Creation

-- SQL Script to Create the Database and Tables:

-- Create Database
CREATE DATABASE EventsManagement;

-- Create Events Table
CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

-- Create Attendees Table
CREATE TABLE Attendees (
    Attendee_Id INT PRIMARY KEY,
    Attendee_Name VARCHAR(100),
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100),
    Attendee_City VARCHAR(100)
);

-- Create Registrations Table
CREATE TABLE Registrations (
    Registration_Id INT PRIMARY KEY,
    Event_Id INT REFERENCES Events(Event_Id),
    Attendee_Id INT REFERENCES Attendees(Attendee_Id),
    Registration_Date DATE,
    Registration_Amount DECIMAL(10, 2)
);

-- 2. Data Creation

-- Insert Sample Data into Events Table
INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES 
(1, 'Diwali Celebration', '2024-11-12', 'Delhi', 'Festival celebration with lights and cultural programs'),
(2, 'Startup Meet', '2024-12-05', 'Bangalore', 'Networking event for entrepreneurs and investors'),
(3, 'Music Fest', '2024-12-20', 'Mumbai', 'Live performances by various artists');

-- Insert Sample Data into Attendees Table
INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES 
(1, 'Rohan Sharma', '9876543210', 'rohan.sharma@example.com', 'Delhi'),
(2, 'Priya Singh', '8765432109', 'priya.singh@example.com', 'Mumbai'),
(3, 'Ankit Verma', '7654321098', 'ankit.verma@example.com', 'Bangalore');

-- Insert Sample Data into Registrations Table
INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES 
(1, 1, 1, '2024-11-01', 500.00),
(2, 2, 2, '2024-12-01', 1000.00),
(3, 3, 3, '2024-12-10', 750.00);

-- 3. Manage Event Details

-- a) Insert a New Event:

INSERT INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES (4, 'Art Workshop', '2025-01-15', 'Chennai', 'Hands-on painting and craft workshop');

-- b) Update an Event’s Information:

UPDATE Events
SET Event_Date = '2024-12-25', Event_Location = 'Pune'
WHERE Event_Id = 3;

-- c) Delete an Event:

DELETE FROM Events
WHERE Event_Id = 4;

-- 4. Manage Attendees & Handle Events

-- a) Insert a New Attendee:

INSERT INTO Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES (4, 'Sneha Kapoor', '6543210987', 'sneha.kapoor@example.com', 'Chennai');

-- b) Register an Attendee for an Event:

INSERT INTO Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (4, 1, 4, '2024-11-10', 600.00);

-- 5. Queries to Retrieve Information

-- a) Retrieve All Events:

SELECT * FROM Events;

-- b) Generate a List of Attendees for a Specific Event:

SELECT A.Attendee_Name, A.Attendee_Email, A.Attendee_City
FROM Attendees A
JOIN Registrations R ON A.Attendee_Id = R.Attendee_Id
WHERE R.Event_Id = 1;

-- c) Calculate Total Attendance for Each Event:

SELECT E.Event_Name, COUNT(R.Registration_Id) AS Total_Attendees
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Id, E.Event_Name;

-- d) Calculate Total Revenue Generated for Each Event:

SELECT E.Event_Name, SUM(R.Registration_Amount) AS Total_Revenue
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Id, E.Event_Name;
