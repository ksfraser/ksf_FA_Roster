# Functional Requirements - ksf_FA_Roster

## Overview

This document details the functional requirements for the Roster module (ksf_FA_Roster), which provides FA-specific shift scheduling, employee availability management, and coverage tracking functionality.

## Scope

The module handles:
- Shift template management
- Schedule type configuration (fixed, flexible, rotating)
- Team-based schedule assignment
- Individual employee schedule overrides
- Daily shift generation and assignment
- Coverage gap detection and resolution
- Calendar integration for availability
- Leave impact analysis
- Training conflict detection
- Activity logging and reporting

---

## FR-1: Shift Template Management

### FR-1.1: Create Shift Template

**Description**: Users shall be able to create shift templates.

**Requirements**:
- FR-1.1.1: System shall accept template name (required)
- FR-1.1.2: System shall accept start time and end time
- FR-1.1.3: System shall accept days of week (multiple selection)
- FR-1.1.4: System shall accept buffer minutes (pre/post shift)
- FR-1.1.5: System shall validate name is unique
- FR-1.1.6: System shall validate times are logical
- FR-1.1.7: System shall default buffer to 0 minutes
- FR-1.1.8: System shall generate activity log entry on creation

**Acceptance Criteria**:
- [ ] Template can be created with all required fields
- [ ] Days of week selection works
- [ ] Buffer minutes stored correctly
- [ ] Activity logged

### FR-1.2: View Shift Templates

**Description**: Users shall be able to view list of shift templates.

**Requirements**:
- FR-1.2.1: System shall display all templates in table format
- FR-1.2.2: System shall show name, times, and days
- FR-1.2.3: System shall indicate active/inactive status
- FR-1.2.4: System shall filter by active status
- FR-1.2.5: System shall sort by name by default

**Acceptance Criteria**:
- [ ] All templates listed correctly
- [ ] Status indicator works
- [ ] Filter applies correctly

### FR-1.3: Edit Shift Template

**Description**: Users shall be able to modify shift templates.

**Requirements**:
- FR-1.3.1: System shall pre-populate form with existing values
- FR-1.3.2: System shall validate required fields
- FR-1.3.3: System shall track changes in activity log
- FR-1.3.4: System shall not allow changing template if in use (with warning)

**Acceptance Criteria**:
- [ ] Form pre-fills with current values
- [ ] Changes saved to database
- [ ] Activity logged with changes

### FR-1.4: Delete Shift Template

**Description**: Users shall be able to delete shift templates.

**Requirements**:
- FR-1.4.1: System shall require confirmation before deletion
- FR-1.4.2: System shall warn if template is in use
- FR-1.4.3: System shall allow cascade delete of assignments
- FR-1.4.4: System shall generate activity log entry

**Acceptance Criteria**:
- [ ] Confirmation dialog appears
- [ ] Warning shown if template in use
- [ ] Deletion removes template

---

## FR-2: Schedule Type Management

### FR-2.1: Fixed Schedule Configuration

**Description**: System shall support fixed schedule type.

**Requirements**:
- FR-2.1.1: System shall accept default start time
- FR-2.1.2: System shall accept default end time
- FR-2.1.3: System shall apply same times every day
- FR-2.1.4: System shall allow template override

**Acceptance Criteria**:
- [ ] Fixed schedule generates consistent daily times
- [ ] Times same every day for assigned employees

### FR-2.2: Flexible Schedule Configuration

**Description**: System shall support flexible schedule type.

**Requirements**:
- FR-2.2.1: System shall accept flexible start window (earliest time)
- FR-2.2.2: System shall accept flexible end window (latest start time)
- FR-2.2.3: System shall require total hours per day
- FR-2.2.4: System shall allow variable daily start times within window
- FR-2.2.5: System shall track actual start/end for each day

**Acceptance Criteria**:
- [ ] Flexible window defined correctly
- [ ] Daily hours calculated correctly
- [ ] Actual times logged when recorded

### FR-2.3: Rotating Schedule Configuration

**Description**: System shall support rotating shift schedules.

