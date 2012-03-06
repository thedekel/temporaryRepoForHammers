--add "IF NOT EXIST" and such
USE cbit;
CREATE TABLE User(
    email VARCHAR(255) PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL,
    pin INTEGER NOT NULL
);
CREATE TABLE Follow(
    parent email NOT Null,
    child email NOT Null
    -- add constraints
);
CREATE TABLE CorkBoards(
    FOREIGN KEY (email) REFERENCES User(email), --look up exact syntax
    title VARCHAR(100) NOT NULL,
    -- user can't have two of the same title
    FOREIGN KEY (category) REFERENCES Categories(name),
    password VARCHAR(20) 
);
CREATE TABLE Categories(
    name VARCHAR(50) UNIQUE NOT NULL PRIMARY,
);
CREATE TABLE Pushpins(
    --add tags
    link VARCHAR(255) NOT NULL, -- why is this half-underlined?
    desc TEXT NOT NULL,
    dateAndTime DATETIME NOT NULL,
    FOREIGN KEY owner REFERENCES CorkBoards(email) PRIMARY
);
CREATE TABLE Comments(
    text TEXT NOT NULL,
    dateAndTime DATETIME NOT NULL,
    FOREIGN KEY owner REFERENCES User(email),
    FOREIGN KEY about REFERENCES Pushpins(owner)
);
CREATE TABLE Likes(
    parent email NOT NULL,
    child owner NOT NULL
    -- how to reference pushpin
);
CREATE TABLE Watches(
    parent email NOT NULL,
    child email NOT NULL,
    -- how to reference corkboard
);
