-- Roster module database schema for FrontAccounting

-- Main roster shifts table
CREATE TABLE IF NOT EXISTS `fa_roster_shifts` (
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
CREATE TABLE IF NOT EXISTS `fa_roster_availability` (
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
CREATE TABLE IF NOT EXISTS `fa_roster_swaps` (
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
INSERT INTO `fa_modules` (`name`, `version`, `enabled`, `installed`) VALUES
('Roster', '1.0.0', 1, NOW())
ON DUPLICATE KEY UPDATE `version` = '1.0.0', `installed` = NOW();