####
## 02. 데이터 분석 캠프 week2
#### ► [01_classic_retention_221014]
- 성공적인 사업 구축에 필요한 5가지 요소인 AARRR 및 Cohort 
####
- ✔︎  
``` SQL
test
```
|test|test|test|test|test|
|:---:|:---:|:---:|:---:|:---:|
|test|test|test|test|test|
|test|test|test|test|test|
##
#### ► [02_rolling_retention_221014]
- 
####
- ✔︎  
``` SQL
test
```
|test|test|test|test|test|
|:---:|:---:|:---:|:---:|:---:|
|test|test|test|test|test|
|test|test|test|test|test|

<br/><br/>
## 💁🏻‍♀️ TIL
#### 1. 그로스 해킹(Growth Hacking)
- Cross-functional한 조직에서 데이터를 기반으로 정의한 핵심 지표를 중심으로 실험의 반복을 통해 제품 및 서비스를 성장시키는 것
- 제품 및 서비스를 성장시키기 위해 데이터 정의부터 환경 구축, 수집, 집계, 분석, 실험 등을 진행하는 전반적인 과정을 포괄하는 용어
#### 2. AARRR / 해적 지표(Pirate Metrics)
- 사용자의 lifecycle을 기반으로 stage를 구분해 핵심 지표를 효율적으로 분석하고 관리하는 그로스 해킹(Growth Hacking)의 대표 프레임워크 
- A(Acquisition) - 사용자 획득 → 사용자를 서비스로 데려오는 것
- A(Activation) - 사용자 활성화 → Acquisition으로 데려온 사용자가 서비스의 핵심 가치를 경험했는가? 
- R(Retention) - 사용자 유지 → Activation 과정으로 경험한 서비스의 핵심 가치를 꾸준히 경험하도록 하는 것
- R(Revenue) - 매출 → 서비스가 매출로 돌아오는가?
- R(Referral) - 전파 / 추천 → 기존 사용자의 추천 및 입소문을 통해 사용자가 확대되었는가?
#### 3-1. 클래식 리텐션(Classic Retiention) / 롤링 리텐션(Rolling Retention) / 범위 리텐션(Range Retention)
- 제품 서비스의 성공을 예측할 수 있는 가장 중요한 지표 중 하나인 리텐션을 분석하는 대표적인 방법 
- 클래식 리텐션(Classic / N-Day Retiention) - 최초 사용일로부터 N일 후에 서비스로 재방문한 사용자 비율 계산
- 롤링 리텐션(Rolling / Unbounded Retention) - 특정 일자를 포함해 그 이후 한 번이라도 서비스에 재방문한 사용자 비율 계산
- 범위 리텐션(Range / Bracket Retention) - 설정한 범위 기간 내에 서비스에 재방문한 사용자 비율 계산
#### 3-2. 코호트 분석(Cohort Analysis) / 리텐션 차트(Retiention Chart)
- 코호트 분석(Cohort Analysis) - 가입 시기별 등, 특정 기간에 공통된 특성이나 경험을 갖는 동질 사용자를 그룹으로 나누어 분석하는 것
- 리텐션 차트(Retiention Chart) - 코호트 분석(Cohort Analysis)을 리텐션 분석에 응용해 사용자의 리텐션 변화를 측정하는 것
#### 3-3. DAU / WAU / MAU / Stickiness
- DAU(Daily Active User) - 일별 활성 사용자 수
- WAU(Weekly Active User) - 주별 활성 사용자 수
- MAU(Monthly Active User) - 월별 활성 사용자 수
- Stickiness - 사용자 고착도

#### Reference
- [그로스해킹 - 데이터와 실험을 통해 성장하는 서비스를 만드는 방법](https://www.inflearn.com/course/%EA%B7%B8%EB%A1%9C%EC%8A%A4%ED%95%B4%ED%82%B9-%EB%8D%B0%EC%9D%B4%ED%84%B0-%EC%8B%A4%ED%97%98-%EC%84%B1%EC%9E%A5-%EC%84%9C%EB%B9%84%EC%8A%A4/)  
- [datarian 데이터 분석 블로그](https://www.datarian.io/blog)
- [리텐션을 측정하는 세 가지 방법](https://blog.ab180.co/posts/retention-series-3-1)
- [Cross-functional이란?](https://brunch.co.kr/@youngstone89/6)
