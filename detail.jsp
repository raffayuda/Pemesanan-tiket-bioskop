<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">\
    <style>
        * { font-family: 'Inter', sans-serif; }
        [x-cloak] { display: none !important; }
        
        .hero-gradient {
            background: linear-gradient(to right, rgba(0,0,0,0.95) 0%, rgba(0,0,0,0.7) 50%, rgba(0,0,0,0.3) 100%);
        }
        
        .text-gradient {
            background: linear-gradient(135deg, #EF4444 0%, #DC2626 50%, #991B1B 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .glassmorphism {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .badge-glow {
            box-shadow: 0 0 20px rgba(239, 68, 68, 0.6);
        }
    </style>
</head>
<body class="bg-black text-white" x-data="movieDetail()">
     <!-- Navigation -->
    <nav class="fixed top-0 w-full z-50 bg-black/95 backdrop-blur-md shadow-2xl">
        <div class="container mx-auto px-4 lg:px-8 py-4 flex items-center justify-between">
            <div class="flex items-center space-x-8">
                <a href="index.html" class="text-gradient text-3xl lg:text-4xl font-black tracking-tight">BODAYCINEMA</a>
            </div>
            <a href="index.html" class="glassmorphism px-6 py-2 rounded-full hover:bg-white/20 transition font-semibold">
                ← Kembali
            </a>
        </div>
    </nav>
    <!-- Navigation -->
    <nav class="fixed top-0 w-full z-50 bg-black/95 backdrop-blur-md shadow-2xl">
        <div class="container mx-auto px-4 lg:px-8 py-4 flex items-center justify-between">
            <div class="flex items-center space-x-8">
                <a href="index.html" class="text-gradient text-3xl lg:text-4xl font-black tracking-tight">BODAYCINEMA</a>
            </div>
            <a href="index.html" class="glassmorphism px-6 py-2 rounded-full hover:bg-white/20 transition font-semibold">
                ← Kembali
            </a>
        </div>
    </nav>

    <!-- Hero Detail -->
    <section class="relative min-h-screen pt-20">
        <div class="absolute inset-0">
            <img :src="movie.image" alt="Movie" class="w-full h-full object-cover">
            <div class="absolute inset-0 hero-gradient"></div>
        </div>
        
        <div class="relative z-10 container mx-auto px-4 lg:px-8 min-h-screen flex items-center py-20">
            <div class="grid lg:grid-cols-3 gap-8 w-full">
                <!-- Poster -->
                <div class="flex justify-center lg:justify-start">
                    <img :src="movie.image" :alt="movie.title" class="w-80 h-auto rounded-2xl shadow-2xl">
                </div>
                
                <!-- Info -->
                <div class="lg:col-span-2 space-y-6">
                    <div>
                        <span class="px-4 py-2 bg-red-600 badge-glow text-xs font-bold uppercase tracking-wider rounded-full">
                            Sedang Tayang
                        </span>
                    </div>
                    
                    <h1 class="text-4xl md:text-6xl font-black" x-text="movie.title"></h1>
                    
                    <div class="flex flex-wrap items-center gap-4 text-lg">
                        <div class="flex items-center space-x-1">
                            <svg class="w-6 h-6 text-yellow-400 fill-current" viewBox="0 0 20 20">
                                <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                            </svg>
                            <span class="text-yellow-400 font-bold" x-text="movie.rating"></span>
                        </div>
                        <span x-text="movie.year"></span>
                        <span class="px-3 py-1 border-2 border-gray-400 text-sm font-bold rounded" x-text="movie.ageRating"></span>
                        <span x-text="movie.duration"></span>
                    </div>
                    
                    <div class="flex flex-wrap gap-2">
                        <template x-for="genre in movie.genres" :key="genre">
                            <span class="px-4 py-2 glassmorphism rounded-full text-sm font-semibold" x-text="genre"></span>
                        </template>
                    </div>
                    
                    <p class="text-xl leading-relaxed text-gray-200" x-text="movie.description"></p>
                    
                    <div class="grid md:grid-cols-2 gap-4 glassmorphism p-6 rounded-xl">
                        <div>
                            <h3 class="text-gray-400 text-sm mb-2">Sutradara</h3>
                            <p class="font-bold" x-text="movie.director"></p>
                        </div>
                        <div>
                            <h3 class="text-gray-400 text-sm mb-2">Penulis</h3>
                            <p class="font-bold" x-text="movie.writer"></p>
                        </div>
                        <div class="md:col-span-2">
                            <h3 class="text-gray-400 text-sm mb-2">Pemain</h3>
                            <p class="font-bold" x-text="movie.cast"></p>
                        </div>
                    </div>
                    
                    <div class="flex flex-wrap gap-4">
                        <button @click="openTicketModal()" class="bg-red-600 text-white px-10 py-4 rounded-full font-bold text-lg hover:bg-red-700 transform hover:scale-105 transition flex items-center space-x-3 shadow-2xl">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"></path>
                            </svg>
                            <span>Beli Tiket</span>
                        </button>
                        <button class="glassmorphism px-10 py-4 rounded-full font-bold text-lg hover:bg-white/20 transition flex items-center space-x-3">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"></path>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <span>Trailer</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Jadwal Tayang -->
    <section class="py-16 bg-gradient-to-b from-black to-gray-900">
        <div class="container mx-auto px-4 lg:px-8">
            <h2 class="text-3xl font-bold mb-8">📅 Jadwal Tayang</h2>
            
            <div class="grid md:grid-cols-3 gap-6">
                <template x-for="cinema in movie.cinemas" :key="cinema.name">
                    <div class="glassmorphism p-6 rounded-xl hover:bg-white/10 transition">
                        <h3 class="font-bold text-xl mb-4" x-text="cinema.name"></h3>
                        <p class="text-sm text-gray-400 mb-4" x-text="cinema.location"></p>
                        <div class="flex flex-wrap gap-2">
                            <template x-for="time in cinema.times" :key="time">
                                <button @click="openTicketModal(cinema.name, time)" 
                                        class="px-4 py-2 bg-white/10 hover:bg-red-600 rounded-lg font-bold transition"
                                        x-text="time"></button>
                            </template>
                        </div>
                    </div>
                </template>
            </div>
        </div>
    </section>

    <!-- Synopsis -->
    <section class="py-16">
        <div class="container mx-auto px-4 lg:px-8">
            <h2 class="text-3xl font-bold mb-6">📖 Sinopsis</h2>
            <div class="glassmorphism p-8 rounded-xl">
                <p class="text-lg leading-relaxed text-gray-200" x-text="movie.fullDescription"></p>
            </div>
        </div>
    </section>

    <!-- Modal Pembelian Tiket -->
    <div x-show="ticketModal" 
         x-cloak
         @click.self="ticketModal = false"
         class="fixed inset-0 bg-black/80 backdrop-blur-sm flex items-center justify-center z-50 p-4"
         x-transition>
        
        <div class="bg-gradient-to-br from-gray-900 to-black rounded-2xl max-w-4xl w-full max-h-[90vh] overflow-y-auto glassmorphism border border-white/20"
             @click.stop>
            
            <div class="sticky top-0 bg-gradient-to-br from-gray-900 to-black border-b border-white/10 p-6 flex items-center justify-between z-10">
                <div class="flex items-center space-x-4">
                    <div class="w-12 h-12 bg-red-600 rounded-full flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"></path>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-2xl font-bold" x-text="movie.title"></h3>
                        <p class="text-gray-400 text-sm">Pemesanan Tiket Bioskop</p>
                    </div>
                </div>
                <button @click="ticketModal = false" class="w-10 h-10 rounded-full glassmorphism hover:bg-white/20 transition flex items-center justify-center">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>

            <div class="p-6 space-y-6">
                <div class="flex gap-4 p-4 glassmorphism rounded-xl">
                    <img :src="movie.image" :alt="movie.title" class="w-24 h-36 object-cover rounded-lg">
                    <div class="flex-1">
                        <h4 class="font-bold text-lg mb-2" x-text="movie.title"></h4>
                        <div class="space-y-1 text-sm text-gray-300">
                            <p><span class="text-gray-400">Genre:</span> <span x-text="movie.genres?.join(', ')"></span></p>
                            <p><span class="text-gray-400">Durasi:</span> <span x-text="movie.duration"></span></p>
                            <p><span class="text-gray-400">Rating:</span> <span x-text="movie.ageRating"></span></p>
                        </div>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-semibold mb-3">Pilih Bioskop</label>
                    <select x-model="selectedCinema" class="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-red-500 transition">
                        <option value="">-- Pilih Bioskop --</option>
                        <template x-for="cinema in movie.cinemas" :key="cinema.name">
                            <option :value="cinema.name" x-text="cinema.name"></option>
                        </template>
                    </select>
                </div>

                <div>
                    <label class="block text-sm font-semibold mb-3">Pilih Tanggal</label>
                    <div class="grid grid-cols-4 gap-2">
                        <template x-for="date in availableDates" :key="date.value">
                            <button @click="selectedDate = date.value" 
                                    :class="selectedDate === date.value ? 'bg-red-600 border-red-600' : 'glassmorphism border-white/20 hover:bg-white/10'"
                                    class="p-3 rounded-lg border-2 transition text-center">
                                <div class="text-xs text-gray-400" x-text="date.day"></div>
                                <div class="font-bold" x-text="date.date"></div>
                                <div class="text-xs text-gray-400" x-text="date.month"></div>
                            </button>
                        </template>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-semibold mb-3">Pilih Jam Tayang</label>
                    <div class="grid grid-cols-4 md:grid-cols-6 gap-2">
                        <template x-for="time in showTimes" :key="time">
                            <button @click="selectedTime = time"
                                    :class="selectedTime === time ? 'bg-red-600 border-red-600' : 'glassmorphism border-white/20 hover:bg-white/10'"
                                    class="py-3 rounded-lg border-2 transition font-bold text-sm"
                                    x-text="time"></button>
                        </template>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-semibold mb-3">Jumlah Tiket</label>
                    <div class="flex items-center space-x-4">
                        <button @click="ticketCount = Math.max(1, ticketCount - 1)" 
                                class="w-12 h-12 glassmorphism rounded-lg hover:bg-white/20 transition font-bold text-xl">-</button>
                        <div class="flex-1 text-center">
                            <div class="text-3xl font-bold" x-text="ticketCount"></div>
                            <div class="text-sm text-gray-400">Tiket</div>
                        </div>
                        <button @click="ticketCount = Math.min(10, ticketCount + 1)" 
                                class="w-12 h-12 glassmorphism rounded-lg hover:bg-white/20 transition font-bold text-xl">+</button>
                    </div>
                </div>

                <div class="glassmorphism p-6 rounded-xl">
                    <div class="flex justify-between items-center mb-4">
                        <span class="text-gray-400">Harga per tiket</span>
                        <span class="font-bold">Rp 50.000</span>
                    </div>
                    <div class="flex justify-between items-center mb-4">
                        <span class="text-gray-400">Jumlah tiket</span>
                        <span class="font-bold" x-text="ticketCount + ' tiket'"></span>
                    </div>
                    <div class="border-t border-white/20 pt-4 flex justify-between items-center">
                        <span class="text-xl font-bold">Total Pembayaran</span>
                        <span class="text-2xl font-black text-red-500" x-text="'Rp ' + (50000 * ticketCount).toLocaleString('id-ID')"></span>
                    </div>
                </div>

                <button @click="confirmBooking()" 
                        :disabled="!selectedCinema || !selectedDate || !selectedTime"
                        :class="!selectedCinema || !selectedDate || !selectedTime ? 'opacity-50 cursor-not-allowed' : 'hover:bg-red-700 transform hover:scale-105'"
                        class="w-full bg-red-600 text-white py-4 rounded-full font-bold text-lg transition-all flex items-center justify-center space-x-3 shadow-2xl">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    <span>Konfirmasi Pemesanan</span>
                </button>
            </div>
        </div>
    </div>
    <script>
        function movieDetail() {
            const urlParams = new URLSearchParams(window.location.search);
            const movieId = parseInt(urlParams.get('id')) || 1;
            
            const movies = {
                1: {
                    id: 1,
                    title: "Gatot Kaca : The Last War",
                    year: "2024",
                    rating: "9.2",
                    ageRating: "18+",
                    duration: "2h 15m",
                    description: "Dalam pertempuran epik antara kerajaan yang berkuasa, seorang ksatria harus memilih antara kesetiaan dan keluarga untuk menyelamatkan kerajaan dari kehancuran total yang mengancam seluruh peradaban.",
                    fullDescription: "Film epik yang menghadirkan kisah dramatis tentang perebutan kekuasaan di masa kegelapan. Dengan sinematografi yang menakjubkan dan adegan pertempuran yang spektakuler, film ini membawa penonton ke dalam dunia abad pertengahan yang penuh intrik politik dan pengkhianatan. Protagonis kita harus menghadapi dilema moral yang berat: apakah ia akan mempertahankan sumpah kesetiaannya kepada raja yang korup, atau melindungi keluarganya yang terancam. Disutradarai dengan brilian dan dibintangi oleh aktor-aktor papan atas, film ini menawarkan pengalaman sinematik yang tak terlupakan dengan plot twist yang mengejutkan dan akhir yang sangat memuaskan.",
                    genres: ["Action", "Drama", "History", "War"],
                    image: "assets/images/image.png",
                    director: "Christopher Nolan",
                    writer: "Jonathan Nolan",
                    cast: "Tom Hardy, Christian Bale, Anne Hathaway, Michael Caine",
                    cinemas: [
                        { name: "CGV Grand Indonesia", location: "Jakarta Pusat", times: ["10:00", "13:00", "16:00", "19:00", "21:30"] },
                        { name: "XXI Plaza Senayan", location: "Jakarta Selatan", times: ["11:00", "14:00", "17:00", "20:00", "22:00"] },
                        { name: "Cinepolis Lippo Mall", location: "Jakarta Barat", times: ["10:30", "13:30", "16:30", "19:30", "21:00"] }
                    ]
                },
                2: {
                    id: 2,
                    title: "Stranger Things Season 5",
                    year: "2024",
                    rating: "8.9",
                    ageRating: "17+",
                    duration: "1h 55m",
                    description: "Petualangan terakhir sekelompok remaja melawan kekuatan supernatural dari dunia terbalik yang mengancam untuk menghancurkan kota mereka selamanya.",
                    fullDescription: "Season final yang sangat dinanti dari serial fenomenal ini menghadirkan klimaks epik dari pertempuran melawan Mind Flayer dan kekuatan jahat dari Upside Down. Setelah empat musim membangun ketegangan, serial ini mencapai puncaknya dengan aksi yang lebih intens, misteri yang lebih gelap, dan emosi yang lebih dalam. Para karakter favorit kita sudah dewasa dan harus menghadapi ancaman terbesar yang pernah ada. Dengan efek visual yang memukau, soundtrack nostalgia 80-an yang ikonik, dan penampilan akting yang luar biasa dari seluruh cast, season ini menjanjikan akhir yang spektakuler dan memuaskan bagi para penggemar setia.",
                    genres: ["Sci-Fi", "Horror", "Drama", "Mystery"],
                    image: "https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?w=400&h=225&fit=crop",
                    director: "The Duffer Brothers",
                    writer: "Matt Duffer, Ross Duffer",
                    cast: "Millie Bobby Brown, Finn Wolfhard, Winona Ryder, David Harbour",
                    cinemas: [
                        { name: "CGV Grand Indonesia", location: "Jakarta Pusat", times: ["12:00", "15:00", "18:00", "21:00"] },
                        { name: "XXI Plaza Senayan", location: "Jakarta Selatan", times: ["11:30", "14:30", "17:30", "20:30"] },
                        { name: "Cinepolis Lippo Mall", location: "Jakarta Barat", times: ["12:30", "15:30", "18:30", "21:30"] }
                    ]
                },
                3: {
                    id: 3,
                    title: "The Dark Knight Returns",
                    year: "2024",
                    rating: "9.0",
                    ageRating: "13+",
                    duration: "2h 32m",
                    description: "Kembalinya sang ksatria kegelapan setelah bertahun-tahun pensiun untuk melawan ancaman baru yang lebih berbahaya dari sebelumnya.",
                    fullDescription: "Sebuah comeback yang epik dari superhero paling ikonik sepanjang masa. Film ini mengangkat tema kedewasaan, tanggung jawab, dan penebusan dosa dengan cara yang belum pernah terlihat sebelumnya dalam film superhero. Gotham City kembali terancam oleh gelombang kejahatan baru yang dipimpin oleh penjahat misterius yang memiliki koneksi dengan masa lalu Batman. Bruce Wayne yang sudah menua harus kembali mengenakan kostum Batman-nya, menghadapi demon masa lalunya sambil melawan musuh yang lebih brutal. Dengan choreography pertarungan yang memukau, plot yang kompleks dan berlapis, serta eksplorasi mendalam tentang psikologi Batman, film ini bukan sekadar film aksi, tetapi sebuah karya seni sinematik yang akan dikenang sepanjang masa.",
                    genres: ["Action", "Crime", "Drama", "Thriller"],
                    image: "https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?w=400&h=225&fit=crop",
                    director: "Matt Reeves",
                    writer: "Matt Reeves, Peter Craig",
                    cast: "Robert Pattinson, Zoë Kravitz, Paul Dano, Colin Farrell",
                    cinemas: [
                        { name: "CGV Grand Indonesia", location: "Jakarta Pusat", times: ["10:30", "13:30", "16:30", "19:30", "22:00"] },
                        { name: "XXI Plaza Senayan", location: "Jakarta Selatan", times: ["11:00", "14:00", "17:00", "20:00", "22:30"] },
                        { name: "Cinepolis Lippo Mall", location: "Jakarta Barat", times: ["10:00", "13:00", "16:00", "19:00", "21:30"] }
                    ]
                }
            };
            
            return {
                ticketModal: false,
                selectedCinema: '',
                selectedDate: '',
                selectedTime: '',
                ticketCount: 1,
                movie: movies[movieId] || movies[1],
                availableDates: [
                    { day: 'Sen', date: '27', month: 'Okt', value: '2025-10-27' },
                    { day: 'Sel', date: '28', month: 'Okt', value: '2025-10-28' },
                    { day: 'Rab', date: '29', month: 'Okt', value: '2025-10-29' },
                    { day: 'Kam', date: '30', month: 'Okt', value: '2025-10-30' },
                ],
                showTimes: ['10:00', '12:30', '15:00', '17:30', '19:00', '20:00', '21:30'],
                openTicketModal(cinema = '', time = '') {
                    this.ticketModal = true;
                    this.selectedCinema = cinema;
                    this.selectedTime = time;
                },
                confirmBooking() {
                    if (!this.selectedCinema || !this.selectedDate || !this.selectedTime) {
                        alert('Mohon lengkapi semua pilihan!');
                        return;
                    }
                    
                    alert('✅ Pemesanan Berhasil!\n\nFilm: ' + this.movie.title +
                        '\nBioskop: ' + this.selectedCinema +
                        '\nTanggal: ' + this.selectedDate +
                        '\nJam: ' + this.selectedTime +
                        '\nJumlah Tiket: ' + this.ticketCount +
                        '\nTotal: Rp ' + (50000 * this.ticketCount).toLocaleString('id-ID') +
                        '\n\nTerima kasih telah memesan!');
                    
                    this.ticketModal = false;
                }
            }
        }
    </script>
</body>
</html>