use mywork;
SELECT * FROM wine_list;

SELECT Name FROM world.country ORDER BY Name;

SELECT *
FROM wine_list a
INNER JOIN world.country b
ON a.country = b.name
ORDER BY country;

SELECT * -- left join
FROM mywork.wine_list
LEFT JOIN world.country ON mywork.wine_list.country = world.country.name;

-- WHERE a.country = "Argentina";

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

UPDATE mywork.wine_list
  SET country = 'New Zealand'
  WHERE country = 'NewZealand';
UPDATE mywork.wine_list
  SET country = 'United States'
  WHERE country = 'UnitedStates';
UPDATE mywork.wine_list
  SET country = 'South Africa'
  WHERE country = 'SouthAfrica';
  
UPDATE mywork.wine_list
SET wine_vintage = NULL
WHERE wine_vintage = 0;
  
CREATE TABLE wine_with_C (
SELECT world.country.Continent, mywork.wine_list.*
	FROM mywork.wine_list
	LEFT JOIN world.country ON mywork.wine_list.country = world.country.name
  WHERE mywork.wine_list.country = world.country.Name);

SELECT * FROM wine_with_C;

-- 1.평점 상위 n개
SELECT DISTINCT wine_name, wine_rate FROM wine_with_C
ORDER BY wine_rate DESC
LIMIT 10; -- 10개

-- 2.평점 별 평가자 많은 순으로 정렬 (order by 두 개)
SELECT DISTINCT wine_name, wine_rate, rating_num
FROM wine_with_C
ORDER BY 2 DESC, 3 DESC
LIMIT 20;

-- 4.국가별 평균 평점
SELECT country, round(avg(wine_rate),2) '평균 평점' FROM wine_with_C GROUP BY country;

-- 5.국가별로 최빈 테이스팅 노트
SELECT country, tasty_note, max(tasty_num)
FROM wine_with_C
GROUP BY 1
ORDER BY 1;

-- 6. 품종별 최빈 테이스팅 노트
SELECT variety, tasty_note, max(tasty_num)
FROM wine_with_C
GROUP BY 1
ORDER BY 1;

-- 6.레드 / 화이트 -> 0 / 1 로 값 바꿔보기 (값 변경을 연습해보는 것에 의의)



-- 7.국가 / 품종별로 레드/화이트 와인의 비율 따져보기
SELECT * FROM 
(
SELECT category, count(category) FROM wine_with_C GROUP BY category
) as a 
GROUP BY a.country;
SELECT * FROM wine_with_C;
-- 8.품종별 평균 가격
SELECT variety, round(avg(cost),0) FROM wine_with_C GROUP BY variety ORDER BY 2 DESC;
-- 9.평가자 가장 많고 별점도 제일 높은(최고 평가) / 평가자 가장 적고 별점 가장 높은 / 평가자 가장 적고 별점 제일 낮은 / 평가자 가장 많고 별점 가장 낮은(최저 평가) : 총 4가지 와인 찾아보기


-- 10.와인이 가장 많은 빈티지 (=와인이 가장 많이 생산된 년도)
SELECT wine_vintage, count(wine_vintage) FROM wine_with_C GROUP BY wine_vintage;

