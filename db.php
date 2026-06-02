<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$host     = "localhost";
$korisnik = "root";
$lozinka  = "";
$baza     = "FitTrack"; // Ovdje smo osigurali točna velika slova F i T!

$conn = new mysqli($host, $korisnik, $lozinka, $baza);

if ($conn->connect_error) {
    die("Greška pri spajanju na bazu: " . $conn->connect_error);
}

$conn->set_charset("utf8mb4");
?>