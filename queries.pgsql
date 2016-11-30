
-- show number of cities in each state
select s.abbr
     , count(c.state_id)
  from states s
  join cities c
    on c.state_id = s.id
 group by 1
 order by 1
;




