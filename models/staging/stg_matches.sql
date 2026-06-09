with source as (
    select * from {{ source('raw', 'matches') }}
),

staged as (
    select
        id,
        season,
        city,
        TRY_TO_DATE(date, 'DD-MM-YYYY') as match_date,
        team1,
        team2,
        toss_winner,
        toss_decision,
        result,
        dl_applied,
        winner,
        win_by_runs,
        win_by_wickets,
        player_of_match,
        venue,
        umpire1,
        umpire2,
        umpire3
    from source
    where id is not null
)

select * from staged