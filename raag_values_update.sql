--drop table if exists #swaramap,#melody;select * into #swaramap from (values ('S',0,'Shadj'),('r',1,'Rishabh'),('R',2,'Rishabh'),('g',3,'Gandhar'),('G',4,'Gandhar'),('m',5,'Madhyam'),('M',6,'Madhyam'),('P',7,'Pancham'),('d',8,'Dhaivat'),('D',9,'Dhaivat'),('n',10,'Nishad'),('N',11,'Nishad'))swaras(swar,notes,swarname)
--select row_number()over(order by (select 1))rn,value swar,notes into #melody from string_split(
--'',' ')a
--left join #swaramap b on a.value=b.swar collate Latin1_General_CS_AS
--select 'before'as state,STRING_AGG(notes,' ')within group (order by rn)melody
--from #melody
--union 
--select 'after 1',dbo.f_translatescales(STRING_AGG(notes,' ')within group (order by rn),null,'0 2 3 5 7 9 a',1)melody
--from #melody
--union 
--select 'after 2',dbo.f_translatescales(STRING_AGG(notes,' ')within group (order by rn),null,'0 2 3 5 7 9 a',2)melody
--from #melody
----union 
----select 'after 3',dbo.f_translatescales(STRING_AGG(notes,' ')within group (order by rn),null,'0 2 3 5 7 9 a',3)melody
----from #melody
----select notes,count(*)count from #melody group by notes having count(*)>3 order by notes
----select * from raag2 where not(complete_scale like '%0%2%3%4%6%7%9%a%'or complete_scale like'%0%2%6%7%9%a%'or complete_scale like'%0%2%6%7%9%')
----order by thaat,raag

