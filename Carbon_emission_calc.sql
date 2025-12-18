-- =====================================================
-- CARBON EMISSION CALCULATOR - SQL DATA ANALYSIS PROJECT
-- Author: Aloshiya Mishra
-- Description: SQL-based carbon emission tracking and analysis
-- =====================================================

-- STEP 1️- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS carbon_emission_db;
USE carbon_emission_db;

-- STEP 2️- DROP TABLES IF THEY ALREADY EXIST (FOR CLEAN RUNS)
DROP TABLE IF EXISTS recommendations;
DROP TABLE IF EXISTS user_activity_log;
DROP TABLE IF EXISTS emission_factors;
DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS users;

-- STEP 3️- CREATE TABLES

-- USERS TABLE
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(100) NOT NULL,
    user_type VARCHAR(50) CHECK (user_type IN ('individual','company')),
    country VARCHAR(100)
);

-- ACTIVITIES TABLE
CREATE TABLE activities (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    activity_name VARCHAR(100) NOT NULL,
    unit VARCHAR(50) NOT NULL
);

-- EMISSION FACTORS TABLE
CREATE TABLE emission_factors (
    factor_id INT PRIMARY KEY AUTO_INCREMENT,
    activity_id INT NOT NULL,
    emission_per_unit DECIMAL(10,4) NOT NULL, -- kg CO₂ per unit
    source VARCHAR(100),
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id)
);

-- USER ACTIVITY LOG TABLE
CREATE TABLE user_activity_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    activity_id INT NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    log_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id)
);

-- RECOMMENDATIONS TABLE
CREATE TABLE recommendations (
    activity_id INT PRIMARY KEY,
    tip TEXT,
    FOREIGN KEY (activity_id) REFERENCES activities(activity_id)
);

-- STEP 4️- INSERT SAMPLE DATA
SELECT * FROM user_activity_log;

-- USERS
INSERT INTO users (user_name, user_type, country) VALUES
('Prince ', 'individual', 'India'),
('Kalinga Ltd', 'company', 'India'),
('Silos Pvt Ltd', 'company', 'Canada'),
('Peter John', 'individual', 'US'),
('Kent Aqua', 'company', 'California');

-- ACTIVITIES
INSERT INTO activities (activity_name, unit) VALUES
('Car Travel', 'km'),
('Electricity Usage', 'kWh'),
('Plastic Waste', 'kg'),
('Air Travel', 'km'),
('Paper Usage', 'kg');

-- EMISSION FACTORS
INSERT INTO emission_factors (activity_id, emission_per_unit, source) VALUES
(1, 0.120, 'IPCC Transport Report'),
(2, 0.920, 'Energy Dept Data 2025'),
(3, 6.000, 'Environmental Study 2024'),
(4, 0.250, 'ICAO Flight Emission Model'),
(5, 1.500, 'Sustainability Journal 2023');

-- USER ACTIVITY LOG
INSERT INTO user_activity_log (user_id, activity_id, quantity, log_date) VALUES
(1, 1, 150, '2025-11-01'),
(1, 2, 80, '2025-11-01'),
(1, 3, 2, '2025-11-02'),
(1, 5, 10, '2025-11-03'),

(2, 1, 5000, '2025-11-01'),
(2, 2, 2500, '2025-11-01'),
(2, 3, 50, '2025-11-02'),

(3, 2, 1800, '2025-11-01'),
(3, 4, 1200, '2025-11-02'),

(4, 1, 200, '2025-11-02'),
(4, 4, 800, '2025-11-03'),

(5, 2, 3000, '2025-11-01'),
(5, 3, 20, '2025-11-02'),
(5, 5, 100, '2025-11-03'),

(6, 1, 150, '2025-11-01'),
(6, 2, 80, '2025-11-01'),
(6, 3, 2, '2025-11-02'),
(6, 5, 10, '2025-11-03'),

(7, 1, 5000, '2025-11-01'),
(7, 2, 2500, '2025-11-01'),
(7, 3, 50, '2025-11-02'),

(8, 2, 1800, '2025-11-01'),
(8, 4, 1200, '2025-11-02'),

(9, 1, 200, '2025-11-02'),
(9, 4, 800, '2025-11-03'),

(10, 2, 3000, '2025-11-01'),
(10, 3, 20, '2025-11-02'),
(10, 5, 100, '2025-11-03');


-- RECOMMENDATIONS
INSERT INTO recommendations (activity_id, tip) VALUES
(1, 'Use public transport or carpool to reduce emissions.'),
(2, 'Switch to renewable energy sources like solar or wind.'),
(3, 'Reduce single-use plastics and recycle whenever possible.'),
(4, 'Choose direct flights and offset carbon emissions.'),
(5, 'Go paperless or use recycled paper.');

-- STEP 5️- SAMPLE ANALYSIS QUERIES

-- 1 List all users and their types

SELECT * FROM users;

-- 2 Show all activities and their units

SELECT * FROM activities;

