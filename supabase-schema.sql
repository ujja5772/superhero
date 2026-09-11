-- Supabase SQL Editor에서 이 파일 내용을 그대로 실행하세요.
-- 학생 게시물, 사용된 카드 목록 등을 key-value 형태로 저장하는 단일 테이블입니다.

create table if not exists kv_store (
  key text primary key,
  value jsonb not null,
  updated_at timestamptz default now()
);

-- 회원가입/로그인 없이 학생들이 브라우저에서 바로 읽고 쓸 수 있도록
-- Row Level Security를 켜고, 누구나 읽고/쓰고/지울 수 있게 허용합니다.
-- (학급 활동용 간단한 도구이므로 이 정도 권한으로 충분합니다.)
alter table kv_store enable row level security;

create policy "public can read" on kv_store
  for select using (true);

create policy "public can insert" on kv_store
  for insert with check (true);

create policy "public can update" on kv_store
  for update using (true);

create policy "public can delete" on kv_store
  for delete using (true);
