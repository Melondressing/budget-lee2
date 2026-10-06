-- 로그인 실패 횟수 제한용 테이블
CREATE TABLE IF NOT EXISTS login_attempts (
  username TEXT PRIMARY KEY,
  fail_count INTEGER NOT NULL DEFAULT 0,
  locked_until INTEGER NOT NULL DEFAULT 0
);
