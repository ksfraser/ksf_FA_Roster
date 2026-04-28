<?php
/**
 * Roster Database Functions
 */

function create_shift(int $employee_id, string $date, string $shift, string $start_time, string $end_time, string $notes = ''): int
{
    global $db;
    $sql = "INSERT INTO " . TB_PREF . "roster_shifts 
        (employee_id, date, shift, start_time, end_time, status, created_by, notes)
        VALUES (" . $employee_id . ", " . $db->escape($date) . ", " . $db->escape($shift) . ", " . $db->escape($start_time) . ", " . $db->escape($end_time) . ", 'Scheduled', " . user_id() . ", " . $db->escape($notes) . ")";
    $db->query($sql);
    return $db->insert_id;
}

function get_shift(int $id): ?array
{
    global $db;
    $sql = "SELECT * FROM " . TB_PREF . "roster_shifts WHERE id = " . $id;
    $result = $db->query($sql);
    if ($result && $db->num_rows($result) > 0) {
        return $db->fetch($result);
    }
    return null;
}

function update_shift(int $id, int $employee_id, string $date, string $shift, string $start_time, string $end_time, string $notes = ''): bool
{
    global $db;
    $sql = "UPDATE " . TB_PREF . "roster_shifts SET employee_id = " . $employee_id . ", date = " . $db->escape($date) . ", shift = " . $db->escape($shift) . ", start_time = " . $db->escape($start_time) . ", end_time = " . $db->escape($end_time) . ", notes = " . $db->escape($notes) . " WHERE id = " . $id;
    return $db->query($sql);
}

function get_weekly_shifts(string $start, string $end): ?object
{
    global $db;
    $sql = "SELECT s.*, e.name FROM " . TB_PREF . "roster_shifts s
        LEFT JOIN " . TB_PREF . "hr_employees e ON s.employee_id = e.id
        WHERE s.date >= " . $db->escape($start) . " AND s.date <= " . $db->escape($end) . "
        ORDER BY e.name, s.date";
    return $db->query($sql);
}

function get_employee_shift(int $employee_id, string $date): ?array
{
    global $db;
    $sql = "SELECT * FROM " . TB_PREF . "roster_shifts WHERE employee_id = " . $employee_id . " AND date = " . $db->escape($date);
    $result = $db->query($sql);
    if ($result && $db->num_rows($result) > 0) {
        return $db->fetch($result);
    }
    return null;
}

function get_employee_shifts(int $employee_id, string $start, string $end): ?object
{
    global $db;
    $sql = "SELECT * FROM " . TB_PREF . "roster_shifts WHERE employee_id = " . $employee_id . " AND date >= " . $db->escape($start) . " AND date <= " . $db->escape($end) . " ORDER BY date";
    return $db->query($sql);
}

function get_employees_list(): ?object
{
    global $db;
    $sql = "SELECT id, name FROM " . TB_PREF . "hr_employees WHERE active = 1 ORDER BY name";
    return $db->query($sql);
}

function get_employees_list_options(): array
{
    $result = get_employees_list();
    $options = [];
    while ($row = db_fetch($result)) {
        $options[$row['id']] = $row['name'];
    }
    return $options;
}

function publish_schedule(string $week): bool
{
    global $db;
    $sql = "INSERT INTO " . TB_PREF . "sys_prefs (name, value) VALUES ('roster_published_week', " . $db->escape($week) . ")
        ON DUPLICATE KEY UPDATE value = " . $db->escape($week);
    return $db->query($sql);
}

function get_published_schedule(): ?string
{
    global $db;
    $sql = "SELECT value FROM " . TB_PREF . "sys_prefs WHERE name = 'roster_published_week'";
    $result = $db->query($sql);
    if ($result && $db->num_rows($result) > 0) {
        $row = $db->fetch($result);
        return $row['value'];
    }
    return null;
}