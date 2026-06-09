with source as (
    select * from {{ source('raw', 'teams') }}
),

staged as (
    select
        team1              
    from source
    where team1 is not null
)

select * from staged