-- 1. 실전반 페이지를 본 세션 수 출력하기
SELECT COUNT(DISTINCT user_id, session_id)
FROM ga_report
WHERE page_title LIKE '%실전반' 
AND event_name = 'view';

-- 2. 실전반 페이지를 본 후, 스크롤한 세션 수와 전환율 출력하기
WITH page_view AS (
SELECT user_id, session_id, event_timestamp
FROM ga_report
WHERE page_title LIKE '%실전반' AND event_name = 'view'
), page_scroll AS (
SELECT user_id, session_id, event_timestamp
FROM ga_report
WHERE page_title LIKE '%실전반' AND event_name = 'scroll')
        
SELECT COUNT(DISTINCT page_view.user_id, page_view.session_id) AS view_session_cnt
     , COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id) AS scroll_session_cnt
     , COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id) 
     / COUNT(DISTINCT page_view.user_id, page_view.session_id) AS view_scroll_rate
FROM page_view
LEFT JOIN page_scroll ON page_view.user_id = page_scroll.user_id
                     AND page_view.session_id = page_scroll.session_id
                     AND page_view.event_timestamp <= page_scroll.event_timestamp;
                 
-- 3. 실전반 페이지를 본 후, 스크롤 뒤 클릭한 각 세션 수와 전환율 출력하기
WITH page_view AS (
SELECT user_id, session_id, event_timestamp
FROM ga_report 
WHERE page_title LIKE '%실전반' AND event_name = 'view'
), page_scroll AS (
SELECT user_id, session_id, event_timestamp
FROM ga_report
WHERE page_title LIKE '%실전반' AND event_name = 'scroll'
), page_click AS (
SELECT user_id, session_id, event_timestamp
FROM ga_report
WHERE page_title LIKE '%실전반' AND event_name LIKE '%click')
                     
SELECT COUNT(DISTINCT page_view.user_id, page_view.session_id) AS view_session_cnt
     , COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id) AS scroll_session_cnt
     , COUNT(DISTINCT page_click.user_id, page_click.session_id) AS click_session_cnt
     , COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id)
     / COUNT(DISTINCT page_view.user_id, page_view.session_id) AS view_scroll_rate
     , COUNT(DISTINCT page_click.user_id, page_click.session_id) 
     / COUNT(DISTINCT page_scroll.user_id, page_scroll.session_idon_id) AS scroll_click_rate
     , COUNT(DISTINCT page_click.user_id, page_click.session_id) 
     / COUNT(DISTINCT page_view.user_id, page_view.session_id) AS view_click_rate
FROM page_view
LEFT JOIN page_scroll ON page_view.user_id = page_scroll.user_id
                     AND page_view.session_id = page_scroll.session_id
                     AND page_view.event_timestamp <= page_scroll.event_timestamp
LEFT JOIN page_click ON page_scroll.user_pseudo_id = page_click.user_pseudo_id
		            AND page_scroll.session_id = page_click.session_id
		            AND page_scroll.event_timestamp <= page_click.event_timestamp;