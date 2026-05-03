-- employeeee confirmed pay runs exported into Budget-Lee transactions.

CREATE TABLE IF NOT EXISTS employeeee_pay_runs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  run_key TEXT NOT NULL,
  summary_mode TEXT NOT NULL,
  period_start TEXT NOT NULL,
  period_end TEXT NOT NULL,
  payday TEXT NOT NULL,
  currency TEXT,
  gross REAL NOT NULL DEFAULT 0,
  deductions REAL NOT NULL DEFAULT 0,
  net REAL NOT NULL DEFAULT 0,
  hours REAL NOT NULL DEFAULT 0,
  entry_count INTEGER NOT NULL DEFAULT 0,
  summary_json TEXT NOT NULL,
  budget_transaction_id INTEGER,
  exported_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (budget_transaction_id) REFERENCES transactions(id) ON DELETE SET NULL,
  UNIQUE (user_id, run_key)
);

CREATE INDEX IF NOT EXISTS idx_employeeee_pay_runs_user_payday
ON employeeee_pay_runs(user_id, payday);

CREATE INDEX IF NOT EXISTS idx_employeeee_pay_runs_transaction
ON employeeee_pay_runs(budget_transaction_id);
