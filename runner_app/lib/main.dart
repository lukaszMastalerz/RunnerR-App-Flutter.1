import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stopwatch _stopwatch = Stopwatch();
  String _stopwatchText = '00:00:00';
  bool _showPreloader = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading time
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showPreloader = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'RUNNER',
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 50.0,
            ),
          ),
        ),
        backgroundColor: Colors.yellow, // App bar background color
      ),
      body: _showPreloader
          ? _buildPreloader()
          : _buildStopwatchContainer(),
    );
  }

  Widget _buildPreloader() {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: SvgPicture.asset(
          'assets/runnerLogo.svg',
          color: Colors.white,
          width: 40.0,
          height: 40.0,
        ),
      ),
    );
  }

  Widget _buildStopwatchContainer() {
    return Container(
      color: Colors.purple, //  Background color
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _stopwatchText,
              style: const TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 70.0,
                color: Colors.yellow, //  Glowing yellow text color
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.yellow,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startStopwatch();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  child: const Text('START'),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    stopStopwatch();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  child: const Text('STOP'),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    resetStopwatch();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  child: const Text('RESET'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startStopwatch() {
    setState(() {
      _stopwatch.start();
      _updateStopwatchText();
    });
  }

  void stopStopwatch() {
    setState(() {
      _stopwatch.stop();
      _updateStopwatchText();
    });
  }

  void resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _updateStopwatchText();
    });
  }

  void _updateStopwatchText() {
    final seconds = _stopwatch.elapsed.inSeconds % 60;
    final minutes = (_stopwatch.elapsed.inMinutes % 60).floor();
    final hours = (_stopwatch.elapsed.inHours).floor();

    setState(() {
      _stopwatchText = '$hours:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
    });
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }
}
