[HOME](../README.md)

## SQL DataLemur Medium

SOURCE: https://datalemur.com/questions?category=SQL

``` 
-- SQL Tutorial Lesson: Superheroes' Likes

select
  actor,
  character,
  platform,
  avg_likes,
  case 
    when avg_likes >= 15000 then 'Super Likes'
    when avg_likes between 5000 and 14999 then 'Good Likes'
    else 'Low Likes'
  end
from marvel_avengers 
order by avg_likes desc;
```

[HOME](../README.md)
