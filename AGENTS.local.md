<!-- Repo-specific appendix to the shared AGENTS.md. Generic conventions live in AGENTS_ARCH.md (hardlinked). -->

```markdown
# AGENTS.local.md — ksf_FA_Roster
## Overview
**FA Module** for Employee Roster/Scheduling — shifts, time slots, and coverage tracking.
## Repository Structure
```
ksf_FA_Roster/
├── sql/
│   ├── fa_roster_shifts.sql
│   ├── fa_roster_assignments.sql
│   └── fa_roster_time_slots.sql
├── includes/
│   ├── shifts_db.inc
│   ├── assignments_db.inc
│   └── time_slots_db.inc
├── pages/
├── hooks.php
├── composer.json
└── ProjectDocs/
```
## Dependencies
- **ksf_FA_Roster_Core** (business logic)
- **ksf_FA_HRM** (link to employees)
- **ksf_FA_Timesheets** (link shifts to timesheets)
- **FrontAccounting 2.4+**
```
