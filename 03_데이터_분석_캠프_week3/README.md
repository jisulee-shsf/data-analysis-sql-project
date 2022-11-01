####
## 03. 데이터 분석 캠프 week3
#### ► [01_funnel_analysis_01_221021 / 02_funnel_analysis_02_221021]
- 퍼널 분석(Funnel Analysis) ・ UTM(Urchin Tracking Module) ・ 세션(Session) 관련 이론 학습
- SQL을 활용한 세션별 퍼널 전환율(Conversion Rate) 계산 실습
##
#### 퍼널 분석(Funnel Analysis)
- 사용자가 설계된 사용자 경험 루트에 유입된 후, 최종 목적지까지 잘 도착했는지 주요 단계별로 나누어 살펴보는 사용자 분석 방법
- 각 단계별로 사용자 수가 줄어드는 깔때기(Funnel) 모양을 본떠 퍼널 분석이라 지칭
- 사용자가 각 단계를 넘어가는 것을 전환(Conversion), 그 비율을 전환율(Conversion Rate)이라 지칭
#### UTM(Urchin Tracking Module) 
- 온라인 마케팅 캠페인을 효과적으로 추적하기 위해 사용하는 유입 경로를 표시해주는 5가지의 URL 매개 변수
- utm_source / utm_medium / utm_campaign / utm_term / utm_content 구성
#### 세션(Session)
- 사용자가 지정된 기간 내에 사이트에서 취한 페이지 조회 / 이벤트 / 전자상거래 등의 행동 집합
- 사용자의 행동이 어떠한 사유로 진행된 것인지 특정하기 위해 연속된 활동을 세션 단위로 묶어 분석 진행
<img src="https://user-images.githubusercontent.com/109773795/198859313-4ce1f4da-fce8-455c-9bc7-11baec7a812a.png" width="750" height="230"/>
<img src="https://user-images.githubusercontent.com/109773795/198901487-8f8fae97-57a2-4b67-942a-09764900777a.png" width="750" height="360"/>

#### Reference 
- [datarian 데이터 분석 블로그](https://www.datarian.io/blog)
- [Google Analytics - 맞춤 URL을 사용해 캠페인 데이터 수집하기](https://support.google.com/analytics/answer/1033863?hl=ko#zippy=%2C%EC%9D%B4-%EB%8F%84%EC%9B%80%EB%A7%90%EC%97%90-%EB%82%98%EC%99%80-%EC%9E%88%EB%8A%94-%EB%82%B4%EC%9A%A9%EC%9D%80-%EB%8B%A4%EC%9D%8C%EA%B3%BC-%EA%B0%99%EC%8A%B5%EB%8B%88%EB%8B%A4)
- [Google Analytics - 유니버설 애널리틱스에서 웹 세션을 정의하는 방법](https://support.google.com/analytics/answer/2731565?hl=ko#zippy=%2C%EC%9D%B4-%EB%8F%84%EC%9B%80%EB%A7%90%EC%97%90-%EB%82%98%EC%99%80-%EC%9E%88%EB%8A%94-%EB%82%B4%EC%9A%A9%EC%9D%80-%EB%8B%A4%EC%9D%8C%EA%B3%BC-%EA%B0%99%EC%8A%B5%EB%8B%88%EB%8B%A4)
##
#### Funnel Analysis - view → scroll
``` SQL
SELECT COUNT(DISTINCT page_view.user_id, page_view.session_id) AS view_session_cnt
     , COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id) AS scroll_session_cnt
     , COUNT(DISTINCT page_scroll.user_id, page_scroll.session_id) 
       / COUNT(DISTINCT page_view.user_id, page_view.session_id) AS view_scroll_rate
FROM page_view
LEFT JOIN page_scroll ON page_view.user_id = page_scroll.user_id
                     AND page_view.session_id = page_scroll.session_id
                     AND page_view.event_timestamp <= page_scroll.event_timestamp;
```
|view_session_cnt|scroll_session_cnt|view_scroll_rate|
|:---:|:---:|:---:|
|1135|309|0.2722|
#### Funnel Analysis - view → scroll → click
``` SQL
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
```
|view_session_cnt|scroll_session_cnt|click_session_cnt|view_scroll_rate|scroll_click_rate|view_click_rate|
|:---:|:---:|:---:|:---:|:---:|:---:|
|1135|309|38|0.2722|0.123|0.0335|
####
