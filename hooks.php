<?php
/**
 * FA_Roster Module Hooks for FrontAccounting
 */

define('SS_ROSTER', 133 << 8);

class hooks_fa_roster extends hooks {
    var $module_name = 'fa_roster';
    var $version = '1.0.0';

    function install_options($app) {
        global $path_to_root;

        switch($app->id) {
            case 'HR':
                $app->add_lapp_function(0, _("Roster Shifts"),
                    $path_to_root."/modules/".$this->module_name."/shifts.php", 'SA_ROSTERVIEW', MENU_ENTRY);
                $app->add_lapp_function(1, _("Create Shift"),
                    $path_to_root."/modules/".$this->module_name."/create.php", 'SA_ROSTERCREATE', MENU_ENTRY);
                $app->add_lapp_function(2, _("Availability"),
                    $path_to_root."/modules/".$this->module_name."/availability.php", 'SA_ROSTEREDIT', MENU_ENTRY);
                $app->add_rapp_function(3, _("Publish Schedule"),
                    $path_to_root."/modules/".$this->module_name."/publish.php", 'SA_ROSTERPUBLISH', MENU_MAINTENANCE);
                break;
        }
    }

    function install_access() {
        $security_sections[SS_ROSTER] = _("Roster Management");
        $security_areas['SA_ROSTERVIEW'] = array(SS_ROSTER | 1, _("View Roster"));
        $security_areas['SA_ROSTERCREATE'] = array(SS_ROSTER | 2, _("Create Shifts"));
        $security_areas['SA_ROSTEREDIT'] = array(SS_ROSTER | 3, _("Edit Shifts"));
        $security_areas['SA_ROSTERDELETE'] = array(SS_ROSTER | 4, _("Delete Shifts"));
        $security_areas['SA_ROSTERPUBLISH'] = array(SS_ROSTER | 5, _("Publish Schedule"));
        return array($security_areas, $security_sections);
    }

    function activate_extension($company, $check_only=true) {
        $updates = array('sql/update.sql' => array($this->module_name));
        $ok = $this->update_databases($company, $updates, $check_only);
        if ($check_only || !$ok) {
            return $ok;
        }
        $this->ensure_roster_schema();
        return $ok;
    }

    private function table_exists($table) {
        $sql = "SHOW TABLES LIKE " . db_escape($table);
        $res = db_query($sql, 'Failed checking table existence');
        return db_num_rows($res) > 0;
    }

    private function ensure_roster_schema() {
        $tables = array(
            TB_PREF . "fa_roster_shifts" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_roster_shifts` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `employee_id` VARCHAR(100) NOT NULL,
                    `shift_date` DATE NOT NULL,
                    `start_time` TIME NOT NULL,
                    `end_time` TIME NOT NULL,
                    `shift_type` VARCHAR(20) DEFAULT 'Regular',
                    `status` VARCHAR(20) DEFAULT 'Scheduled',
                    `notes` TEXT,
                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`),
                    KEY `idx_employee` (`employee_id`),
                    KEY `idx_date` (`shift_date`),
                    KEY `idx_status` (`status`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci",

            TB_PREF . "fa_roster_availability" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_roster_availability` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `employee_id` VARCHAR(100) NOT NULL,
                    `day_of_week` INT(11) NOT NULL,
                    `start_time` TIME DEFAULT NULL,
                    `end_time` TIME DEFAULT NULL,
                    `is_available` TINYINT(1) DEFAULT 1,
                    PRIMARY KEY (`id`),
                    KEY `idx_employee` (`employee_id`),
                    KEY `idx_day` (`day_of_week`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci",

            TB_PREF . "fa_roster_swaps" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_roster_swaps` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `requestor_id` VARCHAR(100) NOT NULL,
                    `requested_shift_id` INT(11) NOT NULL,
                    `target_employee_id` VARCHAR(100) DEFAULT NULL,
                    `target_shift_id` INT(11) DEFAULT NULL,
                    `status` VARCHAR(20) DEFAULT 'Pending',
                    `reason` TEXT,
                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`),
                    KEY `idx_requestor` (`requestor_id`),
                    KEY `idx_status` (`status`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
        );

        foreach ($tables as $table_name => $sql) {
            db_query($sql, "Could not create Roster table: $table_name");
        }
    }

    function db_prevoid($trans_type, $trans_no) {
        // Handle voiding if needed
    }
}
?>
