-- LEVEL 1

-- Question 1: Number of users with sessions
SELECT COUNT(DISTINCT user_id) AS number_of_users_with_sessions
FROM Sessions;

-- Question 2: Number of chargers used by user with id 1
SELECT COUNT(DISTINCT charger_id) AS number_of_chargers_used
FROM Sessions
WHERE user_id = 1;


-- LEVEL 2

-- Question 3: Number of sessions per charger type (AC/DC):
SELECT c.type, COUNT(s.id) AS session_count
FROM Chargers c
JOIN Sessions s ON c.id = s.charger_id
GROUP BY c.type;

-- Question 4: Chargers being used by more than one user
SELECT charger_id
FROM Sessions
GROUP BY charger_id
HAVING COUNT(DISTINCT user_id) > 1;

-- Question 5: Average session time per charger
SELECT charger_id, AVG(strftime('%s', end_time) - strftime('%s', start_time)) AS average_session_time_seconds
FROM Sessions
GROUP BY charger_id;


-- LEVEL 3

-- Question 6: Full username of users that have used more than one charger in one day (NOTE: for date only consider start_time)
SELECT DISTINCT u.name || ' ' || u.surname AS full_name
FROM Users u
JOIN (
    SELECT user_id, date(start_time) AS session_date
    FROM Sessions
    GROUP BY user_id, date(start_time)
    HAVING COUNT(DISTINCT charger_id) > 1
) filtered ON u.id = filtered.user_id;

