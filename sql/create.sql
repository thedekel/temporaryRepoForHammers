CREATE DATABASE IF NOT EXISTS cs4400_group53;
USE cs4400_group53;
CREATE TABLE Users(
    email VARCHAR(255) NOT NULL,
    name VARCHAR(30) NOT NULL,
    pin INTEGER NOT NULL,
    PRIMARY KEY(email)
);
CREATE TABLE Follow(
    parent VARCHAR(255) NOT NULL,
    child VARCHAR(255) NOT NULL,
    FOREIGN KEY (parent) REFERENCES Users(email) ,
    FOREIGN KEY (child)  REFERENCES Users(email) 
);
ALTER TABLE Follow  ENGINE = InnoDB;
CREATE TABLE Categories(
    name VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY(name)
);
CREATE TABLE CorkBoards(
    owner VARCHAR(255) NOT NULL,
    FOREIGN KEY (owner) REFERENCES Users(email), 
    title VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    FOREIGN KEY (category) REFERENCES Categories(name),
    password VARCHAR(20),
    PRIMARY KEY (owner, title)
);
ALTER TABLE CorkBoards ENGINE = InnoDB;
CREATE TABLE Pushpins(
    link VARCHAR(255) NOT NULL, 
    descr TEXT NOT NULL,
    dateAndTime DATETIME NOT NULL,
    owner VARCHAR(255) NOT NULL,
    FOREIGN KEY (owner) REFERENCES CorkBoards(owner),
    PRIMARY KEY(owner, dateAndTime)
);
ALTER TABLE Pushpins ENGINE = InnoDB;
CREATE TABLE Comments(
    text TEXT NOT NULL,
    dateAndTime DATETIME NOT NULL,
    owner VARCHAR(255) NOT NULL,
    about VARCHAR(255) NOT NULL,
    pinTime DATETIME NOT NULL,
    FOREIGN KEY (owner) REFERENCES Users(email),
    FOREIGN KEY (about, pinTime) REFERENCES Pushpins(owner, dateAndTime),
    PRIMARY KEY(owner, dateAndTime, about, pinTime)
);
ALTER TABLE Comments ENGINE = InnoDB;
CREATE TABLE Likes(
    parent VARCHAR(255) NOT NULL,
    pinOwner VARCHAR(255) NOT NULL,
    pinTime DATETIME NOT NULL,
    FOREIGN KEY (parent) REFERENCES Users(email) ,
    FOREIGN KEY (pinOwner, pinTime)  REFERENCES Pushpins(owner, dateAndTime),
    PRIMARY KEY (parent, pinOwner, pinTime)
);
ALTER TABLE Likes ENGINE = InnoDB;
CREATE TABLE Watches(
    parent VARCHAR(255) NOT NULL,
    boardOwner VARCHAR(255) NOT NULL,
    boardTitle VARCHAR(50) NOT NULL,
    FOREIGN KEY (parent) REFERENCES Users(email) ,
    FOREIGN KEY (boardOwner, boardTitle)  REFERENCES CorkBoards(owner, title),
    PRIMARY KEY(parent, boardOwner, boardTitle)

);
ALTER TABLE Watches ENGINE = InnoDB;
