<?php
include "db.php";

$id = (int)$_GET['id'];

if ($id > 0) {
    $stmt = $conn->prepare("DELETE FROM OsobniRekord WHERE ID_rekord = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
}

// Povratak na početnu s porukom
header("Location: index.php?poruka=obrisano");
exit;
?>