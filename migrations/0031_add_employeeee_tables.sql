-- employeeee payroll app data.
-- These tables live in the same D1 database and are linked to the shared
-- Budget-Lee users table by user_id.

CREATE TABLE IF NOT EXISTS employeeee_pay_rules (
  user_id INTEGER PRIMARY KEY,
  rule_json TEXT NOT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS employeeee_work_entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  entry_id TEXT NOT NULL,
  entry_date TEXT NOT NULL,
  entry_json TEXT NOT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE (user_id, entry_id)
);

CREATE INDEX IF NOT EXISTS idx_employeeee_work_entries_user_date
ON employeeee_work_entries(user_id, entry_date);
