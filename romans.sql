drop table if exists #scaleref
select _id,Step_Family,Shape,Degree,Steps,refnotenum,refnotes,
	replace(replace(refnotes,'a','10'),'b','11')%12 refnoteval,roman refroman
	into #scaleref 
	from scales	
	cross join
	(values 
	(1,'i','bii','#xii'),(2,'ii','biii','#i'),(3,'iii','biv','#ii'),(4,'iv','bv','#iii'),
	(5,'v','bvi','#iv'),(6,'vi','bvii','#v'),(7,'vii','bviii','#vi'),(8,'viii','bix','#vii'),
	(9,'ix','bx','#viii'),(10,'x','bxi','#ix'),(11,'xi','bxii','#x'),(12,'xii','bi','#xi')
	)degreess(degroman,roman,flat,sharp)
	outer apply (select ROW_NUMBER()over(partition by _id order by value)refnotenum,value refnotes from string_split(scales.pat_up,' '))ref
	where (degree='II'or _id in (1960,2048,2043,2031,1963,1))--I've arbitrarily chosen degree II of each step-family, shape combo as basis for enumeration
	and refnotenum=degroman
--select * from #scaleref order by _id,refnotes

drop table if exists #scales
select _id,Step_Family,Shape,Degree,Steps,degroman,roman 
		,replace(replace(degreess.degroman-1,'10','a'),'11','b')scalenotes
		,degreess.degroman-1 scalenoteval
	into #scales from scales
	cross join
	(values 
	(1,'i','bii','#xii'),(2,'ii','biii','#i'),(3,'iii','biv','#ii'),(4,'iv','bv','#iii'),
	(5,'v','bvi','#iv'),(6,'vi','bvii','#v'),(7,'vii','bviii','#vi'),(8,'viii','bix','#vii'),
	(9,'ix','bx','#viii'),(10,'x','bxi','#ix'),(11,'xi','bxii','#x'),(12,'xii','bi','#xi')
	)degreess(degroman,roman,flat,sharp)
	cross apply string_split(pat_up,' ')
	where replace(replace(value,'a','10'),'b','11')+1=degroman
--select * from #scales order by _id

drop table if exists #nats
select scales._id,scales.Step_Family,scales.Shape,scales.Degree,scales.Steps
	,scaleref.refnoteval,scales.scalenoteval,scaleref.refroman roman
	into #nats
	from #scales scales
	left join #scaleref scaleref
		on scales.scalenoteval = refnoteval 
		and scaleref.Step_Family=scales.Step_Family and scaleref.shape=scales.Shape
order by _id,degroman

select nats._id scale_id,nats.Step_Family,nats.Shape,nats.Degree
,nats.scalenoteval scale_note
,coalesce(nats.refnoteval,
	flats1.refnoteval,sharps1.refnoteval,
	flats2.refnoteval,sharps2.refnoteval,
	flats3.refnoteval,sharps3.refnoteval,
	flats4.refnoteval,sharps4.refnoteval,
	flats5.refnoteval,sharps5.refnoteval,
	flats6.refnoteval,sharps6.refnoteval)ref_note
