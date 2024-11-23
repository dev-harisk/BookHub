-- Create a new database named 'library_db'
-- This database will be used to store all information related to the library system,
-- including books, authors, members, and transactions.

CREATE DATABASE library_db;

-- Switch to the 'library_db' database
-- This command sets the context to the 'library_db' database,
-- allowing subsequent SQL commands to operate within this database.

USE library_db;

-- Create a table named 'authors' to store information about authors in the library

CREATE TABLE authors (
  author_id int NOT NULL AUTO_INCREMENT,  -- Unique identifier for each author, auto-incremented
  author_name varchar(100) NOT NULL,  -- Name of the author, required field
  author_email varchar(100) DEFAULT NULL,  -- Email address of the author, optional field
  author_country varchar(100) DEFAULT NULL,  -- Country of the author, optional field
  PRIMARY KEY (author_id)  -- Set 'author_id' as the primary key for the table
);

-- Create a table named 'genre' to store information about book genres

CREATE TABLE genre (
  genre_id int NOT NULL AUTO_INCREMENT,  -- Unique identifier for each genre, auto-incremented
  genre_name varchar(100) NOT NULL,  -- Name of the genre, required field
  PRIMARY KEY (genre_id),  -- Set 'genre_id' as the primary key for the table
  UNIQUE KEY genre_name (genre_name)  -- Ensure that each genre name is unique
);

-- Create a table named 'books' to store information about books in the library

CREATE TABLE books (
  isbn varchar(20) DEFAULT NULL,  -- ISBN number of the book, optional field
  book_id int NOT NULL AUTO_INCREMENT,  -- Unique identifier for each book, auto-incremented
  title varchar(250) NOT NULL,  -- Title of the book, required field
  publisher varchar(200) DEFAULT NULL,  -- Publisher of the book, optional field
  published_year year NOT NULL,  -- Year the book was published, required field
  -- genre varchar(150) DEFAULT NULL,  -- Genre of the book, optional field
  no_of_copies int NOT NULL,  -- Number of copies available in the library, required field
  genre_id int NOT NULL,  -- Foreign key referencing the genre of the book
  author_id int NOT NULL,  -- Foreign key referencing the author of the book
  PRIMARY KEY (book_id),  -- Set 'book_id' as the primary key for the table
  KEY fk_author_id (author_id),  -- Index for the 'author_id' foreign key
  KEY fk_genre_id (genre_id),  -- Index for the 'genre_id' foreign key
  CONSTRAINT fk_author_id FOREIGN KEY (author_id) REFERENCES authors (author_id),  -- Foreign key constraint linking to 'authors' table
  CONSTRAINT fk_genre_id FOREIGN KEY (genre_id) REFERENCES genre (genre_id)  -- Foreign key constraint linking to 'genre' table
);

-- Create a table named 'book_availability' to track the availability of books in the library

CREATE TABLE book_availability (
  book_id int NOT NULL,  -- Foreign key referencing the unique identifier of the book
  no_of_copies int DEFAULT NULL,  -- Number of copies available for the book, optional field
  PRIMARY KEY (book_id),  -- Set 'book_id' as the primary key for the table
  CONSTRAINT fk_book_id FOREIGN KEY (book_id) REFERENCES books (book_id)  -- Foreign key constraint linking to 'books' table
    ON DELETE CASCADE  -- If a book is deleted, its availability record will also be deleted
    ON UPDATE CASCADE  -- If the book ID is updated, the change will be reflected in this table
);

-- Create a table named 'members' to store information about library members

CREATE TABLE members (
  member_id int NOT NULL AUTO_INCREMENT,  -- Unique identifier for each member, auto-incremented
  full_name varchar(50) NOT NULL,  -- Full name of the member, required field
  address varchar(250) DEFAULT NULL,  -- Address of the member, optional field
  email varchar(250) NOT NULL,  -- Email address of the member, required field
  membership_type enum('Student','General','Temporary','Senior citizen','Faculty') NOT NULL,  -- Type of membership, required field
  age int DEFAULT NULL,  -- Age of the member, optional field
  PRIMARY KEY (member_id),  -- Set 'member_id' as the primary key for the table
  UNIQUE KEY email (email)  -- Ensure that each email address is unique among members
);