select scales.Steps,pat_up,* from raag2 join scales on scales.pat_up=raag2.complete_scale order by 1,5,4
select scales.Steps,pat_up,pakadscale,* from raag2 join scales on scales.pat_up=raag2.pakadscale order by 1,5,4
select scales.Steps,pat_up,aarohscale,* from raag2 join scales on scales.pat_up=raag2.aarohscale order by 1,5,4
select scales.Steps,pat_up,avrohscale,* from raag2 join scales on scales.pat_up=raag2.avrohscale order by 1,5,4
select 'Pakad'similarity,DENSE_RANK()over(order by pakadpattern)similar,pakadpattern,aarohpattern,avrohpattern,* from raag2 where pakadpattern in(select pakadpattern from raag2
group by pakadpattern having count(*)>1 and pakadpattern!='')
union all
select 'Aaroh'similarity,DENSE_RANK()over(order by aarohpattern)similar,pakadpattern,aarohpattern,avrohpattern,* from raag2 where aarohpattern in(select aarohpattern from raag2
group by aarohpattern having count(*)>1 and aarohpattern!='')
union all
select 'Avroh'similarity,DENSE_RANK()over(order by avrohpattern)similar,pakadpattern,aarohpattern,avrohpattern,* from raag2 where avrohpattern in(select avrohpattern from raag2
group by avrohpattern having count(*)>1 and avrohpattern!='')
order by 1,2
--bug in raag2 - negative values go like -12 -11 -10.. -1 0 in raag... but they should be -1 -2 -3... -12 which is how I've stored it in scales I think
--v accidentally set aaroh avroh to null after doing all work... so decided to make new table for raag
/*drop table if exists #swaramap;select * into #swaramap from (values ('S',0,'Shadj'),('r',1,'Rishabh'),('R',2,'Rishabh'),('g',3,'Gandhar'),('G',4,'Gandhar'),('m',5,'Madhyam'),('M',6,'Madhyam'),('P',7,'Pancham'),('d',8,'Dhaivat'),('D',9,'Dhaivat'),('n',10,'Nishad'),('N',11,'Nishad'))swaras(swar,notes,swarname)
--http://www.tanarang.com/
DECLARE	
 @raag varchar(256) =	N'Yaman'
	
,@swaras VARCHAR(512) =	N'Madhyam Teevra. Rest all Shuddha Swaras.'
,@jati VARCHAR(512) =	N'Sampurna-Sampurna'
,@thaat VARCHAR(512) =	N'Kalyan' collate Latin1_General_CS_AS
,@vadi_samvadi VARCHAR(512) =	N'Gandhar/Nishad' collate Latin1_General_CS_AS
,@time VARCHAR(512) =	N'(6 PM - 9 PM) : 1st Prahar of the night : Ratri ka Pratham Prahar' collate Latin1_General_CS_AS
,@vishranti_sthan VARCHAR(512) =	N'S; G; N; - S`; N; P; G;' collate Latin1_General_CS_AS
,@mukhya_ang VARCHAR(512) =	N',N R G ; ,N R M G ; M P ; M D P N D P M R G R ; ,N R ,D ,N S;' collate Latin1_General_CS_AS
,@aaroh_avroh VARCHAR(512) =	N',N R S - N R G M P D N S` - S` N D P M G R S ,N R S' collate Latin1_General_CS_AS
--,@vadi_samvadi VARCHAR(512) =	null

--jati
update raag set jati = (select jati from raag_jati where jati=@jati or replace(jati,' - ','-')=@jati)
from raag where raag=@raag and jati is null
--vishranti
;with vishranti as(select row_number()over(order by (select 1))rn,replace(replace(replace(value,';',''),N'`',''),N',','') note,case when value like'%`%'then 12 when value like'%,%'then -12 else 0 end adder from string_split(@vishranti_sthan,' ')
)
, vishrantinotes as (select string_agg(isnull(replace(convert(varchar(10),notes+adder),'-','|'),note),' ')within group (order by rn)note from vishranti
left join #swaramap map on map.swar=note collate Latin1_General_CS_AS)
update raag 
set vishranti_aaroh=case when CHARINDEX(' -',vishrantinotes.note)>1 then replace(left(vishrantinotes.note,CHARINDEX(' -',vishrantinotes.note)-1),'|','-')else replace(vishrantinotes.note,'|','-')end
,	vishranti_avroh=case when CHARINDEX('-',vishrantinotes.note)>1 then replace(right(vishrantinotes.note,len(vishrantinotes.note)-CHARINDEX('-',vishrantinotes.note)-1),'|','-')else replace(vishrantinotes.note,'|','-')end
from vishrantinotes
where raag.Raag=@raag and vishranti_aaroh is null and vishranti_avroh is null
--mukhyang
;with mukhya_ang as(select row_number()over(order by (select 1))rn,case when value=';'then';'else replace(replace(replace(value,';',''),N'`',''),N',','')end note,case when value like'%`%'then 12 when value like'%,%'then -12 else 0 end adder from string_split(@mukhya_ang,' ')
)
, mukhya_angnotes as (select string_agg(isnull(replace(convert(varchar(10),notes+adder),'-','|'),note),' ')within group (order by rn)note from mukhya_ang
left join #swaramap map on map.swar=note collate Latin1_General_CS_AS)
update raag 
set mukhya_ang=replace(mukhya_angnotes.note,'|','-')
from mukhya_angnotes
where raag.Raag=@raag and mukhya_ang is null
--aaroh-avroh
;with aarohavaroh as(select row_number()over(order by (select 1))rn,case when value=';'then';'else replace(replace(replace(value,';',''),N'`',''),N',','')end note,case when value like'%`%'then 12 when value like'%,%'then -12 else 0 end adder from string_split(@aaroh_avroh,' ')
)
, aarohavarohnotes as (select string_agg(isnull(replace(convert(varchar(10),notes+adder),'-','|'),note),' ')within group (order by rn)note from aarohavaroh
left join #swaramap map on map.swar=note collate Latin1_General_CS_AS)
update raag 
set aaroh=replace(left(aarohavarohnotes.note,CHARINDEX(' -',aarohavarohnotes.note)-1),'|','-')
,	avaroh=replace(right(aarohavarohnotes.note,len(aarohavarohnotes.note)-CHARINDEX('-',aarohavarohnotes.note)-1),'|','-')
from aarohavarohnotes
where raag.Raag=@raag and aaroh is null and avaroh is null

--vadisamvadi
;with aarohavaroh as(select row_number()over(order by (select 1))rn,case when value=';'then';'else replace(replace(replace(value,';',''),N'`',''),N',','')end note,case when value like'%`%'then 12 when value like'%,%'then -12 else 0 end adder from string_split(@aaroh_avroh,' ')
)
,vadisamvadi as
(select row_number()over(order by (select 1))rn,value note from string_split(@vadi_samvadi,'/'))
, aarohavarohnotes as 
(select distinct vadisamvadi.rn,isnull(replace(convert(varchar(10),notes+adder%12),'-','|'),aarohavaroh.note) note from aarohavaroh
join #swaramap map on map.swar=note collate Latin1_General_CS_AS
join vadisamvadi on vadisamvadi.note=map.swarname)
,vadisamvadirecon as(select string_agg(note,'/')within group(order by rn)vadisamvadi from aarohavarohnotes)--select * from vadisamvadirecon
update raag
set vadi=left(vadisamvadirecon.vadisamvadi,CHARINDEX('/',vadisamvadirecon.vadisamvadi)-1)
,	samvadi=right(vadisamvadirecon.vadisamvadi,len(vadisamvadirecon.vadisamvadi)-CHARINDEX('/',vadisamvadirecon.vadisamvadi))
from vadisamvadirecon
where raag.Raag=@raag and vadi is null and samvadi is null

select * from raag where jati is not null order by raag asc
select * from raag where jati is null --and raag>(select max(r2.raag)from raag r2 where r2.jati is not null and r2.Raag!='Shobhavari')
order by raag asc
--select * from raag where raag like'%yama%'
--update raag set vadi=4, samvadi=11 where raag='Tilang'
*/

