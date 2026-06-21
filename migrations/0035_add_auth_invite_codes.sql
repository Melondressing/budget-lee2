-- Limited-launch invite codes for shared auth.
-- Each code can be redeemed by a single user account.

CREATE TABLE IF NOT EXISTS auth_invite_codes (
  code TEXT PRIMARY KEY,
  label TEXT,
  is_active INTEGER NOT NULL DEFAULT 1,
  used_by_user_id INTEGER,
  used_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (used_by_user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_auth_invite_codes_active
ON auth_invite_codes(is_active, code);
