CREATE DATABASE PROJECT;
USE PROJECT;

CREATE TABLE Person_Details (
    Person_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Role ENUM('Student', 'Staff', 'Author', 'Publisher') NOT NULL,
    Age INT,
    CHECK (Age>=5 AND Age<=105)
);

CREATE TABLE Category_Details (
    Category_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Publisher_Details (
    Publisher_ID INT PRIMARY KEY AUTO_INCREMENT,
    Person_ID INT,  -- References Parent Table
    Publishing_Company VARCHAR(100) NOT NULL,
    FOREIGN KEY (Person_ID) REFERENCES Person_Details(Person_ID) ON DELETE CASCADE
);


CREATE TABLE Author_Details (
    Author_ID INT PRIMARY KEY AUTO_INCREMENT,
    Person_ID INT,  
    Genre VARCHAR(100),
    FOREIGN KEY (Person_ID) REFERENCES Person_Details(Person_ID) ON DELETE CASCADE
);


CREATE TABLE Book_Details (
    Book_ID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255) NOT NULL,
    Category_ID INT,
    Publisher_ID INT,
    Price DECIMAL(10,2),
    Year INT,
    FOREIGN KEY (Category_ID) REFERENCES Category_Details(Category_ID),
    FOREIGN KEY (Publisher_ID) REFERENCES Publisher_Details(Publisher_ID)
);

