# netflix-content-analytics
End-to-end Netflix content analytics using Python, PostgreSQL and Power BI
# 🎬 Decoding Netflix: End-to-End Content Strategy & BI Analysis

An end-to-end data analytics project on Netflix's content catalog.
**Python** for cleaning, EDA and statistical analysis → **PostgreSQL** for validation and business insights → **Power BI** for an interactive dashboard.

![Dashboard Preview](main/dashboard/screensort/dashboard.png.png)

---

## 📌 Project Overview

Netflix's catalog is huge and global. This project answers practical content-strategy questions:

- How is the catalog split between Movies and TV Shows?
- Which countries contribute the most titles?
- How has content addition changed over the years?
- How do ratings, genres and release years vary across the catalog?

The work follows a full analyst workflow: audit the raw data, clean it, explore it, validate it in SQL, and present it in a dashboard a non-technical stakeholder can use.

## 🛠️ Tech Stack

| Stage | Tools |
|-------|-------|
| Data audit, cleaning, EDA | Python (Pandas, NumPy, Matplotlib, Seaborn) |
| Statistical analysis | Python |
| Validation and insights | PostgreSQL (SQL) |
| Dashboard | Power BI Desktop |
| Version control | Git, GitHub |

## 🔄 Pipeline

1. **Audit** – checked missing values, duplicates and data types (`audit_missing`).
2. **Clean** – handled missing values, fixed date fields, standardised columns (`cleaning_plan`, `clean_data`).
3. **EDA and statistics** – distributions, trends, relationships (`Netflix_EDA`).
4. **SQL validation and insights** – re-checked counts and ran business queries in PostgreSQL (`sql/`).
5. **Dashboard** – built the Power BI report on the cleaned table.

## 📊 Dashboard Features

- **KPI cards:** Total Titles, Total Movies, Total TV Shows
- **4 slicers:** Release Year, Content Type, Rating, Country
- **Content by Type:** bar chart of Movies vs TV Shows
- **Movies vs TV Shows:** share of the catalog (donut)
- **Top 10 Countries by Titles:** horizontal bar chart
- **Titles Added Over Time:** area chart by year added
- Custom dark Netflix theme with a cinematic header banner

## 🔍 Key Insights

- The catalog has **8,807 titles**: **6,131 Movies (69.6%)** and **2,676 TV Shows (30.4%)**.
- The **United States** has the most titles, followed by **India**.
- Titles added per year rose sharply after 2015 and peaked around 2019–2020. `[verify against your data]`
- `[add 2-3 insights from your Python EDA and SQL queries, with numbers]`

## 📁 Project Structure

```
├── notebooks/
│   ├── audit_missing.ipynb
│   ├── clean_data.ipynb
│   └── Netflix_EDA.ipynb
├── data/                  # raw and cleaned datasets
├── sql/                   # PostgreSQL validation and insight queries
├── charts/                # charts exported from Python
├── dashboard/
│   ├── Netflix_Analytics_Dashboard.pbix
│   └── screenshots/
├── docs/
│   └── cleaning_plan
├── README.md
└── .gitignore
```

## ▶️ How to Run

1. Clone the repo
   ```bash
   git clone https://github.com/vivekmittal110/netflix-content-analytics.git
   cd netflix-content-analytics
   ```
2. Install the libraries
   ```bash
   pip install pandas numpy matplotlib seaborn jupyter
   ```
3. Run the notebooks in order: `audit_missing` → `clean_data` → `Netflix_EDA`
4. Run the queries in `sql/` on a PostgreSQL database loaded with the cleaned data.
5. Open `dashboard/Netflix_Analytics_Dashboard.pbix` in Power BI Desktop.

## ⚠️ Notes and Limitations

- Titles with a missing country are labelled **Unknown** and excluded from the Top 10 Countries chart.
- The final year in the dataset may be only partially covered, so its drop in the trend chart should not be read as a real decline.
- Dataset source: the Kaggle Netflix Movies and TV Shows dataset

## 🚀 What I Learned

- Building a complete analysis pipeline from raw CSV to dashboard
- Using SQL to cross-check results from Python
- Designing a clean, readable Power BI dashboard with consistent theming and layout

## 👤 Author

**Vivek**
MCA Student | Aspiring Data Analyst
🔗 LinkedIn: www.linkedin.com/in/vivekmittal110230
💻 GitHub: https://github.com/vivekmittal110/

⭐ If you found this useful, consider giving the repo a star.
