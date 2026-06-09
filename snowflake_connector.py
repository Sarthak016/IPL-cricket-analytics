import snowflake.connector
import pandas as pd
import os

conn = snowflake.connector.connect(
    user='SARTHAK016',
    password=os.environ.get('SNOWFLAKE_PASSWORD'),
    account='emaswsd-ey58003',
    warehouse='compute_wh',
    database='ipl_db',
    schema='raw'
)

print("Connected to Snowflake successfully\n")
cur = conn.cursor()

# query 1 - top 10 batsmen
cur.execute("""
    SELECT batsman, total_runs, strike_rate, total_fours, total_sixes
    FROM dim_batsmen
    ORDER BY total_runs DESC
    LIMIT 10
""")
df_batsmen = pd.DataFrame(cur.fetchall(), columns=[desc[0] for desc in cur.description])
print("Top 10 IPL Batsmen:")
print(df_batsmen)

# query 2 - top 10 bowlers
cur.execute("""
    SELECT bowler, wicket_count, economy_rate, matches_played
    FROM dim_bowlers
    ORDER BY wicket_count DESC
    LIMIT 10
""")
df_bowlers = pd.DataFrame(cur.fetchall(), columns=[desc[0] for desc in cur.description])
print("\nTop 10 IPL Bowlers:")
print(df_bowlers)

# query 3 - toss analysis
cur.execute("""
    SELECT 
        COUNT(*) as total_matches,
        SUM(CASE WHEN toss_winner_won_match = true THEN 1 ELSE 0 END) as toss_winner_won,
        ROUND(SUM(CASE WHEN toss_winner_won_match = true THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as win_percentage
    FROM fact_matches
""")
df_toss = pd.DataFrame(cur.fetchall(), columns=[desc[0] for desc in cur.description])
print("\nToss Analysis:")
print(df_toss)

cur.close()
conn.close()
print("\nConnection closed.")