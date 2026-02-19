import 'package:flutter/material.dart';

class ColorService extends ChangeNotifier {
  final Map<CardType, int> _tapCounts = { // bonus
    CardType.red: 0,
    CardType.blue: 0,
    CardType.green: 0,
  };

  int getCount(CardType type) => _tapCounts[type] ?? 0;

  void increment(CardType type) {
    _tapCounts[type] = (_tapCounts[type] ?? 0) + 1;
    notifyListeners();
  }
}

final colorService = ColorService(); // global instance

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue, green }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _screens = [const ColorTapsScreen(), const StatisticsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: CardType.values.map((type) => ColorTap(type: type,)).toList(),
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  const ColorTap({super.key, required this.type});

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, child) {
        return GestureDetector(
          onTap:() => colorService.increment(type),
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: 100,
            child: Center(
              child: Text(
                'Taps: ${colorService.getCount(type)}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: ListenableBuilder(
          listenable: colorService,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: CardType.values.map((type) => 
              Text('${type.name.toUpperCase()} Taps: ${colorService.getCount(type)}',
              style: const TextStyle(fontSize: 24))).toList(),
            );
          },
        ),
      ),
    );
  }
}