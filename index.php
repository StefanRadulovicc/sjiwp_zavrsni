<?php 
include "db.php"; 

// --- 1. DOHVAĆANJE STATISTIKE ZA DASHBOARD ---
// Ukupan broj rekorda
$stat_ukupno_rez = $conn->query("SELECT COUNT(*) AS ukupno FROM OsobniRekord");
$stat_ukupno = $stat_ukupno_rez->fetch_assoc()['ukupno'];

// Najveća podignuta težina ikad
$stat_max_rez = $conn->query("SELECT MAX(MaxOpterecenje_kg) AS max_kg FROM OsobniRekord");
$stat_max = $stat_max_rez->fetch_assoc()['max_kg'];


// --- 2. LOGIKA ZA TRAŽILICU ---
$trazi = isset($_GET['trazi']) ? trim($_GET['trazi']) : '';

// Osnovni SQL upit koji povezuje 3 tablice

// Osnovni SQL upit prilagođen tvojoj originalnoj bazi iz završnog rada
$sql = "SELECT r.ID_rekord, k.Ime AS Korisnik, v.Naziv AS Vjezba, r.MaxOpterecenje_kg, r.BrojPonavljanja, r.DatumPostizanja 
        FROM OsobniRekord r
        JOIN Korisnik k ON r.korisnik_id = k.ID_korisnik
        JOIN Vjezba v ON r.vjezba_id = v.ID_vjezba";
// Ako je korisnik nešto upisao u tražilicu, dodajemo WHERE uvjet s prepared statementom
if ($trazi !== '') {
    $sql .= " WHERE k.Ime LIKE ? OR v.Naziv LIKE ? ";
}

$sql .= " ORDER BY r.DatumPostizanja DESC";
?>
<!DOCTYPE html>
<html lang="hr">
<head>
    <meta charset="UTF-8">
    <title>FitTrack - Osobni Rekordi</title>
    <link rel="stylesheet" href="stil.css">
</head>
<body>

<h1>🏆 FitTrack Dashboard</h1>

<div class="stats-container">
    <div class="stat-card">
        <h3>Ukupno rekorda</h3>
        <p><?= $stat_ukupno ?></p>
    </div>
    <div class="stat-card accent">
        <h3>Apsolutni Max (kg)</h3>
        <p><?= number_format($stat_max, 1) ?> kg</p>
    </div>
</div>

<?php
// Prikaz poruka o uspjehu (CRUD akcije)
if (isset($_GET['poruka'])) {
    $poruke = [
        'dodano'    => '✅ Rekord je uspješno dodan.',
        'azurirano' => '✅ Rekord je uspješno ažuriran.',
        'obrisano'  => '✅ Rekord je uspješno obrisan.'
    ];
    $kljuc = $_GET['poruka'];
    if (isset($poruke[$kljuc])) {
        echo "<div class='uspjeh'>" . $poruke[$kljuc] . "</div>";
    }
}
?>

<div class="toolbar">
    <a href="dodaj.php" class="btn">➕ Dodaj novi rekord</a>
    
    <form method="GET" action="index.php" class="search-form">
        <input type="text" name="trazi" placeholder="Pretraži po korisniku ili vježbi..." value="<?= htmlspecialchars($trazi) ?>">
        <button type="submit" class="btn-search">🔍 Traži</button>
        <?php if ($trazi !== ''): ?>
            <a href="index.php" class="btn-clear">Očisti</a>
        <?php endif; ?>
    </form>
</div>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Korisnik</th>
            <th>Vježba</th>
            <th>Max Opterećenje</th>
            <th>Ponavljanja</th>
            <th>Datum postizanja</th>
            <th>Akcije</th>
        </tr>
    </thead>
    <tbody>
<?php
// Izvršavanje upita (običan ili s prepared statementom ako se traži pojam)
if ($trazi !== '') {
    $stmt = $conn->prepare($sql);
    $uzorak = "%" . $trazi . "%";
    $stmt->bind_param("ss", $uzorak, $uzorak);
    $stmt->execute();
    $rezultat = $stmt->get_result();
} else {
    $rezultat = $conn->query($sql);
}

// Provjera ima li uopće rezultata
if ($rezultat->num_rows === 0):
?>
    <tr>
        <td colspan="7" style="text-align: center; color: #7f8c8d; padding: 30px;">Nema pronađenih rekorda za traženi pojam.</td>
    </tr>
<?php
else:
    while ($red = $rezultat->fetch_assoc()):
?>
    <tr>
        <td><strong>#<?= $red['ID_rekord'] ?></strong></td>
        <td><?= htmlspecialchars($red['Korisnik']) ?></td>
        <td><span class="badge-vjezba"><?= htmlspecialchars($red['Vjezba']) ?></span></td>
        <td><span class="text-kg"><?= number_format($red['MaxOpterecenje_kg'] ?? 0 , 1) ?> kg</span></td>
        <td><?= $red['BrojPonavljanja'] ?> ×</td>
        <td><?= date("d.m.Y.", strtotime($red['DatumPostizanja'])) ?></td>
        <td>
            <a href="uredi.php?id=<?= $red['ID_rekord'] ?>" class="btn-action edit">✏️ Uredi</a>
            <a href="obrisi.php?id=<?= $red['ID_rekord'] ?>" class="btn-action delete" onclick="return confirm('Jeste li sigurni da želite obrisati ovaj rekord?')">🗑️ Obriši</a>
        </td>
    </tr>
<?php 
    endwhile; 
endif;
?>
    </tbody>
</table>

<?php $conn->close(); ?>
</body>
</html>