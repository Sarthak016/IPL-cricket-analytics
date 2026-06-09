with source as (
    select * from {{ source('raw', 'deliveries') }}
),

staged as (
    select
        match_id,
        inning,
        batting_team,
        bowling_team,
        over,
        ball,
        batsman,
        non_striker,
        bowler,
        is_super_over,
        wide_runs,
        bye_runs,
        legbye_runs,
        noball_runs,
        penalty_runs,
        batsman_runs,
        extra_runs,
        total_runs,
        player_dismissed,
        dismissal_kind,
        fielder
    from source
    where match_id is not null
)

select * from staged