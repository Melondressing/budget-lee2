# Invite Code Setup

Shared auth sign-up now requires a one-time invite code.

## 1. Apply the migration

```bash
npm run db:migrate:prod
```

## 2. Insert your first 10 codes

```sql
INSERT INTO auth_invite_codes (code, label) VALUES
  ('LAUNCH-001', 'Initial launch 1'),
  ('LAUNCH-002', 'Initial launch 2'),
  ('LAUNCH-003', 'Initial launch 3'),
  ('LAUNCH-004', 'Initial launch 4'),
  ('LAUNCH-005', 'Initial launch 5'),
  ('LAUNCH-006', 'Initial launch 6'),
  ('LAUNCH-007', 'Initial launch 7'),
  ('LAUNCH-008', 'Initial launch 8'),
  ('LAUNCH-009', 'Initial launch 9'),
  ('LAUNCH-010', 'Initial launch 10');
```

With Wrangler:

```bash
wrangler d1 execute webapp-production --command "
INSERT INTO auth_invite_codes (code, label) VALUES
  ('LAUNCH-001', 'Initial launch 1'),
  ('LAUNCH-002', 'Initial launch 2'),
  ('LAUNCH-003', 'Initial launch 3'),
  ('LAUNCH-004', 'Initial launch 4'),
  ('LAUNCH-005', 'Initial launch 5'),
  ('LAUNCH-006', 'Initial launch 6'),
  ('LAUNCH-007', 'Initial launch 7'),
  ('LAUNCH-008', 'Initial launch 8'),
  ('LAUNCH-009', 'Initial launch 9'),
  ('LAUNCH-010', 'Initial launch 10');
"
```

## 3. Disable a code without deleting history

```sql
UPDATE auth_invite_codes
SET is_active = 0
WHERE code = 'LAUNCH-001';
```

## 4. Check which codes were used

```sql
SELECT code, is_active, used_by_user_id, used_at
FROM auth_invite_codes
ORDER BY created_at ASC, code ASC;
```
