CREATE TABLE #EMP
(
EMP_ID INT,
EMP_NAME VARCHAR(10),
MANAGER_ID INT)
;

INSERT INTO #EMP VALUES (1,'MARK',NULL),
(5,'JANE',1),
(4,'HENRY',1),
(2,'MIKE',5),
(6,'JOAN',5),
(8,'JUNE',4),
(9,'GUS',4),
(3,'JOHN',2),
(7,'PETER',2),
(10,'TIM',8)
;

WITH MGR (MGR_ID, MGR_NAME, EMP_ID, EMP_NAME, TOP_MGR_ID, CNTER)
AS (
SELECT A.EMP_ID AS MGR_ID,
A.EMP_NAME AS MGR_NAME,
B.EMP_ID,
B.EMP_NAME,
A.EMP_ID AS TOP_MGR_ID,
1 AS CNTR
FROM #EMP A
INNER JOIN
#EMP B
ON
B.MANAGER_ID = A.EMP_ID

UNION ALL
SELECT B.MGR_ID,
B.MGR_NAME,
A.EMP_ID,
A.EMP_NAME,
B.TOP_MGR_ID,
B.CNTER +1
FROM #EMP A
INNER JOIN
MGR B
ON
A.MANAGER_ID = B.EMP_ID
)
SELECT * FROM MGR ORDER BY CNTER, MGR_ID, TOP_MGR_ID