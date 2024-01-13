<?php

$conn = mysqli_connect("localhost", "root", "", "uniwear");

$aksi = $_POST["aksi"];
if ($aksi == "register") {
    register($_POST);
} else if ($aksi == "login") {
    login($_POST);
} else if ($aksi == "getTotalKlub") {
    getTotalClub();
} else if ($aksi == "getTotalSupporter") {
    getTotalSupporter();
} else if ($aksi == "tambahKlubBola") {
    tambahDataKlub($_POST);
} else if ($aksi == "tampilKlubBola") {
    getDataKlub();
} else if ($aksi == "editKlubBola") {
    updateKlub($_POST);
} else if ($aksi == "hapusKlubBola") {
    deleteClub($_POST);
} else if ($aksi == "cariKlubBola") {
    searchClub($_POST);
} else if ($aksi == "tambahSupporter") {
    tambahSupporter($_POST, $_FILES["foto"]);
} else if ($aksi == "tampilSupporter") {
    getDataSupporter();
} else if ($aksi == "editSupporter") {
    editSupporter($_POST);
} else if ($aksi == "editSupporterWithFoto") {
    editSupporterWithFoto($_POST, $_FILES["foto"]);
} else if ($aksi == "cariSupporter") {
    searchSupporter($_POST);
} else if ($aksi == "hapusSupporter") {
    deleteSupporter($_POST);
}

function register($data)
{
    global $conn;
    $nama = $data["nama"];
    $username = $data["username"];
    $password = password_hash($data["password"], PASSWORD_DEFAULT);

    $query = "INSERT INTO user VALUES(NULL, ?, ?, ?)";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "sss", $nama, $username, $password);
    mysqli_stmt_execute($stmt);
}

function login($data)
{
    global $conn;
    $username = $data["username"];
    $password = $data["password"];

    $query = "SELECT * FROM user WHERE username = '$username'";
    $result = mysqli_query($conn, $query);
    if ($row = mysqli_fetch_assoc($result)) {
        if (password_verify($password, $row["password"])) {
            echo json_encode("true");
        } else {
            echo json_encode("Password Salah!");
        }
    } else {
        echo json_encode("Username Tidak Terdaftar!");
    }
}

function getTotalClub()
{
    global $conn;
    $query = "SELECT COUNT(*) FROM klub";
    $result = mysqli_query($conn, $query);
    if ($row = mysqli_fetch_assoc($result)) {
        echo json_encode($row["COUNT(*)"]);
    }
}

function getTotalSupporter()
{
    global $conn;
    $query = "SELECT COUNT(*) FROM supporter";
    $result = mysqli_query($conn, $query);
    if ($row = mysqli_fetch_assoc($result)) {
        echo json_encode($row["COUNT(*)"]);
    }
}

function tambahDataKlub($data)
{
    global $conn;
    $idKlub = $data["idKlub"];
    $namaKlub = $data["namaKlub"];
    $tanggalBerdiri = $data["tanggalBerdiri"];
    $kondisiKlub = $data["kondisiKlub"];
    $kotaKlub = $data["kotaKlub"];
    $peringkat = $data["peringkat"];
    $hargaKlub = $data["hargaKlub"];

    $query = "INSERT INTO klub VALUES(?, ?, ?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "isssssi", $idKlub, $namaKlub, $tanggalBerdiri, $kondisiKlub, $kotaKlub, $peringkat, $hargaKlub);
    mysqli_stmt_execute($stmt);
}

function getDataKlub()
{
    global $conn;
    $query = "SELECT * FROM klub";
    $result = mysqli_query($conn, $query);
    $rows = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $rows[] = $row;
    }
    echo json_encode($rows);
}

function updateKlub($data)
{
    global $conn;
    $idKlub = $data["idKlub"];
    $namaKlub = $data["namaKlub"];
    $tanggalBerdiri = $data["tanggalBerdiri"];
    $kondisiKlub = $data["kondisiKlub"];
    $kotaKlub = $data["kotaKlub"];
    $peringkat = $data["peringkat"];
    $hargaKlub = $data["hargaKlub"];

    $query = "UPDATE klub SET nama_klub = ?, tanggal_berdiri = ?, kondisi_klub = ?, kota_klub = ?, peringkat = ?, hargaKlub = ? WHERE id_klub = ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "sssssii", $namaKlub, $tanggalBerdiri, $kondisiKlub, $kotaKlub, $peringkat, $hargaKlub, $idKlub);
    mysqli_stmt_execute($stmt);
}

function deleteClub($data)
{
    global $conn;
    $idKlub = $data["idKlub"];

    $query = "DELETE FROM klub WHERE id_klub = $idKlub";
    mysqli_query($conn, $query);
}

