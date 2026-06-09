with source as (
    select * from {{ source('raw', 'players') }}
),

staged as (
    select
        Player_Name,
        DOB,
        Batting_Hand,
        Bowling_Skill,
        Country
    from source
    where Player_Name is not null
)

select * from staged