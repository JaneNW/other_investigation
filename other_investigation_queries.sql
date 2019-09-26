
--Registrations SST Query::

select event_vertical_nm, sum(metric_value) as numRegistrations
from dw_ba_report.ba_vertical_traffic_sst
where dw_eff_dt >= '2019-08-01' and dw_eff_dt <= '2019-08-31' and metric_sk = 502 and model_id = 104
group by event_vertical_nm
order by event_vertical_nm

--Page Views Query

select event_vertical_nm, sum(metric_value) as numPageViews
from dw_ba_report.ba_vertical_traffic_sst
where dw_eff_dt >= '2019-08-01' and dw_eff_dt <= '2019-08-31' and metric_sk = 101 and model_id = 104
group by event_vertical_nm
order by event_vertical_nm

--Page Views base table Query

select case when src_view_page_long_tx like '%mobile-creditcards://home%' then src_view_page_long_tx
      when src_view_page_long_tx like '%www.nerdwallet.com/community%' then 'community page' 
      when src_view_page_long_tx like '%www.nerdwallet.com/careers%' then 'career page'
      when src_view_page_long_tx like '%www.nerdwallet.com/blog%' then 'blog page'
      else 'other type of page' 
      end as pageCategory
  , count(*) as numPageViews
from dw_page_view_enriched
where dw_eff_dt >= '2019-08-01' and dw_eff_dt <= '2019-08-31' and rpt_page_vertical = 'Other'
group by pageCategory
order by numPageViews Desc
