import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(PrimeVideoWithInteractions());

class PrimeVideoWithInteractions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Video Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueAccent,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    PrimePage(),
    SubscriptionsPage(),
    DownloadsPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(top: BorderSide(color: Colors.grey[800]!)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[600],
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              activeIcon: Icon(Icons.star),
              label: 'Prime',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: 'Subscriptions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download_outlined),
              activeIcon: Icon(Icons.download),
              label: 'Downloads',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}

/// Home page
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late PageController _bannerController;
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  // 🎬 Banner Movies (Featured Content)
  final List<Map<String, dynamic>> bannerMovies = [
    {
      'title': 'The Lord of the Rings: The Rings of Power',
      'posters': [
        'https://m.media-amazon.com/images/S/pv-target-images/0705e32f6d314bad7eba9d35e74daafbca16857d5b4b937d16be1726d574ca5f.jpg',
      ],
      'description': 'Epic drama set thousands of years before the events of J.R.R. Tolkien\'s The Hobbit and The Lord of the Rings, this series follows an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth.',
      'year': 2022,
      'duration': '8 episodes',
      'isPrime': true,
    },
    {
      'title': 'Formula 1: Drive to Survive',
      'posters': [
        'https://image.tmdb.org/t/p/original/lkDYN0whyE82mcM20rwtwjbniKF.jpg',
      ],
      'description': 'This docuseries offers unprecedented behind-the-scenes access to the drivers, managers, and team owners in Formula 1 — both on and off the track — as they race for glory and survival.',
      'year': 2019,
      'duration': '6 seasons',
      'isPrime': true,
    },
    {
      'title': 'John Wick',
      'posters': [
        'https://media.themoviedb.org/t/p/w780/fog8Vbeg1KOZAucucPxgYpXJ0a0.jpg',
      ],
      'description': 'John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.',
      'year': 2014,
      'duration': '1h 41m',
      'isPrime': false,
    },
    {
      'title': 'Oppenheimer',
      'posters': [
        'https://image.tmdb.org/t/p/original/yg7B62JJbJrkBwiQrRf8vMDogLB.jpg',
      ],
      'description': 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb. Witness the creation of the most destructive weapon in human history.',
      'year': 2023,
      'duration': '3h 0m',
      'isPrime': true,
    },
  ];

  // 🎬 Continue Watching Section
  final List<Map<String, dynamic>> continueWatching = [
    {
      'title': 'Stranger Things',
      'posters': [
        'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
      ],
      'description': 'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces and one strange little girl.',
      'year': 2016,
      'duration': '4 seasons',
      'isPrime': false,
    },
    {
      'title': 'Titanic',
      'posters': [
        'https://res.cloudinary.com/jerrick/image/upload/d_642250b563292b35f27461a7.png,f_jpg,fl_progressive,q_auto,w_1024/6482ed1fc7106c001d64f01b.jpg',
      ],
      'description': 'A young aristocrat falls in love with a kind but poor artist aboard the ill-fated RMS Titanic. Their romance unfolds as the ship faces a tragic destiny.',
      'year': 1997,
      'duration': '3h 14m',
      'isPrime': true,
    },
    {
      'title': 'Lovely Runner',
      'posters': [
        'https://media.themoviedb.org/t/p/w780/vUVPHEo4ayCO4kkNV4k0PbWPmZS.jpg',
      ],
      'description': 'Years after a K-pop star saves her life, a fan learns of his death — but when she\'s suddenly transported to the past, she sets out to change their fate.',
      'year': 2024,
      'duration': '1 season (16 episodes)',
      'isPrime': true,
    },
    {
      'title': 'From',
      'posters': [
        'https://image.tmdb.org/t/p/original/g3JFcuQpmzVzVgSvbrmRqkjuT84.jpg',
      ],
      'description': 'Unravel the mystery of a nightmarish town in middle America that traps all those who enter. As the unwilling residents fight to keep a sense of normalcy and search for a way out.',
      'year': 2022,
      'duration': '2 seasons',
      'isPrime': false,
    },
    {
      'title': 'When I Fly Towards You',
      'posters': [
        'https://media.themoviedb.org/t/p/w780/lszTdpvocgGlOo6DBmqBO50qd1h.jpg',
      ],
      'description': 'A cheerful and straightforward girl, Su Zai Zai, falls for the cool and aloof Zhang Lu Rang. As they navigate high school life together, friendship slowly blossoms into a tender romance.',
      'year': 2023,
      'duration': '1 season (24 episodes)',
      'isPrime': false,
    },
  ];

  // 🎬 Prime Originals Section
  final List<Map<String, dynamic>> primeOriginals = [
    {
      'title': 'Life of Pi',
      'posters': [
        'https://media.themoviedb.org/t/p/w500/mjCChwZcEZ9902tUAG1hWZlfOHm.jpg',
      ],
      'description': 'After a shipwreck, a young man named Pi finds himself stranded on a lifeboat with a Bengal tiger, beginning an extraordinary journey of survival and faith.',
      'year': 2012,
      'duration': '2h 7m',
      'isPrime': true,
    },
    {
      'title': 'Mr and Mrs smith',
      'posters': [
        'https://image.tmdb.org/t/p/original/prCEjiFC8YggtvsGy99Z8C1Sqat.jpg',
      ],
      'description': 'A married couple, both secret assassins for rival organizations, discover each other\'s identities and are assigned to eliminate one another — leading to explosive chaos and rediscovered love.',
      'year': 2005,
      'duration': '2hr',
      'isPrime': false,
    },
    {
      'title': 'Mouse',
      'posters': [
        'https://image.tmdb.org/t/p/original/qz0axqEwwIa5uaMsUYKGs9u29ut.jpg',
      ],
      'description': 'A rookie police officer\'s life is turned upside down when he and a detective hunt a vicious serial killer — leading to chilling questions about whether psychopathy can be detected before birth.',
      'year': 2021,
      'duration': '1 season (20 episodes)',
      'isPrime': true,
    },
    {
      'title': 'The Chronicles of Narnia: The Lion, the Witch and the Wardrobe',
      'posters': [
        'https://media.themoviedb.org/t/p/w500/iREd0rNCjYdf5Ar0vfaW32yrkm.jpg',
      ],
      'description': 'Jack Reacher, a veteran military police investigator, has just recently entered civilian life when he is falsely accused of murder.',
      'year': 2005,
      'duration': '2h 23m',
      'isPrime': true,
    },
    {
      'title': 'MyFault',
      'posters': [
        'https://static0.colliderimages.com/wordpress/wp-content/uploads/sharedimages/2024/04/my-fault-prime-video-poster.jpg?q=70&fit=contain&w=480&dpr=1',
      ],
      'description': 'Noah must leave her city, boyfriend, and friends when her mother marries a wealthy man. She meets her new stepbrother Nick and quickly discovers they have an irresistible connection.',
      'year': 2023,
      'duration': '1hr 57m',
      'isPrime': true,
    },
    {
      'title': 'The Maze Runner',
      'posters': [
        'https://media.themoviedb.org/t/p/w500/beR71cbwXH0vySlTMPZo0GQ54Q9.jpg',
      ],
      'description': 'A teenager named Thomas wakes up in a mysterious maze with no memory of who he is. Along with other trapped boys, he must find a way out while uncovering the dark truth behind their imprisonment.',
      'year': 2014,
      'duration': '1h 53m',
      'isPrime': true,
    },
  ];

  // 🎬 Popular Shows Section
  final List<Map<String, dynamic>> popularShows = [
    {
      'title': 'Stranger Things',
      'posters': [
        'https://image.tmdb.org/t/p/original/2vMKrzpGITTrmFKnze9KqgAl7Y9.jpg',
      ],
      'description': 'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
      'year': 2016,
      'duration': '4 seasons',
      'isPrime': false,
    },
    {
      'title': 'Demon Slayer: Kimetsu no Yaiba',
      'posters': [
        'https://image.tmdb.org/t/p/original/dZDfgqbgZ09eZ1YaXXM71y2Sskv.jpg',
      ],
      'description': 'After a demon attack leaves his family slain and his sister cursed, Tanjiro Kamado sets out on a perilous journey to become a demon slayer and find a cure for her.',
      'year': 2019,
      'duration': '4 seasons',
      'isPrime': false,
    },
    
    {
      'title': 'Squid Game',
      'posters': [
        'https://image.tmdb.org/t/p/w500/dDlEmu3EZ0Pgg93K2SVNLCjCSvE.jpg',
      ],
      'description': 'Hundreds of cash-strapped players accept a strange invitation to compete in children\'s games. Inside, a tempting prize awaits with deadly high stakes.',
      'year': 2021,
      'duration': '1 season',
      'isPrime': false,
    },
    {
      'title': 'The Last of Us',
      'posters': [
        'https://image.tmdb.org/t/p/w500/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg',
      ],
      'description': 'After a global pandemic destroys civilization, a hardened survivor takes charge of a 14-year-old girl who may be humanity\'s last hope.',
      'year': 2023,
      'duration': '1 season',
      'isPrime': false,
    },
    {
      'title': 'Wednesday',
      'posters': [
        'https://image.tmdb.org/t/p/w500/9PFonBhy4cQy7Jz20NpMygczOkv.jpg',
      ],
      'description': 'Follows Wednesday Addams\' years as a student, when she attempts to master her emerging psychic ability and solve a murder mystery.',
      'year': 2022,
      'duration': '1 season',
      'isPrime': false,
    },
    {
      'title': 'Breaking Bad',
      'posters': [
        'https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg',
      ],
      'description': 'A high school chemistry teacher diagnosed with cancer turns to a life of crime to secure his family\'s future.',
      'year': 2008,
      'duration': '5 seasons',
      'isPrime': false,
    },
    {
      'title': 'The Witcher',
      'posters': [
        'https://image.tmdb.org/t/p/w500/7vjaCdMw15FEbXyLQTVa04URsPm.jpg',
      ],
      'description': 'Geralt of Rivia, a mutated monster-hunter for hire, journeys toward his destiny in a turbulent world where people often prove more wicked than beasts.',
      'year': 2019,
      'duration': '3 seasons',
      'isPrime': false,
    },
  ];

  // 🎬 Recommended Movies Section
  final List<Map<String, dynamic>> recommendedMovies = [
    {
      'title': 'Your Name',
      'posters': [
        'https://image.tmdb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg',
      ],
      'description': 'Two teenagers share a profound, magical connection upon discovering they are swapping bodies. Things manage to become even more complicated when the boy and girl decide to meet in person.',
      'year': 2016,
      'duration': '1h 46m',
      'isPrime': false,
    },
    {
      'title': 'Spirited Away',
      'posters': [
        'https://image.tmdb.org/t/p/w500/39wmItIWsg5sZMyRUHLkWBcuVCM.jpg',
      ],
      'description': 'During her family\'s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits.',
      'year': 2001,
      'duration': '2h 5m',
      'isPrime': false,
    },
    {
      'title': 'Dune',
      'posters': [
        'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
      ],
      'description': 'Paul Atreides, a brilliant and gifted young man born into a great destiny beyond his understanding, must travel to the most dangerous planet in the universe.',
      'year': 2021,
      'duration': '2h 35m',
      'isPrime': false,
    },
    {
      'title': 'Interstellar',
      'posters': [
        'https://media.themoviedb.org/t/p/w220_and_h330_face/hDO9K7NLSUHTis7QDeEdH64KEJ2.jpg',
      ],
      'description': 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival. The voyage is mankind\'s last chance.',
      'year': 2014,
      'duration': '2h 49m',
      'isPrime': false,
    },
    {
      'title': 'The Batman',
      'posters': [
        'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
      ],
      'description': 'When a sadistic serial killer begins murdering key political figures in Gotham, Batman is forced to investigate the city\'s hidden corruption.',
      'year': 2022,
      'duration': '2h 56m',
      'isPrime': false,
    },
    {
      'title': 'M3GAN',
      'posters': [  'https://media.themoviedb.org/t/p/w116_and_h174_face/d9nBoowhjiiYc4FBNtQkPY7c11H.jpg',
      ],
      'description': 'A brilliant roboticist creates M3GAN, a life-like AI doll designed to be a child\'s greatest companion. But when M3GAN becomes self-aware, her protective instincts turn deadly.',
      'year': 2022,
      'duration': '1h 42m',
      'isPrime': false,
    },
  ];

  // 🎬 Action Movies Section
  final List<Map<String, dynamic>> actionMovies = [
    {
      'title': 'John Wick: Chapter 4',
      'posters': [
        'https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg',
      ],
      'description': 'John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy.',
      'year': 2023,
      'duration': '2h 49m',
      'isPrime': false,
    },
    {
      'title': 'Mission: Impossible - Dead Reckoning',
      'posters': [
        'https://image.tmdb.org/t/p/w500/NNxYkU70HPurnNCSiCjYAmacwm.jpg',
      ],
      'description': 'Ethan Hunt and his IMF team must track down a terrifying new weapon that threatens all of humanity if it falls into the wrong hands.',
      'year': 2023,
      'duration': '2h 43m',
      'isPrime': false,
    },
    {
      'title': 'Extraction 2',
      'posters': [
        'https://image.tmdb.org/t/p/w500/7gKI9hpEMcZUQpNgKrkDzJpbnNS.jpg',
      ],
      'description': 'After barely surviving the events of the first movie, elite black ops mercenary Tyler Rake is back for another deadly mission.',
      'year': 2023,
      'duration': '2h 3m',
      'isPrime': true,
    },
    {
      'title': 'Sisu',
      'posters': [
        'https://image.tmdb.org/t/p/original/l2hTQgqlRjs8QoO2yx3iCLuC88k.jpg',
      ],
      'description': 'When an ex-soldier discovers gold in the Lapland wilderness, he tries to take the loot into the city. But brutal Nazi soldiers led by a ruthless SS officer battle him for it.',
      'year': 2022,
      'duration': '1h 31m',
      'isPrime': false,
    },
    {
      'title': 'Captain America: Brave New World',
      'posters': [
        'https://image.tmdb.org/t/p/original/qfAfE5auxsuxhxPpnETRAyTP5ff.jpg',
      ],
      'description': 'Newly anointed Captain America Sam Wilson finds himself caught in an international incident after meeting the newly elected U.S. President Thaddeus Ross. He must uncover a global conspiracy before the whole world "sees red".',
      'year': 2025,
      'duration': '1h 58m',
      'isPrime': false,
    },
  ];

  List<String> get bannerUrls {
    return bannerMovies.map((m) => (m['posters'] as List).first as String).toList();
  }

  @override
  void initState() {
    super.initState();
    _bannerController = PageController(viewportFraction: 1.0);
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _bannerTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_bannerController.hasClients) {
        final nextPage = (_currentBannerIndex + 1) % bannerUrls.length;
        _bannerController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 700;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Amazon_Prime_Video_logo.svg/2560px-Amazon_Prime_Video_logo.svg.png', 
              height: 37,
              fit: BoxFit.contain,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          // Auto-sliding Banner Carousel
          Stack(
            children: [
              SizedBox(
                height: isTablet ? 400 : 250,
                child: PageView.builder(
                  controller: _bannerController,
                  itemCount: bannerUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () => _showMovieDialog(context, bannerMovies[i]),
                      child: Stack(
                        children: [
                          // Background Image
                          Image.network(
                            bannerUrls[i],
                            width: double.infinity,
                            height: isTablet ? 400 : 250,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[900],
                              child: const Center(
                                child: Icon(Icons.image_not_supported,
                                    size: 50, color: Colors.white30),
                              ),
                            ),
                          ),
                          // Gradient Overlay
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black87,
                                ],
                              ),
                            ),
                          ),
                          // Content
                          Positioned(
                            bottom: 40,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Prime Badge
                                if (bannerMovies[i]['isPrime'] == true)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'PRIME',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (bannerMovies[i]['isPrime'] == true) const SizedBox(height: 10),
                                Text(
                                  bannerMovies[i]['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet ? 32 : 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: isTablet ? 400 : 200,
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _showMovieDialog(context, bannerMovies[i]),
                                    icon: const Icon(Icons.play_arrow),
                                    label: const Text('Watch Now'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Page Indicators
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    bannerUrls.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentBannerIndex == index
                            ? Colors.blueAccent
                            : Colors.white.withAlpha(128),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Continue Watching Section
          sectionHeader(context, 'Continue Watching'),
          SizedBox(
            height: isTablet ? 220 : 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: continueWatching.length,
              itemBuilder: (context, idx) {
                final m = continueWatching[idx];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () => _showMovieDialog(context, m),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            PosterTile(
                              title: m['title'],
                              posterCandidates: m['posters'],
                              width: isTablet ? 280 : 140,
                              height: isTablet ? 160 : 100,
                              roundRadius: 8,
                            ),
                            if (m['isPrime'] == true)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'PRIME',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: isTablet ? 280 : 140,
                          child: LinearProgressIndicator(
                            value: 0.37,
                            minHeight: 6,
                            backgroundColor: Colors.white12,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blueAccent),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('37% watched',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: isTablet ? 14 : 12)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Prime Originals Section
          sectionHeader(context, 'Prime Originals'),
          _horizontalMovieList(context, primeOriginals, isTablet),

          const SizedBox(height: 24),

          // Popular Shows Section
          sectionHeader(context, 'Popular Shows'),
          _horizontalMovieList(context, popularShows, isTablet),

          const SizedBox(height: 24),

          // Recommended Movies Section
          sectionHeader(context, 'Recommended Movies'),
          _horizontalMovieList(context, recommendedMovies, isTablet),

          const SizedBox(height: 24),

          // Action Movies Section
          sectionHeader(context, 'Action Movies'),
          _horizontalMovieList(context, actionMovies, isTablet),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _horizontalMovieList(
      BuildContext context, List<Map<String, dynamic>> movies, bool isTablet) {
    return SizedBox(
      height: isTablet ? 320 : 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: movies.length,
        itemBuilder: (context, idx) {
          final m = movies[idx];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              children: [
                PosterTile(
                  title: m['title'],
                  posterCandidates: m['posters'],
                  width: isTablet ? 200 : 120,
                  height: isTablet ? 300 : 160,
                  roundRadius: 10,
                  onTap: () => _showMovieDialog(context, m),
                ),
                if (m['isPrime'] == true)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'PRIME',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget sectionHeader(BuildContext ctx, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text('View all',
              style: TextStyle(color: Colors.blueAccent.shade200)),
        )
      ]),
    );
  }

  void _showMovieDialog(BuildContext ctx, Map<String, dynamic> movie) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(movie['title'], style: const TextStyle(color: Colors.white)),
        content: const Text(
          'Would you like to view more details?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(ctx,
                  MaterialPageRoute(builder: (_) => DetailPage(movie: movie)));
            },
            child: const Text('View Details',
                style: TextStyle(color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }
}

/// Prime Page
class PrimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Prime', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 80, color: Colors.blueAccent),
            SizedBox(height: 20),
            Text(
              'Prime Content',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Exclusive Prime movies and shows',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

/// Subscriptions Page
class SubscriptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Subscriptions', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.subscriptions, size: 80, color: Colors.blueAccent),
            SizedBox(height: 20),
            Text(
              'Your Subscriptions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Manage your channel subscriptions',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

/// Downloads Page
class DownloadsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Downloads', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.download, size: 80, color: Colors.blueAccent),
            SizedBox(height: 20),
            Text(
              'Your Downloads',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Offline content available',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

/// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.blueAccent,
          decoration: const InputDecoration(
            hintText: 'Search movies or shows...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search, color: Colors.white70),
          ),
          onChanged: (query) {},
        ),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Search results will appear here',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}

/// Poster Tile (handles fallback)
class PosterTile extends StatefulWidget {
  final String title;
  final List<String> posterCandidates;
  final double width;
  final double height;
  final double roundRadius;
  final VoidCallback? onTap;
  final bool showTitleOverlay;

  const PosterTile({
    Key? key,
    required this.title,
    required this.posterCandidates,
    required this.width,
    required this.height,
    this.roundRadius = 8,
    this.onTap,
    this.showTitleOverlay = false,
  }) : super(key: key);

  @override
  State<PosterTile> createState() => _PosterTileState();
}

class _PosterTileState extends State<PosterTile> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasCandidate = _currentIndex < widget.posterCandidates.length;
    final imageUrl = hasCandidate ? widget.posterCandidates[_currentIndex] : null;

    Widget posterChild;

    if (imageUrl != null) {
      posterChild = Image.network(
        imageUrl,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            width: widget.width,
            height: widget.height,
            color: Colors.grey[900],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _currentIndex += 1);
          });
          return Container(
            width: widget.width,
            height: widget.height,
            color: Colors.grey[900],
            child: const Center(
                child: Icon(Icons.image_not_supported,
                    size: 36, color: Colors.white24)),
          );
        },
      );
    } else {
      posterChild = Container(
        width: widget.width,
        height: widget.height,
        color: Colors.grey[850],
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.roundRadius),
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 200),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              posterChild,
              if (widget.showTitleOverlay)
                Container(
                  width: widget.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Detail Page
class DetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final String title = movie['title'] ?? 'Details';
    final String description = movie['description'] ?? 'No description available.';
    final int year = movie['year'] ?? 0;
    final String duration = movie['duration'] ?? 'N/A';
    final List<String> posters = (movie['posters'] as List?)?.cast<String>() ?? [];
    final String mainPosterUrl = posters.isNotEmpty ? posters.first : '';
    final bool isPrime = movie['isPrime'] ?? false;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image/Poster
            if (mainPosterUrl.isNotEmpty)
              Stack(
                children: [
                  Image.network(
                    mainPosterUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      color: Colors.grey[800],
                      child: const Center(
                          child: Icon(Icons.image_not_supported, size: 50, color: Colors.white30)),
                    ),
                  ),
                  if (isPrime)
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'PRIME',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Metadata (Year, Duration)
                  Row(
                    children: [
                      Text(
                        '$year',
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const Text(' • ', style: TextStyle(color: Colors.white70)),
                      Text(
                        duration,
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      if (isPrime) ...[
                        const Text(' • ', style: TextStyle(color: Colors.white70)),
                        const Text(
                          'Included with Prime',
                          style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Watch Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.download_for_offline, size: 30, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add, size: 30, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Description
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  // More content
                  const Text('Cast & Crew', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Coming Soon...', style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder Page
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prime Video')),
      body:
          Center(child: Text(title, style: const TextStyle(fontSize: 18))),
    );
  }
}