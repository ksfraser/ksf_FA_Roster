-- Roster module database schema for FrontAccounting
-- Table: 0_ksf_roster_swaps

ALTER TABLE IF EXISTS `fa_roster_swaps` RENAME TO `0_ksf_roster_swaps`;

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
