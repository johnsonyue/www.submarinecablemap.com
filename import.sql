use cbl;

drop table if exists cc2cbl;
create table if not exists cc2cbl(
  name text,
  id text 
)engine=MyISAM;

drop table if exists cc2lp;
create table if not exists cc2lp(
  name text,
  id text 
)engine=MyISAM;

drop table if exists cbl;
create table if not exists cbl(
  id text,
  name text,
  owners text,
  length text
)engine=MyISAM;

drop table if exists lp;
create table if not exists lp(
  id text,
  name text,
  city_id text,
  latitude text,
  longitude text,
  type text
)engine=MyISAM;

drop table if exists cbl2lp;
create table if not exists cbl2lp(
  cable_id text,
  id text 
)engine=MyISAM;

drop table if exists lp2cbl;
create table if not exists lp2cbl(
  id text,
  cable_id text
)engine=MyISAM;

load data local infile 'cc2cbl.csv' into table cc2cbl fields terminated by '|';
load data local infile 'cc2lp.csv' into table cc2lp fields terminated by '|';
load data local infile 'cbl.csv' into table cbl fields terminated by '|';
load data local infile 'lp.csv' into table lp fields terminated by '|';
load data local infile 'cbl2lp.csv' into table cbl2lp fields terminated by '|';
load data local infile 'lp2cbl.csv' into table lp2cbl fields terminated by '|';
