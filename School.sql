CREATE DATABASE school;
USE school;
CREATE TABLE D (
    Yxh CHAR(2) NOT NULL,
    mc CHAR(20) NOT NULL,
    dz CHAR(100) NOT NULL,
    lxdh CHAR(11) NOT NULL,
    PRIMARY KEY (Yxh)
);
CREATE TABLE S (
    Xh CHAR(4) NOT NULL,
    xm CHAR(10) NOT NULL,
    xb CHAR(2) NOT NULL,
    csrq DATE NOT NULL,
    jg CHAR(20) NOT NULL,
    sjhm CHAR(11) NOT NULL,
    yxh CHAR(2) NOT NULL,
    Zt CHAR(20) NULL,
    PRIMARY KEY (Xh),
    FOREIGN KEY (yxh) REFERENCES D(Yxh)
);
CREATE TABLE T (
    Gh CHAR(4) NOT NULL,
    xm CHAR(10) NOT NULL,
    xb CHAR(2) NOT NULL,
    csrq DATE NOT NULL,
    Zc CHAR(20) NOT NULL,
    jbgz INT NULL,
    yxh CHAR(2) NOT NULL,
    PRIMARY KEY (Gh),
    FOREIGN KEY (yxh) REFERENCES D(Yxh)
);
CREATE TABLE C(
    kh CHAR(8) NOT NULL,
    km CHAR(20) NOT NULL,
    xf INT NOT NULL,
    xs INT NOT NULL,
    yxh CHAR(2) NOT NULL,
    PRIMARY KEY (kh),
    FOREIGN KEY (yxh) REFERENCES D(Yxh)
);
CREATE TABLE O (
    xq CHAR(6) NOT NULL,
    kh CHAR(8) NOT NULL,
    gh CHAR(4) NOT NULL,
    sksj CHAR(20) NOT NULL,
    PRIMARY KEY (xq, kh, gh),
    FOREIGN KEY (kh) REFERENCES C(kh),
    FOREIGN KEY (gh) REFERENCES T(gh)
);
CREATE TABLE E (
    Xh char(4) NOT NULL,
    xq CHAR(6) NOT NULL,
    kh CHAR(8) NOT NULL,
    gh CHAR(4) NOT NULL,
    pscj INT CHECK(
        pscj BETWEEN 1 AND 100
    ) NULL,
    kscj INT CHECK(
        kscj BETWEEN 1 AND 100
    ) NULL,
    zpcj INT CHECK(
        zpcj BETWEEN 1 AND 100
    ) NULL,
    PRIMARY KEY (Xh, xq, kh, gh),
    FOREIGN KEY (gh) REFERENCES T(Gh),
    FOREIGN KEY (kh) REFERENCES C(kh),
    FOREIGN KEY (Xh) REFERENCES S(Xh)
);
SELECT xh,
    xm
FROM s
WHERE csrq < "1991-01-01"
    AND xb = "男";
SELECT DISTINCT kh
FROM c
WHERE kh NOT IN (
        SELECT kh
        FROM e
        WHERE xh IN (
                SELECT xh
                FROM s
                WHERE xm = "刘晓明"
            )
    );
SELECT xq,
    kh,
    sksj
FROM o
WHERE gh IN(
        SELECT gh
        FROM t
        WHERE xm = "马小红"
    );
SELECT c.kh,
    c.km,
    t.xm
FROM c,
    o,
    t,
    e,
    s,
    d
WHERE e.zpcj >= 60
    AND t.zc = "教授"
    AND c.kh = e.kh
    AND e.kh = o.kh
    AND s.xb = "男"
    and t.gh = o.gh
    AND d.mc = "计算机学院"
    AND s.yxh = d.yxh
    AND e.xh = s.xh
ORDER BY t.xm ASc,
    c.kh desc;
SELECT DISTINCT s1.xh,
    s1.xm
FROM s AS s1,
    s AS s2
WHERE s1.xh > s2.xh
    AND s1.csrq > s2.csrq
    AND s2.xm = "张颖";
SELECT DISTINCT s.xm,
    s.xh
FROM s,
    e AS e1,
    e AS e2
WHERE e1.xh = e2.xh
    AND s.xh = e1.xh
    and e1.kh = "08305001"
    and e2.kh = "08305002";
SELECT s.xm,
    s.xh,
    e.kh,
    e.xq
FROM s
    LEFT OUTER JOIN e ON e.xh = s.xh;
SELECT xh,
    xm
FROM s
WHERE NOT EXISTS (
        SELECT *
        FROM c
        WHERE NOT EXISTS (
                SELECT *
                FROM e
                WHERE xh = s.xh
                    AND kh = c.kh
            )
    );
SELECT DISTINCT xh,
    xm
FROM s
WHERE NOT EXISTS(
        SELECT *
        FROM e AS e1
        WHERE e1.xh = 1106
            AND NOT EXISTS(
                SELECT *
                FROM e AS e2
                WHERE e2.xh = s.xh
                    AND e1.kh = e2.kh
                    AND s.xh != 1106
            )
    );
SELECT s.xm,
    s.xh,
    c.km,
    e.zpcj
FROM s,
    c,
    e
WHERE s.xh = e.xh
    AND e.kh = c.kh
    AND e.zpcj =(
        SELECT MAX(zpcj)
        FROM e AS e1
        WHERE e1.kh = e.kh
            AND e1.zpcj != 0
    );
SELECT a.xh,
    a.xm,
    avg(zpcj) AS 平均成绩,
    DATEDIFF("2021-12-21", csrq) / 365 AS 年龄
FROM s,
    e AS e3,
    (
        SELECT s1.xh,
            s1.xm
        FROM (
                SELECT xh,
                    xm,
                    yxh,
                    DATEDIFF("2021-12-21", csrq) / 365 AS 年龄
                FROM s
            ) AS s1,
            (
                SELECT yxh,
                    avg(DATEDIFF("2021-12-21", csrq) / 365) AS 平均年龄
                FROM s
                GROUP BY yxh
            ) AS s2
        WHERE s1.yxh = s2.yxh
            AND s1.年龄 <= s2.平均年龄
    ) AS a,
    (
        SELECT s3.xh,
            xm,
            e2.kh
        FROM (
                SELECT kh,
                    avg(zpcj) AS 平均成绩
                FROM e
                GROUP BY kh
            ) AS e1,
            e AS e2,
            s AS s3
        WHERE e1.kh = e2.kh
            AND e2.xh = s3.xh
            AND e2.zpcj >= 平均成绩
            AND e2.zpcj != 0
    ) AS b
WHERE a.xh = b.xh
    AND a.xh = e3.xh
    AND s.xh = a.xh
GROUP BY a.xh,
    a.xm,
    DATEDIFF("2021-12-21", csrq) / 365
ORDER BY 年龄;