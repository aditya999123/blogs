create table users(
   id serial primary key
);

insert into users select * from generate_series(1, 200000);

create table orgs(
   id serial primary key
);

insert into orgs select * from generate_series(1, 1000);

create table expenses(
   id serial primary key,
   org_id integer references orgs(id) not null,
   user_ids integer[] not null
);

insert into expenses 
   select 
       id, 
       1+id%999 org_id, 
       gi.user_ids
   from 
      generate_series(1, 5000000) id
   join lateral (
      select 
          i%5000000 pid, 
          array_agg(round(random() * 200000)) user_ids
      from generate_series(1, 5.5*5000000) i
      group by i%5000000
   ) gi on pid=id
;
