-- creating database

drop schema if exists escaperoom;

create schema escaperoom;

use escaperoom;

drop table if exists progress;
drop table if exists actions;
drop table if exists players;
drop table if exists teams;
drop table if exists hints;
drop table if exists puzzles;
drop table if exists rooms;

create table if not exists rooms (
	roomid int auto_increment primary key,
    title varchar(45),
    theme varchar(45),
    difficultylevel varchar(45),
    duration_min int
);

create table if not exists puzzles (
	puzzleid int auto_increment primary key,
    roomid int,
	puzzlename varchar(45) not null,
    `Description` varchar(120),
    Puzzletype varchar(45),
    difficultyrating varchar(45),
	FOREIGN KEY (roomid) REFERENCES rooms(roomid)
);

create table if not exists teams (
	teamid int auto_increment primary key,
    teamname varchar(45),
    starttime timestamp,
    endtime timestamp,
    completionstatus boolean default false
);

create table if not exists players (
	playerid int auto_increment primary key,
    `name` varchar(45) not null,
    nickname varchar(45),
    email varchar(45),
    teamid int,
    foreign key (teamid) references teams(teamid)
);

create table if not exists progress (
	progressid int auto_increment primary key,
    teamid int,
    puzzleid int,
    starttime timestamp,
    endtime timestamp,
    solvedstatus boolean default false,
    foreign key (teamid) references teams(teamid),
    foreign key (puzzleid) references puzzles(puzzleid)
);

create table if not exists hints (
	hintid int auto_increment primary key,
    puzzleid int,
    hinttext varchar(45),
    usecount int,
	foreign key (puzzleid) references puzzles(puzzleid)
);

create table if not exists actions (
	actionid int auto_increment primary key,
    playerid int,
    puzzleid int,
    actiontype varchar(45),
    actiontimestamp timestamp,
    foreign key (playerid) references players(playerid),
    foreign key (puzzleid) references puzzles(puzzleid)
);


-- inserting data
use escaperoom;
-- rooms
insert into rooms (title,theme,difficultylevel,duration_min) values ('Søreøverkaptajnens endeligt','sørøver','easy',60);
insert into rooms (title,theme,difficultylevel,duration_min) values ('Lengenden om hyrden','Spøgelser','hard',150);
-- puzzles
insert into puzzles (roomid,puzzlename,Description,Puzzletype,difficultyrating) values (1,'Skattekort','find den gemte luge i gulvet ved hjælp af kortet','map','easy');
insert into puzzles (roomid,puzzlename,Description,Puzzletype,difficultyrating) values (1,'Kortkombi','find den skjulte mening bag de fundene spillekort','logic','hard');
insert into puzzles (roomid,puzzlename,Description,Puzzletype,difficultyrating) values (1,'Sømandsvise','find den skjulte sætning i sømandsvisen','wordplay','easy');
insert into puzzles (roomid,puzzlename,Description,Puzzletype,difficultyrating) values (2,'tælleFår','','geometric','hard');
-- hints
insert into hints (puzzleid,hinttext,usecount) values (1,'this is a hinttext',1);
insert into hints (puzzleid,hinttext,usecount) values (2,'alle billedkortene er navngivne',1);
-- teams
insert into teams (teamname,starttime,endtime,completionstatus) values ('Beavers','2024-10-13 16:10:45','2024-10-13 18:36:05',true);
insert into teams (teamname,starttime,completionstatus) values ('KEA-IT-AR-24','2024-10-13 20:25:54',false);
-- players
insert into players (name,nickname,email,teamid) values ('Johan','John','john@john.john',1);
insert into players (name,nickname,email,teamid) values ('Felix','','felix@mail.com',2);
insert into players (name,nickname,email,teamid) values ('Elias','','Elias@jmail.com',2);
-- progress
insert into progress (teamid,puzzleid,starttime,endtime,solvedstatus) values (1,1,'2024-10-13 16:30:46','2024-10-13 16:56:12',true);
insert into progress (teamid,puzzleid,starttime,endtime,solvedstatus) values (1,2,'2024-10-13 16:58:42','2024-10-13 17:34:07',true);
insert into progress (teamid,puzzleid,starttime,endtime,solvedstatus) values (1,3,'2024-10-13 18:00:38','2024-10-13 18:34:39',true);
insert into progress (teamid,puzzleid,starttime,solvedstatus) values (2,4,'2024-10-13 20:26:23',false);
-- actions
insert into actions (playerid,puzzleid,actiontype,actiontimestamp) values (3,4,'requested hint','2024-10-13 20:36:23');


-- query examples
-- display teams playing right now and their start time
select teamname, starttime
from teams
where endtime is null;

-- displaying teams hwo many puzzles eash team has completed
select teams.teamname, sum(progress.solvedstatus)
from teams
inner join progress
on teams.teamid = progress.teamid
group by teams.teamname;

-- display the amount of actions taken on evry individuel puzzle
select puzzles.puzzlename, count(actions.actionid) as numberOfActions
from puzzles
left join actions
on actions.puzzleid = puzzles.puzzleid
group by puzzles.puzzlename