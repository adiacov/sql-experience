[HOME](../README.md)

## SQL Hackerrank Medium

SOURCE: https://www.hackerrank.com/domains/sql

``` 
-- The PADS
select 
    concat(name, '(', substring(occupation,1,1), ')')
from occupations
order by name;

select 
    concat('There are a total of ', count(occupation), ' ', lower(occupation), 's.')
from occupations
group by occupation
order by 1;
```

```
-- Binary Tree Nodes
select
    sub.num1,
    case
        when parent is not null and child is null then 'Leaf'
        when parent is not null and child is not null then 'Inner'
        else 'Root'
    end as node_type
from (
    select
        a.n as num1,
        min(a.p) as parent,
        min(b.n) as child,
        min(b.p)
    from bst a
    left join bst b on a.n = b.p
    group by a.n
    order by 1
) sub
```

[HOME](../README.md)
