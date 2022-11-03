-- 1. user_id 8번의 행동로그 추출하기
SELECT user_id
     , event_type
     , event_name
     , occurred_at
     , occurred_at - LAG(occurred_at, 1) OVER (ORDER BY occurred_at) AS last_event
     , LEAD(occurred_at, 1) OVER (ORDER BY occurred_at) - occurred_at AS next_event
     , ROW_NUMBER() OVER () AS id
FROM tutorial.yammer_events
WHERE event_type = 'engagement' 
  AND user_id = 8
ORDER BY occurred_at;

-- 2. session 정의하기
SELECT inline_view_subquery1.*
     , CASE WHEN last_event IS NULL THEN id 
            WHEN last_event >= INTERVAL '10 MINUTES' THEN id
            ELSE LAG(id, 1) OVER (ORDER BY id) END AS session
FROM (
     SELECT user_id
          , event_type
          , event_name
          , occurred_at
          , occurred_at - LAG(occurred_at, 1) OVER (ORDER BY occurred_at) AS last_event
          , LEAD(occurred_at, 1) OVER (ORDER BY occurred_at) - occurred_at AS next_event
          , ROW_NUMBER() OVER () AS id
     FROM tutorial.yammer_events
     WHERE event_type = 'engagement' 
       AND user_id = 8
     ORDER BY occurred_at) inline_view_subquery1
WHERE last_event IS NULL 
   OR last_event >= INTERVAL '10 MINUTES'
   OR next_event IS NULL 
   OR next_event >= INTERVAL '10 MINUTES';
   
-- 3. session에 따른 시작 / 종료 시간 출력하기
SELECT user_id
     , session
     , MIN(occurred_at) as session_start
     , MAX(occurred_at) as session_end
FROM (    
     SELECT inline_view_subquery1.*
          , CASE WHEN last_event IS NULL THEN id 
                 WHEN last_event >= INTERVAL '10 MINUTES' THEN id
                 ELSE LAG(id, 1) OVER (ORDER BY id) END AS session
     FROM (
          SELECT user_id
               , event_type
               , event_name
               , occurred_at
               , occurred_at - LAG(occurred_at, 1) OVER (ORDER BY occurred_at) AS last_event
               , LEAD(occurred_at, 1) OVER (ORDER BY occurred_at) - occurred_at AS next_event
               , ROW_NUMBER() OVER () AS id
          FROM tutorial.yammer_events
          WHERE event_type = 'engagement' 
           AND user_id = 8
          ORDER BY occurred_at) inline_view_subquery1
     WHERE last_event IS NULL 
        OR last_event >= INTERVAL '10 MINUTES'
        OR next_event IS NULL 
        OR next_event >= INTERVAL '10 MINUTES') inline_view_subquery2
GROUP BY 1, 2;