CREATE DATABASE STUDENT;
USE STUDENT;
CREATE TABLE S(
    SNO CHAR(4) NOT NULL,
    SNAME CHAR(10) NULL,
    SEX CHAR(2) NULL,
    AGE CHAR(2) NULL,
    SDEPT CHAR(10) NULL,
    FEES INT NOT NULL,
    PRIMARY KEY (SNO)
);
CREATE TABLE T(
    TNO CHAR(4) NOT NULL,
    TNAME CHAR(10) NULL,
    TDEPT CHAR(10) NULL,
    TCLASS CHAR(10) NULL,
    PRIMARY KEY (TNO)
);
CREATE TABLE C(
    CNO CHAR(4) NOT NULL,
    CNAME CHAR(20) NULL,
    CREDEIT INT NULL,
    CDEPT CHAR(10) NULL,
    TNO CHAR(4) NULL,
    PRIMARY KEY (CNO),
    FOREIGN KEY (TNO) REFERENCES T(TNO)
);
CREATE TABLE SC(
    SNO CHAR(4) NOT NULL,
    CNO CHAR(4) NOT NULL,
    GRADE FLOAT NULL,
    PGRADE FLOAT NULL,
    EGRADE FLOAT NULL,
    POINT FLOAT NULL,
    PRIMARY KEY (SNO, CNO),
    FOREIGN KEY (SNO) REFERENCES S(SNO),
    FOREIGN KEY (CNO) REFERENCES C(CNO)
);
SELECT CNO,
    CNAME
FROM C,
    T
WHERE C.TNO = T.TNO
    AND T.TNAME = "王晓名";
SELECT SNO,
    SNAME
FROM S
WHERE AGE > 22
    AND SEX = "男";
SELECT CNO
FROM C
WHERE CNO NOT IN (
        SELECT CNO
        FROM SC
        WHERE SNO IN (
                SELECT SNO
                FROM S
                WHERE SNAME = "李铭"
            )
    );
SELECT CNO,
    CNAME
FROM C
WHERE NOT EXISTS(
        SELECT *
        FROM S
        WHERE NOT EXISTS (
                SELECT *
                FROM SC
                WHERE C.CNO = SC.CNO
                    AND S.SNO = SC.SNO
            )
    );
SELECT AVG(AGE)
FROM S,
    C,
    SC
WHERE S.SNO = SC.SNO
    AND C.CNO = SC.CNO
    AND C.CNO = "C2";
SELECT DISTINCT CNO,
    COUNT(SNO)
FROM SC
GROUP BY CNO
HAVING COUNT(SNO) > 5;
SELECT SNAME,
    AGE
FROM s
WHERE SNAME LIKE "李%";
SELECT SNAME,
    AGE
FROM s
WHERE SEX = "男"
GROUP BY SNAME,
    AGE
HAVING AGE > (
        SELECT AVG(AGE)
        FROM s
        WHERE SEX = "女"
    )
ORDER BY s.AGE;
INSERT INTO S(SNO, SNAME, AGE)
VALUES ("S10", "吴坚", "22");
UPDATE SC
SET EGRADE = GRADE + PGRADE;
CREATE TABLE STUDENT (
    SNO CHAR(4) NOT NULL,
    NAME CHAR(8),
    SEX CHAR(2)
);
INSERT INTO STUDENT(SNO, NAME, SEX)
SELECT SNO,
    SNAME AS NAME,
    SEX
FROM S
WHERE SNO IN(
        SELECT SNO
        FROM SC
        WHERE EGRADE >= 80
    );
DELETE FROM SC
WHERE GRADE IS NULL;
DELETE FROM SC
WHERE SNO IN (
        SELECT SNO
        FROM S
        WHERE SNAME = "刘成刚"
    );
UPDATE SC
SET EGRADE = NULL
WHERE GRADE < 60
    AND CNO IN (
        SELECT CNO
        FROM C
        WHERE CNAME = "数据结构"
    );
UPDATE SC
SET GRADE = GRADE * 1.05
WHERE SNO IN (
        SELECT SNO
        FROM S
        WHERE SEX = "女"
    )
    AND GRADE < (
        SELECT *
        FROM(
                SELECT AVG(GRADE)
                FROM SC
            ) TEMP
    );
UPDATE SC
SET EGRADE = EGRADE * 1.05
WHERE CNO = "C4"
    AND EGRADE <= 75;
UPDATE SC
SET EGRADE = EGRADE * 1.04
WHERE CNO = "C4"
    AND EGRADE > 75;
CREATE VIEW STUDENT_FAIL_EGRADE (xh, xm, xb, sjhm, km, zpcj) AS (
    SELECT e.xh,
        xm,
        xb,
        sjhm,
        km,
        zpcj
    FROM e
        INNER JOIN s ON e.xh = s.xh
        INNER JOIN c ON e.kh = c.kh
    WHERE e.zpcj < 60
        AND s.yxh = 1
);
INSERT INTO e
SELECT DISTINCT s.xh,
    o.xq,
    o.kh,
    o.gh,
    NULL,
    NULL,
    NULL
FROM s,
    o
WHERE NOT EXISTS(
        SELECT *
        FROM e
        WHERE e.xh = s.xh
            AND e.kh = o.kh
    );
SELECT xm,
    2021 - year (s.csrq) AS age
FROM s
WHERE s.xb = "男"
    AND s.csrq <(
        SELECT min(s.csrq)
        FROM s
        WHERE s.xb = "女"
    );
UPDATE e
SET pscj = pscj * 1.05
WHERE pscj <= 75;
UPDATE e
SET pscj = pscj * 1.04
WHERE pscj > 75;
SET foreign_key_checks = 0;
DELETE FROM d
WHERE NOT EXISTS (
        SELECT *
        FROM o
            INNER JOIN c ON o.kh = c.kh
        WHERE c.yxh = d.yxh
    );
SET foreign_key_checks = 1;
SELECT (
        SELECT COUNT(*)
        FROM (
                SELECT zpcj
                FROM e
                GROUP BY zpcj
                HAVING zpcj > 90
            ) AS LH
    ) AS '优秀',
    (
        SELECT COUNT(*)
        FROM (
                SELECT zpcj
                FROM e
                GROUP BY zpcj
                HAVING zpcj >= 80
                    AND zpcj < 90
            ) AS LH
    ) AS '良好',
    (
        SELECT COUNT(*)
        FROM (
                SELECT zpcj
                FROM e
                GROUP BY zpcj
                HAVING zpcj >= 70
                    AND zpcj < 80
            ) AS LH
    ) AS '中等',
    (
        SELECT COUNT(*)
        FROM (
                SELECT zpcj
                FROM e
                GROUP BY zpcj
                HAVING zpcj >= 60
            ) AS JG
    ) AS '及格',
    (
        SELECT COUNT(*)
        FROM (
                SELECT zpcj
                FROM e
                GROUP BY zpcj
                HAVING zpcj < 60
            ) AS BJG
    ) AS '不及格';
CREATE VIEW STUDENT_SC(SNO, SNAME, EGRADE, AVG_EGRADE) AS
SELECT S.SNO,
    SNAME,
    COUNT(CNO),
    SUM(EGRADE) / COUNT(CNO)
FROM S,
    SC
WHERE SC.SNO = S.SNO
GROUP BY S.SNO,
    SNAME;
SELECT *
FROM STUDENT_SC;