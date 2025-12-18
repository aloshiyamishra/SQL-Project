# Carbon Emission Calculator (SQL Project)

## Project Overview

The **Carbon Emission Calculator** is a SQL-based data analysis project designed to measure, analyze, and interpret carbon emissions generated from various activities such as transportation, electricity usage, and waste generation. The project helps organizations and individuals understand their carbon footprint and supports data-driven, sustainability-focused decision-making.

---

## Business Problem

Organizations and individuals often lack clear visibility into which activities contribute most to their carbon emissions. Without proper tracking and analysis, it becomes difficult to plan effective emission reduction strategies.

**This project addresses the problem by:**
- Quantifying emissions using structured SQL queries
- Identifying high-emission activities, users, and regions
- Providing actionable insights for carbon reduction

---

## Objectives

- Measure carbon emissions across multiple activity categories
- Identify major emission hotspots (users, activities, countries)
- Analyze daily, weekly, and regional emission trends
- Provide SQL-driven, actionable sustainability recommendations
- Enable eco-friendly decision-making using data analytics

---

## Data Model

The database follows a **relational schema**, designed for scalability and clarity:

- **Users** – Individual or company-level entities
- **Activities** – Emission-generating actions (travel, electricity, waste, etc.)
- **Emission_Factors** – CO₂ emission rate per unit of activity
- **Activity_Logs** – Daily records of activity usage
- **Recommendations** – Emission reduction suggestions mapped to activities

---

## Data Analysis Approach

- **Data Modeling:** Designed normalized relational tables
- **Data Cleaning:** Standardized units, structured numeric fields, ensured referential integrity
- **SQL Analysis:** Used SELECT, JOIN, GROUP BY, HAVING, subqueries, and aggregate functions
- **Insight Extraction:** Identified high-emission users, activities, and regions
- **Recommendation Mapping:** Linked activity emissions to reduction strategies

---

## SQL Queries Covered

The project includes **14 core SQL queries**, each with logic explanation and insights:

1. List all users and their types (individual / company)
2. Show all activities and their measurement units
3. Display emission factor for each activity
4. Calculate total CO₂ emission per user
5. Calculate total carbon emission per activity type
6. Find average emission per activity type
7. Identify the activity contributing most to total emissions
8. Identify the user with the highest CO₂ emissions
9. Calculate total emissions by country
10. Daily emission trend for a specific user
11. Emission reduction recommendations by activity type
12. Percentage contribution of each activity to total emissions
13. List users with daily emissions greater than 500 kg CO₂
14. Average emission by user type (individual vs company)

---

## Key Insights

- Electricity usage and transportation are the largest contributors to carbon emissions
- Companies emit significantly more CO₂ than individuals
- Certain countries show disproportionately high emission levels
- Peak emission days indicate operational or usage spikes

---

## Business Recommendations

- Shift to **renewable energy sources** to reduce electricity-related emissions
- Promote **public transport, carpooling, and EV adoption**
- Encourage organizations to monitor operational inefficiencies
- Conduct regular carbon audits using SQL reports
- Provide personalized reduction tips based on activity patterns

---

## Tools & Technologies

- **SQL** – Core analysis and querying
- **Relational Database Design** – Normalized schema
- **Analytical Functions & Aggregates** – Emission calculations
- **Presentation Layer** – Insights summarized for stakeholders

---

## Project Scope & Limitations

### Scope
- Historical emission analysis using structured SQL queries
- Suitable for individuals and organizations
- Scalable schema for environmental analytics

### Limitations
- No real-time data integration
- Dependent on accuracy of emission factors
- No predictive or machine learning models included

---

## Future Enhancements

- Integration of real-time IoT data from smart meters and vehicles
- Predictive emission forecasting using machine learning
- Visualization dashboards using Power BI or Tableau
- Personalized emission reduction recommendations
- Carbon credit and renewable energy tracking

---

## Conclusion

The **SQL-based Carbon Emission Calculator** provides a structured and analytical framework to evaluate carbon footprints across diverse activities. By leveraging relational data modeling and advanced SQL queries, the project delivers meaningful insights that support sustainability planning and environmental responsibility.

---

## Author

**Aloshiya Mishra**  
- GitHub: https://github.com/aloshiyamishra  
- LinkedIn: https://www.linkedin.com/in/aloshiya-mishra-9a5571244