-- Create a table named 'transactions' to store information about book transactions

CREATE TABLE transactions (
  transaction_id int NOT NULL AUTO_INCREMENT,  -- Unique identifier for each transaction, auto-incremented
  book_id int NOT NULL,  -- Foreign key referencing the unique identifier of the book being borrowed
  member_id int NOT NULL,  -- Foreign key referencing the unique identifier of the member borrowing the book
  issue_date date DEFAULT NULL,  -- Date when the book was issued, optional field
  due_date date DEFAULT NULL,  -- Date when the book is due to be returned, optional field
  return_date date DEFAULT NULL,  -- Date when the book was returned, optional field
  fine_amount decimal(10,2) DEFAULT '0.00',  -- Fine amount for overdue books, default is 0.00
  PRIMARY KEY (transaction_id),  -- Set 'transaction_id' as the primary key for the table
  KEY book_id (book_id),  -- Index on 'book_id' for faster lookups
  KEY member_id (member_id),  -- Index on 'member_id' for faster lookups
  CONSTRAINT fk_book_id FOREIGN KEY (book_id) REFERENCES books (book_id) ON DELETE CASCADE,  -- Foreign key constraint for book
  CONSTRAINT fk_member_id FOREIGN KEY (member_id) REFERENCES members (member_id) ON DELETE CASCADE  -- Foreign key constraint for member
);

-- Create a table named 'librarian' to store information about library staff

CREATE TABLE librarian (
  librarian_id int NOT NULL AUTO_INCREMENT,  -- Unique identifier for each librarian, auto-incremented
  librarian_name varchar(100) DEFAULT NULL,  -- Name of the librarian, optional field
  login_password varchar(100) DEFAULT NULL,  -- Password for librarian login, optional field
  librarian_address varchar(100) DEFAULT NULL,  -- Address of the librarian, optional field
  librarian_email varchar(100) NOT NULL,  -- Email address of the librarian, required field
  PRIMARY KEY (librarian_id),  -- Set 'librarian_id' as the primary key for the table
  UNIQUE KEY librarian_email_UNIQUE (librarian_email)  -- Ensure that each email address is unique among librarians
);


-- Inserting demo data into the 'librarian' table to populate it with sample librarian information, including names, addresses, emails, and login passwords.

INSERT INTO librarian (librarian_name, login_password, librarian_address, librarian_email) VALUES 
('John Doe', 'Nimda@36', '123 Library Lane, Springfield', 'john.doe@example.com');


-- 
-- Insert multiple genres into the 'genre' table.
-- This table is used to categorize books into different genres for better organization and retrieval.
-- The following genres are being added:
-- 
-- 1. Fiction: A literary work based on the imagination and not necessarily on fact.
-- 2. Non-Fiction: A genre that presents factual information and real events.
-- 3. Mystery: A genre that involves suspenseful events and often a crime to be solved.
-- 4. Thriller: A genre characterized by excitement and suspense, often involving danger.
-- 5. Fantasy: A genre that includes magical elements and fantastical worlds.
-- 6. Science Fiction: A genre that explores futuristic concepts, advanced technology, and space exploration.
-- 7. Biography: A detailed description of a person's life, written by someone else.
-- 8. Romance: A genre focused on romantic relationships and emotional connections.
-- 9. Historical Fiction: A genre that combines fictional stories with historical events or settings.
-- 10. Self-Help: A genre that provides guidance and strategies for personal improvement.
-- 11. Horror: A genre intended to frighten, scare, or disturb the audience.
-- 12. Adventure: A genre that involves exciting and often dangerous journeys or quests.
-- 13. Poetry: A literary genre that expresses ideas and emotions through rhythmic and metaphorical language.
-- 14. Graphic Novel: A genre that combines visual art with narrative storytelling, often in comic book format.
-- 15. Young Adult: A genre targeted towards teenage readers, often dealing with themes relevant to young adults.
-- 16. Technology: A genre that explores themes related to technology and its impact on society.
-- 17. Classic: A genre that includes works recognized for their literary merit and lasting significance.
-- 18. Dystopian: A genre that explores social and political structures in a dark, nightmare world.
-- 19. Coming-of-age: A genre that focuses on the growth and development of a protagonist from youth to adulthood.
-- 
-- The following SQL statement inserts these genres into the 'genre' table:

