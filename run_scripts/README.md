# Windows workflow
Order: Local Run → GitHub Setup → Push Changes → Supabase → Docker → Azure.

Each script checks prerequisites and returns non-zero on failure. Login uses official CLI browser flows. Scripts never capture credentials. Rollback: stop the Node process; `docker compose down`; revert Git commit; unlink Supabase locally. Azure creation is deliberately not automated without subscription-specific consent.