**Requirements**:
- FR-2.3.1: System shall accept rotation pattern (sequence of templates)
- FR-2.3.2: System shall accept rotation cycle length (days/weeks)
- FR-2.3.3: System shall auto-calculate shift for each day based on pattern
- FR-2.3.4: System shall handle offset for start date alignment

**Acceptance Criteria**:
- [ ] Rotation pattern configurable
- [ ] Correct template applied for each day
- [ ] Pattern repeats correctly

### FR-2.4: View Schedule Types

**Description**: Users shall be able to view schedule type configurations.

**Requirements**:
- FR-2.4.1: System shall list all defined schedule types
- FR-2.4.2: System shall show current usage count
- FR-2.4.3: System shall allow enabling/disabling types

**Acceptance Criteria**:
- [ ] Schedule types listed
- [ ] Usage information accurate

---

## FR-3: Team Schedule Assignment

### FR-3.1: Assign Schedule to Team

**Description**: Users shall be able to assign schedules to teams/departments.

**Requirements**:
- FR-3.1.1: System shall require team_id and schedule type/template
- FR-3.1.2: System shall accept effective_from date
- FR-3.1.3: System shall accept effective_to date (optional)
- FR-3.1.4: System shall validate dates are logical
- FR-3.1.5: System shall override with individual assignments
- FR-3.1.6: System shall generate daily shifts for team members
- FR-3.1.7: System shall generate activity log entry

**Acceptance Criteria**:
- [ ] Schedule assigned to team
- [ ] Dates stored correctly
- [ ] Individual overrides take precedence
- [ ] Daily shifts generated

### FR-3.2: View Team Schedules

**Description**: Users shall be able to view schedules assigned to teams.

**Requirements**:
- FR-3.2.1: System shall list all team schedules
- FR-3.2.2: System shall show team name, schedule type, and template
- FR-3.2.3: System shall show effective dates
- FR-3.2.4: System shall filter by team

**Acceptance Criteria**:
- [ ] Team schedules listed correctly
- [ ] Filter works correctly

### FR-3.3: Edit Team Schedule

**Description**: Users shall be able to modify team schedule assignments.

**Requirements**:
- FR-3.3.1: System shall allow changing schedule type/template
- FR-3.3.2: System shall allow changing effective dates
- FR-3.3.3: System shall regenerate shifts if times change
- FR-3.3.4: System shall log changes

**Acceptance Criteria**:
- [ ] Changes saved correctly
- [ ] Shifts regenerated if needed
- [ ] Activity logged

### FR-3.4: Remove Team Schedule

**Description**: Users shall be able to remove schedule assignments.

**Requirements**:
- FR-3.4.1: System shall remove schedule assignment
- FR-3.4.2: System shall require confirmation
- FR-3.4.3: System shall handle active shifts gracefully
- FR-3.4.4: System shall log removal

**Acceptance Criteria**:
- [ ] Assignment removed
- [ ] Active shifts handled appropriately

---

## FR-4: Employee Schedule Management

### FR-4.1: Assign Individual Override

**Description**: Users shall be able to assign individual schedule overrides.

**Requirements**:
- FR-4.1.1: System shall require employee_id
- FR-4.1.2: System shall accept override schedule type/template
- FR-4.1.3: System shall accept flexible window settings if applicable
- FR-4.1.4: System shall accept effective dates
- FR-4.1.5: System shall override team schedule when present
- FR-4.1.6: System shall validate employee exists
- FR-4.1.7: System shall log assignment

**Acceptance Criteria**:
- [ ] Individual override assigned
- [ ] Override takes precedence over team schedule
- [ ] Employee validated
- [ ] Activity logged

### FR-4.2: View Employee Schedule

**Description**: Users shall be able to view employee schedules.

**Requirements**:
- FR-4.2.1: System shall show employee's active schedule
- FR-4.2.2: System shall indicate if individual override or team-based
- FR-4.2.3: System shall show schedule type and template
- FR-4.2.4: System shall show effective dates

**Acceptance Criteria**:
- [ ] Schedule displayed correctly
- [ ] Override indicator shown

### FR-4.3: View Employee Availability

**Description**: System shall provide employee availability information.

