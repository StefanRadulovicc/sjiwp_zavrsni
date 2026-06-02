<?php
include "db.php";
$greska = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $korisnik_id     = (int)$_POST['korisnik_id'];
    $vjezba_id       = (int)$_POST['vjezba_id'];
    $max_opterecenje = (float)$_POST['max_opterecenje'];
    $ponavljanja     = (int)$_POST['ponavljanja'];
    $datum           = $_POST['datum'];

    if ($korisnik_id <= 0 || $vjezba_id <= 0 || $ponavljanja <= 0 || $max_opterecenje < 0) {
        $greska = "Sva polja moraju biti ispravno popunjena (ponavljanja > 0, težina >= 0).";
    } else {
        $stmt = $conn->prepare("INSERT INTO OsobniRekord (korisnik_id, vjezba_id, MaxOpterecenje_kg, BrojPonavljanja, DatumPostizanja) VALUES (?, ?, ?, ?, ?)");
        // Tipovi: i=int, i=int, d=double, i=int, s=string (datum) -> "iidis"
        $stmt->bind_param("iidis", $korisnik_id, $vjezba_id, $max_opterecenje, $ponavljanja, $datum);
        
        if ($stmt->execute()) {
            header("Location: index.php?poruka=dodano");
            exit;
        } else {
            // Hvatanje SQL greške (npr. ako se prekrši UNIQUE ograničenje)
            $greska = "Greška pri unosu: " . $conn->error;
        }
    }
}

// Dohvaćanje podataka za dropdown liste
$korisnici = $conn->query("SELECT ID_korisnik, Ime FROM Korisnik ORDER BY Ime");
$vjezbe    = $conn->query("SELECT ID_vjezba, Naziv FROM Vjezba ORDER BY Naziv");
?>

<!DOCTYPE html>
<html lang="hr">
<head><meta charset="UTF-8"><title>Dodaj Rekord</title></head>
<body style="font-family: Arial; padding: 20px;">

<h1>Novi Osobni Rekord</h1>
<?php if ($greska): ?><p style="color:red; font-weight:bold;"><?= $greska ?></p><?php endif; ?>

<form method="POST">
    <label>Korisnik:<br>
        <select name="korisnik_id" required>
            <option value="">-- Odaberi korisnika --</option>
            <?php while ($k = $korisnici->fetch_assoc()): ?>
                <option value="<?= $k['ID_korisnik'] ?>"><?= htmlspecialchars($k['Ime']) ?></option>
            <?php endwhile; ?>
        </select>
    </label><br><br>

    <label>Vježba:<br>
        <select name="vjezba_id" required>
            <option value="">-- Odaberi vježbu --</option>
            <?php while ($v = $vjezbe->fetch_assoc()): ?>
                <option value="<?= $v['ID_vjezba'] ?>"><?= htmlspecialchars($v['Naziv']) ?></option>
            <?php endwhile; ?>
        </select>
    </label><br><br>

    <label>Maksimalno opterećenje (kg):<br>
        <input type="number" name="max_opterecenje" step="0.1" min="0" required>
    </label><br><br>

    <label>Broj ponavljanja:<br>
        <input type="number" name="ponavljanja" min="1" required>
    </label><br><br>

    <label>Datum postizanja:<br>
        <input type="date" name="datum" required>
    </label><br><br>

    <button type="submit" style="padding: 10px; background: #28a745; color: white; border: none; border-radius: 3px; cursor: pointer;">💾 Spremi rekord</button>
    <a href="index.php" style="margin-left: 10px; text-decoration: none; color: #555;">Odustani</a>
</form>

</body></html>