INSERT INTO genre (genre_name) VALUES 
('Fiction'),
('Non-Fiction'),
('Mystery'),
('Thriller'),
('Fantasy'),
('Science Fiction'),
('Biography'),
('Romance'),
('Historical Fiction'),
('Self-Help'),
('Horror'),
('Adventure'),
('Poetry'),
('Graphic Novel'),
('Young Adult'),
('Technology'),
('Classic'),
('Dystopian'),
('Coming-of-age');

-- Inserting demo data into the 'authors' table to populate it with sample author information, including names, email addresses, and countries of origin.

INSERT INTO authors (author_name, author_email, author_country) VALUES 
('J.K. Rowling', 'jk.rowling@example.com', 'United Kingdom'),
('George R.R. Martin', 'george.martin@example.com', 'United States'),
('Agatha Christie', 'agatha.christie@example.com', 'United Kingdom'),
('Mark Twain', 'mark.twain@example.com', 'United States'),
('Haruki Murakami', 'haruki.murakami@example.com', 'Japan'),
('Chinua Achebe', 'chinua.achebe@example.com', 'Nigeria'),
('Jane Austen', 'jane.austen@example.com', 'United Kingdom'),
('Stephen King', 'stephen.king@example.com', 'United States'),
('Isabel Allende', 'isabel.allende@example.com', 'Chile'),
('Gabriel García Márquez', 'gabriel.garcia@example.com', 'Colombia');

-- Inserting demo data into the 'members' table to populate it with sample member information, including full name, address, email, membership type, and age.

INSERT INTO books (isbn, title, publisher, published_year, no_of_copies, genre_id, author_id) VALUES 
('978-3-16-148410-0', 'Harry Potter and the Philosophers Stone', 'Bloomsbury', 1997, 10, 1, 1),
('978-0-7432-7356-5', 'A Game of Thrones', 'Bantam Books', 1996, 5, 2, 2),
('978-0-06-112008-4', 'To Kill a Mockingbird', 'J.B. Lippincott & Co.', 1960, 8, 3, 3),
('978-0-452-28423-4', 'The Great Gatsby', 'Charles Scribners Sons', 1925, 6, 3, 4),
('978-1-56619-909-4', 'Norwegian Wood', 'Harvill Secker', 1987, 7, 3, 5),
('978-0-14-028333-4', 'Things Fall Apart', 'Heinemann', 1958, 4, 3, 6),
('978-0-19-953556-9', 'Pride and Prejudice', 'T. Egerton', 1813, 9, 4, 7),
('978-1-5011-2630-0', 'The Shining', 'Doubleday', 1977, 12, 5, 8),
('978-0-06-231500-7', 'The House of the Spirits', 'Alfred A. Knopf', 1982, 3, 6, 9),
('978-0-06-088328-7', 'One Hundred Years of Solitude', 'Harper & Row', 1967, 2, 6, 10);

-- Inserting sample data into the 'members' table

