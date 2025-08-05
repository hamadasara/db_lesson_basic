-------------------------- DB練習問題 ---------------------
-- Q1 新しいテーブルを追加する
CREATE TABLE departments (
    department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Q2 peopleテーブルに新しいカラムを追加
ALTER TABLE people
ADD COLUMN dapartment_id INT UNSIGNED NULL AFTER email;

-- Q3 レコードを追加していく
-- 1,departmentsテーブルに部門レコードを追加
INSERT INTO departments (name) VALUES
('私'),
('開発'),
('経理'),
('人事'),
('情報システム');

-- 2 peopleテーブルに10人分のレコードを追加
INSERT INTO people (name, email, department_id, age, gender)
VALUES
-- 営業３人
('青木りく', 'aoki@gizumo.jp', 1, 28, 1),
('斉藤さやか', 'saitou@gizumo.jp', 1, 26, 2),
('石田たくみ', 'ishida@gizumo.jp', 1, 30, 1),
-- 開発4人
('山田ひろし', 'yamada@gizumo.jp', 2, 28, 1),
('高橋みつき', 'takahashi@gizumo.jp', 2, 26, 2),
('上田ゆうき', 'ueda@gizumo.jp', 2, 34, 1),
('森田れい', 'morita@gizumo.jp', 2, 35, 1),
-- 経理、人事、情報システム各1人
('佐藤なぎさ', 'satou@gizumo.jp', 3, 31, 2),
('守屋さやか', 'moriya@gizumo.jp', 4, 26, 2),
('渡邉かな', 'watanabe@gizumo.jp', 5, 28, 2);

-- 3 日報（reports）追加クエリ（10件、person_idは存在するIDを使う）
INSERT INTO reports (person_id, content)
VALUES
(17, 'クライアントと打ち合わせをしました。'),
(18, '営業資料を作成しました。'),
(19, '月売り上げを確認しました。'),
(20, '機能改善のコードレビューを行いました。'),
(21, 'バグの修正を行いました。'),
(22, 'API集計のレビューを行いました。'),
(23, 'フィードバック対応を行いました。'),
(24, 'プロジェクトの進捗報告をしました。'),
(25, '経費精算処理を行いました。'),
(26, '新卒採用の書類選考を行いました。');


-- 4 department_idがNULLのデータを埋めるクエリ
UPDATE people
SET department_id = 1
WHERE name = '鈴木たかし';

UPDATE people
SET department_id = 2
WHERE name = '田中ゆうこ';

UPDATE people
SET department_id = 3
WHERE name = '福田だいすけ';

UPDATE people
SET department_id = 4
WHERE name = '豊島はなこ';

UPDATE people
SET department_id = 5
WHERE name = '早坂てつお';

UPDATE people
SET department_id = 1
WHERE name = '不可思議みちこ';

-- 5 年齢の降順で男性の名前と年齢を取得する
SELECT name, age
FROM people
WHERE gender = 1
ORDER BY age DESC;

-- テーブル・レコード・カラムという3つの単語を適切に使用して、
-- 下記のSQL文を日本語で説明してください。
SELECT
`name`, `email`, `age`
FROM
`people`
WHERE
`department_id` = 1
ORDER BY
`created_at`;
-- peopleテーブルから男性(gender=1)のレコードを探し、
-- その中のname, email, ageの３つのカラムの情報だけを取得。
-- さらに、カラムの値(created_at)が古い順に並べて表示する。

-- 7 20代の女性と40代の男性の名前一覧を所得
SELECT name
FROM people
WHERE
(gender = 2 AND age BETWEEN 20 AND 29)
OR
(gender = 1 AND age BETWEEN 40 AND 49);

-- 8 営業部に所属する人だけの年齢の昇順で取得する
SELECT *
FEOM people
WHERE
department_id = 1
ORDER BY age ASC;

-- 9 開発部に所属している女性の平均年齢を取得する
SELECT AVG(age) AS average_age
FROM people
WHERE department_id = 2 AND gender = 2;

-- 10 名前と部署名とその人が提出した日報に内容を同時に取得する
-- （日報を提出してない人は含めない）
SELECT
people.name,
departments.name AS department_name,
reports.content
FROM
people
INNER JOIN
departments
ON people.department_id = departments.department_id
INNER JOIN
reports
ON
people.person_id = reports.person_id;

-- 11 日報を一つも提出していない人の名前の一覧を取得する
SELECT
people.name
FROM
people
LEFT JOIN
reports
ON
people.person_id = reports.person_id
WHERE
reports.person_id IS NULL;

