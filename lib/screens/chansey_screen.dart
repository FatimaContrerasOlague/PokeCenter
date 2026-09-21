import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poke_center/widgets/menu_button.dart';
import 'package:poke_center/widgets/responsive_panel.dart';

class ChanseyScreen extends StatefulWidget {
  const ChanseyScreen({super.key});

  @override
  State<ChanseyScreen> createState() => _ChanseyScreenState();
}

class _FallingItem {
  _FallingItem({required this.lane, required this.isEgg});

  final int lane;
  final bool isEgg;
  double progress = 0;
}

class _ChanseyScreenState extends State<ChanseyScreen> {
  static const _background = 'assets/images/poke_center/chF.jpeg';
  static const _egg = 'assets/images/poke_center/huevo.png';
  static const _bolt = 'assets/images/poke_center/bolt.png';
  static const _characters = [
    'assets/images/poke_center/characters/chanseyMJ3.png',
    'assets/images/poke_center/characters/chanseyMJ1.png',
    'assets/images/poke_center/characters/chanseyMJ2.png',
  ];

  final _random = math.Random();
  Timer? _gameTimer;
  final _fallingItems = <_FallingItem>[];
  int _elapsedTicks = 0;
  int _score = 0;
  bool _gameStarted = false;
  int _activeLane = 1;

  String get _activeCharacter => _characters[_activeLane];

  void _updateSafely(VoidCallback update) {
    if (!mounted) return;
    final phase = WidgetsBinding.instance.schedulerPhase;
    if (phase == SchedulerPhase.idle ||
        phase == SchedulerPhase.postFrameCallbacks) {
      setState(update);
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(update);
    });
    WidgetsBinding.instance.scheduleFrame();
  }

  void _setActiveLane(int lane) {
    _updateSafely(() => _activeLane = lane);
  }

  @override
  void initState() {
    super.initState();
    _gameTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (mounted) _advanceGame();
    });
  }

  void _advanceGame() {
    if (!_gameStarted) return;

    _updateSafely(() {
      _elapsedTicks++;
      if (_elapsedTicks >= 40) {
        _elapsedTicks = 0;
        _fallingItems.add(_createItem());
      }

      for (final item in _fallingItems) {
        item.progress += 1 / 40;
        if (item.progress >= 1 && item.lane == _activeLane) {
          _score = item.isEgg ? _score + 1 : math.max(0, _score - 5);
        }
      }

      _fallingItems.removeWhere((item) => item.progress >= 1);
    });
  }

  _FallingItem _createItem() {
    return _FallingItem(
      lane: _random.nextInt(3),
      isEgg: _random.nextDouble() < 0.75,
    );
  }

  void _startGame() {
    _updateSafely(() {
      _gameStarted = true;
      _elapsedTicks = 0;
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final eggSize = (screenWidth * 0.32).clamp(110.0, 155.0).toDouble();
    final boltSize = (screenWidth * 0.24).clamp(85.0, 120.0).toDouble();
    final characterLeft = const [0.15, 0.25, 0.35][_activeLane];
    final characterRight = const [0.35, 0.25, 0.15][_activeLane];
    final panelSize = math.min(
      (screenHeight * 0.09).clamp(55.0, 85.0).toDouble(),
      screenWidth * 0.20,
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_background, fit: BoxFit.cover),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: MenuButton(),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 2, right: 12),
                child: _ScorePanel(score: _score),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * characterLeft,
            right: screenWidth * characterRight,
            top: screenHeight * 0.12,
            bottom: screenHeight * 0.18,
            child: _LaneCharacter(
              asset: _activeCharacter,
              scale: _activeLane == 1 ? 1.08 : 1,
            ),
          ),
          for (final item in _fallingItems)
            Positioned(
              top: screenHeight * (0.15 + item.progress * 0.48),
              left: screenWidth * (0.17 + item.lane * 0.33) -
                  (item.isEgg ? eggSize : boltSize) / 2,
              width: item.isEgg ? eggSize : boltSize,
              height: item.isEgg ? eggSize : boltSize,
              child: Image.asset(
                item.isEgg ? _egg : _bolt,
                fit: BoxFit.contain,
              ),
            ),
          Positioned(
            left: screenWidth * 0.015,
            right: screenWidth * 0.015,
            bottom: screenHeight * 0.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _LanePanel(
                  size: panelSize,
                  onPress: () => _setActiveLane(0),
                  onRelease: () => _setActiveLane(1),
                ),
                _LanePanel(
                  size: panelSize,
                  onPress: () => _setActiveLane(2),
                  onRelease: () => _setActiveLane(1),
                ),
              ],
            ),
          ),
          if (!_gameStarted)
            Center(
              child: ResponsivePanel(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5345AB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'INICIAR',
                    style: TextStyle(
                      fontFamily: 'NESFont',
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LaneCharacter extends StatelessWidget {
  const _LaneCharacter({required this.asset, this.scale = 1});

  final String asset;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.bottomCenter,
        child: Image.asset(asset, fit: BoxFit.contain),
      ),
    );
  }
}

class _LanePanel extends StatelessWidget {
  const _LanePanel({
    required this.size,
    required this.onPress,
    required this.onRelease,
  });

  final double size;
  final VoidCallback onPress;
  final VoidCallback onRelease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => onPress(),
        onTapUp: (_) => onRelease(),
        onTapCancel: onRelease,
        child: ResponsivePanel(
          padding: EdgeInsets.zero,
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _ScorePanel extends StatelessWidget {
  const _ScorePanel({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Text(
      'PUNTOS: $score',
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'NESFont',
        fontSize: 10,
      ),
    );
  }
}

