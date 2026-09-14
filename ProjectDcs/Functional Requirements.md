# Functional Requirements - ksf_FA_Roster

## Document Information
- **Module**: ksf_FA_Roster
- **Version**: 1.0.0
- **Date**: 2026-05-11
- **Status**: Implemented
- **Author**: KSFII Development Team

---

## 1. Overview

### 1.1 Purpose
ksf_FA_Roster provides FrontAccounting UI integration for roster.

### 1.2 Scope
- FA module hooks
- Database adapters
- UI pages
- GL integration

---

## 2. Core Features

### 2.1 Module Hooks

| Hook | Description |
|------|-------------|
| install_options | Menu items |
| install_access | Security setup |
| activate_extension | DB setup |

### 2.2 Database Adapters

| Adapter | FA Table | Direction |
|---------|----------|-----------|
| DebtorAdapter | debtors | Read/Write |
| EmployeeAdapter | employee | Read |

### 2.3 UI Pages

| Page | Access |
|------|--------|
| List | SA_ROSTER_VIEW |
| Edit | SA_ROSTER_EDIT |
| Report | SA_ROSTER_VIEW |

---

## 3. GL Integration

| Type | GL Code |
|------|---------|
| Default | As per category |
| Override | User specified |

---

*Document Version: 1.0.0*
*Last Updated: 2026-05-11*
