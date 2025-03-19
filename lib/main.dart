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
  final Function toggleTheme;

  const MyHomePage({super.key, required this.title, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () => toggleTheme(),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GetStartedPage()),
            );
          },
          child: Text('Get Started'),
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
    setState(() {
      _cardColor = color;
    });
  }

  void _saveAndNavigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(name: _name, cardColor: _cardColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Name'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                color: _cardColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(9.0),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/list.png', width: 200, height: 200),
                      SizedBox(height: 4),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomPaint(
                          size: Size(double.infinity, 1),
                          painter: DashedLinePainter(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0), // Reduced top margin
                        child: Text('Name: $_name', style: TextStyle(fontFamily: 'AestheticFont', fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Selected Color: ${_colorNames[_cardColor] ?? "Custom"}',
              style: TextStyle(fontFamily: 'AestheticFont', fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _colorPicker(Colors.red),
                _colorPicker(Colors.green),
                _colorPicker(Colors.blue),
                _colorPicker(Colors.yellow),
                _colorPicker(Colors.orange),
                _colorPicker(Colors.purple),
                _colorPicker(Colors.brown),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.blue),
                  onPressed: () {
                    // Add custom color picker functionality here
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Name',
              style: TextStyle(fontFamily: 'AestheticFont', fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.transparent),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveAndNavigate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black, width: 1),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    var max = size.width;
    var dashWidth = 5;
    var dashSpace = 3;
    double startX = 0;

    while (startX < max) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DisplayPage extends StatelessWidget {
  final String name;
  final Color cardColor;

  const DisplayPage({super.key, required this.name, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, $name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(9.0),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/list.png', width: 200, height: 200),
                      SizedBox(height: 4), // Reduced height
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomPaint(
                          size: Size(double.infinity, 1),
                          painter: DashedLinePainter(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0), // Reduced top margin
                        child: Text('Name: $name', style: TextStyle(fontFamily: 'AestheticFont', fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}