function searchClub($data)
{
    global $conn;
    $keywords = $data["keywords"];
    $keywords = "%$keywords%";
    $query = "SELECT * FROM klub WHERE id_klub LIKE ? OR nama_klub LIKE ? OR tanggal_berdiri LIKE ? OR kondisi_klub LIKE ? OR kota_klub LIKE ? OR peringkat LIKE ? OR hargaKlub LIKE ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "isssssi", $keywords, $keywords, $keywords, $keywords, $keywords, $keywords, $keywords);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_bind_result($stmt, $id_klub, $nama_klub, $tanggal_berdiri, $kondisi_klub, $kota_klub, $peringkat, $harga_klub);
    $rows = [];
    while (mysqli_stmt_fetch($stmt)) {
        $rows[] = [
            "id_klub" =>  (string) $id_klub,
            "nama_klub" => $nama_klub,
            "tanggal_berdiri" => $tanggal_berdiri,
            "kondisi_klub" => $kondisi_klub,
            "kota_klub" => $kota_klub,
            "peringkat" => $peringkat,
            "hargaKlub" => (string) $harga_klub,
        ];
    }
    echo json_encode($rows);
}

function tambahSupporter($data, $foto)
{
    global $conn;

    $idSupporter = $data["idSupporter"];
    $namaSupporter = $data["namaSupporter"];
    $alamat = $data["alamat"];
    $tanggalDaftar = $data["tanggalDaftar"];
    $noTelephone = $data["noTelephone"];

    $ekstensiFoto = explode(".", $foto["name"])[1];
    $namaFoto = date("YmdHis") . ".$ekstensiFoto";
    move_uploaded_file($foto["tmp_name"], "uploads/$namaFoto");

    $query = "INSERT INTO supporter VALUES(?, ?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "isssss", $idSupporter, $namaSupporter, $alamat, $tanggalDaftar, $noTelephone, $namaFoto);
    mysqli_stmt_execute($stmt);
}

function getDataSupporter()
{
    global $conn;
    $query = "SELECT * FROM supporter";
    $result = mysqli_query($conn, $query);
    $rows = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $rows[] = $row;
    }
    echo json_encode($rows);
}

function editSupporter($data)
{
    global $conn;
    $idSupporter = $data["idSupporter"];
    $namaSupporter = $data["namaSupporter"];
    $alamat = $data["alamat"];
    $tanggalDaftar = $data["tanggalDaftar"];
    $noTelephone = $data["noTelephone"];

    $query = "UPDATE supporter SET nama_supporter = ?, alamat = ?, tanggal_daftar = ?, no_telephone = ? WHERE id_supporter = ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "ssssi", $namaSupporter, $alamat, $tanggalDaftar, $noTelephone, $idSupporter);
    mysqli_stmt_execute($stmt);
}

function editSupporterWithFoto($data, $foto)
{
    global $conn;
    $idSupporter = $data["idSupporter"];
    $namaSupporter = $data["namaSupporter"];
    $alamat = $data["alamat"];
    $tanggalDaftar = $data["tanggalDaftar"];
    $noTelephone = $data["noTelephone"];

    $ekstensiFoto = explode(".", $foto["name"])[1];
    $namaFoto = date("YmdHis") . ".$ekstensiFoto";
    move_uploaded_file($foto["tmp_name"], "uploads/$namaFoto");

    $namaGambarLama = $data["namaGambarLama"];
    unlink("uploads/$namaGambarLama");

    $query = "UPDATE supporter SET nama_supporter = ?, alamat = ?, tanggal_daftar = ?, no_telephone = ?, foto = ? WHERE id_supporter = ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "sssssi", $namaSupporter, $alamat, $tanggalDaftar, $noTelephone, $namaFoto, $idSupporter);
    mysqli_stmt_execute($stmt);
}

function searchSupporter($data)
{
    global $conn;
    $keywords = $data["keywords"];
    $keywords = "%$keywords%";
    $query = "SELECT * FROM supporter WHERE id_supporter LIKE ? OR nama_supporter LIKE ? OR alamat LIKE ? OR tanggal_daftar LIKE ? OR no_telephone LIKE ?";
    $stmt = mysqli_prepare($conn, $query);
    mysqli_stmt_bind_param($stmt, "issss", $keywords, $keywords, $keywords, $keywords, $keywords);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_bind_result($stmt, $id_supporter, $nama_supporter, $alamat, $tanggal_daftar, $no_telephone, $foto);
    $rows = [];
    while (mysqli_stmt_fetch($stmt)) {
        $rows[] = [
            "id_supporter" =>  (string) $id_supporter,
            "nama_supporter" => $nama_supporter,
            "alamat" => $alamat,
            "tanggal_daftar" => $tanggal_daftar,
            "no_telephone" => $no_telephone,
            "foto" => $foto,
        ];
    }
    echo json_encode($rows);
}

function deleteSupporter($data)
{
    global $conn;
    $idSupporter = $data["idSupporter"];
    $namaFotoLama = $data["namaFotoLama"];

    $query = "DELETE FROM supporter WHERE id_supporter = $idSupporter";
    mysqli_query($conn, $query);
    unlink("uploads/$namaFotoLama");
}
