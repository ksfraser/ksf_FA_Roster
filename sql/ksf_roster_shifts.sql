-- Roster module database schema for FrontAccounting
-- Table: 0_ksf_roster_shifts

ALTER TABLE IF EXISTS `fa_roster_shifts` RENAME TO `0_ksf_roster_shifts`;

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
