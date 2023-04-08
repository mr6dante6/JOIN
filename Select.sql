select g.genre_name, count(ge.executors_id) 
from genre_executors ge 
join genre g on ge.genre_id = g.genre_id 
group by g.genre_name 


--Вывод альбомов с количеством в них треков
select a.album_name, a.release_year, count(c.composition_name) as count_traks 
from compositions c 
join album a on a.album_id = c.album_id
where a.release_year >= 2019 and a.release_year <= 2020
group by a.album_name, a.release_year 

--Вывод сумма треков в найденных в диапазоне альбомах
select count(c.composition_name) as count_traks from compositions c 
join album a on a.album_id = c.album_id
where a.release_year >= 2019 and a.release_year <= 2020


select a.album_name, round(avg(c.duration)) 
from compositions c 
join album a on a.album_id = c.album_id 
group by a.album_name 


select distinct (e.executor_name) 
from executors e
where e.executor_name not in (
    select distinct e.executor_name
    from executors a
    left join album_executors ae on ae.executors_id  = e.executors_id 
    left join album al on al.album_id  = ae.album_id 
    where al.release_year = 2020
)
order by e.executor_name 


select c.collection_name  
from collection c 
join collection_compositions cc on cc.collection_id = c.collection_id 
join compositions com on com.compositions_id = cc.compositions_id 
join album a on a.album_id = com.album_id 
join album_executors ae on ae.album_id = a.album_id 
join executors e on e.executors_id = ae.executors_id 
where e.executor_name = 'Korn'
group by c.collection_name 


select a.album_name, e.executor_name, count(g.genre_name) as count_genre
from album a 
join album_executors ae on ae.album_id = a.album_id 
join executors e on e.executors_id = ae.executors_id 
join genre_executors ge on ge.executors_id = e.executors_id 
join genre g on g.genre_id = ge.genre_id
group by a.album_name, e.executor_name 
having count(g.genre_name) > 3


select c.composition_name 
from compositions c 
left join collection_compositions cc on cc.compositions_id = c.compositions_id 
left join collection col on col.collection_id = cc.collection_id 
where col.collection_name is null 


select e.executor_name , c.duration
from compositions c
left join album a on a.album_id = c.album_id 
left join album_executors ae on ae.album_id = a.album_id
left join executors e on e.executors_id  = ae.executors_id 
group by e.executor_name , c.duration
having c.duration = (select min(duration) from compositions)
order by e.executor_name


select distinct (a.album_name), a.album_id  
from album as a
left join compositions c on c.album_id = a.album_id
where c.album_id in (
    select album_id
    from compositions c
    group by album_id
    having count(album_id) = (
        select count(album_id)
        from compositions c
        group by album_id
        order by count
        limit 1
    )
)
order by a.album_name 

