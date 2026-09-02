import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ArticleReaderApp());
}

class ArticleReaderApp extends StatefulWidget {
  const ArticleReaderApp({super.key});

  @override
  State<ArticleReaderApp> createState() => _ArticleReaderAppState();
}

class _ArticleReaderAppState extends State<ArticleReaderApp> {
  String selectedFont = 'Roboto';
  double selectedFontSize = 14;
  ThemeMode selectedTheme = ThemeMode.light;

  void updateSettings(String font, double size, ThemeMode mode) {
    setState(() {
      selectedFont = font;
      selectedFontSize = size;
      selectedTheme = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Article Reader',
      themeMode: selectedTheme,

      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),

      home: ArticlePage(
        fontFamily: selectedFont,
        fontSize: selectedFontSize,
        themeMode: selectedTheme,
        onSettingsChanged: updateSettings,
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  final String fontFamily;
  final double fontSize;
  final ThemeMode themeMode;
  final Function(String, double, ThemeMode) onSettingsChanged;

  const ArticlePage({
    super.key,
    required this.fontFamily,
    required this.fontSize,
    required this.themeMode,
    required this.onSettingsChanged,
  });

  TextStyle getArticleFont() {
    switch (fontFamily) {
      case 'Merriweather':
        return GoogleFonts.merriweather(fontSize: fontSize, height: 1.8);

      case 'Roboto Mono':
        return GoogleFonts.robotoMono(fontSize: fontSize, height: 1.7);

      case 'Roboto':
      default:
        return GoogleFonts.roboto(fontSize: fontSize, height: 1.8);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = getArticleFont();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Beauty of Nature',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    fontFamily: fontFamily,
                    fontSize: fontSize,
                    themeMode: themeMode,
                    onSettingsChanged: onSettingsChanged,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The Beauty of Nature',
              style: GoogleFonts.merriweather(
                fontSize: fontSize + 10,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              '''
Nature is one of the most beautiful things that surrounds us every day. From the green trees in the forest to the sound of flowing water, nature gives us a peaceful place to relax and enjoy our lives.

Spending time in nature can help us feel calm and refreshed. Walking through a park, watching the sunset, or simply sitting under a tree can make an ordinary day feel special. The natural world gives us many opportunities to slow down and appreciate the simple things around us.

Forests are home to many different kinds of plants and animals. Each living thing has an important role in maintaining the balance of the environment. Trees provide oxygen, protect the soil, and create homes for many animals. A healthy forest is an important part of a healthy planet.

Water is also an important part of nature. Rivers, lakes, and oceans support countless forms of life. Clean water is necessary for people, animals, and plants to survive. Water also makes landscapes beautiful and provides peaceful places where people can relax.

However, nature needs our help. Pollution, deforestation, and waste can damage the environment. When natural resources are used without care, plants and animals can lose their homes and ecosystems can become unbalanced.

Everyone can help protect nature through simple actions. We can reduce waste, save water, plant trees, recycle materials, and use resources responsibly. Even small changes in our daily lives can help create a cleaner environment.

When we take care of nature, we are also taking care of our future. A clean and healthy environment can make our lives better and give future generations a beautiful world to live in.

Nature reminds us that even simple things can be meaningful. A flower blooming, birds singing, leaves moving in the wind, or rain falling can show us the beauty that exists around us.

Let us appreciate nature and do our best to protect it. Even small actions can make a difference when many people work together.
''',
              style: textStyle,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  final String fontFamily;
  final double fontSize;
  final ThemeMode themeMode;
  final Function(String, double, ThemeMode) onSettingsChanged;

  const SettingsPage({
    super.key,
    required this.fontFamily,
    required this.fontSize,
    required this.themeMode,
    required this.onSettingsChanged,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String selectedFont;
  late double selectedFontSize;
  late ThemeMode selectedTheme;

  @override
  void initState() {
    super.initState();

    selectedFont = widget.fontFamily;
    selectedFontSize = widget.fontSize;
    selectedTheme = widget.themeMode;
  }

  void saveSettings() {
    widget.onSettingsChanged(selectedFont, selectedFontSize, selectedTheme);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),

      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Font Family',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            initialValue: selectedFont,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.font_download),
            ),
            items: [
              DropdownMenuItem(
                value: 'Roboto',
                child: Text('Roboto', style: GoogleFonts.roboto()),
              ),
              DropdownMenuItem(
                value: 'Merriweather',
                child: Text('Merriweather', style: GoogleFonts.merriweather()),
              ),
              DropdownMenuItem(
                value: 'Roboto Mono',
                child: Text('Roboto Mono', style: GoogleFonts.robotoMono()),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedFont = value;
                });
              }
            },
          ),

          const SizedBox(height: 32),

          const Text(
            'Font Size',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          RadioGroup<double>(
            groupValue: selectedFontSize,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedFontSize = value;
                });
              }
            },
            child: const Column(
              children: [
                RadioListTile<double>(title: Text('Small (14px)'), value: 14),
                RadioListTile<double>(title: Text('Large (20px)'), value: 20),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Display Mode',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          RadioGroup<ThemeMode>(
            groupValue: selectedTheme,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedTheme = value;
                });
              }
            },
            child: const Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: Text('Light Mode'),
                  secondary: Icon(Icons.light_mode),
                  value: ThemeMode.light,
                ),
                RadioListTile<ThemeMode>(
                  title: Text('Dark Mode'),
                  secondary: Icon(Icons.dark_mode),
                  value: ThemeMode.dark,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: saveSettings,
              icon: const Icon(Icons.save),
              label: const Text(
                'Save Settings',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
