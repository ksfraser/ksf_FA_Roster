<?php
/**
 * Roster Module for FrontAccounting
 */

$module_id = 'Roster';
$module_version = '1.0.0';
$module_name = 'Roster Scheduling';
$module_description = 'Employee roster scheduling with shift management';

$module_tables = [
    'fa_roster_shifts',
    'fa_roster_availability',
    'fa_roster_swaps',
];

$module_capabilities = [
    'SA_ROSTERVIEW' => 'View Roster',
    'SA_ROSTERCREATE' => 'Create Shifts',
    'SA_ROSTEREDIT' => 'Edit Shifts',
    'SA_ROSTERDELETE' => 'Delete Shifts',
    'SA_ROSTERPUBLISH' => 'Publish Schedule',
];

function roster_install(): bool
{
    global $db, $db_multi_sql;
    $sql_file = dirname(__FILE__) . '/../sql/install.sql';
    if (!file_exists($sql_file)) return false;
    $sql = file_get_contents($sql_file);
    return $db_multi_sql($sql);
}

function roster_enable(): bool
{
    global $db;
    return $db->query("UPDATE " . TB_PREF . "modules SET enabled = 1 WHERE name = 'Roster'");
}

function roster_disable(): bool
{
    global $db;
    return $db->query("UPDATE " . TB_PREF . "modules SET enabled = 0 WHERE name = 'Roster'");
}

function roster_remove(): bool
{
    global $db, $db_multi_sql;
    $sql = "DROP TABLE IF EXISTS " . TB_PREF . "roster_swaps;
           DROP TABLE IF EXISTS " . TB_PREF . "roster_availability;
           DROP TABLE IF EXISTS " . TB_PREF . "roster_shifts;
           DELETE FROM " . TB_PREF . "modules WHERE name = 'Roster';";
    return $db_multi_sql($sql);
}

add_module($module_name, $module_version, $module_description);