INSERT INTO members (full_name, address, email, membership_type, age) VALUES 
('Alice Johnson', '123 Maple St, Springfield', 'alice.johnson@example.com', 'Student', 20),
('Bob Smith', '456 Oak St, Springfield', 'bob.smith@example.com', 'General', 35),
('Charlie Brown', '789 Pine St, Springfield', 'charlie.brown@example.com', 'Temporary', 28),
('Diana Prince', '321 Elm St, Springfield', 'diana.prince@example.com', 'Senior citizen', 65),
('Ethan Hunt', '654 Cedar St, Springfield', 'ethan.hunt@example.com', 'Faculty', 45),
('Fiona Gallagher', '987 Birch St, Springfield', 'fiona.gallagher@example.com', 'Student', 22),
('George Costanza', '135 Willow St, Springfield', 'george.costanza@example.com', 'General', 40),
('Hannah Baker', '246 Spruce St, Springfield', 'hannah.baker@example.com', 'Temporary', 30);

-- Inserting demo data into the 'transactions' table to populate it with sample transaction information, including book ID, member ID, issue date, due date, return date, and fine amount.

INSERT INTO transactions (book_id, member_id, issue_date, due_date, returned_date, fine_amount)
VALUES
  (5, 10, '2023-11-15', '2023-12-15', '2023-12-10', 0.00),
  (12, 5, '2023-10-20', '2023-11-20', '2023-11-25', 15.00),
  (3, 8, '2024-01-05', '2024-02-05', NULL, 0.00),
  (18, 15, '2023-09-25', '2023-10-25', '2023-10-20', 0.00),
  (7, 12, '2023-12-01', '2024-01-01', '2024-01-05', 5.00),
  (2, 6, '2024-02-10', '2024-03-10', NULL, 0.00),
  (15, 9, '2023-11-28', '2023-12-28', '2024-01-02', 20.00),
  (10, 4, '2023-10-15', '2023-11-15', '2023-11-10', 0.00),
  (1, 11, '2024-01-20', '2024-02-20', NULL, 0.00),
  (19, 7, '2023-12-12', '2024-01-12', '2024-01-10', 0.00);

-- Create or replace a view named 'get_book_details' to retrieve detailed information about books

CREATE OR REPLACE VIEW get_book_details AS
SELECT 
    b.book_id AS book_id,                  -- Unique identifier for the book
    b.title AS title,                      -- Title of the book
    b.author_id AS author_id,              -- Unique identifier for the author
    a.author_name AS author_name,          -- Name of the author
    b.genre_id AS genre_id,                -- Unique identifier for the genre
    g.genre_name AS genre_name,            -- Name of the genre
    b.publisher AS publisher,               -- Publisher of the book
    b.published_year AS published_year,    -- Year the book was published
    b.isbn AS isbn,                        -- ISBN number of the book
    b.no_of_copies AS no_of_copies         -- Number of copies available
FROM 
    books b                                 -- Books table
JOIN 
    authors a ON b.author_id = a.author_id  -- Join with authors table
JOIN 
    genre g ON b.genre_id = g.genre_id      -- Join with genre table
ORDER BY 
    b.book_id DESC;                        -- Order results by book_id in descending order


-- Create or replace a view named 'transaction_details' to retrieve detailed information about transactions

CREATE OR REPLACE VIEW transaction_details AS
SELECT 
    t.transaction_id AS transaction_id,  -- Unique identifier for each transaction
    m.full_name AS full_name,             -- Full name of the member
    t.book_id AS book_id,                 -- Unique identifier for the book
    b.title AS title,                      -- Title of the book
    t.issue_date AS issue_date,           -- Date the book was issued
    t.due_date AS due_date,               -- Due date for returning the book
    t.return_date AS return_date,         -- Date the book was returned
    t.fine_amount AS fine_amount           -- Fine amount for late returns
FROM 
    transactions t                         -- Transactions table
JOIN 
    books b ON t.book_id = b.book_id      -- Join with books table
JOIN 
    members m ON t.member_id = m.member_id -- Join with members table;


-- Create a stored procedure to insert an author name if it does not already exist

