create index on expenses using gin(user_ids);
create index on expenses(org_id);

explain analzye 
select
  *
from
  expenses ex
where
  ex.org_id=1
  and ex.user_ids @> '{5}'
;

Bitmap Heap Scan on expenses ex  (cost=253.62..278.99 rows=25 width=51) (actual time=1.050..1.051 rows=1 loops=1)
   Recheck Cond: ((org_id = 999) AND (user_ids @> '{44226}'::integer[]))
   Heap Blocks: exact=1
   ->  BitmapAnd  (cost=253.62..253.62 rows=25 width=0) (actual time=1.023..1.024 rows=0 loops=1)
         ->  Bitmap Index Scan on expenses_org_id_idx  (cost=0.00..51.86 rows=4990 width=0) (actual time=0.725..0.725 rows=5005 loops=1)
               Index Cond: (org_id = 999)
         ->  Bitmap Index Scan on expenses_user_ids_idx  (cost=0.00..201.50 rows=25000 width=0) (actual time=0.023..0.023 rows=142 loops=1)
               Index Cond: (user_ids @> '{44226}'::integer[])
 Planning Time: 0.112 ms
 Execution Time: 1.079 ms
(10 rows)
