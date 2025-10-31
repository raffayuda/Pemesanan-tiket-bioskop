<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistem Pemesanan Tiket Bioskop</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<style>
        * {
            font-family: 'Inter', sans-serif;
        }
        
        [x-cloak] { display: none !important; }
        
        .hero-gradient {
            background: linear-gradient(to bottom, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0.2) 40%, rgba(0,0,0,0.95) 100%);
        }
        
        .scrollbar-hide::-webkit-scrollbar {
            display: none;
        }
        
        .scrollbar-hide {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        .movie-card {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .movie-card:hover {
            transform: scale(1.08) translateY(-8px);
            box-shadow: 0 20px 40px rgba(239, 68, 68, 0.4);
            z-index: 10;
        }

        .movie-card::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, transparent 50%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .movie-card:hover::before {
            opacity: 1;
        }

        .movie-card .overlay-content {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 1rem;
            transform: translateY(100%);
            transition: transform 0.3s ease;
        }

        .movie-card:hover .overlay-content {
            transform: translateY(0);
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .float-animation {
            animation: float 3s ease-in-out infinite;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .slide-in {
            animation: slideIn 0.6s ease-out;
        }

        .bg-gradient-radial {
            background: radial-gradient(circle at center, rgba(239, 68, 68, 0.15) 0%, transparent 70%);
        }

        .glassmorphism {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .text-gradient {
            background: linear-gradient(135deg, #EF4444 0%, #DC2626 50%, #991B1B 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .spotlight {
            position: absolute;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at var(--x, 50%) var(--y, 50%), rgba(239, 68, 68, 0.15) 0%, transparent 50%);
            pointer-events: none;
        }

        .badge-glow {
            box-shadow: 0 0 20px rgba(239, 68, 68, 0.6);
        }

        .smooth-shadow {
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }
    </style>
<body class="bg-black text-white overflow-x-hidden" x-data="netflixApp()">
    
    <!-- Background Animated Pattern -->
    <div class="fixed inset-0 pointer-events-none opacity-10">
        <div class="absolute inset-0 bg-gradient-radial"></div>
    </div>

    <!-- Navigation -->
    <nav class="fixed top-0 w-full z-50 transition-all duration-500" 
         :class="scrolled ? 'bg-black/95 backdrop-blur-md shadow-2xl' : 'bg-transparent'">
        <div class="container mx-auto px-4 lg:px-8 py-4 flex items-center justify-between">
            <div class="flex items-center space-x-8">
                <h1 class="text-gradient text-3xl lg:text-4xl font-black tracking-tight">CINEMAFLIX</h1>
                <ul class="hidden lg:flex space-x-8 text-sm font-medium">
                    <li><a href="index.html" class="hover:text-red-500 transition-colors duration-200 relative group">
                        Home
                        <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-500 group-hover:w-full transition-all duration-300"></span>
                    </a></li>
                    <li><a href="#" class="hover:text-red-500 transition-colors duration-200 relative group">
                        Sedang Tayang
                        <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-500 group-hover:w-full transition-all duration-300"></span>
                    </a></li>
                    <li><a href="#" class="hover:text-red-500 transition-colors duration-200 relative group">
                        Coming Soon
                        <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-500 group-hover:w-full transition-all duration-300"></span>
                    </a></li>
                    <li><a href="#" class="hover:text-red-500 transition-colors duration-200 relative group">
                        Bioskop
                        <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-500 group-hover:w-full transition-all duration-300"></span>
                    </a></li>
                    <li><a href="#" class="hover:text-red-500 transition-colors duration-200 relative group">
                        Tiket Saya
                        <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-500 group-hover:w-full transition-all duration-300"></span>
                    </a></li>
                </ul>
            </div>
            <div class="flex items-center space-x-4 lg:space-x-6">
                <!-- Search Toggle -->
                <button @click="searchOpen = !searchOpen" class="hover:text-red-500 transition-colors duration-200">
                    <svg class="w-5 h-5 lg:w-6 lg:h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                    </svg>
                </button>
                <!-- Notification with badge -->
                <button class="hover:text-red-500 transition-colors duration-200 relative">
                    <svg class="w-5 h-5 lg:w-6 lg:h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
                    </svg>
                    <span class="absolute -top-1 -right-1 bg-red-600 text-xs w-4 h-4 rounded-full flex items-center justify-center">3</span>
                </button>
                <!-- Profile Dropdown -->
                <div class="relative" x-data="{ open: false }">
                    <button @click="open = !open" class="flex items-center space-x-2 hover:opacity-80 transition">
                        <div class="w-8 h-8 lg:w-10 lg:h-10 bg-gradient-to-br from-red-500 to-red-700 rounded-lg flex items-center justify-center font-bold shadow-lg">
                            U
                        </div>
                    </button>
                    <!-- Dropdown Menu -->
                    <div x-show="open" 
                         @click.away="open = false"
                         x-transition:enter="transition ease-out duration-200"
                         x-transition:enter-start="opacity-0 scale-95"
                         x-transition:enter-end="opacity-100 scale-100"
                         x-transition:leave="transition ease-in duration-150"
                         x-transition:leave-start="opacity-100 scale-100"
                         x-transition:leave-end="opacity-0 scale-95"
                         class="absolute right-0 mt-2 w-48 glassmorphism rounded-lg shadow-2xl py-2 text-sm"
                         x-cloak>
                        <a href="#" class="block px-4 py-2 hover:bg-white/10 transition">Profil</a>
                        <a href="#" class="block px-4 py-2 hover:bg-white/10 transition">Pengaturan</a>
                        <hr class="my-2 border-white/10">
                        <a href="#" class="block px-4 py-2 hover:bg-white/10 transition text-red-400">Keluar</a>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Search Bar Expandable -->
        <div x-show="searchOpen" 
             x-transition:enter="transition ease-out duration-300"
             x-transition:enter-start="opacity-0 -translate-y-4"
             x-transition:enter-end="opacity-100 translate-y-0"
             x-transition:leave="transition ease-in duration-200"
             x-transition:leave-start="opacity-100 translate-y-0"
             x-transition:leave-end="opacity-0 -translate-y-4"
             class="border-t border-white/10" 
             x-cloak>
            <div class="container mx-auto px-4 lg:px-8 py-4">
                <div class="relative max-w-2xl mx-auto">
                    <input type="text" 
                           placeholder="Cari film, serial, atau aktor..." 
                           class="w-full bg-white/10 backdrop-blur-md border border-white/20 rounded-full px-6 py-3 pl-12 focus:outline-none focus:ring-2 focus:ring-red-500 transition">
                    <svg class="w-5 h-5 absolute left-4 top-1/2 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                    </svg>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="relative min-h-screen pt-20 pb-32 overflow-hidden">
        <div class="absolute inset-0 z-0">
            <img :src="featuredMovie.image" 
                 alt="Featured Movie" 
                 class="w-full h-full object-cover"
                 :class="{'scale-110': scrolled}">
            <div class="absolute inset-0 hero-gradient"></div>
            <div class="spotlight" 
                 @mousemove="updateSpotlight($event)"
                 style="--x: 50%; --y: 50%;"></div>
        </div>
        
        <div class="relative z-10 container mx-auto px-4 lg:px-8 min-h-screen flex items-center pt-16">
            <div class="max-w-3xl slide-in">
                <div class="inline-block mb-4 md:mb-6">
                    <span class="px-4 py-2 bg-red-600 badge-glow text-xs font-bold uppercase tracking-wider rounded-full">
                        🔥 Trending #1
                    </span>
                </div>
                <h2 class="text-3xl sm:text-5xl md:text-6xl lg:text-7xl xl:text-8xl font-black mb-4 md:mb-6 leading-tight" 
                    x-text="featuredMovie.title"></h2>
                <div class="flex flex-wrap items-center gap-2 md:gap-4 mb-4 md:mb-6 text-sm md:text-base">
                    <div class="flex items-center space-x-1">
                        <svg class="w-4 h-4 md:w-5 md:h-5 text-yellow-400 fill-current" viewBox="0 0 20 20">
                            <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                        </svg>
                        <span class="text-yellow-400 font-bold" x-text="featuredMovie.rating"></span>
                    </div>
                    <span class="text-green-400 font-bold" x-text="featuredMovie.match"></span>
                    <span class="text-gray-300" x-text="featuredMovie.year"></span>
                    <span class="px-2 md:px-3 py-1 border-2 border-gray-400 text-xs font-bold rounded" x-text="featuredMovie.ageRating"></span>
                    <span class="text-gray-300" x-text="featuredMovie.duration"></span>
                </div>
                <p class="text-sm sm:text-base md:text-lg lg:text-xl mb-6 md:mb-8 leading-relaxed text-gray-200 max-w-2xl" 
                   x-text="featuredMovie.description"></p>
                
                <!-- Genre Tags -->
                <div class="flex flex-wrap gap-2 mb-6 md:mb-8">
                    <template x-for="genre in featuredMovie.genres" :key="genre">
                        <span class="px-3 md:px-4 py-1 md:py-1.5 glassmorphism text-xs md:text-sm rounded-full" x-text="genre"></span>
                    </template>
                </div>
                
                <div class="flex flex-wrap gap-3 md:gap-4">
                    <button @click="openTicketModal(featuredMovie)" class="group bg-red-600 text-white px-6 md:px-8 lg:px-10 py-3 lg:py-4 rounded-full font-bold flex items-center space-x-2 md:space-x-3 hover:bg-red-700 transition-all duration-300 shadow-2xl transform hover:scale-105 text-sm md:text-base">
                        <svg class="w-5 h-5 md:w-6 md:h-6 lg:w-7 lg:h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"></path>
                        </svg>
                        <span class="hidden sm:inline">Beli Tiket</span>
                        <span class="sm:hidden">Tiket</span>
                    </button>
                    <button @click="window.location.href='detail.jsp?id=' + featuredMovie.id" class="group glassmorphism px-6 md:px-8 lg:px-10 py-3 lg:py-4 rounded-full font-bold flex items-center space-x-2 md:space-x-3 hover:bg-white/20 transition-all duration-300 transform hover:scale-105 text-sm md:text-base">
                        <svg class="w-5 h-5 md:w-6 md:h-6 lg:w-7 lg:h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <span class="hidden md:inline">Lihat Detail</span>
                        <span class="md:hidden">Detail</span>
                    </button>
                    <button class="group glassmorphism px-6 md:px-8 lg:px-10 py-3 lg:py-4 rounded-full font-bold flex items-center space-x-2 md:space-x-3 hover:bg-white/20 transition-all duration-300 transform hover:scale-105 text-sm md:text-base">
                        <svg class="w-5 h-5 md:w-6 md:h-6 lg:w-7 lg:h-7" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                        </svg>
                        <span class="hidden sm:inline">Favorit</span>
                    </button>
                </div>
            </div>
        </div>

        <!-- Scroll Indicator -->
        <div class="absolute bottom-8 left-1/2 -translate-x-1/2 float-animation z-10">
            <svg class="w-6 h-6 text-white/70" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
            </svg>
        </div>
    </section>

    <!-- Trending Now -->
    <section class="relative -mt-32 z-10 pb-16">
        <div class="container mx-auto px-4 lg:px-8">
            <div class="flex items-center justify-between mb-6">
                <h3 class="text-2xl lg:text-3xl font-bold">🔥 Sedang Trending</h3>
                <button class="text-red-500 hover:text-red-400 transition font-semibold flex items-center space-x-2">
                    <span>Lihat Semua</span>
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                    </svg>
                </button>
            </div>
            <div class="flex overflow-x-auto space-x-4 lg:space-x-6 scrollbar-hide pb-6">
                <template x-for="(movie, index) in trendingMovies" :key="movie.id">
                    <div class="movie-card flex-none w-72 lg:w-80 cursor-pointer group">
                        <div class="relative rounded-xl overflow-hidden smooth-shadow">
                            <img :src="movie.image" 
                                 :alt="movie.title" 
                                 class="w-full h-44 object-cover">
                            <div class="absolute top-3 left-3 flex items-center space-x-2">
                                <span class="bg-gradient-to-r from-red-600 to-red-700 px-3 py-1.5 text-xs font-black rounded-full badge-glow flex items-center">
                                    <span class="text-yellow-300 mr-1">★</span>
                                    <span x-text="'#' + (index + 1)"></span>
                                </span>
                            </div>
                            <div class="overlay-content">
                                <h4 class="font-bold text-lg mb-2" x-text="movie.title"></h4>
                                <div class="flex space-x-2">
                                    <button class="bg-white text-black p-2 rounded-full hover:scale-110 transition">
                                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M6.3 2.841A1.5 1.5 0 004 4.11V15.89a1.5 1.5 0 002.3 1.269l9.344-5.89a1.5 1.5 0 000-2.538L6.3 2.84z"></path>
                                        </svg>
                                    </button>
                                    <button class="glassmorphism p-2 rounded-full hover:bg-white/30 transition">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                        </svg>
                                    </button>
                                    <button class="glassmorphism p-2 rounded-full hover:bg-white/30 transition">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
        </div>
    </section>

    <!-- Popular Movies -->
    <section class="py-16 bg-gradient-to-b from-black via-gray-900/50 to-black">
        <div class="container mx-auto px-4 lg:px-8">
            <div class="flex items-center justify-between mb-6">
                <h3 class="text-2xl lg:text-3xl font-bold">⭐ Film Populer</h3>
                <button class="text-red-500 hover:text-red-400 transition font-semibold flex items-center space-x-2">
                    <span>Jelajahi</span>
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                    </svg>
                </button>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-4 lg:gap-6">
                <template x-for="movie in popularMovies" :key="movie.id">
                    <div class="movie-card cursor-pointer group">
                        <div class="relative rounded-xl overflow-hidden">
                            <img :src="movie.image" 
                                 :alt="movie.title" 
                                 class="w-full h-80 lg:h-96 object-cover">
                            <div class="absolute top-3 right-3">
                                <div class="bg-black/70 backdrop-blur-sm px-2 py-1 rounded-full flex items-center space-x-1">
                                    <svg class="w-3 h-3 text-yellow-400 fill-current" viewBox="0 0 20 20">
                                        <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                                    </svg>
                                    <span class="text-xs font-bold" x-text="movie.rating"></span>
                                </div>
                            </div>
                            <div class="overlay-content">
                                <h4 class="font-bold mb-2" x-text="movie.title"></h4>
                                <div class="flex space-x-2">
                                    <button class="bg-white text-black p-2 rounded-full hover:scale-110 transition">
                                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M6.3 2.841A1.5 1.5 0 004 4.11V15.89a1.5 1.5 0 002.3 1.269l9.344-5.89a1.5 1.5 0 000-2.538L6.3 2.84z"></path>
                                        </svg>
                                    </button>
                                    <button class="glassmorphism p-2 rounded-full hover:bg-white/30 transition">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
        </div>
    </section>

    <!-- Action Movies -->
    <section class="py-16">
        <div class="container mx-auto px-4 lg:px-8">
            <div class="flex items-center justify-between mb-6">
                <h3 class="text-2xl lg:text-3xl font-bold">💥 Film Aksi Terbaik</h3>
                <button class="text-red-500 hover:text-red-400 transition font-semibold flex items-center space-x-2">
                    <span>Selengkapnya</span>
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                    </svg>
                </button>
            </div>
            <div class="flex overflow-x-auto space-x-4 lg:space-x-6 scrollbar-hide pb-6">
                <template x-for="movie in actionMovies" :key="movie.id">
                    <div class="movie-card flex-none w-80 lg:w-96 cursor-pointer group">
                        <div class="relative rounded-xl overflow-hidden smooth-shadow">
                            <img :src="movie.image" 
                                 :alt="movie.title" 
                                 class="w-full h-52 object-cover">
                            <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/30 to-transparent"></div>
                            <div class="absolute bottom-4 left-4 right-4">
                                <h4 class="font-bold text-xl mb-2" x-text="movie.title"></h4>
                                <div class="flex items-center space-x-3 text-sm">
                                    <span class="flex items-center space-x-1">
                                        <svg class="w-4 h-4 text-yellow-400 fill-current" viewBox="0 0 20 20">
                                            <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                                        </svg>
                                        <span class="text-yellow-400 font-semibold" x-text="movie.rating"></span>
                                    </span>
                                    <span class="text-green-400 font-semibold" x-text="movie.match"></span>
                                    <span class="text-gray-300" x-text="movie.year"></span>
                                </div>
                            </div>
                            <div class="overlay-content !transform-none !opacity-0 group-hover:!opacity-100 transition-opacity">
                                <div class="flex space-x-2 mt-3">
                                    <button class="flex-1 bg-white text-black py-2 rounded-lg font-bold hover:bg-red-600 hover:text-white transition flex items-center justify-center space-x-2">
                                        <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M6.3 2.841A1.5 1.5 0 004 4.11V15.89a1.5 1.5 0 002.3 1.269l9.344-5.89a1.5 1.5 0 000-2.538L6.3 2.84z"></path>
                                        </svg>
                                        <span>Putar</span>
                                    </button>
                                    <button class="glassmorphism p-2 rounded-lg hover:bg-white/30 transition">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
        </div>
    </section>

    <!-- Drama Series -->
    <section class="py-16 bg-gradient-to-b from-black to-gray-900">
        <div class="container mx-auto px-4 lg:px-8">
            <div class="flex items-center justify-between mb-6">
                <h3 class="text-2xl lg:text-3xl font-bold">🎭 Serial Drama Pilihan</h3>
                <button class="text-red-500 hover:text-red-400 transition font-semibold flex items-center space-x-2">
                    <span>Lihat Semua</span>
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                    </svg>
                </button>
            </div>
            <div class="flex overflow-x-auto space-x-4 lg:space-x-6 scrollbar-hide pb-6">
                <template x-for="movie in dramaMovies" :key="movie.id">
                    <div class="movie-card flex-none w-80 lg:w-96 cursor-pointer group">
                        <div class="relative rounded-xl overflow-hidden smooth-shadow">
                            <img :src="movie.image" 
                                 :alt="movie.title" 
                                 class="w-full h-52 object-cover">
                            <div class="absolute top-3 left-3">
                                <span class="px-3 py-1 bg-purple-600 text-xs font-bold rounded-full">SERIES</span>
                            </div>
                            <div class="overlay-content">
                                <h4 class="font-bold text-lg mb-1" x-text="movie.title"></h4>
                                <p class="text-sm text-gray-300 mb-3" x-text="movie.genre"></p>
                                <div class="flex space-x-2">
                                    <button class="flex-1 bg-white text-black py-2 rounded-lg font-bold hover:bg-red-600 hover:text-white transition">
                                        Tonton
                                    </button>
                                    <button class="glassmorphism p-2 rounded-lg hover:bg-white/30 transition">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
        </div>
    </section>

    <!-- Continue Watching -->
    <section class="py-16">
        <div class="container mx-auto px-4 lg:px-8">
            <h3 class="text-2xl lg:text-3xl font-bold mb-6">▶️ Lanjutkan Menonton</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <template x-for="item in continueWatching" :key="item.id">
                    <div class="glassmorphism rounded-xl p-4 hover:bg-white/10 transition cursor-pointer group">
                        <div class="flex space-x-4">
                            <div class="relative flex-shrink-0">
                                <img :src="item.image" 
                                     :alt="item.title" 
                                     class="w-32 h-20 object-cover rounded-lg">
                                <div class="absolute inset-0 flex items-center justify-center">
                                    <div class="w-10 h-10 bg-white/90 rounded-full flex items-center justify-center group-hover:scale-110 transition">
                                        <svg class="w-5 h-5 text-black" fill="currentColor" viewBox="0 0 20 20">
                                            <path d="M6.3 2.841A1.5 1.5 0 004 4.11V15.89a1.5 1.5 0 002.3 1.269l9.344-5.89a1.5 1.5 0 000-2.538L6.3 2.84z"></path>
                                        </svg>
                                    </div>
                                </div>
                            </div>
                            <div class="flex-1">
                                <h4 class="font-bold mb-1" x-text="item.title"></h4>
                                <p class="text-sm text-gray-400 mb-2" x-text="item.episode"></p>
                                <div class="w-full bg-gray-700 rounded-full h-1.5">
                                    <div class="bg-red-600 h-1.5 rounded-full" 
                                         :style="'width: ' + item.progress + '%'"></div>
                                </div>
                                <p class="text-xs text-gray-400 mt-1" x-text="item.progress + '% selesai'"></p>
                            </div>
                        </div>
                    </div>
                </template>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gradient-to-b from-gray-900 to-black border-t border-white/10 py-16 mt-20">
        <div class="container mx-auto px-4 lg:px-8">
            <!-- Social Media -->
            <div class="flex justify-center space-x-6 mb-12">
                <a href="#" class="w-12 h-12 glassmorphism rounded-full flex items-center justify-center hover:bg-red-600 hover:scale-110 transition-all">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                    </svg>
                </a>
                <a href="#" class="w-12 h-12 glassmorphism rounded-full flex items-center justify-center hover:bg-red-600 hover:scale-110 transition-all">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
                    </svg>
                </a>
                <a href="#" class="w-12 h-12 glassmorphism rounded-full flex items-center justify-center hover:bg-red-600 hover:scale-110 transition-all">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 0C8.74 0 8.333.015 7.053.072 5.775.132 4.905.333 4.14.63c-.789.306-1.459.717-2.126 1.384S.935 3.35.63 4.14C.333 4.905.131 5.775.072 7.053.012 8.333 0 8.74 0 12s.015 3.667.072 4.947c.06 1.277.261 2.148.558 2.913.306.788.717 1.459 1.384 2.126.667.666 1.336 1.079 2.126 1.384.766.296 1.636.499 2.913.558C8.333 23.988 8.74 24 12 24s3.667-.015 4.947-.072c1.277-.06 2.148-.262 2.913-.558.788-.306 1.459-.718 2.126-1.384.666-.667 1.079-1.335 1.384-2.126.296-.765.499-1.636.558-2.913.06-1.28.072-1.687.072-4.947s-.015-3.667-.072-4.947c-.06-1.277-.262-2.149-.558-2.913-.306-.789-.718-1.459-1.384-2.126C21.319 1.347 20.651.935 19.86.63c-.765-.297-1.636-.499-2.913-.558C15.667.012 15.26 0 12 0zm0 2.16c3.203 0 3.585.016 4.85.071 1.17.055 1.805.249 2.227.415.562.217.96.477 1.382.896.419.42.679.819.896 1.381.164.422.36 1.057.413 2.227.057 1.266.07 1.646.07 4.85s-.015 3.585-.074 4.85c-.061 1.17-.256 1.805-.421 2.227-.224.562-.479.96-.899 1.382-.419.419-.824.679-1.38.896-.42.164-1.065.36-2.235.413-1.274.057-1.649.07-4.859.07-3.211 0-3.586-.015-4.859-.074-1.171-.061-1.816-.256-2.236-.421-.569-.224-.96-.479-1.379-.899-.421-.419-.69-.824-.9-1.38-.165-.42-.359-1.065-.42-2.235-.045-1.26-.061-1.649-.061-4.844 0-3.196.016-3.586.061-4.861.061-1.17.255-1.814.42-2.234.21-.57.479-.96.9-1.381.419-.419.81-.689 1.379-.898.42-.166 1.051-.361 2.221-.421 1.275-.045 1.65-.06 4.859-.06l.045.03zm0 3.678c-3.405 0-6.162 2.76-6.162 6.162 0 3.405 2.76 6.162 6.162 6.162 3.405 0 6.162-2.76 6.162-6.162 0-3.405-2.76-6.162-6.162-6.162zM12 16c-2.21 0-4-1.79-4-4s1.79-4 4-4 4 1.79 4 4-1.79 4-4 4zm7.846-10.405c0 .795-.646 1.44-1.44 1.44-.795 0-1.44-.646-1.44-1.44 0-.794.646-1.439 1.44-1.439.793-.001 1.44.645 1.44 1.439z"/>
                    </svg>
                </a>
                <a href="#" class="w-12 h-12 glassmorphism rounded-full flex items-center justify-center hover:bg-red-600 hover:scale-110 transition-all">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                    </svg>
                </a>
            </div>

            <!-- Footer Links -->
            <div class="grid grid-cols-2 md:grid-cols-4 gap-8 mb-12">
                <div>
                    <h5 class="font-bold mb-4 text-lg">Navigasi</h5>
                    <ul class="space-y-3 text-gray-400">
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Beranda</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Film</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Serial TV</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Baru & Populer</a></li>
                    </ul>
                </div>
                <div>
                    <h5 class="font-bold mb-4 text-lg">Bantuan</h5>
                    <ul class="space-y-3 text-gray-400">
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">FAQ</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Pusat Bantuan</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Akun</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Media Center</a></li>
                    </ul>
                </div>
                <div>
                    <h5 class="font-bold mb-4 text-lg">Legal</h5>
                    <ul class="space-y-3 text-gray-400">
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Privasi</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Syarat Layanan</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Cookie</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Informasi Perusahaan</a></li>
                    </ul>
                </div>
                <div>
                    <h5 class="font-bold mb-4 text-lg">Perusahaan</h5>
                    <ul class="space-y-3 text-gray-400">
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Tentang Kami</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Karir</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Hubungi Kami</a></li>
                        <li><a href="#" class="hover:text-white hover:translate-x-1 inline-block transition-all">Press</a></li>
                    </ul>
                </div>
            </div>

            <!-- Copyright -->
            <div class="border-t border-white/10 pt-8 text-center">
                <div class="text-gradient text-2xl font-black mb-4">MOVIEFLIX</div>
                <p class="text-gray-500 text-sm">
                    &copy; 2025 MovieFlix Indonesia. All rights reserved. Made with ❤️ for movie lovers.
                </p>
            </div>
        </div>
    </footer>

    <!-- Scroll to Top Button -->
    <button @click="window.scrollTo({top: 0, behavior: 'smooth'})"
            x-show="scrolled"
            x-transition
            class="fixed bottom-8 right-8 w-12 h-12 bg-red-600 rounded-full flex items-center justify-center hover:bg-red-700 hover:scale-110 transition-all shadow-2xl z-40">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
        </svg>
    </button>

    <!-- Modal Pembelian Tiket -->
    <div x-show="ticketModal" 
         x-cloak
         @click.self="ticketModal = false"
         class="fixed inset-0 bg-black/80 backdrop-blur-sm flex items-center justify-center z-50 p-4"
         x-transition:enter="transition ease-out duration-300"
         x-transition:enter-start="opacity-0"
         x-transition:enter-end="opacity-100"
         x-transition:leave="transition ease-in duration-200"
         x-transition:leave-start="opacity-100"
         x-transition:leave-end="opacity-0">
        
        <div class="bg-gradient-to-br from-gray-900 to-black rounded-2xl max-w-4xl w-full max-h-[90vh] overflow-y-auto glassmorphism border border-white/20"
             x-transition:enter="transition ease-out duration-300"
             x-transition:enter-start="opacity-0 scale-90"
             x-transition:enter-end="opacity-100 scale-100"
             x-transition:leave="transition ease-in duration-200"
             x-transition:leave-start="opacity-100 scale-100"
             x-transition:leave-end="opacity-0 scale-90"
             @click.stop>
            
            <!-- Header -->
            <div class="sticky top-0 bg-gradient-to-br from-gray-900 to-black border-b border-white/10 p-6 flex items-center justify-between z-10">
                <div class="flex items-center space-x-4">
                    <div class="w-12 h-12 bg-red-600 rounded-full flex items-center justify-center">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 5v2m0 4v2m0 4v2M5 5a2 2 0 00-2 2v3a2 2 0 110 4v3a2 2 0 002 2h14a2 2 0 002-2v-3a2 2 0 110-4V7a2 2 0 00-2-2H5z"></path>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-2xl font-bold" x-text="selectedMovie?.title"></h3>
                        <p class="text-gray-400 text-sm">Pemesanan Tiket Bioskop</p>
                    </div>
                </div>
                <button @click="ticketModal = false" class="w-10 h-10 rounded-full glassmorphism hover:bg-white/20 transition flex items-center justify-center">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>

            <!-- Content -->
            <div class="p-6 space-y-6">
                <!-- Movie Info -->
                <div class="flex gap-4 p-4 glassmorphism rounded-xl">
                    <img :src="selectedMovie?.image" :alt="selectedMovie?.title" class="w-24 h-36 object-cover rounded-lg">
                    <div class="flex-1">
                        <h4 class="font-bold text-lg mb-2" x-text="selectedMovie?.title"></h4>
                        <div class="space-y-1 text-sm text-gray-300">
                            <p><span class="text-gray-400">Genre:</span> <span x-text="selectedMovie?.genres?.join(', ')"></span></p>
                            <p><span class="text-gray-400">Durasi:</span> <span x-text="selectedMovie?.duration"></span></p>
                            <p><span class="text-gray-400">Rating:</span> <span x-text="selectedMovie?.ageRating"></span></p>
                            <div class="flex items-center space-x-1 mt-2">
                                <svg class="w-5 h-5 text-yellow-400 fill-current" viewBox="0 0 20 20">
                                    <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                                </svg>
                                <span class="font-semibold text-yellow-400" x-text="selectedMovie?.rating"></span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pilih Bioskop -->
                <div>
                    <label class="block text-sm font-semibold mb-3">Pilih Bioskop</label>
                    <select x-model="selectedCinema" class="w-full bg-white/10 border border-white/20 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-red-500 transition">
                        <option value="">-- Pilih Bioskop --</option>
                        <option value="cgv">CGV Grand Indonesia</option>
                        <option value="xxi">XXI Plaza Senayan</option>
                        <option value="cinepolis">Cinepolis Lippo Mall</option>
                    </select>
                </div>

                <!-- Pilih Tanggal -->
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

                <!-- Pilih Jam -->
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

                <!-- Pilih Jumlah Tiket -->
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

                <!-- Total Harga -->
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

                <!-- Tombol Konfirmasi -->
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
        function netflixApp() {
            return {
                scrolled: false,
                searchOpen: false,
                ticketModal: false,
                selectedMovie: null,
                selectedCinema: '',
                selectedDate: '',
                selectedTime: '',
                ticketCount: 1,
                availableDates: [
                    { day: 'Sen', date: '27', month: 'Okt', value: '2025-10-27' },
                    { day: 'Sel', date: '28', month: 'Okt', value: '2025-10-28' },
                    { day: 'Rab', date: '29', month: 'Okt', value: '2025-10-29' },
                    { day: 'Kam', date: '30', month: 'Okt', value: '2025-10-30' },
                ],
                showTimes: ['10:00', '12:30', '15:00', '17:30', '19:00', '20:00', '21:30'],
                featuredMovie: {
                    id: 1,
                    title: "The Last Kingdom",
                    match: "98% Match",
                    year: "2024",
                    rating: "9.2",
                    ageRating: "18+",
                    duration: "2h 15m",
                    description: "Dalam pertempuran epik antara kerajaan yang berkuasa, seorang ksatria harus memilih antara kesetiaan dan keluarga untuk menyelamatkan kerajaan dari kehancuran total yang mengancam seluruh peradaban.",
                    genres: ["Action", "Drama", "History", "War"],
                    image: "https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=1600&h=900&fit=crop"
                },
                trendingMovies: [
                    { id: 2, title: "Stranger Things S5", image: "https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?w=400&h=225&fit=crop", rating: "8.9", duration: "1h 55m", ageRating: "17+", genres: ["Sci-Fi", "Horror", "Drama"] },
                    { id: 3, title: "The Dark Knight Returns", image: "https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?w=400&h=225&fit=crop", rating: "9.0", duration: "2h 32m", ageRating: "13+", genres: ["Action", "Crime", "Drama"] },
                    { id: 4, title: "The Witcher: Blood Origin", image: "https://images.unsplash.com/photo-1594908900066-3f47337549d8?w=400&h=225&fit=crop", rating: "8.5", duration: "2h 10m", ageRating: "18+", genres: ["Fantasy", "Adventure", "Drama"] },
                    { id: 5, title: "Breaking Bad: El Camino", image: "https://images.unsplash.com/photo-1616530940355-351fabd9524b?w=400&h=225&fit=crop", rating: "8.8", duration: "2h 2m", ageRating: "17+", genres: ["Crime", "Drama", "Thriller"] },
                    { id: 6, title: "Peaky Blinders: New Era", image: "https://images.unsplash.com/photo-1485846234645-a62644f84728?w=400&h=225&fit=crop", rating: "8.7", duration: "1h 58m", ageRating: "18+", genres: ["Crime", "Drama", "History"] },
                    { id: 7, title: "Money Heist: Korea", image: "https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=400&h=225&fit=crop", rating: "8.3", duration: "2h 5m", ageRating: "16+", genres: ["Crime", "Thriller", "Drama"] },
                ],
                popularMovies: [
                    { id: 8, title: "Inception", rating: "8.8", image: "https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=300&h=450&fit=crop" },
                    { id: 9, title: "Interstellar", rating: "8.6", image: "https://images.unsplash.com/photo-1446941611757-91d2c3bd3d45?w=300&h=450&fit=crop" },
                    { id: 10, title: "The Matrix", rating: "8.7", image: "https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=300&h=450&fit=crop" },
                    { id: 11, title: "Tenet", rating: "7.3", image: "https://images.unsplash.com/photo-1574267432644-f610f5b45efa?w=300&h=450&fit=crop" },
                    { id: 12, title: "Dune", rating: "8.0", image: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=450&fit=crop" },
                    { id: 13, title: "Blade Runner 2049", rating: "8.0", image: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=300&h=450&fit=crop" },
                ],
                actionMovies: [
                    { id: 14, title: "John Wick 4", match: "95% Match", year: "2024", rating: "8.9", image: "https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500&h=280&fit=crop" },
                    { id: 15, title: "Mad Max: Fury Road", match: "92% Match", year: "2023", rating: "8.1", image: "https://images.unsplash.com/photo-1451976426598-a7593bd6d0b2?w=500&h=280&fit=crop" },
                    { id: 16, title: "Mission Impossible 8", match: "90% Match", year: "2024", rating: "7.8", image: "https://images.unsplash.com/photo-1512070679279-8988d32161be?w=500&h=280&fit=crop" },
                    { id: 17, title: "Fast X", match: "88% Match", year: "2024", rating: "6.5", image: "https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=500&h=280&fit=crop" },
                    { id: 18, title: "Extraction 3", match: "93% Match", year: "2024", rating: "7.9", image: "https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=500&h=280&fit=crop" },
                ],
                dramaMovies: [
                    { id: 19, title: "Breaking Bad", genre: "Crime • Drama • Thriller", image: "https://images.unsplash.com/photo-1594908900066-3f47337549d8?w=500&h=280&fit=crop" },
                    { id: 20, title: "The Crown", genre: "Historical • Drama • Biography", image: "https://images.unsplash.com/photo-1514539079130-25950c84af65?w=500&h=280&fit=crop" },
                    { id: 21, title: "Better Call Saul", genre: "Crime • Drama • Legal", image: "https://images.unsplash.com/photo-1524712245354-2c4e5e7121c0?w=500&h=280&fit=crop" },
                    { id: 22, title: "The Queen's Gambit", genre: "Drama • Chess • Period", image: "https://images.unsplash.com/photo-1560264280-88b68371db39?w=500&h=280&fit=crop" },
                    { id: 23, title: "Succession", genre: "Drama • Business • Family", image: "https://images.unsplash.com/photo-1485846234645-a62644f84728?w=500&h=280&fit=crop" },
                ],
                continueWatching: [
                    { id: 24, title: "Stranger Things", episode: "S4 E7 - The Massacre at Hawkins Lab", progress: 45, image: "https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?w=200&h=120&fit=crop" },
                    { id: 25, title: "The Witcher", episode: "S3 E4 - The Invitation", progress: 78, image: "https://images.unsplash.com/photo-1594908900066-3f47337549d8?w=200&h=120&fit=crop" },
                    { id: 26, title: "Breaking Bad", episode: "S5 E14 - Ozymandias", progress: 23, image: "https://images.unsplash.com/photo-1616530940355-351fabd9524b?w=200&h=120&fit=crop" },
                ],
                init() {
                    window.addEventListener('scroll', () => {
                        this.scrolled = window.scrollY > 50;
                    });
                },
                updateSpotlight(event) {
                    var rect = event.currentTarget.getBoundingClientRect();
                    var x = ((event.clientX - rect.left) / rect.width) * 100;
                    var y = ((event.clientY - rect.top) / rect.height) * 100;
                    event.currentTarget.style.setProperty('--x', x + '%');
                    event.currentTarget.style.setProperty('--y', y + '%');
                },
                openTicketModal(movie) {
                    this.selectedMovie = movie;
                    this.ticketModal = true;
                    this.selectedCinema = '';
                    this.selectedDate = '';
                    this.selectedTime = '';
                    this.ticketCount = 1;
                },
                confirmBooking() {
                    if (!this.selectedCinema || !this.selectedDate || !this.selectedTime) {
                        alert('Mohon lengkapi semua pilihan!');
                        return;
                    }
                    
                    var cinemaNames = {
                        'cgv': 'CGV Grand Indonesia',
                        'xxi': 'XXI Plaza Senayan',
                        'cinepolis': 'Cinepolis Lippo Mall'
                    };
                    
                    var message = '✅ Pemesanan Berhasil!\n\n' +
                        'Film: ' + this.selectedMovie.title + '\n' +
                        'Bioskop: ' + cinemaNames[this.selectedCinema] + '\n' +
                        'Tanggal: ' + this.selectedDate + '\n' +
                        'Jam: ' + this.selectedTime + '\n' +
                        'Jumlah Tiket: ' + this.ticketCount + '\n' +
                        'Total: Rp ' + (50000 * this.ticketCount).toLocaleString('id-ID') + '\n\n' +
                        'Terima kasih telah memesan!';
                    
                    alert(message);
                    
                    this.ticketModal = false;
                }
            }
        }
    </script>

    
</body>
</html>
