import 'dart:async';
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
  int _bottomNavIndex = 2;

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
      backgroundColor: Colors.black,
      body: SafeArea(child: pages[_bottomNavIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        backgroundColor: const Color(0xFF111111),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF640A),
        unselectedItemColor: Colors.white54,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline), label: 'My Lists'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Browse'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Simulcast'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.purple,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBrandHeader(),
        const SizedBox(height: 16),
        Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1578632767115-351597cf2477?w=500&q=80'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Colors.black87, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            alignment: Alignment.bottomLeft,
            child: const Text("FEATURED: Demon Slayer New Arc", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 20),
        const Text("Continue Watching", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ListTile(
          tileColor: const Color(0xFF161616),
          leading: const Icon(Icons.play_circle_fill, color: Color(0xFFFF640A), size: 36),
          title: const Text("Naruto Shippuden - Ep 48"),
          subtitle: const Text("18m left", style: TextStyle(color: Colors.white54, fontSize: 12)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: () => _openPlayer(_allAnimeList[1]),
        )
      ],
    );
  }

  Widget _buildMyListsScreen() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("My Watchlist & Offline", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListTile(
          tileColor: const Color(0xFF141414),
          leading: const Icon(Icons.download_done, color: Colors.green),
          title: const Text("Blue Lock - Episode 1"),
          subtitle: const Text("Downloaded • 1080p Ultra HD", style: TextStyle(color: Colors.white54, fontSize: 12)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white38),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onTap: () => _openPlayer(_allAnimeList[2]),
        ),
      ],
    );
  }

  Widget _buildBrowseScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: _buildBrandHeader(),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Text('Popular', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 18,
              childAspectRatio: 0.58,
            ),
            itemCount: _allAnimeList.length,
            itemBuilder: (context, index) {
              final item = _allAnimeList[index];
              return GestureDetector(
                onTap: () => _openPlayer(item),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(item['image']!, width: double.infinity, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['type']!, style: const TextStyle(fontSize: 11, color: Colors.white54)),
                        const Icon(Icons.play_circle_fill, size: 20, color: Color(0xFFFF640A)),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSimulcastScreen() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text("Weekly Simulcast Schedule", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        ListTile(
          tileColor: Color(0xFF141414),
          leading: Icon(Icons.schedule, color: Color(0xFFFF640A)),
          title: Text("Demon Slayer New Episode"),
          subtitle: Text("Streaming Today at 8:30 PM", style: TextStyle(color: Colors.white54, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildAccountScreen() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 10),
        Center(
          child: Column(
            children: const [
              CircleAvatar(radius: 40, backgroundColor: Colors.purple, child: Icon(Icons.person, size: 45, color: Colors.white)),
              SizedBox(height: 10),
              Text("Anime DX VIP User", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("Free Tier • Ad-Supported", style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildAccountOption(Icons.hd, "Video Playback Quality", "1080p Ultra HD"),
        _buildAccountOption(Icons.notifications_outlined, "Notification Settings", "Enabled"),
        _buildAccountOption(Icons.download, "Download Location", "Internal Storage"),
        _buildAccountOption(Icons.help_outline, "Help & Feedback", ""),
      ],
    );
  }

  Widget _buildAccountOption(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFF640A)),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.white54)) : null,
      trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.white38),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opened $title')));
      },
    );
  }

  Widget _buildBrandHeader() {
    return Row(
      children: const [
        Text('ANIME ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.2)),
        Text('DX', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFFFF640A), letterSpacing: 1.2)),
      ],
    );
  }
}

class AnimePlayerScreen extends StatefulWidget {
  final Map<String, String> anime;
  const AnimePlayerScreen({super.key, required this.anime});

  @override
  State<AnimePlayerScreen> createState() => _AnimePlayerScreenState();
}

class _AnimePlayerScreenState extends State<AnimePlayerScreen> {
  bool _isPlaying = true;
  String _currentQuality = "1080p Ultra HD";
  double _volume = 0.8;
  bool _isMuted = false;
  double _videoSeconds = 120.0;
  final double _totalSeconds = 1440.0;
  String _currentEpisode = "Episode 1";
  Timer? _playbackTimer;
  final Map<String, double> _downloadProgress = {};

  @override
  void initState() {
    super.initState();
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPlaying && mounted) {
        setState(() {
          if (_videoSeconds < _totalSeconds) {
            _videoSeconds += 1;
          } else {
            _videoSeconds = 0;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    super.dispose();
  }

  String _formatDuration(double seconds) {
    int mins = (seconds / 60).floor();
    int secs = (seconds % 60).floor();
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _triggerDownload(String epName) {
    setState(() => _downloadProgress[epName] = 0.1);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Downloading $epName...')));

    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_downloadProgress[epName]! < 1.0) {
          _downloadProgress[epName] = _downloadProgress[epName]! + 0.2;
        } else {
          _downloadProgress[epName] = 1.0;
          timer.cancel();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$epName Download Complete!')));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: Text(widget.anime['title']!, style: const TextStyle(fontSize: 16))),
      body: Column(
        children: [
          Container(
            height: 210,
            color: const Color(0xFF0A0A0A),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(widget.anime['image']!, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                Container(color: Colors.black.withOpacity(_isPlaying ? 0.4 : 0.8)),
                GestureDetector(
                  onTap: () => setState(() => _isPlaying = !_isPlaying),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black54, border: Border.all(color: const Color(0xFFFF640A), width: 2)),
                    padding: const EdgeInsets.all(12),
                    child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 36, color: const Color(0xFFFF640A)),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      Text(_formatDuration(_videoSeconds), style: const TextStyle(fontSize: 10)),
                      Expanded(
                        child: Slider(
                          activeColor: const Color(0xFFFF640A),
                          value: _videoSeconds,
                          max: _totalSeconds,
                          onChanged: (v) => setState(() => _videoSeconds = v),
                        ),
                      ),
                      Text(_formatDuration(_totalSeconds), style: const TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(widget.anime['title']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(widget.anime['desc']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 16),
                const Text("Episodes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ...List.generate(4, (index) {
                  final epName = "Episode ${index + 1}";
                  final isCurrent = _currentEpisode == epName;
                  final downloadVal = _downloadProgress[epName] ?? 0.0;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Material(
                      color: isCurrent ? const Color(0xFF2A1C12) : const Color(0xFF141414),
                      borderRadius: BorderRadius.circular(8),
                      child: ListTile(
                        leading: Icon(isCurrent ? Icons.play_arrow : Icons.play_circle_outline, color: const Color(0xFFFF640A)),
                        title: Text(epName, style: TextStyle(color: isCurrent ? const Color(0xFFFF640A) : Colors.white, fontWeight: FontWeight.bold)),
                        trailing: IconButton(
                          icon: downloadVal == 1.0
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : (downloadVal > 0.0
                                  ? SizedBox(width: 18, height: 18, child: CircularProgressIndicator(value: downloadVal, strokeWidth: 2, color: const Color(0xFFFF640A)))
                                  : const Icon(Icons.download_for_offline_outlined, color: Colors.white70)),
                          onPressed: () => _triggerDownload(epName),
                        ),
                        onTap: () => setState(() {
                          _currentEpisode = epName;
                          _videoSeconds = 0;
                          _isPlaying = true;
                        }),
                      ),
                    ),
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