CREATE TABLE Book_Author (
    Book_ID INT,
    Author_ID INT,
    PRIMARY KEY (Book_ID, Author_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book_Details(Book_ID),
    FOREIGN KEY (Author_ID) REFERENCES Author_Details(Author_ID)
);

CREATE TABLE Student_Details (
    Student_ID INT PRIMARY KEY AUTO_INCREMENT,
    Person_ID INT UNIQUE,  -- References Parent Table
    Grade INT NOT NULL,
    FOREIGN KEY (Person_ID) REFERENCES Person_Details(Person_ID) ON DELETE CASCADE
);


CREATE TABLE Staff_Details (
    Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
    Person_ID INT,  -- References Parent Table
    Department VARCHAR(100),
    FOREIGN KEY (Person_ID) REFERENCES Person_Details(Person_ID) ON DELETE CASCADE
);

CREATE TABLE Borrower_Details (
    Borrower_ID INT PRIMARY KEY AUTO_INCREMENT,
    Person_ID INT NOT NULL,  
    Issued_By_Staff_ID INT NOT NULL,  -- The staff member who issued the book
    FOREIGN KEY (Person_ID) REFERENCES Person_Details(Person_ID) ON DELETE CASCADE,
    FOREIGN KEY (Issued_By_Staff_ID) REFERENCES Staff_Details(Staff_ID) ON DELETE CASCADE
);

CREATE TABLE Shelf_Details (
    Shelf_ID INT PRIMARY KEY AUTO_INCREMENT,
    Location VARCHAR(50)
);

CREATE TABLE Transaction_Details (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Borrower_ID INT,
    Book_ID INT,
    Borrow_Date DATE,
    Return_Date DATE,
    FOREIGN KEY (Borrower_ID) REFERENCES Borrower_Details(Borrower_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book_Details(Book_ID)
);

CREATE TABLE Reservation_Details (
    Reservation_ID INT PRIMARY KEY AUTO_INCREMENT,
    Borrower_ID INT,
    Book_ID INT,
    Reservation_Date DATE,
    FOREIGN KEY (Borrower_ID) REFERENCES Borrower_Details(Borrower_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book_Details(Book_ID)
);


INSERT INTO Person_Details (Person_ID,First_Name, Last_Name, Role,Age) 
VALUES (1, 'John', 'Doe', 'Student',16);  
INSERT INTO Person_Details (First_Name, Last_Name, Role, Age) 
VALUES ('Alice', 'Johnson', 'Author',30),
('Bob', 'Brown', 'Author',45),
('Emma', 'Smith', 'Publisher',50),
('David', 'Taylor', 'Staff',33),
('Michael', 'Anderson', 'Student',14),
('Sophia', 'Miller', 'Student',17),
('Daniel', 'Wilson', 'Staff',28),
('Emily', 'Davis', 'Student',13),
('Olivia', 'Garcia', 'Student',15),
('James', 'Hernandez', 'Publisher',55),
('Ava', 'Martinez', 'Author',26),
('Benjamin', 'Lopez', 'Student',16),
('Chloe', 'Gonzalez', 'Staff',38),
('Ryan', 'King', 'Author',27),
('Ethan', 'Scott', 'Publisher',43),
('Hannah', 'Moore', 'Student',20),
('Matthew', 'Lee', 'Staff',38),
('Lily', 'Thomas', 'Author',45),
('Jacob', 'Walker', 'Publisher',44);

INSERT INTO Category_Details (Category_ID,Name) 
VALUES (101, 'Science Fiction'); 
INSERT INTO Category_Details (Name) 
VALUES ('Mystery'),
('Romance'),
('Fantasy'),
('History'),
('Biography'),
('Horror'),
('Adventure'),
('Technology'),
('Health'),
('Thriller'),
('Self-Help'),
('Poetry'),
('Education'),
('Philosophy'),
('Politics'),
('Business'),
('Religion'),
('Science'),
('Comedy');

INSERT INTO Publisher_Details (Publisher_ID,Person_ID, Publishing_Company) 
VALUES (400, 4, 'Penguin Books');     
INSERT INTO Publisher_Details (Person_ID, Publishing_Company) 
VALUES (11, 'HarperCollins'),
(16, 'Macmillan'),
(20, 'Oxford University Press'),
(11, 'Random House'),
(4, 'Scholastic'),
(16, 'Hachette Livre'),
(20, 'Springer'),
(4, 'Wiley'),
(11, 'Pearson'),
(16, 'McGraw-Hill'),
(20, 'Cengage'),
(4, 'Thomson Reuters'),
(11, 'Bloomsbury'),
(16, 'Pan Macmillan'),
(20, 'Tor Books'),
(4, 'Bantam Books'),
(11, 'Little, Brown and Company'),
(16, 'Elsevier'),
(20, 'MIT Press');

INSERT INTO Author_Details (Author_ID,Person_ID, Genre) 
VALUES (600, 2, 'Science Fiction'); 
INSERT INTO Author_Details (Person_ID, Genre) 
VALUES (3, 'Fantasy'),
(12, 'Romance'),
(15, 'Mystery'),
(19, 'History'),
(2, 'Thriller'),
(3, 'Horror'),
(12, 'Adventure'),
(15, 'Poetry'),
(19, 'Philosophy'),
(2, 'Business'),
(3, 'Self-Help'),
(12, 'Biography'),
(15, 'Education'),
(19, 'Politics'),
(2, 'Religion'),
(3, 'Technology'),
(12, 'Science'),
(15, 'Health'),
(19, 'Comedy');

INSERT INTO Book_Details (Book_ID,Title, Category_ID, Publisher_ID, Price, Year) 
VALUES (800, 'The Great Adventure', 108, 400, 19.99, 2020);
INSERT INTO Book_Details (Title, Category_ID, Publisher_ID, Price, Year) 
VALUES ( 'Lost in Time', 101, 401, 15.99, 2021),
( 'Romantic Escape', 103, 402, 12.50, 2019),
( 'Magical Kingdom', 104, 403, 25.99, 2022),
( 'History of Legends', 105, 404, 18.75, 2023),
( 'The Haunted Manor', 107, 405, 22.99, 2018),
( 'Journey to the Stars', 101, 406, 16.50, 2017),
( 'Secret Mysteries', 102, 407, 14.99, 2016),
( 'Tech Wonders', 109, 408, 19.99, 2015),
( 'The Science Handbook', 119, 409, 29.99, 2014),
( 'The Ultimate Guide to Business', 117, 410, 34.99, 2020),
( 'Mind and Body', 110, 411, 23.99, 2021),
( 'The Political Arena', 116, 412, 21.99, 2022),
( 'Philosophical Thoughts', 115, 413, 27.50, 2013),
( 'Poetry of the Heart', 113, 414, 11.99, 2011),
( 'The History of Art', 105, 415, 17.99, 2010),
( 'Medical Breakthroughs', 110, 416, 32.99, 2009),
( 'Exploring Space', 119, 417, 28.99, 2008),
( 'The Comedy Chronicles', 120, 418, 24.99, 2007),
( 'The Future of AI', 109, 419, 39.99, 2023);


INSERT INTO Book_Author (Book_ID, Author_ID) 
VALUES (800, 600),
(801, 601),
(802, 602),
(803, 603),
(804, 604),
(805, 605),
(806, 606),
(807, 607),
(808, 608),
(809, 609),
(810, 610),
(811, 611),
(812, 612),
(813, 613),
(814, 614),
(815, 615),
(816, 616),
(817, 617),
(818, 618),
(819, 619);

INSERT INTO Student_Details (Student_ID,Person_ID, Grade) 
VALUES (1000, 1, 1); 
INSERT INTO Student_Details (Person_ID, Grade) 
VALUES (2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 1),
(14, 2),
(15, 3),
(16, 4),
(17, 5),
(18, 6),
(19, 7),
(20, 8);

INSERT INTO Staff_Details (Staff_ID,Person_ID, Department) 
VALUES (2000, 2, 'Mathematics');    
INSERT INTO Staff_Details (Person_ID, Department) 
VALUES (1, 'Science'),
(3, 'English'),
(4, 'History'),
(5, 'Geography'),
(6, 'Physics'),
(7, 'Chemistry'),
(8, 'Biology'),
(9, 'Computer Science'),
(10, 'Economics'),
(11, 'Business Studies'),
(12, 'Political Science'),
(13, 'Sociology'),
(14, 'Philosophy'),
(15, 'Music'),
(16, 'Physical Education'),
(17, 'Art & Design'),
(18, 'Psychology'),
(19, 'Media Studies'),
(20, 'Library Management');

INSERT INTO Borrower_Details (Borrower_ID,Person_ID, Issued_By_Staff_ID) 
VALUES (700, 1, 2000);
INSERT INTO Borrower_Details (Person_ID, Issued_By_Staff_ID) 
VALUES (2, 2001),
(3, 2002),
(4, 2003),
(5, 2004),
( 6, 2005),
(7, 2006),
( 8, 2007),
(9, 2008),
(10, 2009),
(11, 2010),
(12, 2011),
(13, 2012),
(14, 2013),
(15, 2014),
(16, 2015),
(17, 2016),
(18, 2017),
(19, 2018),
(20, 2019);

INSERT INTO Shelf_Details (Shelf_ID,Location) 
VALUES (8000, 'A1');   
INSERT INTO Shelf_Details (Location) 
VALUES 
('A2'),
('A3'),
('B1'),
('B2'),
('B3'),
('C1'),
('C2'),
('C3'),
('D1'),
('D2'),
('D3'),
('E1'),
('E2'),
('E3'),
('F1'),
('F2'),
('F3'),
('G1'),
('G2');

INSERT INTO Transaction_Details (Transaction_ID,Borrower_ID, Book_ID, Borrow_Date, Return_Date) 
VALUES (3000, 701, 803, '2024-01-10', '2024-01-20'); 
INSERT INTO Transaction_Details (Borrower_ID, Book_ID, Borrow_Date, Return_Date) 
VALUES (702, 805, '2024-01-12', '2024-01-22'),
(703, 807, '2024-01-14', '2024-01-24'),
(704, 809, '2024-01-16', '2024-01-26'),
(705, 811, '2024-01-18', '2024-01-28'),
(706, 813, '2024-01-20', '2024-01-30'),
(707, 815, '2024-01-22', '2024-02-01'),
(708, 817, '2024-01-24', '2024-02-03'),
(709, 819, '2024-01-26', '2024-02-05'),
(710, 801, '2024-01-28', '2024-02-07'),
(711, 803, '2024-01-30', '2024-02-09'),
(712, 815, '2024-02-01', '2024-02-11'),
(713, 817, '2024-02-03', '2024-02-13'),
(714, 819, '2024-02-05', '2024-02-15'),
(715, 811, '2024-02-07', '2024-02-17'),
(716, 803, '2024-02-09', '2024-02-19'),
(717, 805, '2024-02-11', '2024-02-21'),
(718, 807, '2024-02-13', '2024-02-23'),
(719, 819, '2024-02-15', '2024-02-25'),
(700, 801, '2024-02-17', '2024-02-27');

INSERT INTO Reservation_Details (Reservation_ID,Borrower_ID, Book_ID, Reservation_Date) 
VALUES (5000, 701, 810, '2024-02-01'); 
INSERT INTO Reservation_Details (Borrower_ID, Book_ID, Reservation_Date) 
VALUES (702, 812, '2024-02-02'),
(703, 814, '2024-02-03'),
(704, 816, '2024-02-04'),
(705, 818, '2024-02-05'),
(706, 810, '2024-02-06'),
(707, 812, '2024-02-07'),
(708, 814, '2024-02-08'),
(709, 816, '2024-02-09'),
(710, 818, '2024-02-10'),
(711, 800, '2024-02-11'),
(712, 802, '2024-02-12'),
(713, 804, '2024-02-13'),
(714, 806, '2024-02-14'),
(715, 808, '2024-02-15'),
(716, 805, '2024-02-16'),
(717, 812, '2024-02-17'),
(718, 814, '2024-02-18'),
(719, 816, '2024-02-19'),
(700, 818, '2024-02-20');


ALTER TABLE Person_Details MODIFY COLUMN First_Name VARCHAR(100); 

-- QUERIES
-- Get books published after 2015 by 'Penguin Books'
SELECT * FROM Book_Details 
WHERE Year > 2015 AND Publisher_ID = 401;

-- Get books that are either has the title'The Great Adventure' OR were published before 2018
SELECT * FROM Book_Details 
WHERE Title='The Great Adventure' OR Year < 2018;

-- Get books that are NOT published after 2015
SELECT * FROM Book_Details 
WHERE NOT (Year > 2015);

-- Get books published between 2010 and 2020
SELECT * FROM Book_Details 
WHERE Year BETWEEN 2010 AND 2020;

-- Get books that belong to specific categories
SELECT * FROM Book_Details 
WHERE Category_ID IN (102, 105, 107);

-- Get the latest 5 books added
SELECT * FROM Book_Details 
ORDER BY Year DESC 
LIMIT 5;

-- Get distinct categories from books
SELECT DISTINCT Category_ID FROM Book_Details;

-- Find books with Genre 'Science'
SELECT * FROM Book_Details 
WHERE Book_ID IN (SELECT Book_ID FROM Book_Author 
	WHERE Category_ID = (SELECT Category_ID FROM Category_Details WHERE Name = 'Science'));

-- Count books in each category
SELECT Category_ID, COUNT(*) AS Total_Books 
FROM Book_Details 
GROUP BY Category_ID;

-- Find the oldest and newest published books
SELECT MIN(Year) AS Oldest, MAX(Year) AS Newest FROM Book_Details;

-- Get the total number of books
SELECT COUNT(*) FROM Book_Details;

-- Find the average year of book publishing
SELECT AVG(Year) FROM Book_Details;

-- Find transactions where the book has not been returned (NULL return date)
SELECT * FROM Transaction_Details WHERE Return_Date IS NULL;

-- Find reservations that have been confirmed (NOT NULL reservation date)
SELECT * FROM Reservation_Details WHERE Reservation_Date IS NOT NULL;

-- Get ASCII value of the first character in book titles
SELECT Title, ASCII(LEFT(Title, 1)) AS ASCII_Value FROM Book_Details;

-- Get character length of book titles
SELECT Title, CHAR_LENGTH(Title) AS CharLength FROM Book_Details;

-- Get character length of book titles
SELECT Title, CHARACTER_LENGTH(Title) AS CharLength FROM Book_Details;

-- Concatenate author first and last name
SELECT CONCAT(First_Name, ' ', Last_Name) AS FullName FROM Person_Details;

-- Concatenate book title and category with a hyphen
SELECT CONCAT_WS(' - ', Title, Category_ID) AS Book_Details FROM Book_Details;

-- Find position of 'Fiction' in a category list
SELECT FIELD('Fiction', 'History', 'Science', 'Fiction', 'Art') AS Position;

-- Find if a book belongs to category 'Science' in a comma-separated category list
SELECT FIND_IN_SET('Science', 'Math,Science,History,Literature') AS Found;

-- Format book prices to 2 decimal places
SELECT Title, FORMAT(Price, 2) AS Formatted_Price FROM Book_Details;

-- Insert 'New' at position 3 in a book title
SELECT INSERT(Title, 3, 0, 'New ') AS NEW_INFO FROM Book_Details;

-- Find position of 'Science' in a book title
SELECT Title, INSTR(Title, 'Science') AS Position FROM Book_Details;

-- Convert book titles to lowercase
SELECT LOWER(Title) AS LowercaseTitle FROM Book_Details;

-- Get first 5 characters of book titles
SELECT LEFT(Title, 5) AS Short_Title FROM Book_Details;

-- Get byte-length of book titles
SELECT Title, LENGTH(Title) AS ByteLength FROM Book_Details;

-- Find position of 'Math' in book titles
SELECT Title, LOCATE('Journey', Title) FROM Book_Details;

-- Pad book title to 20 characters with '-'
SELECT LPAD(Title, 20, '-') AS Padded_Title FROM Book_Details;

-- Trim leading spaces from book titles
SELECT LTRIM(Title) FROM Book_Details;

-- Extract 4 characters from position 3 in book titles
SELECT MID(Title, 3, 4) AS Extracted FROM Book_Details;

-- Find position of 'History' in book titles
SELECT Title, POSITION('History' IN Title) FROM Book_Details;

-- Repeat the word 'Library' 3 times
SELECT REPEAT('Library ', 3);

-- Replace 'Old' with 'New' in book titles
SELECT REPLACE(Title, 'Old', 'New') AS New_Name FROM Book_Details;

-- Reverse book titles
SELECT REVERSE(Title) AS Reversed FROM Book_Details;

-- Get the last 5 characters of book titles
SELECT RIGHT(Title, 5) AS Last_Five FROM Book_Details;

-- Pad book title to 20 characters with '-'
SELECT RPAD(Title, 20, '-') AS Padded FROM Book_Details;

-- Trim trailing spaces from book titles
SELECT RTRIM(Title) FROM Book_Details;

-- Add 5 spaces between two words
SELECT CONCAT('Library', SPACE(5), 'Database') AS SpacedText;

-- Compare two book titles (Returns 0 if they are the same)
SELECT STRCMP('Book A', 'Book B') AS CompareResult;

-- Extract first 6 characters from book titles
SELECT SUBSTR(Title, 1, 6) AS Extracted FROM Book_Details;

-- Extract characters from position 3 onwards in book titles
SELECT SUBSTRING(Title, 3) AS Extracted FROM Book_Details;

-- Get the first word from book titles (split by space)
SELECT SUBSTRING_INDEX(Title, ' ', 1) AS Extracted FROM Book_Details;

-- Remove spaces from both sides of book titles
SELECT TRIM(Title) FROM Book_Details;

-- Convert book titles to uppercase
SELECT UPPER(Title) AS UppercaseTitle FROM Book_Details;

-- Cross Join
SELECT Book_Details.Title, Person_Details.First_Name AS Person_Name
FROM Book_Details 
CROSS JOIN Person_Details;

-- Inner Join
SELECT Book_Details.Title, Category_Details.Name AS Category_Name
FROM Book_Details
INNER JOIN Category_Details ON Book_Details.Category_ID = Category_Details.Category_ID;

-- Left Join
SELECT Book_Details.Title, Person_Details.First_Name AS Person_Name
FROM Book_Details
LEFT JOIN Person_Details ON Book_Details.Publisher_ID = Person_Details.Person_ID;

-- Right Join
SELECT Book_Details.Title, Publisher_Details.Person_ID AS Publisher_ID
FROM Book_Details
RIGHT JOIN Publisher_Details ON Book_Details.Publisher_ID = Publisher_Details.Publisher_ID;

-- Full Outer Join (Using UNION)
SELECT b.Title, p.Publisher_ID 
FROM Book_Details b 
LEFT JOIN Publisher_Details p ON b.Publisher_ID = p.Publisher_ID
UNION
SELECT b.Title, p.Publisher_ID 
FROM Book_Details b 
RIGHT JOIN Publisher_Details p ON b.Publisher_ID = p.Publisher_ID;

-- EQUI JOIN
SELECT Book_Details.Title, Category_Details.Name AS Category_Name
FROM Book_Details, Category_Details
WHERE Book_Details.Category_ID = Category_Details.Category_ID;

-- CONDITIONAL JOIN
SELECT Book_Details.Title, Borrower_Details.Person_ID AS Borrower_ID
FROM Borrower_Details
JOIN Transaction_Details 
ON Borrower_Details.Borrower_ID = Transaction_Details.Borrower_ID
JOIN Book_Details
ON Transaction_Details.Book_ID = Book_Details.Book_ID
WHERE Transaction_Details.Borrow_Date > '2023-01-01';

-- SELF JOIN
SELECT A.First_Name AS Author1, B.First_Name AS Author2
FROM Person_Details A, Person_Details B
WHERE A.Person_ID <> B.Person_ID;

-- UNION
SELECT Student_ID FROM Student_Details  
UNION  
SELECT Staff_ID FROM Staff_Details;

-- UNION ALL
SELECT Student_ID FROM Student_Details  
UNION ALL
SELECT Staff_ID FROM Staff_Details;

-- INTERSECT
SELECT First_Name, Last_Name FROM Person_Details  
INNER JOIN Staff_Details  
ON Person_Details.Person_ID = Staff_Details.Person_ID;

-- ANY Operator
SELECT * FROM Book_Details
WHERE Year > ANY (SELECT Year FROM Book_Details WHERE Category_ID = 101);

-- ANY: Find books that have been borrowed at least once
SELECT * FROM Book_Details 
WHERE Book_ID = ANY (SELECT Book_ID FROM Transaction_Details);

-- ALL Operator
SELECT * FROM Book_Details
WHERE Year > ALL (SELECT Year FROM Book_Details WHERE Category_ID = 102);

-- ALL: Find books that have been borrowed more than once
SELECT * FROM Book_Details 
WHERE Book_ID = ALL (SELECT Book_ID FROM Transaction_Details GROUP BY Book_ID HAVING COUNT(*) > 1);

-- EXISTS
SELECT * FROM Borrower_Details B
WHERE EXISTS (SELECT 1 FROM Transaction_Details T WHERE B.Borrower_ID = T.Borrower_ID);

-- NOT EXISTS: Find books that have never been borrowed
SELECT * FROM Book_Details b
WHERE NOT EXISTS (SELECT 1 FROM Transaction_Details t WHERE t.Book_ID = b.Book_ID);

-- Simple View
CREATE VIEW Book_View AS
SELECT Book_ID, Title, Price
FROM Book_Details;
SELECT * FROM Book_View;

-- Complex View
CREATE VIEW Borrower_Book_View AS
SELECT B.Borrower_ID, Bo.Title AS Borrowed_Book, T.Borrow_Date
FROM Borrower_Details B
JOIN Transaction_Details T ON B.Borrower_ID = T.Borrower_ID
JOIN Book_Details Bo ON T.Book_ID = Bo.Book_ID
WHERE T.Return_Date IS NOT NULL;
SELECT * FROM Borrower_Book_View;

-- Creating a View
CREATE VIEW Category_Count AS
SELECT C.Category_ID, C.Name AS Category_Name, COUNT(B.Book_ID) AS Book_Count
FROM Category_Details C
LEFT JOIN Book_Details B ON C.Category_ID = B.Category_ID
GROUP BY C.Category_ID, C.Name;
SELECT * FROM Category_Count;

-- Renaming a View
RENAME TABLE Book_View TO Books_Summary;
SELECT * FROM Books_Summary;
-- Replacing a View
CREATE OR REPLACE VIEW Book_View AS
SELECT Book_ID, Title, Price, Year
FROM Book_Details;
SELECT * FROM Book_View;

-- Updating a View
UPDATE Book_View
SET Price = Price + 5
WHERE Book_ID = 101;
SELECT * FROM Book_View;

-- Deleting a View
DROP VIEW Book_View;

















