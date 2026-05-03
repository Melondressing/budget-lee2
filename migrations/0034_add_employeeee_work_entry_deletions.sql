-- Tombstones for employeeee work-entry deletes.
-- This prevents an older device cache from re-uploading a record that was
-- deleted on another device.

CREATE TABLE IF NOT EXISTS employeeee_work_entry_deletions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  entry_id TEXT NOT NULL,
  deleted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE (user_id, entry_id)
);

CREATE INDEX IF NOT EXISTS idx_employeeee_work_entry_deletions_user
ON employeeee_work_entry_deletions(user_id, deleted_at);
