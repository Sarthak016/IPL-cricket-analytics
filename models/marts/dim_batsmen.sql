with stg_deliveries as(
    select * from {{ ref('stg_deliveries') }}
),

batsmen as (
    select batsman,

SUM(batsman_runs) as total_runs,
SUM(CASE WHEN batsman_runs = 4 THEN 1 ELSE 0 END) as total_fours,
SUM(CASE WHEN batsman_runs = 6 THEN 1 ELSE 0 END) as total_sixes,
SUM(CASE WHEN wide_runs = 0 THEN 1 ELSE 0 END) as balls_faced,
count(distinct match_id)                        as matches_played,
Round(
    SUM(batsman_runs) * 100.0 /
            NULLIF(SUM(CASE WHEN wide_runs = 0 THEN 1 ELSE 0 END), 0)     , 2)                                                 as strike_rate
    from stg_deliveries
    group by batsman
)

select * from batsmen
order by total_runs desc