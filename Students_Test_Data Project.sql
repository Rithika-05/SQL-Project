CREATE DATABASE Students_Test_Data;
USE Students_Test_Data;
SELECT * FROM Private_data;
SHOW COLUMNS FROM Private_data; 

/* 1.  Find Top 5 Student by Total Score */
SELECT * FROM Private_data ORDER BY TOTAL_SCORE DESC LIMIT 5;

/* 2. Calculate Average Score per Domain */
SELECT Domain, AVG(GENERAL_MANAGEMENT_SCORE) AS Avg_General_Management_Score, AVG(`Domain_ Specific_SCORE`) AS Avg_Domain_Specific_Score
FROM Private_data GROUP BY Domain;

/* 3. List Students in a Specific University */
SELECT * FROM Private_data WHERE UNIVERSITY = 'Stanford University, USA';

/*4. Get Students by Program and Specialization */
SELECT * FROM Private_data WHERE PROGRAM_NAME = 'MBA' AND Specialisation = 'International Business';

/* 5. Find Students in a Specific Semester with High Scores */
SELECT * FROM Private_data WHERE SEMESTER = 3 AND TOTAL_SCORE > 85;

/* 6. Rank Students by Domain */
SELECT S_No, NAME_OF_THE_STUDENT, Domain, TOTAL_SCORE, RANK() OVER (PARTITION BY Domain ORDER BY TOTAL_SCORE DESC) AS Domain_Rank FROM Private_data;

/* 7. Get Students with Percentile Above 90 */
SELECT * FROM Private_data WHERE PERCENTILE > 0.90;

/* 8. Calculate Total Average Score Across All Students */
SELECT AVG(TOTAL_SCORE) AS Avg_Total_Score FROM Private_data;

/* 9. Count of Students per Semester */
SELECT SEMESTER, COUNT(*) AS Student_Count FROM Private_data GROUP BY SEMESTER;

/* 10. Update Ranking */
SET SQL_SAFE_UPDATES = 0; 
UPDATE Private_data SET RANKING = 2 WHERE S_No = 1;

/* 11. Count of Students per Program and Specialization */
SELECT PROGRAM_NAME, Specialisation, COUNT(*) AS Student_Count FROM Private_data GROUP BY PROGRAM_NAME, Specialisation;

/* 12.  Identify Students Who Have Scored Above Average in General Management */
SELECT * FROM Private_data WHERE GENERAL_MANAGEMENT_SCORE > (SELECT AVG(GENERAL_MANAGEMENT_SCORE) FROM Private_data);

/* 13. Calculate Highest and Lowest Domain Specific Score by Domain */  
SELECT Domain, MAX(`Domain_ Specific_SCORE`) AS Max_Domain_Specific_Score, MIN(`Domain_ Specific_SCORE`) AS Min_Domain_Specific_Score FROM Private_data GROUP BY Domain;

/* 14.Average Total Score and Percentile for "MBA" students in the "International Business" specialization in the 3rd semester. */
SELECT AVG(TOTAL_SCORE) AS average_total_score, AVG(PERCENTILE) AS average_percentil FROM Private_data WHERE PROGRAM_NAME = 'MBA'
AND Specialisation = 'International Business' AND SEMESTER = '3rd';

/* 15. List All Students Sorted by Percentile in Descending Order */
SELECT * FROM Private_data ORDER BY PERCENTILE DESC;

 /* 16. Calculate Average Total Score per University */
 SELECT UNIVERSITY, AVG(TOTAL_SCORE) AS Avg_Total_Score FROM Private_data GROUP BY UNIVERSITY;

/* 17. Identify Top Scorer in Each Specialization */
SELECT Specialisation, NAME_OF_THE_STUDENT, TOTAL_SCORE AS Top_Total_Score FROM Private_data WHERE (Specialisation, TOTAL_SCORE) IN (SELECT Specialisation, MAX(TOTAL_SCORE)
FROM Private_data GROUP BY Specialisation);

/* 18. List Students Who Are Ranked in the Top 10 Percentile */
SELECT * FROM Private_data WHERE PERCENTILE >= 0.9;

/* 19. Calculate Average Domain Score per Semester */
SELECT SEMESTER, AVG(`Domain_ Specific_SCORE`) AS Avg_Domain_Specific_Score FROM Private_data GROUP BY SEMESTER;

/* 20. Identify Students Who Excelled in General Management but Scored Low in Domain Specific */
SELECT * FROM Private_data WHERE GENERAL_MANAGEMENT_SCORE > 49 AND `Domain_ Specific_SCORE` < 50;

/* 21. Get Students by Semester and Rank Them within Each Semester */
SELECT S_No, NAME_OF_THE_STUDENT, SEMESTER, TOTAL_SCORE, RANK() OVER (PARTITION BY SEMESTER ORDER BY TOTAL_SCORE DESC) AS Semester_Rank FROM Private_data;

/* 22. Calculate the Median Total Score for Each Program */
WITH RankedScores AS (SELECT PROGRAM_NAME,TOTAL_SCORE,ROW_NUMBER() OVER(PARTITION BY PROGRAM_NAME ORDER BY TOTAL_SCORE) AS rn_asc,ROW_NUMBER() OVER(PARTITION BY PROGRAM_NAME 
ORDER BY TOTAL_SCORE DESC) AS rn_desc FROM Private_data)

SELECT PROGRAM_NAME, AVG(TOTAL_SCORE) AS Median_Total_Score FROM RankedScores WHERE rn_asc = rn_desc OR rn_asc + 1 = rn_desc GROUP BY PROGRAM_NAME;

/* 23. Counting Students and Average Score */
SELECT COUNT(*) AS student_count, 
       AVG(TOTAL_SCORE) AS average_total_score
FROM Private_data
WHERE PROGRAM_NAME = 'MBA'
  AND Specialisation = 'International Business'
  AND SEMESTER = '3rd';