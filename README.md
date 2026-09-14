# ksf_FA_Roster - Employee Roster & Scheduling Module

## Overview

The Roster module provides comprehensive shift scheduling and employee availability management for FrontAccounting. It integrates with Calendar, Leave Management, and Training modules to provide a complete workforce scheduling solution.

## Features

### Core Features

- **Shift Templates Management**
  - Create and manage named shift templates (Day Shift, Night Shift, etc.)
  - Define start time, end time, and applicable days of week
  - Template-based scheduling for consistent scheduling

- **Schedule Types**
  - **Fixed Schedule**: Same start/end time every day (e.g., 8:00-17:00)
  - **Flexible Schedule**: Variable daily hours within a time window (e.g., 8 hours between 6am-6pm)
  - **Rotating Shift**: Sequential shift patterns (e.g., Day shift 3 days, Night shift 3 days, Off 3 days)

- **Team Assignment**
  - Assign schedules to teams/departments
  - Individual employee schedule overrides
  - Bulk assignment capabilities

- **Calendar Integration**
  - Generate "Available" blocks in Calendar from daily schedules
  - Real-time availability checking for meeting invites
  - iCal free/busy data export

- **Leave Impact Analysis**
  - Coverage gap detection when leave is requested
  - Critical shift position flagging
  - Override capability with approval workflow

- **Training Conflict Detection**
  - Warning when training scheduled during shifts
  - Conflict flagging system

### Dashboard Features

- Team roster overview
- Coverage status at a glance
- Pending coverage gaps
- Today's schedule summary

---

## Quick Start

### Installation

1. Copy the module to `/modules/ksf_FA_Roster/`
2. Activate via FA Modules admin interface
3. Database tables and initial data created automatically

### Basic Usage

#### Create Shift Template
1. Navigate to Roster > Shift Templates
2. Click "New Template"
3. Enter name, start time, end time, and days of week
4. Save

#### Assign Schedule to Team
1. Navigate to Roster > Team Schedules
2. Select team/department
3. Assign shift template or schedule type
4. Set effective dates

#### View Coverage
1. Navigate to Roster > Dashboard
2. View today's coverage status
3. Click on gaps to see details

---

## Database Tables

| Table | Description |
|-------|-------------|
| `fa_roster_shift_templates` | Shift template definitions |
| `fa_roster_schedule_types` | Schedule type configurations |
| `fa_roster_team_schedules` | Team-level schedule assignments |
| `fa_roster_employee_schedules` | Individual employee schedule overrides |
| `fa_roster_shift_assignments` | Daily shift assignments |
| `fa_roster_coverage_gaps` | Detected coverage gaps |
| `fa_roster_activity_log` | Audit log for all roster operations |

### Key Fields

#### fa_roster_shift_templates
- `template_id` - Unique identifier
- `name` - Template name (e.g., "Day Shift")
- `start_time` - Shift start time
- `end_time` - Shift end time
- `days_of_week` - JSON array of working days
- `buffer_minutes` - Pre/post shift buffer
- `inactive` - Active/inactive flag

#### fa_roster_team_schedules
- `schedule_id` - Unique identifier
- `team_id` - Team/department reference
- `schedule_type` - fixed/flexible/rotating
- `shift_template_id` - Assigned template
- `effective_from` - Start date
- `effective_to` - End date (nullable)

#### fa_roster_employee_schedules
- `employee_id` - Employee reference
- `schedule_type` - Override schedule type
- `shift_template_id` - Override template
- `flex_start_window` - Flexible start earliest time
- `flex_end_window` - Flexible start latest time
- `rotation_pattern` - JSON rotation sequence

---

## Permissions

| Permission | Description |
|------------|-------------|
| `ROS_VIEW_ROSTER` | View roster and schedules |
| `ROS_MANAGE_TEMPLATES` | Create/edit shift templates |
| `ROS_MANAGE_SCHEDULES` | Assign schedules to teams/employees |
| `ROS_VIEW_COVERAGE` | View coverage reports |
| `ROS_MANAGE_COVERAGE` | Manage coverage gaps |
| `ROS_VIEW_REPORTS` | View scheduling reports |
| `ROS_ADMIN` | Full admin access |

