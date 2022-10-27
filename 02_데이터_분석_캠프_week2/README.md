####
## 02. 데이터 분석 캠프 week2
#### ► [01_classic_retention_221014]
- 성공적인 사업 구축에 필요한 5가지 요소인 AARRR 또는 해적 지표(Pirate Metrics) 이론 학습
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
#### 1. Growth hacking
- Cross-functional한 조직에서 데이터를 기반으로 정의한 핵심 지표를 중심으로 실험의 반복을 통해 제품 및 서비스를 성장시키는 것
- 제품 및 서비스를 성장시키기 위해 데이터 정의부터 환경 구축, 수집, 집계, 분석, 실험 등을 진행하는 전반적인 과정을 포괄하는 용어
#### 2. AARRR
- 사용자의 lifecycle을 기반으로 stage를 구분해 핵심 지표를 효율적으로 분석하고 관리하는 Growth hacking의 대표 프레임워크 
- A(Acquisition): 사용자 획득 → 사용자를 서비스로 데려오는 것
- A(Activation): 사용자 활성화 → Acquisition으로 데려온 사용자가 서비스의 핵심 가치를 경험했는가? 
- R(Retention): 사용자 유지 → Activation 과정으로 경험한 서비스의 핵심 가치를 꾸준히 경험하도록 하는 것
- R(Revenue): 매출 → 서비스가 매출로 돌아오는가?
- R(Referral): 전파 → 기존 사용자의 추천 및 입소문을 통해 사용자가 확대되었는가?
#### 3-1. Retention
- 서비스의 성공을 예측할 수 있는 가장 중요한 지표 중 하나 / 비용대비 개선 효과가 크고, 복리 효과로 매출 성장에 기여
- Retention을 분석하는 대표적인 방법은 측정 기준에 따라 Classic retiention / Rolling retention / Range retention로 구분
#### 3-2. Classic retiention / Rolling retention / Range retention
- Classic retiention / Day-N retiention: 특정 일자에 서비스로 재방문한 사용자의 비율 계산
- Rolling retention / Unbounded retention: 특정 기간에 서비스로 재방문한 사용자의 비율 계산
- Range retention / Bracket retention: 사용자 중, 어느 정도 인원이 서비스를 이탈했는가에 초점을 맞춘 계산
#### 3-3. Cohort analysis / Retiention chart & Retiention curve
- Cohort analysis: 가입 시기별 등, 특정 기간에 공통된 특성이나 경험을 갖는 동질 사용자를 그룹으로 나누어 분석하는 하는 것
- Retiention chart & Retiention curve: Cohort analysis를 Retention analysis에 응용해 사용자 Retiention 변화를 측정하는 것
#### 3-4. DAU / WAU / MAU / Stickiness
- DAU(Daily Active User): 일별 활성 사용자 수
- WAU(Weekly Active User): 주별 활성 사용자 수
- MAU(Monthly Active User): 월별 활성 사용자 수
- Stickiness : 사용자 고착도

#### Reference
- [Inflearn] [그로스해킹 - 데이터와 실험을 통해 성장하는 서비스를 만드는 방법](https://www.inflearn.com/course/%EA%B7%B8%EB%A1%9C%EC%8A%A4%ED%95%B4%ED%82%B9-%EB%8D%B0%EC%9D%B4%ED%84%B0-%EC%8B%A4%ED%97%98-%EC%84%B1%EC%9E%A5-%EC%84%9C%EB%B9%84%EC%8A%A4/)  
- [datarian] [datarian 데이터 분석 블로그](https://www.datarian.io/blog)
- [brunch] [Cross-functional이란?](https://brunch.co.kr/@youngstone89/6)
