# 나만의 히어로 만들기 (Netlify + Supabase 배포판)

클로드 아티팩트로 만들었던 버전과 기능은 완전히 동일합니다. 다른 점은 데이터
저장소가 `window.storage`(아티팩트 전용) 대신 **Supabase**로 바뀐 것뿐이에요.
서버 함수(Netlify Functions)나 AI API 호출이 전혀 없어서, 예전 "나의 특별한
하루" 프로젝트 때 겪으셨던 404/서버 함수 문제가 애초에 생길 수 없는 구조입니다.

## 1. Supabase 프로젝트 만들기

1. https://supabase.com 에서 무료 계정으로 로그인 후 새 프로젝트를 만듭니다.
2. 왼쪽 메뉴 **SQL Editor**를 열고, 이 폴더의 `supabase-schema.sql` 내용을
   전부 복사해서 붙여넣고 실행(Run)합니다. `kv_store`라는 테이블 하나가
   생성됩니다.
3. 왼쪽 메뉴 **Project Settings → API**로 이동해서 다음 두 값을 복사해둡니다.
   - **Project URL**
   - **anon public** 키

## 2. config.js에 키 넣기

이 폴더의 `config.js` 파일을 열어 아래처럼 채워주세요.

```js
const SUPABASE_URL = "https://xxxxxxxxxxxx.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJI... (긴 문자열)";
```

## 3. GitHub에 올리기

1. GitHub에서 새 저장소(레포지토리)를 만듭니다. (예: `my-hero-webapp`)
2. 이 폴더 안의 파일들(`index.html`, `app.js`, `config.js`,
   `supabase-schema.sql`, `README.md`)을 그 저장소에 그대로 올립니다.
   - GitHub Desktop을 쓰신다면: 저장소를 로컬에 클론 → 이 파일들을 그 폴더에
     복사 → Commit → Push
   - 웹에서 바로 하신다면: 저장소 페이지의 "Add file → Upload files"로
     이 파일들을 드래그해서 올리고 Commit

## 4. Netlify로 배포하기

1. https://app.netlify.com 에서 **Add new site → Import an existing project**
2. GitHub 계정 연결 후, 방금 만든 저장소를 선택합니다.
3. 빌드 설정은 아래처럼 비워두거나 그대로 두면 됩니다. (별도 빌드 과정이
   필요 없는 순수 정적 사이트입니다.)
   - Build command: 비워둠
   - Publish directory: `.` (저장소 루트)
4. Deploy site를 누르면 몇 초 안에 `https://xxxx.netlify.app` 주소가
   생성됩니다.

이후 GitHub 저장소에 새로 Push할 때마다 Netlify가 자동으로 재배포합니다.

## 5. 확인해보기

- 배포된 주소로 접속해서 반/번호/이름을 넣고 히어로를 하나 만들어보세요.
- Supabase 대시보드의 **Table Editor → kv_store**에서 방금 만든 게시물이
  저장되어 있는지 확인할 수 있습니다.
- 선생님 로그인 비밀번호는 `app.js` 안의 `TEACHER_PW` 값을 바꾸면 변경됩니다.

## 파일 구성

| 파일 | 설명 |
|---|---|
| `index.html` | 화면 구조와 스타일 (디자인은 아티팩트 버전과 동일) |
| `app.js` | 전체 로직 — 카드 뽑기, 게시판, 승인, 하트, 교사 페이지 등 |
| `config.js` | Supabase 연결 정보 (직접 채워야 함) |
| `supabase-schema.sql` | Supabase에 한 번 실행해야 하는 테이블 생성 스크립트 |

## 참고

- 카드 이미지 48장은 `app.js` 안에 base64로 이미 포함되어 있어서 별도
  이미지 호스팅이 필요 없습니다. (그만큼 `app.js` 파일 용량이 좀 큽니다 — 약 1.5MB)
- `kv_store` 테이블은 회원가입 없이 누구나 읽고 쓸 수 있게 열어둔 상태입니다.
  학급 활동용으로는 충분하지만, 민감한 개인정보는 넣지 않는 걸 권장드려요.