--^accidentally set aaroh avroh to null after doing all work... so decided to make new table for raag

--;with cte as( select raag2._id,row_number()over (order by (select 1))rn,pakad,
--substring(pakad,number,1)pakad_div
--from raag2
--cross apply
--(select number from master..spt_values where type='P' and number between 1 and LEN(pakad))x
--)
--,ctee as(select _id,pakad,replace(replace(STRING_AGG(pakad_div,' ')within group (order by rn),'. ','.'),' `','`')pakadnew from cte
--where pakad_div!=' '
--group by _id,pakad)
--update raag2 set pakad=ctee.pakadnew
--from ctee where ctee._id=raag2._id and ctee.pakad=raag2.pakad
--select * from raag2 alter column pakad varchar(256)
--drop table if exists #swaramap;select convert(varchar(5),swar) collate Latin1_General_CS_AS swar,notes,convert(varchar(50),swarname)swarname into #swaramap from (values ('S',0,'Shadj'),('r',1,'Rishabh'),('R',2,'Rishabh'),('g',3,'Gandhar'),('G',4,'Gandhar'),('m',5,'Madhyam'),('M',6,'Madhyam'),('P',7,'Pancham'),('d',8,'Dhaivat'),('D',9,'Dhaivat'),('n',10,'Nishad'),('N',11,'Nishad'))swaras(swar,notes,swarname)
--insert into #swaramap select swar+'`',12+notes,'.'+swarname from #swaramap
--select * from #swaramap order by notes

--;with cte as(select _id,--raag2.*,substring(value,number,1) 
--STRING_AGG(isnull(convert(varchar(5),map.notes),value),' ')within group (order by rn)aarohnotes
--from raag2
--cross apply (select row_number()over (order by (select 1))rn,* from string_split(aaroh,' '))a
--left join #swaramap map on map.swar=value collate Latin1_General_CS_AS
----cross apply
----(select number from master..spt_values where type='P' and number between 1 and LEN(value))y
--group by _id)
--update raag2 set aarohnotes=cte.aarohnotes from cte where cte._id=raag2._id
--select * from raag2

/*
;with cte as
(
select _id raag_id,rn degree,value notes from raag2
cross apply (select row_number()over(order by value)rn,replace(replace(value,'a','10'),'b','11')value from string_split(complete_scale,' '))a
)--select * from cte
,aarohs as
(
select _id raag_id,STRING_AGG(isnull(try_convert(int,cte.degree),value),' ')within group (order by rn)aarohpattern
from raag2
cross apply (select row_number()over(order by (select 1))rn,value+12 value from string_split(replace(replace(aarohnotes,', ',''),',',''),' '))a
left join cte on try_convert(int,cte.notes)=try_convert(int,a.value)%12 and cte.raag_id=raag2._id
group by _id
)--select * from aarohs
,avrohs as
(
select _id raag_id,STRING_AGG(isnull(try_convert(int,cte.degree),value),' ')within group (order by rn)avrohpattern
from raag2
cross apply (select row_number()over(order by (select 1))rn,value+12 value from string_split(replace(replace(avrohnotes,', ',''),',',''),' '))a
join cte on try_convert(int,cte.notes)=try_convert(int,a.value)%12 and cte.raag_id=raag2._id
group by _id
)
,pakads as
(
select _id raag_id,STRING_AGG(isnull(try_convert(int,cte.degree),value),' ')within group (order by rn)pakadpattern
from raag2
cross apply (select row_number()over(order by (select 1))rn,value+12 value from string_split(replace(replace(pakadnotes,', ',''),',',''),' '))a
join cte on try_convert(int,cte.notes)=try_convert(int,a.value)%12 and cte.raag_id=raag2._id
group by _id
)
update raag2
set
raag2.aarohpattern=aarohs.aarohpattern
,raag2.avrohpattern=avrohs.avrohpattern
,raag2.pakadpattern=pakads.pakadpattern
from raag2
left join aarohs on aarohs.raag_id=raag2._id
left join avrohs on avrohs.raag_id=raag2._id
left join pakads on pakads.raag_id=raag2._id
--select * from raag2
*/