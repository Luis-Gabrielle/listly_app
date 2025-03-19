import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aesthetic To-Do List',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(title: 'Task Manager', toggleTheme: toggleTheme),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final VoidCallback toggleTheme;

  const MyHomePage({super.key, required this.title, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GetStartedPage()),
          ),
          child: const Text('Get Started'),
        ),
      ),
    );
  }
}

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final TextEditingController _nameController = TextEditingController();
  String _name = '';
  Color _cardColor = Colors.white;

  final Map<Color, String> _colorNames = {
    Colors.red: 'Red',
    Colors.green: 'Green',
    Colors.blue: 'Blue',
    Colors.yellow: 'Yellow',
    Colors.orange: 'Orange',
    Colors.purple: 'Purple',
    Colors.brown: 'Brown',
  };

  void _pickColor(Color color) {
    setState(() => _cardColor = color);
  }

  void _saveAndNavigate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DisplayPage(name: _name, cardColor: _cardColor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Name')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardPreview(),
            const SizedBox(height: 10),
            Text(
              'Selected Color: ${_colorNames[_cardColor] ?? "Custom"}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildColorPicker(),
            const SizedBox(height: 20),
            _buildNameInput(),
            const SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: _cardColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(9.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/list.png', width: 200, height: 200),
              const SizedBox(height: 4),
              const Divider(),
              Text('Name: $_name', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _colorNames.keys.map((color) => _colorPicker(color)).toList(),
    );
  }

  Widget _colorPicker(Color color) {
    return GestureDetector(
      onTap: () => _pickColor(color),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 1),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() => _name = value),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveAndNavigate,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black, width: 1),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        child: const Text('Save'),
      ),
    );
  }
}

class DisplayPage extends StatelessWidget {
  final String name;
  final Color cardColor;

  const DisplayPage({super.key, required this.name, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, $name', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [Image.asset('assets/images/list.png', width: 200, height: 200)]),
        ),
      ),
    );
  }
}