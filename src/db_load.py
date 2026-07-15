import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

load_dotenv()
password=os.getenv("POSTGRES_PASSWORD")
db=os.getenv("POSTGRES_DB")
engine=create_engine(f"postgresql://postgres:{password}@localhost:5432/{db}")

print("Database connection successful")

zomato=pd.read_csv("data/processed/zomato_clean.csv") 
delivery=pd.read_csv("data/processed/delivery_clean.csv")

#explore cuisines
cuisine_rows=[]
for _,row in zomato.iterrows():
    if pd.notna(row.get("cuisines")):
        for c in str(row["cuisines"]).split(","):
            cuisine_rows.append({
                "restaurant_id": row["restaurant_id"],
                "restaurant_name": row["restaurant_name"],
                "cuisine": c.strip(),
                "locality":row["locality"],
                "votes":row["votes"],
                "aggregate_rating":row["aggregate_rating"],
                "avg_cost_for_two":row["average_cost_for_two"]
            })
            
            
cuisine_df=pd.DataFrame(cuisine_rows)

zomato.to_sql("zomato_restaurants",  engine, if_exists="replace", index=False)
delivery.to_sql("delivery_times",    engine, if_exists="replace", index=False)
cuisine_df.to_sql("cuisine_breakdown", engine, if_exists="replace", index=False)

print("All tables loaded into PostgreSQL successfully.")
print(f"zomato_restaurants : {len(zomato)} rows")
print(f"delivery_times: {len(delivery)} rows")
print(f"cuisine_breakdown: {len(cuisine_df)} rows")
