[HOME](../README.md)

## SQL DataLemur Easy

SOURCE: https://datalemur.com/questions?category=SQL

``` 
-- Histogram of Tweets

select
 sub.tweet_bucket,
 count(sub.user_id)
from
 (
  select 
   user_id,
   count(user_id) as tweet_bucket
  from tweets
  where extract('year' from tweet_date) = '2022'
  group by user_id
 ) sub
group by sub.tweet_bucket
```

``` 
-- Data Science Skills

select candidate_id
from candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having count(skill) = 3
order by candidate_id
```

``` 
-- Page With No Like

select
 p.page_id
from pages p
full join page_likes pl
 on pl.page_id = p.page_id
where pl.page_id is null
order by p.page_id

```

``` 
-- Unfinished Parts

select part, assembly_step 
from parts_assembly where finish_date is null;
```

``` 
-- Laptop vs. Mobile Viewership

select 
 count(case when device_type = 'laptop' then 1 else null end) as laptop_reviews,
 count(case when device_type != 'laptop' then 1 else null end) as mobile_views
from viewership;
```

```
-- Average Post Hiatus (Part 1)

select
  user_id,
  max(post_date::date) - min(post_date::date) as days
from posts
where date_part('year', post_date) = 2021
group by user_id
having count(post_id) > 1
```

``` 
-- Teams Power Users

select 
 sender_id,
 count(sender_id) as total_messages
from messages
where sent_date > '08/01/2022 00:00:00' and sent_date < '09/01/2022 00:00:00'
group by sender_id
order by 2 desc
limit 2
```

```
-- Duplicate Job Listings

select count(*)
from (
  select  company_id as duplicates
  from job_listings
  group by company_id, title, description
  having count(title) > 1 and count(description) > 1
) sub
```

``` 
-- Cities With Completed Trades

select
  u.city,
  count(t.order_id) as orders
from trades t 
join users u on u.user_id = t.user_id 
where t.status = 'Completed'
group by u.city
order by orders desc
limit 3
```

``` 
-- Average Review Ratings

select 
  extract('month' from submit_date) as month,
  product_id,
  round(avg(stars), 2) as avg_rating
from reviews 
group by product_id, extract('month' from submit_date)
order by month, product_id
```

[HOME](../README.md)