**Requirements**:
- FR-4.3.1: System shall show available hours for date range
- FR-4.3.2: System shall account for existing leave
- FR-4.3.3: System shall account for existing meetings
- FR-4.3.4: System shall return iCal compatible free/busy data

**Acceptance Criteria**:
- [ ] Available hours calculated correctly
- [ ] Leave and meetings factored in
- [ ] iCal export works

---

## FR-5: Daily Shift Management

### FR-5.1: Generate Daily Shifts

**Description**: System shall generate daily shifts for assigned schedules.

**Requirements**:
- FR-5.1.1: System shall generate shifts for all assigned employees
- FR-5.1.2: System shall apply fixed schedule times directly
- FR-5.1.3: System shall calculate flexible schedule times
- FR-5.1.4: System shall apply rotating schedule pattern
- FR-5.1.5: System shall apply buffer times
- FR-5.1.6: System shall create Calendar entries for availability

**Acceptance Criteria**:
- [ ] Shifts generated for all employees
- [ ] Each schedule type handled correctly
- [ ] Calendar entries created

### FR-5.2: View Daily Shifts

**Description**: Users shall be able to view generated shifts.

**Requirements**:
- FR-5.2.1: System shall display shifts by date
- FR-5.2.2: System shall filter by team/department
- FR-5.2.3: System shall show assigned employees
- FR-5.2.4: System shall show start/end times

**Acceptance Criteria**:
- [ ] Shifts displayed in table format
- [ ] Filters work correctly

### FR-5.3: Manual Shift Override

**Description**: Users shall be able to manually adjust shifts.

**Requirements**:
- FR-5.3.1: System shall allow changing start time
- FR-5.3.2: System shall allow changing end time
- FR-5.3.3: System shall flag as manual override
- FR-5.3.4: System shall log manual changes

**Acceptance Criteria**:
- [ ] Manual changes saved
- [ ] Override flag set
- [ ] Activity logged

### FR-5.4: Shift Absence Recording

**Description**: System shall record employee absences against shifts.

**Requirements**:
- FR-5.4.1: System shall record unplanned absence
- FR-5.4.2: System shall mark shift as uncovered
- FR-5.4.3: System shall trigger coverage gap detection

**Acceptance Criteria**:
- [ ] Absence recorded
- [ ] Coverage gap triggered

---

## FR-6: Coverage Management

### FR-6.1: Detect Coverage Gaps

**Description**: System shall automatically detect coverage gaps.

**Requirements**:
- FR-6.1.1: System shall compare actual coverage to required coverage
- FR-6.1.2: System shall define minimum staffing per shift/team
- FR-6.1.3: System shall flag gaps below threshold
- FR-6.1.4: System shall store gap records with date, shift, team, required, actual

**Acceptance Criteria**:
- [ ] Gaps detected correctly
- [ ] Gap records created
- [ ] Minimum staffing respected

### FR-6.2: View Coverage Gaps

**Description**: Users shall be able to view coverage gaps.

**Requirements**:
- FR-6.2.1: System shall list pending gaps
- FR-6.2.2: System shall show date, shift, team, severity
- FR-6.2.3: System shall filter by date range
- FR-6.2.4: System shall filter by team
- FR-6.2.5: System shall sort by date by default

**Acceptance Criteria**:
- [ ] Gaps listed correctly
- [ ] Filters work correctly

### FR-6.3: Resolve Coverage Gaps

**Description**: Users shall be able to resolve coverage gaps.

**Requirements**:
- FR-6.3.1: System shall accept resolution notes
- FR-6.3.2: System shall accept resolution type (covered, acknowledged, cancelled)
- FR-6.3.3: System shall mark gap as resolved
- FR-6.3.4: System shall log resolution

**Acceptance Criteria**:
- [ ] Gap resolved with notes
- [ ] Resolution type saved
- [ ] Activity logged

### FR-6.4: Coverage Reports

**Description**: System shall generate coverage reports.

**Requirements**:
- FR-6.4.1: System shall calculate coverage percentage by team/shift
- FR-6.4.2: System shall show trend over time
- FR-6.4.3: System shall identify chronic gap patterns

