/*all gyms thay have more than 100 places for viewers*/
SELECT SportPlace.name, SportPlace.addres
FROM SportPlace JOIN Attributes ON SportPlace.attributesId = Attributes.id JOIN Type ON Attributes.typeId = Type.id
WHERE Type.name = 'gym' AND  Attributes.maxCountOfVisitors > 100;

/*all sportsmen paying chess with trainer*/
SELECT SportsMan.name, SportActivities.rank, Trainer.name
FROM SportsMan LEFT JOIN SportActivities ON SportsMan.id = SportActivities.sportsManId
    INNER JOIN Trainer ON SportActivities.trainerId = Trainer.id
    RIGHT JOIN Sport ON Trainer.sportId = Sport.id
WHERE Sport.name = 'chess';

/*sportsmen training with Yuriy Prohorovych and having first or higher rank*/
SELECT SportsMan.name, SportActivities.rank
FROM SportsMan LEFT JOIN SportActivities ON SportsMan.id = SportActivities.sportsManId
    INNER JOIN Trainer ON SportActivities.trainerId = Trainer.id
    RIGHT JOIN Sport ON Trainer.sportId = Sport.id
WHERE Trainer.name = 'Yuriy Prohorovych' AND SportActivities.ranK != 'second category';

/*sportsmen training more than 1 sport*/
SELECT SportsMan.name, Sport.name
FROM SportsMan LEFT JOIN SportActivities ON SportsMan.id = SportActivities.sportsManId
    INNER JOIN Trainer ON SportActivities.trainerId = Trainer.id
    RIGHT JOIN Sport ON Trainer.sportId = Sport.id
WHERE (SELECT  COUNT(*)
    FROM SportActivities
    WHERE SportActivities.sportsManId = SportsMan.id) > 1
ORDER BY 1;


/*all trainers of the sportsman that have 1 id*/
SELECT Trainer.name
FROM Trainer LEFT JOIN SportActivities ON Trainer.id = SportActivities.trainerId
WHERE SportActivities.sportsManId = 1;

/*all tournaments from 2019-09-01 to 2019-11-01*/
SELECT Tournament.*
FROM Tournament
WHERE ((Tournament.start <= '2019-09-01' AND Tournament.end >= '2019-11-01')
    OR (Tournament.start >= '2019-09-01' AND Tournament.start <= '2019-11-01')
    OR (Tournament.end  >= '2019-09-01' AND Tournament.end <= '2019-11-01'));

/*all prize places in tournament 10*/
SELECT SportsMan.name, ParticipationInTournament.placeInTournament, Tournament.id AS touenamentId
FROM SportsMan JOIN ParticipationInTournament ON SportsMan.id = ParticipationInTournament.sportsManId
    JOIN Tournament ON ParticipationInTournament.tournamentId = Tournament.id
WHERE ParticipationInTournament.placeInTournament <= Tournament.countOfPrizePlaces
    AND Tournament.id = 10
ORDER BY 2;

/*all tournaments in whose id equals 8*/
SELECT Tournament.*
FROM Tournament JOIN SportPlace ON Tournament.sportPlaceId = SportPlace.id
WHERE SportPlace.id = 8;

/*all sport clubs with count of members who participated in tournaments between 2019-09-01 2019-11-01*/
SELECT SportClub.id, SportClub.name, (
    SELECT COUNT(*)
    FROM SportsMan LEFT JOIN ParticipationInTournament ON SportsMan.id = ParticipationInTournament.sportsManId
        RIGHT JOIN Tournament ON ParticipationInTournament.tournamentId = Tournament.id
    WHERE ((Tournament.start <= '2019-09-01' AND Tournament.end >= '2019-11-01')
    OR (Tournament.start >= '2019-09-01' AND Tournament.start <= '2019-11-01')
    OR (Tournament.end  >= '2019-09-01' AND Tournament.end <= '2019-11-01'))
    AND SportsMan.sportClubId = SportClub.id
    )
FROM SportClub;

/*all trainers by necessary sport*/
SELECT *
FROM Trainer
WHERE Trainer.sportId = 5;

/*all sportsmen have not been playing in tournaments*/
SELECT DISTINCT SportsMan.id, SportsMan.name
                      FROM SportsMan JOIN ParticipationInTournament
                      WHERE NOT EXISTS(SELECT *
                                      FROM ParticipationInTournament
                                      WHERE ParticipationInTournament.sportsManId = SportsMan.id);

/*all organizers with count of tournaments*/
SELECT Organizer.id, Organizer.name, (SELECT COUNT(*) FROM Tournament WHERE Tournament.organizerId = Organizer.id) AS countOfTournaments
FROM Organizer JOIN Tournament ON Organizer.id = Tournament.organizerId
WHERE ((Tournament.start <= '2019-09-01' AND Tournament.end >= '2019-11-01')
    OR (Tournament.start >= '2019-09-01' AND Tournament.start <= '2019-11-01')
    OR (Tournament.end  >= '2019-09-01' AND Tournament.end <= '2019-11-01'));

/*all sport places had had sport event between '2019-09-01' and '2019-11-01'*/
SELECT SportPlace.id, SportPlace.name, Tournament.start, Tournament.end
FROM SportPlace JOIN Tournament ON SportPlace.id = Tournament.sportPlaceId
WHERE ((Tournament.start <= '2019-09-01' AND Tournament.end >= '2019-11-01')
    OR (Tournament.start >= '2019-09-01' AND Tournament.start <= '2019-11-01')
    OR (Tournament.end  >= '2019-09-01' AND Tournament.end <= '2019-11-01'))