---

## API Reference

### Database Functions (roster_db.inc)

#### Template Functions
- `get_roster_templates($active_only)` - List shift templates
- `get_roster_template($template_id)` - Get single template
- `insert_roster_template($data)` - Create template
- `update_roster_template($template_id, $data)` - Update template
- `delete_roster_template($template_id)` - Delete template

#### Schedule Functions
- `get_team_schedules($team_id)` - Get team schedules
- `get_employee_schedule($employee_id, $date)` - Get employee schedule
- `assign_schedule_to_team($data)` - Assign schedule to team
- `assign_schedule_to_employee($data)` - Individual override
- `get_schedule_coverage($date, $team_id)` - Get coverage for date

#### Shift Functions
- `generate_daily_shifts($date)` - Generate shifts for date
- `get_shift_assignments($date, $team_id)` - Get assignments
- `assign_shift($data)` - Assign employee to shift
- `remove_shift_assignment($assignment_id)` - Remove assignment

#### Coverage Functions
- `detect_coverage_gaps($date, $team_id)` - Detect gaps
- `get_pending_gaps($team_id)` - Get unresolved gaps
- `resolve_gap($gap_id, $resolution)` - Resolve gap
- `get_coverage_summary($date_range)` - Coverage summary

### UI Functions (roster_ui.inc)

- `roster_navigation_menu()` - Main menu tabs
- `display_roster_dashboard($stats)` - Dashboard view
- `display_shift_template($template)` - Template display
- `display_coverage_status($coverage)` - Coverage indicator
- `sel_shift_template($selected)` - Template dropdown
- `sel_schedule_type($selected)` - Schedule type dropdown
- `sel_team($selected)` - Team dropdown

### Service Layer (RosterContainer)

```php
$container = new RosterContainer();
$templateService = $container->get(ShiftTemplateServiceInterface::class);
$scheduleService = $container->get(ScheduleServiceInterface::class);
```

---

## Integration Points

### ksf_HRM (Employee Management)
- Employee reference for schedule assignment
- Department/team hierarchy for team-based scheduling
- Employee attributes (job title, department)

### ksf_Leave (Leave Management)
- Leave requests trigger coverage check
- Leave dates matched against shift schedules
- Warning on coverage gaps before approval

### ksf_Training (Training Management)
- Training schedules checked against shifts
- Conflict detection and warnings
- Training impact on availability

### ksf_Calendar (Calendar)
- "Available" blocks from daily schedules
- Free/busy time export (iCal)
- Meeting availability checking

---

## Module Structure

```
ksf_FA_Roster/
├── FA_Roster_Module.php      # Module class with permissions
├── hooks.php                 # FA lifecycle hooks
├── roster.php               # API controller
├── _init/
│   └── init.inc            # Module initialization
├── includes/
│   ├── import.php          # Import functionality
│   ├── RosterContainer.php # DI container & services
│   ├── roster_db.inc      # Database functions
│   └── roster_ui.inc      # UI helpers
├── pages/
│   ├── dashboard.php       # Dashboard view
│   ├── templates.php       # Shift template CRUD
│   ├── schedules.php      # Schedule management
│   ├── shifts.php         # Daily shift management
│   ├── coverage.php        # Coverage analysis
│   ├── reports.php         # Reporting
│   └── settings.php       # Settings
└── sql/
    ├── install.sql        # Schema creation
    └── uninstall.sql      # Schema removal
```

---

## Configuration

### Default Settings (pages/settings.php)

- Default schedule type (fixed/flexible/rotating)
- Default shift times
- Coverage threshold percentages
- Buffer time settings
- Notification preferences

### Schedule Types Configuration

- **Fixed**: Default start/end time
- **Flexible**: Start window and end window hours
- **Rotating**: Rotation sequence and cycle length

---

## Support

For issues and feature requests, please contact the development team.

---

## License

This module is part of the FrontAccounting KS Framework (ksf).
See main FA license for terms.
