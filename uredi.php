<?php
include "db.php";
$id = (int)$_GET['id'];

// Obrada POST zahtjeva
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $korisnik_id     = (int)$_POST['korisnik_id'];
    $vjezba_id       = (int)$_POST['vjezba_id'];
    $max_opterecenje = (float)$_POST['max_opterecenje'];
    $ponavljanja     = (int)$_POST['ponavljanja'];
    $datum           = $_POST['datum'];

    $stmt = $conn->prepare("UPDATE OsobniRekord SET korisnik_id=?, vjezba_id=?, MaxOpterecenje_kg=?, BrojPonavljanja=?, DatumPostizanja=? WHERE ID_rekord=?");
    // Tipovi: iidis + i (za ID) -> "iidisi"
    $stmt->bind_param("iidisi", $korisnik_id, $vjezba_id, $max_opterecenje, $ponavljanja, $datum, $id);
    
    if ($stmt->execute()) {
        header("Location: index.php?poruka=azurirano");
        exit;
    } else {
        echo "<p style='color:red;'>Greška: " . $conn->error . "</p>";
    }
}

// Dohvati trenutni rekord
$stmt = $conn->prepare("SELECT * FROM OsobniRekord WHERE ID_rekord = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$rekord = $stmt->get_result()->fetch_assoc();

if (!$rekord) die("Rekord ne postoji.");

// Dohvati liste za padajuće izbornike
$korisnici = $conn->query("SELECT ID_korisnik, Ime FROM Korisnik ORDER BY Ime");
$vjezbe    = $conn->query("SELECT ID_vjezba, Naziv FROM Vjezba ORDER BY Naziv");
?>

<!DOCTYPE html>
<html lang="hr">
<head><meta charset="UTF-8"><title>Uredi Rekord</title></head>
<body style="font-family: Arial; padding: 20px;">

<h1>Uredi Osobni Rekord #<?= $id ?></h1>

<form method="POST">
    <label>Korisnik:<br>
        <select name="korisnik_id" required>
            <?php while ($k = $korisnici->fetch_assoc()): ?>
                <option value="<?= $k['ID_korisnik'] ?>" <?= $k['ID_korisnik'] == $rekord['korisnik_id'] ? 'selected' : '' ?>>
                    <?= htmlspecialchars($k['Ime']) ?>
                </option>
            <?php endwhile; ?>
        </select>
    </label><br><br>

    <label>Vježba:<br>
        <select name="vjezba_id" required>
            <?php while ($v = $vjezbe->fetch_assoc()): ?>
                <option value="<?= $v['ID_vjezba'] ?>" <?= $v['ID_vjezba'] == $rekord['vjezba_id'] ? 'selected' : '' ?>>
                    <?= htmlspecialchars($v['Naziv']) ?>
                </option>
            <?php endwhile; ?>
        </select>
    </label><br><br>

    <label>Maksimalno opterećenje (kg):<br>
        <input type="number" name="max_opterecenje" step="0.1" min="0" value="<?= $rekord['MaxOpterecenje_kg'] ?>" required>
    </label><br><br>

    <label>Broj ponavljanja:<br>
        <input type="number" name="ponavljanja" min="1" value="<?= $rekord['BrojPonavljanja'] ?>" required>
    </label><br><br>

    <label>Datum postizanja:<br>
        <input type="date" name="datum" value="<?= $rekord['DatumPostizanja'] ?>" required>
    </label><br><br>

    <button type="submit" style="padding: 10px; background: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer;">💾 Spremi izmjene</button>
    <a href="index.php" style="margin-left: 10px; text-decoration: none; color: #555;">Odustani</a>
</form>

</body></html>