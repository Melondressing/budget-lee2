-- Add updated_at to settings so per-user settings can be ordered safely.
-- SQLite/D1 cannot add a column with CURRENT_TIMESTAMP as a non-constant
-- default, so existing rows are backfilled after the column is added.

ALTER TABLE settings ADD COLUMN updated_at DATETIME;

UPDATE settings
SET updated_at = COALESCE(created_at, CURRENT_TIMESTAMP)
WHERE updated_at IS NULL;
