import 'package:flutter/material.dart';
import 'create_event_screen.dart';

class Event {
  final String id;
  final String title;
  final String date;
  final String location;
  final String imageUrl;
  final List<String> categories;
  final double price;
  final String organizer;
  bool isLiked;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.categories,
    required this.price,
    required this.organizer,
    this.isLiked = false,
  });
}

final List<Event> dummyEvents = [
  // Music & Entertainment
  Event(
    id: '1',
    title: 'Summer Music Festival',
    date: 'July 15, 2024',
    location: 'Central Park, NY',
    imageUrl: 'https://picsum.photos/200/300?music',
    categories: ['Music Concerts', 'Festivals'],
    price: 49.99,
    organizer: 'Music Events Inc.',
  ),
  Event(
    id: '2',
    title: 'Jazz Night Live',
    date: 'August 2, 2024',
    location: 'Blue Note Club',
    imageUrl: 'https://picsum.photos/200/300?jazz',
    categories: ['Live Music'],
    price: 35.00,
    organizer: 'Jazz Society',
  ),

  // Sports
  Event(
    id: '3',
    title: 'Championship Football',
    date: 'September 10, 2024',
    location: 'City Stadium',
    imageUrl: 'https://picsum.photos/200/300?football',
    categories: ['Sports Events', 'Football'],
    price: 75.00,
    organizer: 'Sports United',
  ),

  // Food & Drink
  Event(
    id: '4',
    title: 'International Food Fest',
    date: 'October 5, 2024',
    location: 'Downtown Market',
    imageUrl: 'https://picsum.photos/200/300?food',
    categories: ['Food Festivals'],
    price: 15.00,
    organizer: 'Foodie Network',
  ),

  // Technology
  Event(
    id: '5',
    title: 'Tech Innovators Summit',
    date: 'November 18, 2024',
    location: 'Convention Center',
    imageUrl: 'https://picsum.photos/200/300?tech',
    categories: ['Technology'],
    price: 299.99,
    organizer: 'Tech Global',
  ),

  // Fashion
  Event(
    id: '6',
    title: 'Spring Fashion Week',
    date: 'March 22, 2024',
    location: 'Fashion District',
    imageUrl: 'https://picsum.photos/200/300?fashion',
    categories: ['Fashion'],
    price: 150.00,
    organizer: 'Fashion Forward',
  ),

  // Gaming
  Event(
    id: '7',
    title: 'Epic Gaming Tournament',
    date: 'June 15, 2024',
    location: 'eSports Arena',
    imageUrl: 'https://picsum.photos/200/300?gaming',
    categories: ['Gaming'],
    price: 25.00,
    organizer: 'Game On',
  ),

  // Theater
  Event(
    id: '8',
    title: 'Broadway Musical Night',
    date: 'April 5, 2024',
    location: 'Majestic Theater',
    imageUrl: 'https://picsum.photos/200/300?theater',
    categories: ['Theater'],
    price: 89.99,
    organizer: 'Stage Masters',
  ),

  // Comedy
  Event(
    id: '9',
    title: 'Stand-Up Comedy Special',
    date: 'May 20, 2024',
    location: 'Laugh Factory',
    imageUrl: 'https://picsum.photos/200/300?comedy',
    categories: ['Comedy Shows'],
    price: 45.00,
    organizer: 'Comedy Central',
  ),

  // Art
  Event(
    id: '10',
    title: 'Modern Art Exhibition',
    date: 'December 1, 2024',
    location: 'Museum of Modern Art',
    imageUrl: 'https://picsum.photos/200/300?art',
    categories: ['Art Exhibitions'],
    price: 25.00,
    organizer: 'Art World',
  ),
];

class HomeScreen extends StatefulWidget {
  final List<String> selectedInterests;

  const HomeScreen({super.key, required this.selectedInterests});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Event> _events = dummyEvents;
  late List<Event> _filteredEvents;
  final String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredEvents = _filterEvents(_events);
  }

  List<Event> _filterEvents(List<Event> events) {
    return events.where((event) {
      final matchesSearch = event.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.organizer.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final matchesInterests = widget.selectedInterests.isEmpty ||
          event.categories.any((category) => widget.selectedInterests.contains(category));
      
      return matchesSearch && matchesInterests;
    }).toList();
  }

  void _toggleLike(String eventId) {
    setState(() {
      _events = _events.map((event) {
        if (event.id == eventId) {
          return Event(
            id: event.id,
            title: event.title,
            date: event.date,
            location: event.location,
            imageUrl: event.imageUrl,
            categories: event.categories,
            price: event.price,
            organizer: event.organizer,
            isLiked: !event.isLiked,
          );
        }
        return event;
      }).toList();
      _filteredEvents = _filterEvents(_events);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: EventSearchDelegate(events: _events),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF9C27B0)],
                ),
              ),
              child: Text(
                'ZED Events',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create Event'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEventScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3F2FD), Color(0xFFF3E5F5)],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            setState(() => _filteredEvents = _filterEvents(_events));
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Interests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.selectedInterests.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Chip(
                              label: Text(widget.selectedInterests[index]),
                              backgroundColor: Colors.blue.shade50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.65,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => EventCard(
                      event: _filteredEvents[index],
                      onLike: () => _toggleLike(_filteredEvents[index].id),
                    ),
                    childCount: _filteredEvents.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateEventScreen()),
        ),
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onLike;

  const EventCard({super.key, required this.event, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFF8F9FA)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    event.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      event.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: event.isLiked ? Colors.red : Colors.white,
                    ),
                    onPressed: onLike,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF2D2D2D),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        event.date,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${event.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventSearchDelegate extends SearchDelegate<Event?> {
  final List<Event> events;

  EventSearchDelegate({required this.events});

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    final results = events.where((event) =>
        event.title.toLowerCase().contains(query.toLowerCase()) ||
        event.organizer.toLowerCase().contains(query.toLowerCase()));

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        leading: Image.network(results.elementAt(index).imageUrl, width: 50),
        title: Text(results.elementAt(index).title),
        subtitle: Text(results.elementAt(index).organizer),
        onTap: () => close(context, results.elementAt(index)),
      ),
    );
  }
}