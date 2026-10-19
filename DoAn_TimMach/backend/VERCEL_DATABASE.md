# PostgreSQL for Vercel

The Flask API uses request-based serverless functions on Vercel. Its filesystem is not a durable database, so production authentication, diagnoses, statistics, and audit records need a managed PostgreSQL database.

## Configure the API project

In the Vercel project `cong-cu-du-doan-benh-tim-wiqe`, open **Settings → Environment Variables** and add these values for **Production** (add Preview too if you test Preview deployments):

| Name | Value |
| --- | --- |
| `DB_MODE` | `postgres` |
| `DATABASE_URL` | The provider's pooled PostgreSQL connection URL; keep it secret |
| `SECRET_KEY` | A random secret of at least 32 bytes; keep it secret |
| `GOOGLE_CLIENT_ID` | The OAuth web client ID used by the frontend |

Use a PostgreSQL provider that accepts connections from Vercel and gives you a pooled connection URL. Do not commit the connection URL or paste it into source code. After saving the variables, redeploy the API project. The application creates the `Users`, `Diagnoses`, and `AuditLog` tables automatically when it starts.

## Google OAuth

In Google Cloud Console, add `https://cong-cu-du-doan-benh-tim.vercel.app` to the OAuth client's authorized JavaScript origins. Confirm that the value of `GOOGLE_CLIENT_ID` in both Vercel projects matches that OAuth client. The frontend project is `cong-cu-du-doan-benh-tim`; the API project is `cong-cu-du-doan-benh-tim-wiqe`.

## Optional email OTP

To send password reset codes by email, configure `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASSWORD`, and `SMTP_FROM` on the API project. Without these settings the existing development fallback may display the OTP in the response, so configure SMTP before enabling password recovery for real users.

## Existing data

This setup creates a new PostgreSQL database. It does not automatically copy accounts or diagnoses from the SQL Server database on a developer's computer. Migrate that data separately if it must be preserved.

## Verify after redeploy

1. Open `/api/health` on the API deployment. It should report `auth_database.connected: true` and `mode: postgres`.
2. On the production frontend, test registration and email/password login.
3. Test Google login, create a prediction, then check the user's diagnosis history and dashboard statistics.
4. Test password reset after SMTP is configured.