-- 3 Display emission factor for every activity

SELECT 
	activity_name, 
    emission_per_unit,
    source 
FROM activities ac
JOIN emission_factors e 
ON ac.activity_id = e.activity_id;

-- 4 Total Carbon Emission per User

SELECT 
	u.user_name, 
    sum(ul.quantity*e.emission_per_unit) as Total_emission_kg
FROM user_activity_log ul
JOIN users u ON u.user_id = ul.user_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
GROUP BY u.user_name
ORDER BY Total_emission_kg DESC;

-- 5 Total emission per activity type

SELECT 
	act.activity_name, 
    round(sum(ul.quantity*e.emission_per_unit),2) as Total_emission_kg
FROM user_activity_log ul
JOIN activities act ON act.activity_id = ul.activity_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
GROUP BY act.activity_name
ORDER BY Total_emission_kg DESC;

-- 6 Average Emission by Activity Type

SELECT 
	act.activity_name, 
    round(avg(ul.quantity*e.emission_per_unit),2) as Avg_emission_kg
FROM user_activity_log ul
JOIN activities act ON act.activity_id = ul.activity_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
GROUP BY act.activity_name
ORDER BY Avg_emission_kg DESC;

-- 7 Highest Emitting Activity

SELECT 
	act.activity_name, 
    round(sum(ul.quantity*e.emission_per_unit),2) 
    as Total_emission_kg
FROM user_activity_log ul
JOIN activities act ON act.activity_id = ul.activity_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
GROUP BY act.activity_name
ORDER BY Total_emission_kg DESC
LIMIT 1;

-- 8 Highest CO2 Emitting User

SELECT 
	u.user_name, 
    ROUND(sum(ul.quantity*e.emission_per_unit),2) 
		as Total_emission_kg
FROM user_activity_log ul
JOIN users u ON u.user_id = ul.user_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
GROUP BY u.user_name
ORDER BY Total_emission_kg DESC
LIMIT 1;

-- 9 Total emission by country

SELECT 
	country,
    ROUND(sum(ul.quantity*e.emission_per_unit),2) 
		as Total_emission_kg
FROM user_activity_log ul
JOIN users u ON u.user_id = ul.user_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
GROUP BY country
ORDER BY Total_emission_kg;

-- 10 Daily Emission Trend for a Specific User

SELECT 
	log_date,
    user_name,
    ROUND(sum(ul.quantity*e.emission_per_unit),2) 
		as daily_emission_kg
FROM user_activity_log ul
JOIN users u ON u.user_id = ul.user_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
GROUP BY log_date, user_name
ORDER BY log_date;

-- 11 Percentage contribution of each activity to total emissions

SELECT 
	activity_name, 
    round(sum(ul.quantity*e.emission_per_unit),2) 
		as Total_emission_kg,
    ROUND(100 * sum(ul.quantity * e.emission_per_unit) / 
        (SELECT sum(quantity * emission_per_unit) 
			FROM user_activity_log l 
			JOIN emission_factors ef 
            ON l.activity_id = ef.activity_id),
        2) AS Percent_Contribution
FROM user_activity_log ul
JOIN activities act ON act.activity_id = ul.activity_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
GROUP BY activity_name
ORDER BY Percent_Contribution DESC;

-- 12 Emission Reduction Recommendations

SELECT 
	u.user_name,
    act.activity_name, 
    round(sum(ul.quantity*e.emission_per_unit),2) 
		as Total_emission_kg,
    r.tip as Recommendation
FROM user_activity_log ul
JOIN activities act ON act.activity_id = ul.activity_id
JOIN emission_factors e ON ul.activity_id = e.activity_id
JOIN recommendations r ON r.activity_id = e.activity_id
JOIN users u ON u.user_id = ul.user_id
GROUP BY act.activity_name, u.user_name, r.tip
ORDER BY Total_emission_kg DESC;

-- 13 List users with daily emissions greater than 500 kg CO₂

SELECT 
    u.user_name,
    l.log_date,
    ROUND(SUM(l.quantity * ef.emission_per_unit), 2) 
	AS total_daily_emission
FROM user_activity_log l
JOIN users u ON l.user_id = u.user_id
JOIN emission_factors ef ON l.activity_id = ef.activity_id
GROUP BY u.user_name, l.log_date
HAVING total_daily_emission > 500
ORDER BY total_daily_emission DESC;

-- 14 Average emission per user type (individual vs company)

SELECT 
    user_type,
    ROUND(AVG(user_total_emission), 2) AS avg_emission_per_user_type
FROM (
    SELECT 
        u.user_id,
        u.user_type,
        SUM(l.quantity * ef.emission_per_unit) AS user_total_emission
    FROM user_activity_log l
    JOIN users u ON l.user_id = u.user_id
    JOIN emission_factors ef ON l.activity_id = ef.activity_id
    GROUP BY u.user_id, u.user_type
) t
GROUP BY user_type;


-- ==============================================================================================================
