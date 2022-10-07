create index on expenses using gin(org_id, user_ids);
ERROR:  data type integer has no default operator class for access method "gin"

create extension btree_gin;
create index on expenses using gin(org_id, user_ids);

select *
from
 expenses ex
where
 ex.org_id=1
 and ex.user_ids @> '{5}'
;

Bitmap Heap Scan on expenses ex  (cost=9.26..34.63 rows=25 width=51) (actual time=0.087..0.087 rows=0 loops=1)
   Recheck Cond: ((org_id = 1) AND (user_ids @> '{5}'::integer[]))
   ->  Bitmap Index Scan on expenses_org_id_user_ids_idx  (cost=0.00..9.25 rows=25 width=0) (actual time=0.086..0.086 rows=0 loops=1)
         Index Cond: ((org_id = 1) AND (user_ids @> '{5}'::integer[]))
 Planning Time: 0.075 ms
 Execution Time: 0.106 ms
(6 rows)
