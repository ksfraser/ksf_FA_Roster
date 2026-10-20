-- Roster module database schema for FrontAccounting

-- Main roster shifts table
ALTER TABLE IF EXISTS `fa_roster_shifts` RENAME TO `0_ksf_roster_shifts`;
ALTER TABLE IF EXISTS `fa_roster_availability` RENAME TO `0_ksf_roster_availability`;
ALTER TABLE IF EXISTS `fa_roster_swaps` RENAME TO `0_ksf_roster_swaps`;

CREATE TABLE IF NOT EXISTS `0_ksf_roster_shifts` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `employee_id` INT(11) NOT NULL,
    `date` DATE NOT NULL,
    `shift` ENUM('Morning','Afternoon','Night','Swing') NOT NULL DEFAULT 'Morning',
    `start_time` TIME NOT NULL DEFAULT '09:00:00',
    `end_time` TIME NOT NULL DEFAULT '17:00:00',
    `status` ENUM('Scheduled','Completed','Cancelled','No Show') NOT NULL DEFAULT 'Scheduled',
    `created_by` INT(11) DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `notes` TEXT,
    PRIMARY KEY (`id`),
    KEY `employee_id` (`employee_id`),
    KEY `date` (`date`),
    KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Employee availability
CREATE TABLE IF NOT EXISTS `0_ksf_roster_availability` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `employee_id` INT(11) NOT NULL,
    `date` DATE NOT NULL,
    `status` ENUM('Available','Unavailable','Preferred') NOT NULL DEFAULT 'Available',
    `start_time` TIME DEFAULT NULL,
    `end_time` TIME DEFAULT NULL,
    `notes` TEXT,
    PRIMARY KEY (`id`),
    KEY `employee_id` (`employee_id`),
    KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Shift swap requests
CREATE TABLE IF NOT EXISTS `0_ksf_roster_swaps` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `from_shift_id` INT(11) NOT NULL,
    `to_shift_id` INT(11) DEFAULT NULL,
    `requested_by` INT(11) NOT NULL,
    `status` ENUM('Pending','Approved','Rejected','Completed') NOT NULL DEFAULT 'Pending',
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `notes` TEXT,
    PRIMARY KEY (`id`),
    KEY `from_shift` (`from_shift_id`),
    KEY `to_shift` (`to_shift_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Module version
INSERT INTO `0_ksf_modules` (`name`, `version`, `enabled`, `installed`) VALUES
('Roster', '1.0.0', 1, NOW())
ON DUPLICATE KEY UPDATE `version` = '1.0.0', `installed` = NOW();

-- ---------------------------------------------------------------------------
-- Module-local employee directory.
--
-- WHY THIS TABLE EXISTS (and why it is not FA core):
--   FA core has no employee entity. In this estate an employee is an FA
--   person (0_crm_persons) plus a crm_categories row of type 'employee' plus
--   a satellite employment table - the satellite belongs to ksf_FA_HRM
--   (0_hrm_contacts_employment). Reaching into another module's table would
--   make this module depend on that module being activated, which
--   AGENTS_ARCH.md 12.2 forbids ("a shared seam must never be gated on
--   another module's activation"). The contact resolver in ksf-fa-common
--   deliberately does not cover the employee intent either.
--   So this module keeps its OWN employee directory, keyed by the same
--   employee_id its own records already carry. It is module-local by design.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `0_ksf_roster_employees` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(120) DEFAULT NULL,
    `active` TINYINT(1) DEFAULT 1,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;