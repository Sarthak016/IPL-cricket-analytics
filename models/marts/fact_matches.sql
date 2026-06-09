with stg_matches as (
    select * from {{ ref('stg_matches') }}
),

fact as (
    select
        id as match_id,
        season,
        city,
        match_date,
        team1,
        team2,
        toss_winner,
        toss_decision,
        winner,
        win_by_runs,
        win_by_wickets,
        player_of_match,
        venue,
        case
            when toss_winner = winner then true
            else false
        end as toss_winner_won_match,
        case
            when win_by_runs > 0 then 'Won by runs'
            when win_by_wickets > 0 then 'Won by wickets'
            else 'No result'
        end as win_type
    from stg_matches
)

select * from fact