DELIMITER //
CREATE PROCEDURE insert_author_name(IN new_author_name VARCHAR(45), OUT p_author_id INT)
BEGIN
    -- Attempt to find the author ID based on the provided author name
    SELECT author_id INTO p_author_id 
    FROM authors 
    WHERE author_name = new_author_name;

    -- Check if the author ID was found
    IF p_author_id IS NULL THEN
        -- If not found, insert the new author name into the authors table
        INSERT INTO authors (author_name) VALUES (new_author_name);
        -- Retrieve the last inserted author ID
        SELECT LAST_INSERT_ID() INTO p_author_id;
    END IF;
END //

DELIMITER ;



-- Create a stored procedure to retrieve author names by genre ID

DELIMITER //
CREATE PROCEDURE getAuthorNameByGenreId(IN genre_id INT)
BEGIN
    -- Select distinct author IDs and names for books that match the given genre ID
    SELECT DISTINCT 
        a.author_id,      -- Unique identifier for the author
        a.author_name     -- Name of the author
    FROM 
        books b          -- Books table
    JOIN 
        authors a ON b.author_id = a.author_id  -- Join with authors table
    WHERE 
        b.genre_id = genre_id;  -- Filter by the provided genre ID
END //

DELIMITER ;

-- Create a stored procedure to retrieve book titles by author ID

DELIMITER //
CREATE PROCEDURE getBookTitleByAuthorId(IN author_id INT)
BEGIN
    -- Select distinct book IDs and titles for books written by the specified author
    SELECT DISTINCT 
        b.book_id,      -- Unique identifier for the book
        b.title         -- Title of the book
    FROM 
        books b         -- Books table
    JOIN 
        authors a ON b.author_id = a.author_id  -- Join with authors table
    JOIN 
        genre g ON b.genre_id = g.genre_id      -- Join with genre table (if needed)
    WHERE 
        a.author_id = author_id;  -- Filter by the provided author ID
END //

DELIMITER ;

-- Create a trigger to replicate the number of copies of a book into the book_availability table after a new book is inserted

DELIMITER //
CREATE TRIGGER tr_replicate_books_no_of_copies_on_insert
AFTER INSERT ON books
FOR EACH ROW
BEGIN
    -- Insert the new book's ID and number of copies into the book_availability table
    INSERT INTO book_availability(book_id, no_of_copies) 
    VALUES (NEW.book_id, NEW.no_of_copies);
END //

DELIMITER ;

-- Create a trigger to update the number of copies of a book in the book_availability table after a book is updated

DELIMITER //
CREATE TRIGGER tr_replicate_books_no_of_copies_on_update
AFTER UPDATE ON books
FOR EACH ROW
BEGIN
    -- Check if the number of copies has changed
    IF OLD.no_of_copies <> NEW.no_of_copies THEN
        -- Update the number of copies in the book_availability table
        UPDATE book_availability 
        SET no_of_copies = NEW.no_of_copies 
        WHERE book_id = NEW.book_id;
    END IF;
END //

DELIMITER ;

-- Create a trigger to set the issue date and due date before inserting a new transaction

DELIMITER //
CREATE TRIGGER set_issue_and_due_date
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    -- Set the issue date to the current date
    SET NEW.issue_date = CURRENT_DATE();
    
    -- Set the due date to 14 days after the issue date
    SET NEW.due_date = DATE_ADD(CURRENT_DATE(), INTERVAL 14 DAY);
END //

DELIMITER ;

-- Create a trigger to update the number of copies available after a new transaction is inserted

DELIMITER //
CREATE TRIGGER tr_update_books_no_of_copies_issued
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    -- Update the number of copies in the book_availability table
    UPDATE book_availability 
    SET no_of_copies = no_of_copies - 1 
    WHERE book_id = NEW.book_id AND no_of_copies > 0; -- Ensure no negative copies
END //

DELIMITER ;