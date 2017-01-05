<?php
$db = new PDO(
    sprintf('%s:host=%s;port=%s', 'mysql', 'localhost', '3306'),
    'root',
    'root'
);
$result = $db->query('SET NAMES utf8;');
echo 'Success to MySQL connect.';