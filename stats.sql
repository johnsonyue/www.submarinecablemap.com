use cbl

-- candidate cbl
create temporary table cn_cbl
as(
select distinct a.id as id1 from cc2cbl as a join cc2cbl as b on a.id = b.id where a.name != b.name and (a.name = 'China' or b.name = 'China' or a.name = 'Taiwan' or b.name = 'Taiwan') order by a.id asc
);

-- cbl end point country
drop table if exists cbl_cc_t;
create table cbl_cc_t
as(
select distinct a.id as id2, if(a.name != 'China' and a.name != 'Taiwan', a.name, if(b.name != 'China' and b.name != 'Taiwan', b.name, '')) as country from cc2cbl as a join cc2cbl as b on a.id = b.id where a.name != b.name and (a.name = 'China' or b.name = 'China' or a.name = 'Taiwan' or b.name = 'Taiwan')
);

create temporary table cbl_cc
as(
select distinct id2, group_concat(distinct country separator ',') as country from cbl_cc_t group by id2
);

-- landing point sig

-- cbl landing points
create temporary table cbl_lp
as(
select distinct cc2cbl.id as id3, group_concat(distinct cbl2lp.id separator ',') as lp from cc2cbl join cbl2lp on cc2cbl.id = cbl2lp.cable_id where cc2cbl.name = 'China' or cc2cbl.name = 'Taiwan' group by cable_id
);

-- cbl properies
create temporary table cbl_prop
as(
select distinct cn_cbl.id1 as id4, cbl.name, cbl.owners, cbl.length from cn_cbl join cbl on cn_cbl.id1 = cbl.id
);

drop table if exists stats;
create table if not exists stats
as(
select cbl_prop.*, cbl_cc.country, cbl_lp.lp from cn_cbl, cbl_prop, cbl_cc, cbl_lp where cn_cbl.id1 = cbl_prop.id4 and cn_cbl.id1 = cbl_cc.id2 and cn_cbl.id1 = cbl_lp.id3
);
