# Journey: User Registration

A new user registers, receives a verification email,
confirms their address, and logs in.

## Context

This journey exercises the registration flow
end-to-end through the API callable surface. It
verifies functional correctness (account creation,
email verification, login) and internal quality
(query count, trace shape, error handling).

## Pre-conditions

- The system is running with a clean database
- No user exists with email `test@example.com`
- Email sending is configured (test mailbox or
  stub)
- OpenTelemetry tracing is enabled

## Steps

### Step 1: Register

**Action**: POST `/api/auth/register`

```json
{
  "email": "test@example.com",
  "password": "Test1234!",
  "name": "Test User"
}
```

**Expected**: 201 Created. Response contains
`userId`. No access token (user is not verified
yet).

### Step 2: Check verification email

**Action**: GET the test mailbox for
`test@example.com`.

**Expected**: One email with a verification link
containing a token. Subject line matches the
expected template.

### Step 3: Verify email

**Action**: POST `/api/auth/verify-email`

```json
{
  "token": "<token-from-email>"
}
```

**Expected**: 200 OK. Response confirms the email
is verified.

### Step 4: Login

**Action**: POST `/api/auth/login`

```json
{
  "email": "test@example.com",
  "password": "Test1234!"
}
```

**Expected**: 200 OK. Response contains
`accessToken` and `refreshToken`.

### Step 5: Access protected resource

**Action**: GET `/api/users/me` with the access
token from Step 4 in the Authorization header.

**Expected**: 200 OK. Response contains user
profile with `name: "Test User"` and
`emailVerified: true`.

## Post-conditions

- User exists in the database with verified email
- One verification email was sent (no duplicates)
- Login produces valid tokens

## Evaluation Criteria

### Functional

| # | Criterion | Scope |
|---|-----------|-------|
| F1 | Registration returns 201 with userId | Step 1 |
| F2 | Duplicate registration returns 409 | Step 1 (re-run) |
| F3 | Verification email contains valid token | Step 2 |
| F4 | Email verification succeeds on first use | Step 3 |
| F5 | Expired/reused token returns 400 | Step 3 (re-run) |
| F6 | Login succeeds after verification | Step 4 |
| F7 | Login before verification returns 403 | Step 4 (alt) |
| F8 | Protected endpoint returns profile | Step 5 |

### Performance

| # | Criterion | Budget |
|---|-----------|--------|
| P1 | Registration: DB queries <= 3 | Step 1 trace |
| P2 | Login: DB queries <= 2 | Step 4 trace |
| P3 | Registration: response time < 500ms | Step 1 |
| P4 | Login: response time < 200ms | Step 4 |

### Security

| # | Criterion | Scope |
|---|-----------|-------|
| S1 | Password is not in any response body | All steps |
| S2 | Verification token is single-use | Step 3 |
| S3 | Access token has reasonable expiry | Step 4 |

### Observability

| # | Criterion | Scope |
|---|-----------|-------|
| O1 | Each step produces a trace with a root span | All steps |
| O2 | DB spans are present for data operations | Steps 1, 3, 4 |
| O3 | Email send span is present | Step 1 |

---

## Sample Walk Report

This is what a completed walk report looks like
after the journey-walker agent executes the journey.

```
## Walk Report: User Registration

**Journey**: User Registration
**Date**: 2026-05-12
**Mode**: White Box (black box first, then traces)
**Callable Surface**: REST API at localhost:5000
**Overall Result**: FAIL (1 violation)

### Step Results

| Step | Action | Result | Trace ID |
|------|--------|--------|----------|
| 1 | POST /api/auth/register | PASS (201) | abc123 |
| 2 | Check verification email | PASS | -- |
| 3 | POST /api/auth/verify-email | PASS (200) | def456 |
| 4 | POST /api/auth/login | PASS (200) | ghi789 |
| 5 | GET /api/users/me | PASS (200) | jkl012 |

### Criteria Results

| ID | Criterion | Result | Evidence |
|----|-----------|--------|----------|
| F1 | Registration returns 201 | PASS | 201, userId: "u-1234" |
| F2 | Duplicate returns 409 | PASS | 409 on re-run |
| F3 | Email contains token | PASS | Token: "vt-5678" |
| F4 | Verification succeeds | PASS | 200 |
| F5 | Reused token returns 400 | PASS | 400 on re-run |
| F6 | Login after verification | PASS | 200, tokens present |
| F7 | Login before verification | PASS | 403 (tested with new user) |
| F8 | Protected endpoint | PASS | Profile matches |
| P1 | Registration DB queries <= 3 | **FAIL** | 5 queries (trace abc123) |
| P2 | Login DB queries <= 2 | PASS | 2 queries |
| P3 | Registration < 500ms | PASS | 320ms |
| P4 | Login < 200ms | PASS | 85ms |
| S1 | No password in responses | PASS | Checked all bodies |
| S2 | Token single-use | PASS | 400 on reuse |
| S3 | Token expiry reasonable | PASS | exp: 1h |
| O1 | Traces present | PASS | All steps traced |
| O2 | DB spans present | PASS | Spans in 1, 3, 4 |
| O3 | Email span present | PASS | SendEmail span |

### Violations

1. **P1**: Registration produces 5 DB queries
   (budget: 3). Trace abc123 shows: INSERT user,
   SELECT duplicate check, INSERT email_token,
   SELECT user (re-read after insert),
   INSERT audit_log. The re-read after insert is
   likely unnecessary -- the INSERT can return the
   created row.

### Findings

- Step 1 trace shows the duplicate check runs
  before the insert (correct order).
- Email send is async (separate span, not blocking
  the response). Good.
- Audit log insert adds 1 query per write
  operation. Consider batching if this pattern
  repeats across other endpoints.
```
