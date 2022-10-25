####
## 01. 데이터 분석 캠프 week1
#### ► [01_where_nested_subquery_221007]
- 연습 문제 풀이(한 달간 고객별 첫 주문 및 마지막 주문 일자 / 주문 일자별 배송 일자에 따른 성공 및 실패 케이스 수 출력)
- Nested SubQuery인 WHERE절의 단일행 ・ 다중행 ・ 다중 컬럼 서브쿼리 출력 실습 
####
- ✔︎ 첫 주문 및 마지막 주문 일자 출력- timestamp의 MIN & MAX 함수를 통해, 첫 일자 & 마지막 일자 출력이 가능함을 확인
- ✔︎ 성공 및 실패 케이스 수 출력 - COUNT 함수 내에 CASE문을 포함하여 조건이 성립될 경우 카운팅 출력이 가능함을 확인
- ✔︎ 단일행 서브쿼리 - 비교 연산자와 1개의 데이터 값이 서브쿼리의 결괏값인 쿼리문 작성
- ✔︎ 다중행 서브쿼리 - 주요 연산자 IN과 다수의 값을 가진 1개의 컬럼이 서브쿼리의 결괏값인 쿼리문 작성
- ✔︎ 다중 컬럼 서브쿼리 - 주요 연산자 IN과 다수의 값을 가진 n개의 컬럼이 서브쿼리의 결괏값인 쿼리문 작성
#### ► [02_from_inline_view_subquery_221007]
- Inline View SubQuery인 FROM절의 서브쿼리를 WITH 구문 사용 여부에 따라 출력 실습
####
- ✔︎ WITH 구문의 경우, 다소 복잡한 FROM절의 서브쿼리를 임시 테이블로 설정해 쿼리의 가독성을 높이고 재사용의 장점을 가짐
- ✔︎ WITH 구문으로 생성된 임시 테이블은 기존 테이블과 동일하게 JOIN 등의 다양한 구문 적용 가능
#### ► [03_select_scala_subquery_221007]
- Scala SubQuery인 SELECT절의 서브쿼리를 WHERE 조건식 여부에 따라 출력 실습
####
- ✔︎ SELECT절 서브퀴리의 결괏값은 1개의 데이터 값만 출력 가능하므로, GROUP BY의 기준 컬럼과 집계 함수를 출력할 수 없음
- ✔︎ SELECT절 서브퀴리에 묶음 기준 컬럼과 집계 함수 출력이 함께 필요한 경우, WHERE 조건으로 연결해 출력 가능함
##
####  WITH
``` SQL
WITH alias_name1 AS (
...
) alias_nameN AS (
...
);

SELECT * FROM alias_nameN;
```
<br/><br/>
## 💁🏻‍♀️ Studying in advance
#### 1. 그로스 해킹(Growth Hacking)
- Cross-functional한 조직에서 데이터를 기반으로 정의한 핵심 지표를 중심으로 실험의 반복을 통해 제품 및 서비스를 성장시키는 것
- 제품 및 서비스를 성장시키기 위해 데이터 정의부터 환경 구축, 수집, 집계, 분석, 실험 등을 진행하는 전반적인 과정을 포괄하는 용어
- 그로스 해킹을 하기 위한 중요한 4가지 요소는 지표, 분석 환경, 프로세스, 문화로 구성됨
#### 2. AARRR
- 사용자의 lifecycle을 기반으로 stage를 구분해 핵심 지표를 효율적으로 분석하고 관리하는 그로스 해킹(Growth Hacking)의 대표 프레임워크 
- A(Acquisition): 사용자 획득 → 사용자를 서비스로 데려오는 것
- A(Activation): 사용자 활성화 → Acquisition으로 데려온 사용자가 서비스의 핵심 가치를 경험했는가? 
- R(Retention): 사용자 유지 → Activation 과정으로 경험한 서비스의 핵심 가치를 꾸준히 경험하도록 하는 것
- R(Revenue): 매출 → 서비스가 매출로 돌아오는가?
- R(Referral): 전파 → 기존 사용자의 추천 및 입소문을 통해 사용자가 확대되었는가?

#### 3-1. Retention
- 서비스의 성공을 예측할 수 있는 가장 중요한 지표 중 하나이며, 사용자가 서비스의 핵심 가치를 꾸준히 경험하며 지속적으로 재사용하는 비율
- Retention을 측정하는 대표적인 방법: Classic Retiention / Rolling Retention / Range Retention
#### 3-2. Classic Retiention / Rolling Retention / Range Retention / Retiention Chart & Retiention Curve
- Classic Retiention / Day-N Retiention: 특정 일자에 서비스로 재방문한 사용자의 비율 계산
- Rolling Retention / Unbounded Retention: 특정 기간에 서비스로 재방문한 사용자의 비율 계산
- Range Retention / Bracket Retention: 사용자 중, 어느 정도 인원이 서비스를 이탈했는가에 초점을 맞춘 계산
- Retiention Chart & Retiention Curve: 사용자의 Retiention 변화 측정 방법
#### 3-3. DAU / WAU / MAU / Stickiness
- DAU(Daily Active User): 일별 활성 사용자 수
- WAU(Weekly Active User): 주별 활성 사용자 수
- MAU(Monthly Active User): 월별 활성 사용자 수
- Stickiness : 사용자 고착도

#### Reference
- [Inflearn] [그로스해킹 - 데이터와 실험을 통해 성장하는 서비스를 만드는 방법](https://www.inflearn.com/course/%EA%B7%B8%EB%A1%9C%EC%8A%A4%ED%95%B4%ED%82%B9-%EB%8D%B0%EC%9D%B4%ED%84%B0-%EC%8B%A4%ED%97%98-%EC%84%B1%EC%9E%A5-%EC%84%9C%EB%B9%84%EC%8A%A4/)  
- [datarian] [datarian 데이터 분석 블로그](https://www.datarian.io/blog)
- [brunch] [Cross-functional이란?](https://brunch.co.kr/@youngstone89/6)
