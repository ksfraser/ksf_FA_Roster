# Architecture - ksf_FA_Roster

## Document Information
- **Module**: ksf_FA_Roster
- **Version**: 1.0.0
- **Date**: 2026-05-11
- **Status**: Implemented
- **Author**: KSFII Development Team

---

## 1. Module Overview

ksf_FA_Roster provides FrontAccounting integration for roster functionality.

### 1.1 Namespace
`Ksfraser\FA\Roster`

### 1.2 FA Module Structure
```
ksf_FA_Roster/
├── hooks.php           # Module hooks
├── pages/              # UI pages
├── src/                # Adapters
└── Integration/        # DB adapters
```

---

## 2. Hooks Integration

### 2.1 Module Registration

```php
class hooks_faroster extends hooks {
    var $module_name = 'fa_roster';
    
    function install_options($app) {
        // Menu items
    }
    
    function install_access() {
        // Security areas
    }
}
```

### 2.2 Security Areas

| Constant | Description |
|----------|-------------|
| SA_ROSTER_VIEW | View access |
| SA_ROSTER_EDIT | Edit access |

---

## 3. Database Adapters

| Adapter | Description |
|---------|-------------|
| DebtorAdapter | FA debtor integration |
| EmployeeAdapter | HRM employee link |
| GLAdapter | GL code mapping |

---

## 4. Page Templates

| Page | Description |
|------|-------------|
| roster-list.php | List view |
| roster-edit.php | Edit form |
| roster-view.php | Detail view |

---

*Document Version: 1.0.0*
*Last Updated: 2026-05-11*
