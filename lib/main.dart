import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const RoommatesCalendarApp());
}

class RoommatesCalendarApp extends StatelessWidget {
  const RoommatesCalendarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roommates Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196F3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
          secondary: const Color(0xFF4CAF50),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF212121)),
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF424242)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF616161)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2196F3),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.home_rounded,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  'Roommates Calendar',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your shared space together',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: const Text('Log In'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Home Screen with Bottom Navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CalendarScreen(),
    const ChoresScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Chores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Calendar Screen
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Dummy events data
  final Map<DateTime, List<Event>> _events = {
    DateTime.now(): [
      Event('Roommate Meeting', '6:00 PM', 'Discuss cleaning schedule'),
      Event('Grocery Shopping', '3:00 PM', 'Weekly grocery run'),
    ],
    DateTime.now().add(const Duration(days: 2)): [
      Event('Rent Due', '11:59 PM', 'Pay monthly rent'),
    ],
    DateTime.now().add(const Duration(days: 5)): [
      Event('Movie Night', '8:00 PM', 'Watch new release together'),
    ],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddEventDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2026, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                markersMaxCount: 3,
                markerDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _selectedDay != null
                ? _buildEventsList()
                : Center(
                    child: Text(
                      'Select a day to view events',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList() {
    final events = _getEventsForDay(_selectedDay!);
    if (events.isEmpty) {
      return Center(
        child: Text(
          'No events for this day',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.event, color: Colors.white),
            ),
            title: Text(event.title),
            subtitle: Text('${event.time}\n${event.description}'),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Event'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(labelText: 'Time'),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Event added successfully')),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

// Chores Screen
class ChoresScreen extends StatefulWidget {
  const ChoresScreen({Key? key}) : super(key: key);

  @override
  State<ChoresScreen> createState() => _ChoresScreenState();
}

class _ChoresScreenState extends State<ChoresScreen> {
  // Dummy chores data
  final List<Chore> _chores = [
    Chore('Clean kitchen', 'Sara', false, 'High'),
    Chore('Take out trash', 'John', true, 'Medium'),
    Chore('Vacuum living room', 'Mike', false, 'Medium'),
    Chore('Clean bathroom', 'Lisa', false, 'High'),
    Chore('Water plants', 'Sara', true, 'Low'),
    Chore('Do laundry', 'John', false, 'Medium'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddChoreDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _chores.length,
        itemBuilder: (context, index) {
          final chore = _chores[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Checkbox(
                value: chore.isCompleted,
                onChanged: (value) {
                  setState(() {
                    chore.isCompleted = value ?? false;
                  });
                },
              ),
              title: Text(
                chore.title,
                style: TextStyle(
                  decoration: chore.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text('Assigned to: ${chore.assignedTo}'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getPriorityColor(chore.priority),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  chore.priority,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showAddChoreDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Chore'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Chore Title'),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(labelText: 'Assign To'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Priority'),
              items: ['High', 'Medium', 'Low']
                  .map((priority) => DropdownMenuItem(
                        value: priority,
                        child: Text(priority),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Chore added successfully')),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sara Johnson',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'sara@example.com',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Room: 01_301_03',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isBusy ? 'Busy - Do not disturb' : 'Available',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Switch(
                      value: _isBusy,
                      onChanged: (value) {
                        setState(() {
                          _isBusy = value;
                        });
                      },
                      activeColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Bio'),
                    subtitle: const Text('Software engineering student who loves cooking and gaming'),
                    leading: const Icon(Icons.info_outline),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Date of Birth'),
                    subtitle: const Text('May 12, 2000'),
                    leading: const Icon(Icons.cake_outlined),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Allergies'),
                    subtitle: const Text('Peanuts, Cats'),
                    leading: const Icon(Icons.medical_services_outlined),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Special Needs'),
                    subtitle: const Text('None'),
                    leading: const Icon(Icons.accessibility_new),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Roommates'),
                    leading: const Icon(Icons.people_outline),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('John Doe'),
                    subtitle: const Text('Room: 01_301_01'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: const Text('JD'),
                    ),
                  ),
                  ListTile(
                    title: const Text('Mike Smith'),
                    subtitle: const Text('Room: 01_301_02'),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: const Text('MS'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Log Out'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Data Models
class Event {
  final String title;
  final String time;
  final String description;

  Event(this.title, this.time, this.description);
}

class Chore {
  final String title;
  final String assignedTo;
  bool isCompleted;
  final String priority;

  Chore(this.title, this.assignedTo, this.isCompleted, this.priority);
}