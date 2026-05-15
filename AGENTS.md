# AGENTS.md - ksf_FA_Roster#

## Architecture Overview#

**FA Module** for Employee Roster/Scheduling - shifts, time slots, and coverage tracking.

### Core Principles#
- **SOLID**, **DRY**, **TDD**, **DI**, **SRP**#

## Repository Structure#

```
ksf_FA_Roster/
├── sql/#
│   ├── fa_roster_shifts.sql#
│   ├── fa_roster_assignments.sql#
│   └── fa_roster_time_slots.sql#
├── includes/#
│   ├── shifts_db.inc#
│   ├── assignments_db.inc#
│   └── time_slots_db.inc#
├── pages/#
├── hooks.php#
├── composer.json#
└── ProjectDocs/#
```

## Dependencies#

- **ksf_FA_Roster_Core** (business logic)#
- **ksf_FA_HRM** (link to employees)#
- **ksf_FA_Timesheets** (link shifts to timesheets)#
- **FrontAccounting 2.4+**#