**Acceptance Criteria**:
- [ ] Coverage percentages accurate
- [ ] Trends visualized
- [ ] Patterns identified

---

## FR-7: Leave Integration

### FR-7.1: Leave Request Coverage Check

**Description**: System shall check coverage when leave is requested.

**Requirements**:
- FR-7.1.1: System shall receive leave request data from Leave module
- FR-7.1.2: System shall check employee's scheduled shifts
- FR-7.1.3: System shall calculate coverage impact
- FR-7.1.4: System shall return coverage status (ok/warning/critical)
- FR-7.1.5: System shall flag critical shift positions

**Acceptance Criteria**:
- [ ] Coverage check executed
- [ ] Impact calculated correctly
- [ ] Status returned accurately

### FR-7.2: Leave Impact Warnings

**Description**: System shall provide warnings for leave impact.

**Requirements**:
- FR-7.2.1: System shall display warning on leave request if gap created
- FR-7.2.2: System shall show required coverage vs remaining
- FR-7.2.3: System shall allow override with approval
- FR-7.2.4: System shall log warning acknowledgment

**Acceptance Criteria**:
- [ ] Warnings displayed correctly
- [ ] Override with approval works
- [ ] Acknowledgment logged

### FR-7.3: Leave Calendar Integration

**Description**: System shall update availability when leave approved.

**Requirements**:
- FR-7.3.1: System shall receive leave approval notification
- FR-7.3.2: System shall update Calendar entries (mark as unavailable)
- FR-7.3.3: System shall trigger coverage re-check

**Acceptance Criteria**:
- [ ] Calendar updated on leave approval
- [ ] Coverage re-checked

---

## FR-8: Training Integration

### FR-8.1: Training Conflict Detection

**Description**: System shall detect conflicts with training schedules.

**Requirements**:
- FR-8.1.1: System shall receive training schedule data
- FR-8.1.2: System shall check for overlap with scheduled shifts
- FR-8.1.3: System shall return conflict status
- FR-8.1.4: System shall flag shift conflicts

**Acceptance Criteria**:
- [ ] Conflicts detected correctly
- [ ] Status returned accurately

### FR-8.2: Training Impact Warnings

**Description**: System shall provide warnings for training conflicts.

**Requirements**:
- FR-8.2.1: System shall display warning when training during shift
- FR-8.2.2: System shall show conflict details
- FR-8.2.3: System shall allow scheduling override

**Acceptance Criteria**:
- [ ] Warnings displayed correctly
- [ ] Override works

---

## FR-9: Calendar Integration

### FR-9.1: Availability Calendar Entries

**Description**: System shall create Calendar entries for availability.

**Requirements**:
- FR-9.1.1: System shall create "Available" blocks from schedules
- FR-9.1.2: System shall update Calendar on schedule change
- FR-9.1.3: System shall mark entries with roster reference
- FR-9.1.4: System shall handle all-day vs timed entries

**Acceptance Criteria**:
- [ ] Calendar entries created
- [ ] Updates propagated on changes
- [ ] Entries linked to roster

### FR-9.2: iCal Free/Busy Export

**Description**: System shall provide iCal compatible free/busy data.

**Requirements**:
- FR-9.2.1: System shall generate iCal VEVENT/FREEBUSY entries
- FR-9.2.2: System shall include available times from schedules
- FR-9.2.3: System shall exclude leave and meetings
- FR-9.2.4: System shall support date range parameter

**Acceptance Criteria**:
- [ ] iCal format correct
- [ ] Data accurate
- [ ] Date range filtering works

### FR-9.3: Meeting Availability Check

**Description**: System shall provide availability for meeting scheduling.

**Requirements**:
- FR-9.3.1: System shall receive meeting time slot request
- FR-9.3.2: System shall check employee availability for slot
- FR-9.3.3: System shall account for schedules, leave, meetings
- FR-9.3.4: System shall return availability status per employee

**Acceptance Criteria**:
- [ ] Availability check works
- [ ] All factors considered
- [ ] Status returned per employee

---

## FR-10: Dashboard

### FR-10.1: Dashboard Overview

**Description**: System shall display roster dashboard.

