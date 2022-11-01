-- 기초반 웹사이트 유입 채널별 view / scroll / click 세션 수와 view → scroll / scroll → click / view → click 전환율 출력하기 
# source & medium 정보는 page_location 컬럼 내에서 추출
# 각 이벤트 간의 선후관계를 고려하고, 동시에 일어난 이벤트도 전환 카운팅에 포함
# view → click 전환율을 기준으로 내림차순 정렬하나, 전환율이 동일할 경우 view 세션 수를 기준으로 내림차순 정렬

WITH page_view AS (
SELECT user_id
     , session_id
     , event_timestamp
     , page_location
FROM ga_report
WHERE page_title LIKE '%기초반' AND event_name = 'view'
), page_scroll AS (
SELECT user_id
     , session_id
     , event_timestamp
     , page_location
FROM ga_report
WHERE page_title LIKE '%기초반' AND event_name = 'scroll'
), page_click AS (
SELECT user_id
     , session_id
     , event_timestamp
     , page_location
FROM ga_report
WHERE page_title LIKE '%기초반' AND event_name LIKE 'click%'
)

SELECT CASE WHEN page_view.page_location LIKE '%source%' THEN SUBSTRING_INDEX(SUBSTRING_INDEX(page_view.page_location, '&', 1), '=', -1) ELSE '(direct)' END AS source
     , CASE WHEN page_view.page_location LIKE '%medium%' THEN SUBSTRING_INDEX(SUBSTRING_INDEX(page_view.page_location, '&', 2), '=', -1) ELSE '(none)' END AS medium
     , COUNT(DISTINCT page_view.user_id, page_view.session_id) AS view_session_cnt
     , COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id) AS scroll_session_cnt
     , COUNT(DISTINCT page_click.user_id, page_click.session_id) AS click_session_cnt
     , ROUND(COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id) * 100
     / COUNT(DISTINCT page_view.user_id, page_view.session_id), 2) AS view_scroll_rate
     , ROUND(COUNT(DISTINCT page_click.user_id, page_click.session_id) * 100
     / COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id), 2) AS scroll_click_rate
     , ROUND(COUNT(DISTINCT page_click.user_id, page_click.session_id) * 100
     / COUNT(DISTINCT page_view.user_id, page_view.session_id), 2) AS view_click_rate
FROM page_view 
LEFT JOIN page_scroll ON page_view.user_id = page_scroll.user_id
                     AND page_view.session_id = page_scroll.session_id
                     AND page_view.event_timestamp <= page_scroll.event_timestamp
LEFT JOIN page_click ON page_scroll.user_id = page_click.user_id
                    AND page_scroll.session_id = page_click.session_id
                    AND page_scroll.event_timestamp <= page_click.event_timestamp
GROUP BY 1, 2
ORDER BY view_click_rate DESC, view_session_cnt DESC;
