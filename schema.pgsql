
drop index if exists zip_codes_code ;
drop table if exists zip_codes ;

drop index if exists cities_name ;
drop table if exists cities ;

drop index if exists states_abbr;
drop table if exists states ;



create table if not exists states (
  id serial primary key,
  abbr char(2) not null
);
create unique index if not exists states_abbr on states (abbr) ;

create table if not exists cities (
  id serial primary key,
  name varchar(64) not null,
  state_id integer not null,
  constraint fk_cities_state_id foreign key (state_id) references states(id) on update cascade on delete cascade
);
create index if not exists cities_name on cities (name) ;

create table if not exists zip_codes (
  id serial primary key,
  code char(5) not null,
  city_id integer not null,
  constraint fk_zip_codes_city_id foreign key (city_id) references cities(id) on update cascade on delete cascade
);
create index if not exists zip_codes_code on zip_codes (code) ;



