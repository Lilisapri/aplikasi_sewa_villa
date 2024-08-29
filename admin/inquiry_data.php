<?php
// Database connection
$host = 'localhost';
$user = 'root';
$password = '';
$dbname = 'lodge_db';

$conn = new mysqli($host, $user, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch data from the inquiry table
$query = "SELECT DATE(created_at) as date, COUNT(*) as count FROM inquiry GROUP BY DATE(created_at)";
$result = $conn->query($query);

$labels = [];
$values = [];

while ($row = $result->fetch_assoc()) {
    $labels[] = $row['date'];
    $values[] = $row['count'];
}

echo json_encode(['labels' => $labels, 'values' => $values]);

$conn->close();
?>