CREATE DATABASE sportOrganizationsDB;
USE sportOrganizationsDB;

CREATE TABLE `Type` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(63) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Attributes` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`size` DOUBLE NOT NULL,
	`maxCountOfVisitors` INT NOT NULL CHECK ( maxCountOfVisitors > 0 ),
	`cover` varchar(63) NOT NULL,
	`typeId` INT NOT NULL,
	FOREIGN KEY  (`typeId`) REFERENCES Type(id),
	PRIMARY KEY (`id`)
);

CREATE TABLE `SportPlace` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(63) NOT NULL,
	`addres` varchar(63) NOT NULL,
	`attributesId` INT NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`attributesId`) REFERENCES Attributes(id)
);

CREATE TABLE `Organizer` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(63) NOT NULL,
	`age` INT(63) NOT NULL CHECK ( age > 0 ),
	`addres` varchar(63) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Tournament` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`start` DATETIME NOT NULL,
	`end` DATETIME NOT NULL CHECK (start < end),
	`reglament` VARCHAR(255) NOT NULL,
	`countOfPrizePlaces` INT NOT NULL CHECK ( countOfPrizePlaces > 0 ),
	`sportPlaceId` INT NOT NULL,
	`organizerId` INT NOT NULL,
	FOREIGN KEY (`sportPlaceId`) REFERENCES SportPlace(id),
	FOREIGN KEY (`organizerId`) REFERENCES Organizer(id),
	PRIMARY KEY (`id`)

);

CREATE TABLE `Sport` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(63) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Trainer` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(63) NOT NULL,
	`sportId` INT NOT NULL,
	FOREIGN KEY (`sportId`) REFERENCES Sport(id),
	PRIMARY KEY (`id`)
);

CREATE TABLE `SportActivities` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`rank` varchar(31),
	`trainerId` INT NOT NULL,
	FOREIGN KEY (`trainerId`) REFERENCES Trainer(id),
	PRIMARY KEY (`id`)
);

CREATE TABLE `SportClub` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(63) NOT NULL,
	`director` varchar(63) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `SportsMan` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar(63) NOT NULL,
	`age` INT NOT NULL CHECK ( age > 0 ),
	`addres` varchar(255) NOT NULL,
	`sportClubId` INT NOT NULL,
	`sportActivitiesId` INT NOT NULL,
	FOREIGN KEY (`sportClubId`) REFERENCES SportClub(id),
	FOREIGN KEY (`sportActivitiesId`) REFERENCES SportActivities(id),
	PRIMARY KEY (`id`)
);

CREATE TABLE `ParticipationInTournament` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`placeInTournament` INT NOT NULL CHECK ( placeInTournament > 0 ),
	`tournamentId` INT NOT NULL,
	`sportsManId` INT NOT NULL,
	FOREIGN KEY (`tournamentId`) REFERENCES Tournament(id),
	FOREIGN KEY (`sportsManId`) REFERENCES SportsMan(id),
	PRIMARY KEY (`id`)
);



alter table SportActivities
	add sportsManId int not null;

alter table SportActivities
	add constraint SportActivities_SportsMan__fk
		foreign key (sportsManId) references SportsMan (id);


alter table SportsMan drop foreign key SportsMan_ibfk_2;

alter table SportsMan drop column sportActivitiesId;

alter table SportClub
	add sportId int not null;

alter table SportClub
	add constraint SportClub_Sport__fk
		foreign key (sportId) references Sport (id);

alter table Tournament
	add sportId int not null;

alter table Tournament
	add constraint Tournament_Sport__fk
		foreign key (sportId) references Sport (id);


