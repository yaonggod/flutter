# Session vs Token

## Session

유저의 정보를 데이터베이스에 저장하고 상태를 유지하는 도구

특징

- 특수한 ID값으로 구성
- 서버에서 생성, 클라이언트에서 쿠키를 통해 저장
- 클라이언트에서 요청 + Session ID 전송 -> 서버에서 사용자 식별 가능
- Session ID는 데이터베이스에 있으므로 요청이 있을때마다 데이터베이스 확인 필요
- 클라이언트에 사용자 정보가 노출될 위험이 없음
- Horizontal Scaling(수평적으로 서버를 늘려서 분산)이 어려움 - 중복 저장

세션 생성

![session](/assets/session.png)

세션 사용

![session2](/assets/session2.png)

## Token

유저의 정보를 Base 64로 인코딩된 String 값에 저장하는 도구

- Header, Payload, Signature로 구성되어 있으며 Base 64로 인코딩되어 있음
- 서버에서 생성되어 클라이언트에서 저장
- 요청 + Token ID 전송 -> 서버에서 사용자 식별 가능
- 데이터베이스에 저장되지 않고 Signature 값을 이용하여 검증할 수 있음
- 정보가 모두 토큰에 담겨있고 클아이언트에 저장되므로 정보 유출의 위험이 있음 -> 유출 위험이 없는 정보만 보내줭 
- Horizontal Scaling이 쉬움

토큰 생성

![token](/assets/token.png)

토큰 사용

![token2](/assets/token2.png)

## JWT

- JSON WEB TOKEN의 약자
- Header, Payload, Signature로 이루어져 있음
- Base 64로 인코딩
- Header : 토큰 종류와 암호화 알고리즘 등 토큰에 대한 정보
- Payload : 발행일, 만료일, 사용자 ID 등 사용자 검증에 필요한 정보

- Signature : Base 64로 인코딩된 Header와 Payload를 알고리즘으로 싸인한 값, 이 값을 기반으로 토큰이 발급된 뒤로 조작되었는지 확인할 수 있음 

## Refresh Token & Access Token

- JWT 기반

### Access Token

- API 요청을 할 때 검증용 토큰으로 사용, Header에 넣어서 요청 전송
- 유효기간이 짧음
- 자주 노출되므로 유효기간을 짧게 해서 토큰이 탈취되어도 유효하지 않게 방지 

### Refresh Token

- Access Token을 추가로 발급할 때 사용

- 유효기간이 김
- 상대적으로 노출이 적어서 탈취 가능성 낮음 

### 토큰 발급 과정

1. ID와 비밀번호 전송 
   - "username:password"값을 base64 인코딩 후 authorization 헤더에 "Basic $token" 형태로 전송(정석)
   - 쿼리에 넣거나, body에 넣거나, 알아서...
2. 토큰 검증
3. Refresh + Access 전송 

### Refresh Token 사용 과정

1. Access Token 재발급 URL로 authorization 헤더에 "Bearer $RT" 전송 
2. RT 검증
3. AT 재발급 후 전송 

### Access Token 사용 과정

1. authorization 헤더에 "Bearer AT"로 요청 전송
2. AT 검증
3. 데이터 요청
4. 데이터 응답
5. 받은 데이터 응답 

### 일반적인 사용 과정

당장 요청이 보낼 때 AT가 만료됐는지 알 수 없음...

1. API 요청
2. AT 검증
3. AT 만료 응답(401)
4. AT 재발급 요청
5. RT 검증
   - RT도 만료되었을 때 401로 응답하면 클라이언트에서 로그아웃 
6. AT 응답
7. 새로운 AT로 API 재요청
8. 데이터 요청
9. 데이터 응답
10. 받은 데터 응답 