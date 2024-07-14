----------------------------------------------------------------------
----------------------------------------------------------------------

select*
from capstone.dbo.[bikedata]

--create new table bikedata: 

create table bikedata 
(
ride_id nvarchar(50) null,
rideable_type nvarchar (50) null,
started_at datetime null,
ended_at datetime null,
start_station_name nvarchar(500) null,
start_station_id nvarchar(50) null,
end_station_name nvarchar(500) null,
end_station_id nvarchar(50) null,
start_lat float null,
start_lng float null,
end_lat float null,
end_lng float null,
member_casual nvarchar(50) null ,
);
--combining all data into bikedata table:

 insert into dbo.bikedata
 select*
 from capstone.dbo.[202108-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202109-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202110-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202111-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202112-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202201-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202202-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202203-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202204-divvy-tripdata]
 union all
 select* 
 from capstone.dbo.[202205-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202206-divvy-tripdata]
 union all
 select*
 from capstone.dbo.[202207-divvy-tripdata];

 --removing null values :
 with cleandata as
 (
 select*
 from capstone..bikedata
 where 
 [ride_id] is not null and
[rideable_type]  is not null and
[started_at] is not null and
[ended_at]  is not null and
[start_station_name]  is not null and
[start_station_id]  is not null and
[end_station_name]  is not null and
[end_station_id]  is not null and
[start_lat]  is not null and
[start_lng]  is not null and
[end_lat]  is not null and
[end_lng]  is not null and
[member_casual]  is not null 
 ),
 --calulate ride_lengh and dates:
rides_and_dates as
 (
 select *,
 datediff(minute, started_at,ended_at) as datdiff,
 datepart(weekday,started_at) as weekday1,
 datepart(month,started_at) as month
 from cleandata
 ),

 --select* from rides_and_dates
 --order by datdiff 

 dateweekday as
 (
 select*,
 case 
 when weekday1 = 1 then 'sunday'
 when weekday1 = 2 then 'monday'
 when weekday1 = 3 then 'tuesday'
 when weekday1 = 4 then 'wednesday'
 when weekday1 = 5 then 'thursday'
 when weekday1 = 6 then 'friday'
 when weekday1 = 7 then 'saturday'
 else 'sunday'
 end as weekday2
 from    rides_and_dates
 ),
 --remove outliers :
  dataexplore as 
  (
  select*
  from dateweekday
  where 
  datdiff between 1 and 1440
  AND [start_station_name] not like '% TEST%'
  )
  select* from dataexplore
  order by [started_at]

  -------------------------------------------------------------------
  -------------------------------------------------------------------
 