,row_number()over(partition by nats._id order by nats.scalenoteval)scale_note_degree,--string_agg(
converT(nvarchar(4000),coalesce(nats.roman,
	N'♭'+flats1.refroman,N'♯'+sharps1.refroman,
	N'♭♭'+flats2.refroman,N'♯♯'+sharps2.refroman,
	N'♭♭♭'+flats3.refroman,N'♯♯♯'+sharps3.refroman,
	N'♭♭♭♭'+flats4.refroman,N'♯♯♯♯'+sharps4.refroman,
	N'♭♭♭♭♭'+flats5.refroman,N'♯♯♯♯♯'+sharps5.refroman,
	N'♭♭♭♭♭♭'+flats6.refroman,N'♯♯♯♯♯♯'+sharps6.refroman,
	'-'))roman
--,' ') within group (order by nats.scalenoteval)roman
into scale_romans
from #nats nats
left join #scaleref flats1 on flats1.refnoteval=(nats.scalenoteval+1)%12 and nats.Step_Family=flats1.Step_Family and nats.Shape=flats1.Shape and flats1.refroman not in (select eh.roman from #nats eh where eh.Step_Family=flats1.Step_Family and eh.Shape=flats1.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref flats2 on flats2.refnoteval=(nats.scalenoteval+2)%12 and nats.Step_Family=flats2.Step_Family and nats.Shape=flats2.Shape and flats2.refroman not in (select eh.roman from #nats eh where eh.Step_Family=flats2.Step_Family and eh.Shape=flats2.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref flats3 on flats3.refnoteval=(nats.scalenoteval+3)%12 and nats.Step_Family=flats3.Step_Family and nats.Shape=flats3.Shape and flats3.refroman not in (select eh.roman from #nats eh where eh.Step_Family=flats3.Step_Family and eh.Shape=flats3.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref flats4 on flats4.refnoteval=(nats.scalenoteval+4)%12 and nats.Step_Family=flats4.Step_Family and nats.Shape=flats4.Shape and flats4.refroman not in (select eh.roman from #nats eh where eh.Step_Family=flats4.Step_Family and eh.Shape=flats4.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref flats5 on flats5.refnoteval=(nats.scalenoteval+5)%12 and nats.Step_Family=flats5.Step_Family and nats.Shape=flats5.Shape and flats5.refroman not in (select eh.roman from #nats eh where eh.Step_Family=flats5.Step_Family and eh.Shape=flats5.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref flats6 on flats6.refnoteval=(nats.scalenoteval+6)%12 and nats.Step_Family=flats6.Step_Family and nats.Shape=flats6.Shape and flats6.refroman not in (select eh.roman from #nats eh where eh.Step_Family=flats6.Step_Family and eh.Shape=flats6.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref sharps1 on (sharps1.refnoteval+1)%12=nats.scalenoteval and nats.Step_Family=sharps1.Step_Family and nats.Shape=sharps1.Shape and sharps1.refroman not in (select eh.roman from #nats eh where eh.Step_Family=sharps1.Step_Family and eh.Shape=sharps1.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref sharps2 on (sharps2.refnoteval+2)%12=nats.scalenoteval and nats.Step_Family=sharps2.Step_Family and nats.Shape=sharps2.Shape and sharps2.refroman not in (select eh.roman from #nats eh where eh.Step_Family=sharps2.Step_Family and eh.Shape=sharps2.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref sharps3 on (sharps3.refnoteval+3)%12=nats.scalenoteval and nats.Step_Family=sharps3.Step_Family and nats.Shape=sharps3.Shape and sharps3.refroman not in (select eh.roman from #nats eh where eh.Step_Family=sharps3.Step_Family and eh.Shape=sharps3.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref sharps4 on (sharps4.refnoteval+4)%12=nats.scalenoteval and nats.Step_Family=sharps4.Step_Family and nats.Shape=sharps4.Shape and sharps4.refroman not in (select eh.roman from #nats eh where eh.Step_Family=sharps4.Step_Family and eh.Shape=sharps4.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref sharps5 on (sharps5.refnoteval+5)%12=nats.scalenoteval and nats.Step_Family=sharps5.Step_Family and nats.Shape=sharps5.Shape and sharps5.refroman not in (select eh.roman from #nats eh where eh.Step_Family=sharps5.Step_Family and eh.Shape=sharps5.Shape and eh.Degree=nats.Degree and eh.roman is not null)
left join #scaleref sharps6 on (sharps6.refnoteval+6)%12=nats.scalenoteval and nats.Step_Family=sharps6.Step_Family and nats.Shape=sharps6.Shape and sharps6.refroman not in (select eh.roman from #nats eh where eh.Step_Family=sharps6.Step_Family and eh.Shape=sharps6.Shape and eh.Degree=nats.Degree and eh.roman is not null)
--group by nats._id,nats.Step_Family,nats.Shape,nats.Degree,nats.Shape
order by nats.Step_Family,nats.Shape,nats.Degree--,nats.scalenoteval
--debug
--select nats._id,nats.Step_Family,nats.Shape,nats.Degree,nats.Shape
--,nats.roman,flats1.refroman,nats.scalenoteval
--from #nats nats
--left join #scaleref flats1 on flats1.refnoteval=(nats.scalenoteval+1)%12 and nats.Step_Family=flats1.Step_Family and nats.Shape=flats1.Shape and flats1.refroman not in (select eh.roman from #nats eh where nats.Step_Family=flats1.Step_Family and nats.Shape=flats1.Shape)
--where nats._id in (2,3,4)
--order by nats._id,nats.scalenoteval
----select nats._id,nats.Step_Family,nats.Shape,nats.Degree,nats.Shape,nats.roman,flats1.refroman,nats.scalenoteval
----from (select * from #nats where _id=4)nats
----left join (select * from #scaleref where Step_Family='1-1-1-1-1-1-1-1-1-1-2 undecatonic'and shape='A')flats1 on  flats1.refnoteval=(nats.scalenoteval+1)%12 
--select nats._id,nats.Step_Family,nats.Shape,nats.Degree,nats.Shape,nats.roman,sharps1.refroman,nats.scalenoteval
--from (select * from #nats where _id=4)nats
--left join (select * from #scaleref where Step_Family='1-1-1-1-1-1-1-1-1-1-2 undecatonic'and shape='A')sharps1 on  (sharps1.refnoteval+1)%12 =nats.scalenoteval
-- and sharps1.refroman not in (select eh.roman from #nats eh where eh.Step_Family=sharps1.Step_Family and eh.Shape=sharps1.Shape and eh.Degree=nats.Degree and eh.roman is not null)

--select * from scale_romans order by _id,

drop table if exists #proper_romans
select scales._id scale_id,ltrim(rtrim(left(triads,charindex('(',triads)-1)))triad,'                                                    ' triadcompact
,roman
into #proper_romans
from scale_interval_chart a
cross apply (select row_number()over(order by (select 1))rn,value triads from string_split(a.triad_harmony,';'))b--wrong_deg_triad doesn't give unique values per note
cross apply (select row_number()over(order by (select 1))rn,replace(replace(replace(right(value,len(value)-charindex('(',value)),'(',''),')',''),'-','') roots from string_split(b.triads,','))c
join scales on scales.pat_up=a.scales
join scale_romans on scale_romans.scale_id=scales._id and scale_note=replace(replace(roots,'a','10'),'b','11')
update #proper_romans set triadcompact=dbo.f_getcompactpitchset(triad)
--select * from #proper_romans
update scale_romans set roman=
case triad when '0 3 6'then lower(proper_romans.roman)+N'°'when '0 3 7'then lower(proper_romans.roman)+'|' when '0 4 7'then upper(proper_romans.roman)+'|'
		when '0 4 8'then upper(proper_romans.roman)+N'⁺'when '0 4 10'then upper(proper_romans.roman)+N'⁺⁶'when '0 5 7'then upper(proper_romans.roman)+N'sus⁴' 
		else proper_romans.roman end
from #proper_romans proper_romans
join scale_romans on scale_romans.scale_id=proper_romans.scale_id and scale_romans.roman=proper_romans.roman
update scale_romans set roman=
case triadcompact when '0 3 6'then lower(proper_romans.roman)+N'°'when '0 3 7'then lower(proper_romans.roman)+'|' when '0 4 7'then upper(proper_romans.roman)+'|'
		when '0 4 8'then upper(proper_romans.roman)+N'⁺'when '0 4 10'then upper(proper_romans.roman)+N'⁺⁶'when '0 5 7'then upper(proper_romans.roman)+N'sus⁴' 
		else proper_romans.roman end
from #proper_romans proper_romans
join scale_romans on scale_romans.scale_id=proper_romans.scale_id and scale_romans.roman=proper_romans.roman

update scale_romans set roman=
case triad when '0 4 a'then upper(proper_romans.roman)+N'⁺⁶'when '0 2 6'then upper(proper_romans.roman)+N'⁺⁶' else proper_romans.roman end
from #proper_romans proper_romans
join scale_romans on scale_romans.scale_id=proper_romans.scale_id and scale_romans.roman=proper_romans.roman
update scale_romans set roman=
case triadcompact when '0 4 a'then upper(proper_romans.roman)+N'⁺⁶'when '0 2 6'then upper(proper_romans.roman)+N'⁺⁶' else proper_romans.roman end
from #proper_romans proper_romans
join scale_romans on scale_romans.scale_id=proper_romans.scale_id and scale_romans.roman=proper_romans.roman
update scale_romans set roman=proper_romans.roman +'('+replace(replace(replace(triadcompact,'10','a'),'11','b'),' ','')+')' 
from #proper_romans proper_romans
join scale_romans on scale_romans.scale_id=proper_romans.scale_id and scale_romans.roman=proper_romans.roman
where scale_romans.roman not like '%|%'
update scale_romans set roman=replace(roman,'|','')

select * from scale_romans order by scale_romans.scale_id,scale_romans.scale_note_degree

drop table if exists #proper_romans
drop table if exists #scaleref
drop table if exists #scales
drop table if exists #nats


select _id,steps,names,pat_up,scales.Step_Family,scales.Shape,scales.Degree,
STRING_AGG(scale_romans.roman,' ') within group (order by scale_romans.scale_note_degree) roman
from scales
join scale_romans on scales._id=scale_romans.scale_id
where tones=7
group by _id,steps,scales.Step_Family,scales.Shape,scales.Degree,names,pat_up
order by scales.Step_Family,scales.Shape,scales.Degree
select * into #scalrom from scale_romans




-------wrong deg triads
drop table if exists #wrong_romans
select scales._id scale_id,ltrim(rtrim(left(triads,charindex('(',triads)-1)))triad,'                                                    ' triadcompact
,roman
into #wrong_romans
from scale_interval_chart a
cross apply (select row_number()over(order by (select 1))rn,value triads from string_split(a.wrong_deg_triad,';'))b--wrong_deg_triad doesn't give unique values per note
cross apply (select row_number()over(order by (select 1))rn,replace(replace(replace(right(value,len(value)-charindex('(',value)),'(',''),')',''),'-','') roots from string_split(b.triads,','))c
join scales on scales.pat_up=a.scales
join scale_romans on scale_romans.scale_id=scales._id and scale_note=replace(replace(roots,'a','10'),'b','11')
update #wrong_romans set triadcompact=dbo.f_getcompactpitchset(triad)
--left(roman,charindex('(',roman)-1)
update #wrong_romans set triad=dbo.f_order_ascending(replace(replace(replace(triad,'12','0'),'11','b'),'10','a'))
select * into scale_romans_wrong_deg_triads from #wrong_romans--
drop table if exists #wrong_romans
