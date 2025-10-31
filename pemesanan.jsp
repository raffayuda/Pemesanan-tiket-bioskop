<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pemesanan Tiket - Sistem Pemesanan Tiket Bioskop</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Pemesanan Tiket</h1>
        </header>

        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="film.jsp">Daftar Film</a></li>
                <li><a href="pemesanan.jsp">Pemesanan</a></li>
                <li><a href="tentang.jsp">Tentang</a></li>
            </ul>
        </nav>

        <main>
            <section class="booking-form">
                <h2>Form Pemesanan</h2>
                <form action="BookingServlet" method="post">
                    <div class="form-group">
                        <label for="nama">Nama Lengkap:</label>
                        <input type="text" id="nama" name="nama" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <label for="film">Pilih Film:</label>
                        <select id="film" name="film" required>
                            <option value="">-- Pilih Film --</option>
                            <!-- Options akan diisi dari database -->
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="tanggal">Tanggal:</label>
                        <input type="date" id="tanggal" name="tanggal" required>
                    </div>

                    <div class="form-group">
                        <label for="jam">Jam:</label>
                        <select id="jam" name="jam" required>
                            <option value="">-- Pilih Jam --</option>
                            <option value="12:00">12:00</option>
                            <option value="15:00">15:00</option>
                            <option value="18:00">18:00</option>
                            <option value="21:00">21:00</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="jumlah">Jumlah Tiket:</label>
                        <input type="number" id="jumlah" name="jumlah" min="1" max="10" required>
                    </div>

                    <button type="submit" class="btn-submit">Pesan Tiket</button>
                </form>
            </section>
        </main>

        <footer>
            <p>&copy; 2025 Sistem Pemesanan Tiket Bioskop. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>
