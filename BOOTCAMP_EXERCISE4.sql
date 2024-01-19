CREATE DATABASE BOOTCAMP_EXERCISE4;

SHOW DATABASES;

USE BOOTCAMP_EXERCISE4;

create table players (
player_id integer not null unique, 
group_id integer not null
);
create table matches (
	match_id integer not null unique, 
    first_player integer not null, 
    second_player integer not null, 
    first_score integer not null, 
    second_score integer not null
);

insert into players
(player_id, group_id)
values
(20, 2),
(30, 1),
(40, 3),
(45, 1),
(50, 2),
(65, 1);

insert into matches
(match_id , first_player , second_player , first_score , second_score)
values
(1, 30, 45, 10, 12),
(2, 20, 50, 5, 5),
(13, 65, 45, 10, 10),
(5, 30, 65, 3, 15),
(42, 45, 65, 8, 4);


select 
j.gpId,
j.pyId
from 
(select row_number() over (
 PARTITION BY p.group_id
 ORDER BY n.sum desc
 ) row_num,
p.group_id as gpId,p.player_id as pyId,(n.sum) as sum from players p left join
(select (m.player) as player, sum(m.score) as sum from 
	(select first_player as player, (first_score) as score from
	matches 
	union
	select second_player as player,(second_score) as score from
	matches ) m
group by m.player) n
on p.player_id=n.player
group by p.group_id,p.player_id) j
where j.row_num=1
;

