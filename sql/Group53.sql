CREATE DATABASE IF NOT EXISTS cs4400_group53;
USE cs4400_group53;
CREATE TABLE Users(
    email VARCHAR(255) NOT NULL,
    name VARCHAR(30) NOT NULL,
    pin INTEGER NOT NULL,
    PRIMARY KEY(email),
	CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);
CREATE TABLE Follow(
    parent VARCHAR(255) NOT NULL,
    child VARCHAR(255) NOT NULL,
    FOREIGN KEY (parent) REFERENCES Users(email) ,
    FOREIGN KEY (child)  REFERENCES Users(email),
	CONSTRAINT follow_self CHECK (STRCMP(parent, child)!=0)
);
ALTER TABLE Follow  ENGINE = InnoDB;
CREATE TABLE Categories(
    name VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY(name)
);
CREATE TABLE CorkBoards(
    owner VARCHAR(255) NOT NULL,
    title VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
	password VARCHAR(20),
    FOREIGN KEY (category) REFERENCES Categories(name),
	FOREIGN KEY (owner) REFERENCES Users(email), 
    PRIMARY KEY (owner, title)
);
ALTER TABLE CorkBoards ENGINE = InnoDB;
CREATE TABLE Pushpins(
    link VARCHAR(255) NOT NULL, 
    descr TEXT NOT NULL,
    dateAndTime DATETIME NOT NULL,
	boardTitle VARCHAR(100) NOT NULL,
    owner VARCHAR(255) NOT NULL,
	tags VARCHAR(359),
    FOREIGN KEY (owner, boardTitle) REFERENCES CorkBoards(owner, title),
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
    PRIMARY KEY (parent, pinOwner, pinTime),
	CONSTRAINT cant_like_your_posts CHECK (STRCMP(parent, pinOwner)!=0)
);
ALTER TABLE Likes ENGINE = InnoDB;
CREATE TABLE Watches(
    parent VARCHAR(255) NOT NULL,
    boardOwner VARCHAR(255) NOT NULL,
    boardTitle VARCHAR(50) NOT NULL,
    FOREIGN KEY (parent) REFERENCES Users(email) ,
    FOREIGN KEY (boardOwner, boardTitle)  REFERENCES CorkBoards(owner, title),
    PRIMARY KEY(parent, boardOwner, boardTitle),
	CONSTRAINT cant_follow_own_board CHECK (STRCMP(parent, boardOwner)!=0)

);
ALTER TABLE Watches ENGINE = InnoDB;

INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Architecture');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Art');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Education');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Food & Drink');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Home & Garden');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Other');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('People');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Pets');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Photography');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Sports');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Technology');
INSERT INTO `cs4400_group53`.`Categories` (`name`) VALUES ('Travel');

INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user1@gt.edu', 'Peter', '1001');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user2@gt.edu', 'Paul', '1002');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user3@gt.edu', 'Mary', '1003');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user4@gt.edu', 'Laura', '1004');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user5@gt.edu', 'Leo', '1002');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user6@gt.edu', 'Ed', '1003');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user7@gt.edu', 'Sue', '1004');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user8@gt.edu', 'Ling', '1005');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user9@gt.edu', 'Jim', '1006');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user10@gt.edu', 'Li', '1007');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user11@gt.edu', 'Anne', '1008');
INSERT INTO `cs4400_group53`.`Users` (`email`, `name`, `pin`) VALUES ('user12@gt.edu', 'Bo', '1009');

INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user1@gt.edu', 'user2@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user1@gt.edu', 'user3@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user3@gt.edu', 'user4@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user3@gt.edu', 'user5@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user3@gt.edu', 'user4@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user4@gt.edu', 'user2@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user4@gt.edu', 'user6@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user5@gt.edu', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user5@gt.edu', 'user2@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user5@gt.edu', 'user7@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user7@gt.edu', 'user5@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user8@gt.edu', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user8@gt.edu', 'user3@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user8@gt.edu', 'user5@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user8@gt.edu', 'user9@gt.edu');
INSERT INTO `cs4400_group53`.`Follow` (`parent`, `child`) VALUES ('user12@gt.edu', 'user7@gt.edu');


INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`, `password`) VALUES ('user1@gt.edu', 'Pools', 'Home & Garden', 'qwerty');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`, `password`) VALUES ('user1@gt.edu', 'Dogs', 'Pets', 'asdfgh');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`, `password`) VALUES ('user2@gt.edu', 'Gardens I Love', 'Architecture', 'zxcvbn');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`, `password`) VALUES ('user3@gt.edu', 'Birthday Ideas', 'Other', 'qwerty');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`, `password`) VALUES ('user5@gt.edu', 'Vacation Spots', 'Travel', 'poiuyt');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`, `password`) VALUES ('user6@gt.edu', 'Cat Antics', 'Pets', 'lkjhgf');

INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user1@gt.edu', 'Garden', 'Home & Garden');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user2@gt.edu', 'My DIY Board', 'Home & Garden');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user3@gt.edu', 'Baseball', 'Sports');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user4@gt.edu', 'Swimming', 'Sports');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user5@gt.edu', 'Run Baby Run', 'Sports');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user6@gt.edu', 'Vacation Ideas', 'Travel');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user6@gt.edu', 'Baseball', 'Sports');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user7@gt.edu', 'My Dog', 'Pets');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user7@gt.edu', 'Dogs', 'Pets');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user7@gt.edu', 'Cars', 'Other');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user8@gt.edu', 'Cars', 'Technology');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user8@gt.edu', 'Garden', 'Home & Garden');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user9@gt.edu', 'GT', 'Education');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user11@gt.edu', 'Buzz', 'Education');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user11@gt.edu', 'GT', 'Technology');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user12@gt.edu', 'Vacation', 'Travel');
INSERT INTO `cs4400_group53`.`CorkBoards` (`owner`, `title`, `category`) VALUES ('user12@gt.edu', 'My Trip', 'Travel');

INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://puppydogweb.com/gallery/germanshepherddogs/germanshepherd_schweitzer.jpg', 'Black Shepherd', '2011-01-01 10:11:12', 'user1@gt.edu', 'Dogs', 'Shepherd,pet,dog');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://puppydogweb.com/gallery/germanshepherddogs/germanshepherd_fernandez.jpg', 'Young shepherd', '2011-01-02 10:11:12', 'user1@gt.edu', 'Dogs', 'Puppy,shepherd,dog');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://puppydogweb.com/gallery/germanshepherddogs/germanshepherd_madrid.jpg', 'Shepherd puppy', '2011-01-03 10:11:12', 'user7@gt.edu', 'My Dog', 'Puppy,furball,cute');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://puppydogweb.com/gallery/germanshepherddogs/germanshepherd_dash.jpg', 'Hungry shepherd puppy', '2011-01-04 10:11:12', 'user7@gt.edu', 'Dogs', 'Puppy,feedme,shepherd');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://puppydogweb.com/gallery/norwegianbuhunds/norwegianbuhund_langhoff.jpg', 'Pretty Buhund', '2011-01-05 10:11:12', 'user7@gt.edu', 'Dogs', 'Buhund,puppy');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://puppydogweb.com/gallery/bulldogs/bulldog_dorson.jpg', 'My GT friend''s doggy', '2011-02-06 10:05:08', 'user9@gt.edu', 'GT', 'Bulldog,outofplace,dog');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://puppydogweb.com/gallery/chihuahuas/chihuahua_gibson1.jpg', 'Chihuahua', '2011-02-08 10:05:08', 'user7@gt.edu', 'Dogs', 'Chihuahua,attackdog');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.earchitect.co.uk/images/jpgs/copenhagen/tuborg_blocks.jpg', 'Tuborg Brewery', '2011-02-09 10:05:08', 'user12@gt.edu', 'Vacation', 'beer');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.pbase.com/traianc/image/117010279', 'Modern architecture Copenhagen', '2011-02-01 10:05:08', 'user12@gt.edu', 'My Trip',  'Modern,architecture');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.pbase.com/traianc/image/78240400', 'Modern art museum', '2011-02-01 09:05:08', 'user12@gt.edu', 'My Trip',  'Architecture');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://static.ddmcdn.com/gif/smart-car-1.jpg', 'French', '2011-08-08 07:05:08', 'user7@gt.edu', 'Cars', 'Cute,smart,car');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://usesolarenergynow.com/wpcontent/uploads/2010/07/Solar_Wing_front_Japanese_electric_powered_car.jpg', 'Sun better shine on this car', '2011-08-08 06:05:08', 'user7@gt.edu', 'Cars', 'Solar,power,car');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://4.bp.blogspot.com/-pkfo8h1-ZcI/T0WVCzTJdQI/AAAAAAAACo0/IKlXypoH518/s400/Ferrari+Enzo.jpg', 'Ferrari Enzo wall to wall power', '2011-08-08 05:05:08', 'user8@gt.edu', 'Cars', 'Italian,pure,fast');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://giverny.org/gardens/fcm/pictures/giverny-4.jpg', 'Monet''s garden in Giverny', '2011-08-08 04:05:08', 'user1@gt.edu', 'Pools', 'Art,gardening');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.jaydax.co.uk/showcase/themes/monet/Monetgarden.jpg', 'Most beautiful garden in the World', '2011-08-08 03:05:08', 'user8@gt.edu', 'Garden', 'Bridge,garden,art');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://buyandsellland.com/wpcontent/uploads/2011/01/poollandscaping-2102.jpg', 'My favorite spot in my backyard', '2011-06-08 08:05:08', 'user1@gt.edu', 'Pools', 'Chill');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.ujenanetwork.com/feed/41504.jpg', 'Sailing and I am in the lead', '2011-12-15 08:05:08', 'user5@gt.edu', 'Vacation Spots', 'Sails,wind,water');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.ujenanetwork.com/gallery/2009-07-28/600/25184.jpg', 'My sister in the lead', '2011-11-15 08:05:08', 'user4@gt.edu', 'Swimming', 'Swimming,fast');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.ujenanetwork.com/gallery/2010-07-13/600/40781.jpg', 'Last Year''s vacation before the shark bite', '2011-10-15 08:05:08', 'user12@gt.edu', 'Vacation', 'Ultimate,photography');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.ujenanetwork.com/gallery/2010-05-18/600/39816.jpg', 'Snake River', '2011-12-10 08:05:08', 'user4@gt.edu', 'Swimming', 'Ultimate,whitewater,rush');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.thebaseballpage.com/sites/default/files/images/Breamatl.JPG', 'Where were you when Sid slid', '2011-12-11 08:05:08', 'user6@gt.edu', 'Baseball', 'Baseball,1992,game seven');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://i1188.photobucket.com/albums/z403/clvclv/sid-bream-slide-1009-lg.jpg', 'Sid slid', '2011-12-12 08:05:08', 'user6@gt.edu', 'Baseball', 'Safe');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.blackanddecker.com//ProductImages/PC_Graphics/PHOTOS/DEWALT/TOOLS/LARGE/7/DCD780C2_1.jpg', 'The ultimate driver', '2011-10-09 08:32:08', 'user2@gt.edu', 'My DIY Board', 'DIY');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.factoryauthorizedoutlet.com/gallery/DW744XRS/DW744XRS_001.jpg', 'DeWALT all the way', '2011-10-08 08:32:08', 'user2@gt.edu', 'My DIY Board', 'Ultimate,saw');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://hgtv.sndimg.com/HGTV/2009/10/19/DP_drury-blue-powderroom_s4x3_lg.jpg', 'Just finished the bathroom', '2011-10-01 08:32:08', 'user2@gt.edu', 'My DIY Board', 'DIY,bath,home');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://www.allathletics.com/files/news_image/On%20your%20marks!.jpg', 'Seconds before the run', '2011-10-15 08:24:08', 'user5@gt.edu', 'Run Baby Run', 'Running,fast,speed');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Michael_Laudrup.jpg/180px-Michael_Laudrup.jpg', 'Michael Laudrup, best soccer player', '2011-10-15 08:27:08', 'user5@gt.edu', 'Run Baby Run', 'Soccer,sport');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/First_GT_Football_Team_1893.jpg/220px-First_GT_Football_Team_1893.jpg', 'GT Football 1893', '2011-09-15 04:24:03', 'user11@gt.edu', 'GT', 'Football,sport,GT');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://media.scout.com/Media/Image/103/1038880.jpg', 'Darius, GT Football', '2011-09-15 04:24:06', 'user11@gt.edu', 'GT', 'Football,sport,GT');
INSERT INTO `cs4400_group53`.`Pushpins` (`link`, `descr`, `dateAndTime`, `owner`, `boardTitle`, `tags`) VALUES ('http://upload.wikimedia.org/wikipedia/commons/7/7e/GT_Buzz.jpg', 'BUZZ and fans', '2011-09-15 04:24:02', 'user11@gt.edu', 'Buzz', 'GT,sport');

INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user1@gt.edu', '2011-08-08 07:05:08', 'user7@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user1@gt.edu', '2011-08-08 06:05:08', 'user7@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user2@gt.edu', '2011-08-08 07:05:08', 'user7@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user2@gt.edu', '2011-01-02 10:11:12', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user2@gt.edu', '2011-08-08 03:05:08', 'user8@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user4@gt.edu', '2011-12-12 08:05:08', 'user6@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user6@gt.edu', '2011-09-15 04:24:02', 'user11@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user6@gt.edu', '2011-09-15 04:24:03', 'user11@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user9@gt.edu', '2011-01-02 10:11:12', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user9@gt.edu', '2011-02-09 10:05:08', 'user12@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user9@gt.edu', '2011-08-08 07:05:08', 'user7@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user10@gt.edu', '2011-08-08 06:05:08', 'user7@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user10@gt.edu', '2011-08-08 05:05:08', 'user8@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user10@gt.edu', '2011-12-11 08:05:08', 'user6@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user10@gt.edu', '2011-12-12 08:05:08', 'user6@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user12@gt.edu', '2011-01-01 10:11:12', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user12@gt.edu', '2011-01-02 10:11:12', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Likes` (`parent`, `pinTime`, `pinOwner`) VALUES ('user12@gt.edu', '2011-01-03 10:11:12', 'user7@gt.edu');


INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('Beautiful Uga', '2012-01-01 12:45:21', 'user1@gt.edu', '2011-02-06 10:05:08', 'user9@gt.edu');
INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('What an ugly dog', '2012-02-02 12:31:07', 'user2@gt.edu', '2011-02-06 10:05:08', 'user9@gt.edu');
INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('Enzo, my dream car', '2012-01-09 09:21:41', 'user3@gt.edu', '2011-08-08 05:05:08', 'user8@gt.edu');
INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('On a warm summer day', '2012-01-09 10:21:41', 'user1@gt.edu', '2011-06-08 08:05:08', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('Great swim', '2012-01-09 09:23:41', 'user4@gt.edu', '2011-06-08 08:05:08', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('I will never forget when Sid slid', '2012-01-09 09:21:37', 'user4@gt.edu', '2011-12-12 08:05:08', 'user6@gt.edu');
INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('Happy NY din''t win that year', '2012-02-02 12:31:07', 'user7@gt.edu', '2011-12-12 08:05:08', 'user6@gt.edu');
INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('I love shepherds', '2011-02-03 12:31:07', 'user4@gt.edu', '2011-01-02 10:11:12', 'user1@gt.edu');
INSERT INTO `cs4400_group53`.`Comments` (`text`, `dateAndTime`, `owner`, `pinTime`, `about`) VALUES ('Tuborg and Carlsberg #1', '2012-01-02 12:31:07', 'user9@gt.edu', '2011-02-09 10:05:08', 'user12@gt.edu');

INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user1@gt.edu', 'user6@gt.edu', 'Vacation Ideas');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user1@gt.edu', 'user3@gt.edu', 'Baseball');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user1@gt.edu', 'user12@gt.edu', 'Vacation');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user3@gt.edu', 'user7@gt.edu', 'Dogs');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user4@gt.edu', 'user7@gt.edu', 'Dogs');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user5@gt.edu', 'user7@gt.edu', 'Dogs');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user5@gt.edu', 'user12@gt.edu', 'My Trip');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user5@gt.edu', 'user1@gt.edu', 'Garden');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user6@gt.edu', 'user2@gt.edu', 'My DIY Board');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user8@gt.edu', 'user4@gt.edu', 'Swimming');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user9@gt.edu', 'user4@gt.edu', 'Swimming');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user10@gt.edu', 'user4@gt.edu', 'Swimming');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user11@gt.edu', 'user4@gt.edu', 'Swimming');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user11@gt.edu', 'user5@gt.edu', 'Run Baby Run');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user11@gt.edu', 'user7@gt.edu', 'Cars');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user11@gt.edu', 'user8@gt.edu', 'Cars');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user12@gt.edu', 'user7@gt.edu', 'Cars');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user12@gt.edu', 'user8@gt.edu', 'Cars');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user12@gt.edu', 'user8@gt.edu', 'Garden');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user12@gt.edu', 'user9@gt.edu', 'GT');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user12@gt.edu', 'user11@gt.edu', 'Buzz');
INSERT INTO `cs4400_group53`.`Watches` (`parent`, `boardOwner`, `boardTitle`) VALUES ('user12@gt.edu', 'user11@gt.edu', 'GT');
