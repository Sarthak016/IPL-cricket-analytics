
with stg_deliveries as(
    select * from {{ ref('stg_deliveries') }}
),

bowlers as (

select 
bowler , 
SUM(CASE WHEN player_dismissed IS NOT NULL 
    AND dismissal_kind NOT IN ('run out', 'retired hurt') 
    THEN 1 ELSE 0 END) as wicket_count,
ROUND(SUM(total_runs) * 6.0 / 
    NULLIF(SUM(CASE WHEN wide_runs = 0 AND noball_runs = 0 THEN 1 ELSE 0 END), 0)
, 2) as economy_rate,
COUNT(DISTINCT match_id) as matches_played,
sum(total_runs) as runs_conceded
from stg_deliveries 
group by bowler
)

select * from bowlers
order by wicket_count desc