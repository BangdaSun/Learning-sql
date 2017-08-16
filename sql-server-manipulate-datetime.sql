/*
  datepart() function
  extract year/month/day etc from date format data
*/  
select  datepart(yyyy, time_) as year_, 
  datepart(mm, time_) as month_, 
  datepart(dd, time_) as day_,
  datepart(wk, time_) as week_,
  datepart(hh, time_) as hour_,
  datepart(mi, time_) as minute_,
  datepart(ss, time_) as second_,
  datepart(ms, time_) as millisecond_,
  datepart(mcs, time_) as microsecond_,
  datepart(ns, time_) as nanosecond_
from (
  select top 100 CURRENT_TIMESTAMP as time_
  from ovs.dbo.optContract) as tmp
