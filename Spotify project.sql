--Advanced Spotify Projject 

--EDA 

select count(*) from spotify;

select count(distinct artist) from spotify

select count(distinct album) from  spotify

select distinct album_type from spotify;

SELECT album_type, COUNT(*) AS type_count
FROM spotify
GROUP BY album_type;


select duration_min from spotify

select max(duration_min) from spotify

select min(duration_min) from spotify

select * from spotify 
where duration_min = 0

delete from spotify
where duration_min = 0

select distinct channel from spotify

select distinct most_played_on from spotify

-- data Analysis -Easy Category

--Q1.Retrieve the name of all tracks that have more than 1 billion streams.

select *from spotify
where stream > 1000000000

--Q2. list all the albums along with their respective artist
select album, artist from spotify

select distinct album from spotify group by 1


select album from spotify

--Q3.get the total number of comment for track where licensed = true

select *from spotify
where licensed = 'true'

select distinct count(*)licensed from spotify

select sum(comments) as total_comment from spotify 
where licensed = 'true'


--Q4. find all tracks that belong to the album type single
select *from spotify 
where album_type Ilike 'single'

--Q5.count the total number of tracks by each artist

SELECT
  artist,
  COUNT(*) AS total_no_song
FROM spotify
GROUP BY artist
order by 2


--Medium Level Questions---

-Q1.calculate the average danceability of tracks in each albums

select album , avg(danceability) as avg_danceability
from spotify
group by 1
order by 2 Desc


--Q2. find the top 5 tracks with highest energy values

select 
     track,
	 max(energy)
	 from spotify
	 group by 1
	 order by 2 
	 limit 5

--Q3.list all tracks along with their views and likes where official_videos = true
select 
track, 
sum(views) as total_views,
sum(likes) as total_likes
from spotify
where official_video = 'true'
group by 1 
order by 2 desc
limit 5

--Q4.for each album , calculate the total views of all associated tracks
SELECT
  album,
  track,
  SUM(views) AS total_views
FROM spotify
GROUP BY 1,2
order by 3 desc


--Q5 Retrieve the track names that have been streamed on spotify more than Youtube
select * from
(select
     track,
	 coalesce(sum(case when most_played_on = 'youtube' then stream End),0) as streamed_on_youtube,
	 coalesce(sum(case when most_played_on = 'spotify' then stream end),0) as streamed_on_spotify
from spotify
group by 1
) as t1
where 
     streamed_on_spotify > streamed_on_youtube
	 and
	 streamed_on_youtube <> 0


--Advanced level Questions

--Q1.find the top 3 most-viewed tracks for each artist using window functions
-- Each Artist and total view for each tracks
-- Dense Rank
--CTE And Filter Rank < = 3
with ranking_artist
as
(select 
artist,
track,
sum(views) as total_views,
Dense_Rank() over(partition by artist order by sum(views) desc) as Rank
from spotify
group by 1,2
order by 1,3 desc
)
select *from ranking_artist
where rank <=3


--Q.2 write A query to find tracks where the liveness score is above the average 

select *from spotify
select avg(liveness) from spotify --0.19

select 
     track,
	 artist,
	 liveness
from spotify
where liveness > (select avg(liveness) from spotify)


--Q.3 use With Clause to calculate the difference between the
-- highest and lowest energy values for tracks in each albums
with cte
as
(select 
     album,
	 max(energy) as highest_energy,
	 min(energy) as lowest_energy
from spotify
group by 1
)
select 
     album,
	 highest_energy - lowest_energy as energy_diff
	 from cte
	 order by 2 Desc



