**Requirements**:
- FR-10.1.1: System shall show today's schedule summary
- FR-10.1.2: System shall show pending coverage gaps count
- FR-10.1.3: System shall show upcoming leave impact
- FR-10.1.4: System shall show team roster status

**Acceptance Criteria**:
- [ ] Dashboard displays correctly
- [ ] Statistics accurate

### FR-10.2: Team Roster View

**Description**: System shall display team roster.

**Requirements**:
- FR-10.2.1: System shall list team members
- FR-10.2.2: System shall show current schedule
- FR-10.2.3: System shall show availability status
- FR-10.2.4: System shall filter by team

**Acceptance Criteria**:
- [ ] Team members listed
- [ ] Schedule displayed
- [ ] Filters work

---

## FR-11: Settings & Configuration

### FR-11.1: Module Settings

**Description**: System shall provide module configuration.

**Requirements**:
- FR-11.1.1: System shall allow setting default schedule type
- FR-11.1.2: System shall allow setting default shift times
- FR-11.1.3: System shall allow setting coverage thresholds
- FR-11.1.4: System shall allow setting buffer times
- FR-11.1.5: System shall allow setting notification preferences

**Acceptance Criteria**:
- [ ] Settings page accessible to admins
- [ ] Settings persist correctly

### FR-11.2: Minimum Staffing Configuration

**Description**: System shall allow configuring minimum staffing levels.

**Requirements**:
- FR-11.2.1: System shall accept minimum count per team
- FR-11.2.2: System shall accept minimum count per shift
- FR-11.2.3: System shall accept minimum count per day

**Acceptance Criteria**:
- [ ] Minimums configurable
- [ ] Configurable values used in gap detection

---

## FR-12: Activity Logging

### FR-12.1: Track All Operations

**Description**: System shall log all roster-related activities.

**Requirements**:
- FR-12.1.1: System shall log template CRUD operations
- FR-12.1.2: System shall log schedule assignments
- FR-12.1.3: System shall log shift changes
- FR-12.1.4: System shall log coverage gap operations
- FR-12.1.5: System shall capture user_id, action, timestamp, old/new values

**Acceptance Criteria**:
- [ ] All operations logged
- [ ] Audit trail complete

---

## Appendix: Requirement ID Index

| ID | Description |
|----|-------------|
| FR-1.1 | Create Shift Template |
| FR-1.2 | View Shift Templates |
| FR-1.3 | Edit Shift Template |
| FR-1.4 | Delete Shift Template |
| FR-2.1 | Fixed Schedule Configuration |
| FR-2.2 | Flexible Schedule Configuration |
| FR-2.3 | Rotating Schedule Configuration |
| FR-2.4 | View Schedule Types |
| FR-3.1 | Assign Schedule to Team |
| FR-3.2 | View Team Schedules |
| FR-3.3 | Edit Team Schedule |
| FR-3.4 | Remove Team Schedule |
| FR-4.1 | Assign Individual Override |
| FR-4.2 | View Employee Schedule |
| FR-4.3 | View Employee Availability |
| FR-5.1 | Generate Daily Shifts |
| FR-5.2 | View Daily Shifts |
| FR-5.3 | Manual Shift Override |
| FR-5.4 | Shift Absence Recording |
| FR-6.1 | Detect Coverage Gaps |
| FR-6.2 | View Coverage Gaps |
| FR-6.3 | Resolve Coverage Gaps |
| FR-6.4 | Coverage Reports |
| FR-7.1 | Leave Request Coverage Check |
| FR-7.2 | Leave Impact Warnings |
| FR-7.3 | Leave Calendar Integration |
| FR-8.1 | Training Conflict Detection |
| FR-8.2 | Training Impact Warnings |
| FR-9.1 | Availability Calendar Entries |
| FR-9.2 | iCal Free/Busy Export |
| FR-9.3 | Meeting Availability Check |
| FR-10.1 | Dashboard Overview |
| FR-10.2 | Team Roster View |
| FR-11.1 | Module Settings |
| FR-11.2 | Minimum Staffing Configuration |
| FR-12.1 | Track All Operations |
