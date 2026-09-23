import 'package:flutter/material.dart';

void main() {
  runApp(const AnimeDXApp());
}

class AnimeDXApp extends StatelessWidget {
  const AnimeDXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ANIME DX',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFFF640A),
      ),
      home: const AnimeDXMainHolder(),
    );
  }
}

class AnimeDXMainHolder extends StatefulWidget {
  const AnimeDXMainHolder({super.key});

  @override
  State<AnimeDXMainHolder> createState() => _AnimeDXMainHolderState();
}

class _AnimeDXMainHolderState extends State<AnimeDXMainHolder> {
  int _bottomNavIndex = 0; // Default to Home
  String _searchQuery = '';

  final List<Map<String, String>> _allAnimeList = [
    {
      'title': 'Demon Slayer: Kimetsu',
      'type': 'Dub | Sub',
      'episodes': '26 Episodes',
      'desc': 'Tanjiro sets out to avenge his family and cure his sister Nezuko.',
      'image': 'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=500&q=80',
    },
    {
      'title': 'Naruto Shippuden',
      'type': 'Dub | Sub',
      'episodes': '500 Episodes',
      'desc': 'Naruto returns to save the ninja world and bring back Sasuke.',
      'image': 'https://images.unsplash.com/photo-1618336753974-aae8e04506aa?w=500&q=80',
    },
    {
      'title': 'Blue Lock',
      'type': 'Dub | Sub',
      'episodes': '24 Episodes',
      'desc': 'Japan creates an extreme soccer training facility to find the ultimate striker.',
      'image': 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=500&q=80',
    },
    {
      'title': 'Gachiakuta',
      'type': 'Dub | Sub',
      'episodes': '12 Episodes',
      'desc': 'A young boy framed for murder falls into the abyss seeking vengeance.',
      'image': 'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=500&q=80',
    },
  ];

  void _openPlayer(Map<String, String> anime) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimePlayerScreen(anime: anime)),
    );
  }

  // 1. HOME SCREEN
  Widget _buildHomeScreen() {
    final featured = _allAnimeList.first;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Banner
          GestureDetector(
            onTap: () => _openPlayer(featured),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  featured['image']!,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        featured['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF640A),
                        ),
                        onPressed: () => _openPlayer(featured),
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        label: const Text('Watch Now', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: Text(
              'Trending Now',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _allAnimeList.length,
              itemBuilder: (context, index) {
                final anime = _allAnimeList[index];
                return GestureDetector(
                  onTap: () => _openPlayer(anime),
                  child: Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              anime['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          anime['title']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 2. MY LISTS SCREEN
  Widget _buildMyListsScreen() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'My Watchlist',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 12),
        ..._allAnimeList.take(2).map((anime) {
          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(anime['image']!, width: 50, height: 70, fit: BoxFit.cover),
              ),
              title: Text(anime['title']!, style: const TextStyle(color: Colors.white)),
              subtitle: Text(anime['type']!, style: const TextStyle(color: Colors.grey)),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Color(0xFFFF640A)),
                onPressed: () => _openPlayer(anime),
              ),
            ),
          );
        }),
      ],
    );
  }

  // 3. BROWSE / SEARCH SCREEN
  Widget _buildBrowseScreen() {
    final filteredList = _allAnimeList.where((anime) {
      final title = anime['title']?.toLowerCase() ?? '';
      return title.contains(_searchQuery.toLowerCase());
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search anime...',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFFF640A)),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
              });
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Popular',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: filteredList.isEmpty
              ? const Center(
                  child: Text('No anime found', style: TextStyle(color: Colors.grey, fontSize: 16)),
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final anime = filteredList[index];
                    return GestureDetector(
                      onTap: () => _openPlayer(anime),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                anime['image']!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            anime['title']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(anime['type']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              const Icon(Icons.play_circle_fill, color: Color(0xFFFF640A), size: 18),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // 4. SIMULCAST SCREEN
  Widget _buildSimulcastScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _allAnimeList.length,
      itemBuilder: (context, index) {
        final anime = _allAnimeList[index];
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.calendar_today, color: Color(0xFFFF640A)),
            title: Text(anime['title']!, style: const TextStyle(color: Colors.white)),
            subtitle: const Text('New Episode drops today!', style: TextStyle(color: Colors.grey)),
            trailing: const Chip(
              label: Text('Simulcast', style: TextStyle(fontSize: 11, color: Colors.white)),
              backgroundColor: Color(0xFFFF640A),
            ),
          ),
        );
      },
    );
  }

  // 5. ACCOUNT SCREEN
  Widget _buildAccountScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 45,
            backgroundColor: Color(0xFFFF640A),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 16),
          Text(
            'Anime DX User',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Free Tier Member', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeScreen(),
      _buildMyListsScreen(),
      _buildBrowseScreen(),
      _buildSimulcastScreen(),
      _buildAccountScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'ANIME DX',
          style: TextStyle(
            color: Color(0xFFFF640A),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(child: pages[_bottomNavIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        backgroundColor: const Color(0xFF121212),
        selectedItemColor: const Color(0xFFFF640A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'My Lists'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Browse'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Simulcast'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

class AnimePlayerScreen extends StatelessWidget {
  final Map<String, String> anime;
  const AnimePlayerScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(anime['title'] ?? 'Player'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  anime['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Container(color: Colors.black45),
                const Icon(Icons.play_circle_outline, size: 64, color: Color(0xFFFF640A)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime['title']!,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  anime['desc'] ?? '',
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Episodes',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.play_circle, color: Color(0xFFFF640A)),
                  title: Text('Episode ${index + 1}', style: const TextStyle(color: Colors.white)),
                  trailing: const Icon(Icons.download, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

