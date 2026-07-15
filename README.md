#PROJECT

Zomato Restaurant Analysis



📌 What is this project about?

This project analyzes real Zomato restaurant data to answer questions like:
Which cuisines are the most popular in the city?
Does spending more money mean getting a better-rated restaurant?
Which areas have very few restaurants but strong demand potential?
Which time windows are best and worst for food delivery?


The project goes from raw messy data all the way to clean charts and insights — using Python, SQL, and Jupyter Notebooks.


📁 Project Structure

zomato_restaurant_analysis/
│
├── data/                       
│
├── notebook/                    ← Jupyter Notebooks (main analysis)

│   ├── 01_data_cleaning.ipynb       
│   ├── 02_eda_zomato.ipynb          
│   ├── 04_delivery_analysis.ipynb   
│   
│
├── sql/                         
│   └── analysis_queries.sql         
│
├── src/                       
│   └── db_load.py                   
│
├── output/

│   └─ charts/                  
│
├── .gitignore                   
├── requirements.txt           
└── README.md                    


#Tech stack

Python
Pandas
SQLite / SQL
Matplotlib / Seaborn

#Tools Used

VS Code
PostgresSQL
Dbeaver

📊 Datasets Used

Dataset 1 — Zomato Restaurant Data (from Kaggle)

Restaurant name, city, locality, cuisines
Average cost for two people
Aggregate rating and votes
Online delivery and table booking availability


Dataset 2 — Food Delivery Time Data (from Kaggle)
Distance, weather, traffic level
Time of day, preparation time
Total delivery time in minutes

⚙️ How to Run This Project

#On Terminal
Step 1 — Create a virtual environment

python -m venv venv

Activate it:
venv\Scripts\activate

You will see (venv) at the start of your terminal line. That means it is working.

Step 2 — Install required libraries

pip install pandas numpy matplotlib seaborn scipy scikit-learn sqlalchemy psycopg2-binary openpyxl jupyter ipykernel


Step 3 — Load data into PostgreSQL

Open src/db_load.py, update your database password, and run:
python src/db_load.py
This creates three tables in your database: zomato_restaurants, cuisine_breakdown, and delivery_times.



💡 Key Findings


North Indian and Chinese cuisines dominate restaurant offerings in most localities

Mid-range restaurants tend to have stronger average ratings than both budget and premium segments

Price and rating have a weak correlation — spending more does not reliably get you a better-rated restaurant

Restaurants with online delivery enabled show higher average engagement and ratings

Evening and high-traffic time windows produce significantly longer delivery times

Several localities show low restaurant count but strong rating signals, making them potential white-space opportunities for new restaurant openings
