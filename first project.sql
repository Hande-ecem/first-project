with faceb_cte as (
SELECT f.ad_date,
'facebook ads' as media_source,
c.campaign_name,
a.adset_name, 
f.spend, f.impressions, f.reach, f.clicks, f.leads, f.value
from facebook_ads_basic_daily f 
left join facebook_adset a
on f.adset_id= a.adset_id
left join facebook_campaign c on f.campaign_id=c.campaign_id ),

gog_ads_google_ads_birl as (
select ad_date, 
'google ads' as media_source,
campaign_name,
adset_name, 
spend, impressions, reach, clicks, leads, value
from google_ads_basic_daily 

union all 

select ad_date,
media_source,
campaign_name,
adset_name, 
spend, impressions, reach, clicks, leads, value
from faceb_cte )


 
select 
ad_date ,
campaign_name,adset_name, media_source,
sum (spend) as toplam_maliyet,
sum (impressions) as gosterim_sayisi,
sum(clicks) as tiklama_sayisi,
sum(value) as toplam_value
from  gog_ads_google_ads_birl
group by ad_date, media_source, campaign_name, adset_name; 
 