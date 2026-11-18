-- Roster module database schema for FrontAccounting
-- Table: 0_ksf_roster_availability

ALTER TABLE IF EXISTS `fa_roster_availability` RENAME TO `0_ksf_roster_availability`;

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
