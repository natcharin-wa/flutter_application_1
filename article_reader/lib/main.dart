import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final savedFont = prefs.getString('fontFamily') ?? 'Mali';
  final savedFontSize = prefs.getDouble('fontSize') ?? 14;
  final savedDarkMode = prefs.getBool('darkMode') ?? false;

  runApp(
    ArticleReaderApp(
      initialFont: savedFont,
      initialFontSize: savedFontSize,
      initialTheme: savedDarkMode ? ThemeMode.dark : ThemeMode.light,
    ),
  );
}

class ArticleReaderApp extends StatefulWidget {
  final String initialFont;
  final double initialFontSize;
  final ThemeMode initialTheme;

  const ArticleReaderApp({
    super.key,
    required this.initialFont,
    required this.initialFontSize,
    required this.initialTheme,
  });

  @override
  State<ArticleReaderApp> createState() => _ArticleReaderAppState();
}

class _ArticleReaderAppState extends State<ArticleReaderApp> {
  late String selectedFont;
  late double selectedFontSize;
  late ThemeMode selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedFont = widget.initialFont;
    selectedFontSize = widget.initialFontSize;
    selectedTheme = widget.initialTheme;
  }

  Future<void> updateSettings(String font, double size, ThemeMode mode) async {
    setState(() {
      selectedFont = font;
      selectedFontSize = size;
      selectedTheme = mode;
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('fontFamily', font);
    await prefs.setDouble('fontSize', size);
    await prefs.setBool('darkMode', mode == ThemeMode.dark);
  }

  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFFFCF5),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF78B89A),
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFDDF2E4),
        foregroundColor: const Color(0xFF315C4A),
        elevation: 0,
        titleTextStyle: GoogleFonts.mali(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF315C4A),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF8FFF9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFFB9DCC7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFFB9DCC7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF70B892), width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF78B89A),
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      textTheme: GoogleFonts.maliTextTheme(),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF172A2A),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF78B89A),
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF203C3A),
        foregroundColor: const Color(0xFFE5F5EA),
        elevation: 0,
        titleTextStyle: GoogleFonts.mali(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFE5F5EA),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF203534),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF547A70)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF8AC6A6), width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF65A986),
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      textTheme: GoogleFonts.maliTextTheme(ThemeData.dark().textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Beauty of Nature',
      themeMode: selectedTheme,
      theme: lightTheme(),
      darkTheme: darkTheme(),
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
  final Future<void> Function(String, double, ThemeMode) onSettingsChanged;

  const ArticlePage({
    super.key,
    required this.fontFamily,
    required this.fontSize,
    required this.themeMode,
    required this.onSettingsChanged,
  });

  TextStyle getArticleFont() {
    switch (fontFamily) {
      case 'Itim':
        return GoogleFonts.itim(fontSize: fontSize, height: 1.8);
      case 'Mitr':
        return GoogleFonts.mitr(fontSize: fontSize, height: 1.8);
      case 'Merriweather':
        return GoogleFonts.merriweather(fontSize: fontSize, height: 1.8);
      case 'Mali':
      default:
        return GoogleFonts.mali(fontSize: fontSize, height: 1.8);
    }
  }

  TextStyle getTitleFont() {
    switch (fontFamily) {
      case 'Itim':
        return GoogleFonts.itim(
          fontSize: fontSize + 10,
          fontWeight: FontWeight.bold,
          height: 1.3,
        );
      case 'Mitr':
        return GoogleFonts.mitr(
          fontSize: fontSize + 10,
          fontWeight: FontWeight.bold,
          height: 1.3,
        );
      case 'Merriweather':
        return GoogleFonts.merriweather(
          fontSize: fontSize + 10,
          fontWeight: FontWeight.bold,
          height: 1.3,
        );
      case 'Mali':
      default:
        return GoogleFonts.mali(
          fontSize: fontSize + 10,
          fontWeight: FontWeight.bold,
          height: 1.3,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final articleStyle = getArticleFont();
    final titleStyle = getTitleFont();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(Icons.menu_book_rounded, size: 30),
        ),
        title: const Text('The Beauty of Nature'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_rounded),
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
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('🌿', style: TextStyle(fontSize: 25)),
                const SizedBox(width: 6),
                Text(
                  'Nature & Peace',
                  style: GoogleFonts.mali(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? const Color(0xFFA8D4B7)
                        : const Color(0xFF78A88A),
                  ),
                ),
                const Spacer(),
                const Text('🌸', style: TextStyle(fontSize: 25)),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'The Beauty of Nature',
              style: titleStyle.copyWith(
                color: isDark
                    ? const Color(0xFFE3F3E8)
                    : const Color(0xFF315C4A),
              ),
            ),
            const SizedBox(height: 20),
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
              style: articleStyle.copyWith(
                color: isDark
                    ? const Color(0xFFDCEBE1)
                    : const Color(0xFF4C4C4C),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                '🌱 Read • Learn • Grow 🌱',
                style: GoogleFonts.mali(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? const Color(0xFFA8D4B7)
                      : const Color(0xFF78A88A),
                ),
              ),
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
  final Future<void> Function(String, double, ThemeMode) onSettingsChanged;

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

  Future<void> saveSettings() async {
    await widget.onSettingsChanged(
      selectedFont,
      selectedFontSize,
      selectedTheme,
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Settings 🌿'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 35),
        children: [
          CuteSection(
            icon: Icons.text_fields_rounded,
            title: 'Font Family',
            lightColor: const Color(0xFFDFF3E5),
            darkColor: const Color(0xFF294642),
            child: DropdownButtonFormField<String>(
              initialValue: selectedFont,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.font_download_rounded),
                labelText: 'Choose your font',
              ),
              items: [
                DropdownMenuItem(
                  value: 'Mali',
                  child: Text(
                    'Mali 🌸 (Default)',
                    style: GoogleFonts.mali(fontSize: 17),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Itim',
                  child: Text('Itim 🐰', style: GoogleFonts.itim(fontSize: 17)),
                ),
                DropdownMenuItem(
                  value: 'Mitr',
                  child: Text('Mitr 🌱', style: GoogleFonts.mitr(fontSize: 17)),
                ),
                DropdownMenuItem(
                  value: 'Merriweather',
                  child: Text(
                    'Merriweather 📖',
                    style: GoogleFonts.merriweather(fontSize: 15),
                  ),
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
          ),
          const SizedBox(height: 18),
          CuteSection(
            icon: Icons.format_size_rounded,
            title: 'Font Size',
            lightColor: const Color(0xFFFFE9E8),
            darkColor: const Color(0xFF4A3031),
            child: RadioGroup<double>(
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
          ),
          const SizedBox(height: 18),
          CuteSection(
            icon: Icons.wb_sunny_rounded,
            title: 'Display Mode',
            lightColor: const Color(0xFFE8F1FA),
            darkColor: const Color(0xFF293D4D),
            child: RadioGroup<ThemeMode>(
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
                    title: Text('Light Mode ☀️'),
                    value: ThemeMode.light,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text('Dark Mode 🌙'),
                    value: ThemeMode.dark,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 56,
            child: ElevatedButton.icon(
              onPressed: saveSettings,
              icon: const Icon(Icons.favorite_rounded),
              label: Text(
                'Save Settings',
                style: GoogleFonts.mali(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: Text(
              isDark
                  ? '🌙 Sweet dreams & happy reading 🌙'
                  : '🌸 Happy reading! 🌸',
              style: GoogleFonts.mali(
                fontSize: 14,
                color: isDark
                    ? const Color(0xFFA8D1B5)
                    : const Color(0xFF79A78A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CuteSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color lightColor;
  final Color darkColor;
  final Widget child;

  const CuteSection({
    super.key,
    required this.icon,
    required this.title,
    required this.lightColor,
    required this.darkColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: BoxDecoration(
        color: isDark ? darkColor : lightColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 26,
                color: isDark
                    ? const Color(0xFFA8D4B7)
                    : const Color(0xFF5D9274),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.mali(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Text('🌿', style: TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
