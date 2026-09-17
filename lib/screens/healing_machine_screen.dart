import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:poke_center/screens/pokemon_center_screen.dart';
import 'package:poke_center/widgets/menu_button.dart';
import 'package:poke_center/widgets/pokeball_painter.dart';
import 'package:poke_center/widgets/responsive_panel.dart';

class HealingMachineScreen extends StatefulWidget {
  const HealingMachineScreen({super.key});

  @override
  State<HealingMachineScreen> createState() => _HealingMachineScreenState();
}

class _HealingMachineScreenState extends State<HealingMachineScreen> {
  static const List<int> available = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
  ];

  final ScrollController _scrollController = ScrollController();
  final List<int?> _slots = List.filled(6, null);
  final Set<int> _healed = {};
  Timer? _timer;
  int _progress = 0;
  bool _healing = false;

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _place(int slot, int id) {
    if (_healing ||
        _slots[slot] != null ||
        _slots.contains(id) ||
        _healed.contains(id)) {
      return;
    }
    setState(() {
      _slots[slot] = id;
      _progress = 0;
    });
  }

  void _heal() {
    if (_healing || !_slots.any((id) => id != null)) return;
    setState(() {
      _healing = true;
      _progress = 0;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      setState(() {
        _progress += 25;
        if (_progress == 100) {
          timer.cancel();
          _healing = false;
          _healed.addAll(_slots.whereType<int>());
          _slots.fillRange(0, _slots.length, null);
        }
      });
    });
  }

  Widget _ball(int id) => Semantics(
    label: 'Pokémon provisional $id',
    child: CustomPaint(painter: PokeballPainter()),
  );

  Widget _machine() => LayoutBuilder(
    builder: (context, constraints) {
      // Match the centered BoxFit.cover background exactly.
      final scale = math.max(
        constraints.maxWidth / 900,
        constraints.maxHeight / 1600,
      );
      final dx = (constraints.maxWidth - 900 * scale) / 2;
      final dy = (constraints.maxHeight - 1600 * scale) / 2;
      Widget at(double x, double y, double w, double h, Widget child) =>
          Positioned(
            left: dx + x * scale,
            top: dy + y * scale,
            width: w * scale,
            height: h * scale,
            child: child,
          );
      return Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          at(
            285,
            150,
            145,
            68,
            Semantics(
              label: 'Barra de curación',
              child: Center(
                child: LinearProgressIndicator(
                  key: const Key('healing-progress-bar'),
                  value: _progress / 100,
                  minHeight: 42 * scale,
                  backgroundColor: const Color(0xFF353653),
                  color: const Color(0xFF00C900),
                ),
              ),
            ),
          ),
          at(
            475,
            150,
            138,
            68,
            Semantics(
              liveRegion: true,
              child: FittedBox(
                child: Text(
                  '$_progress%',
                  key: const Key('healing-progress-text'),
                  style: const TextStyle(
                    color: Color(0xFF00C900),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          for (var slot = 0; slot < 6; slot++)
            at(
              260 + (slot % 3) * 133,
              299 + (slot ~/ 3) * 125,
              112,
              112,
              DragTarget<int>(
                key: ValueKey('healing-slot-$slot'),
                onWillAcceptWithDetails: (details) =>
                    !_healing &&
                    _slots[slot] == null &&
                    !_slots.contains(details.data) &&
                    !_healed.contains(details.data),
                onAcceptWithDetails: (details) => _place(slot, details.data),
                builder: (context, candidates, rejected) => Semantics(
                  label:
                      'Espacio ${slot + 1}${_slots[slot] == null ? ', vacío' : ', Pokémon ${_slots[slot]}'}',
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: candidates.isNotEmpty
                          ? Colors.green.withValues(alpha: 0.4)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: candidates.isNotEmpty
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: _slots[slot] == null
                        ? null
                        : Tooltip(
                            message: 'Toca para devolver al panel',
                            child: InkWell(
                              onTap: _healing
                                  ? null
                                  : () => setState(() {
                                      _slots[slot] = null;
                                      _progress = 0;
                                    }),
                              child: _ball(_slots[slot]!),
                            ),
                          ),
                  ),
                ),
              ),
            ),
        ],
      );
    },
  );

  @override
 Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/poke_center/centerF2.jpeg',
            fit: BoxFit.cover,
          ),
          _machine(),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: const MenuButton(),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: screenHeight * 0.04,
            child: ResponsivePanel(
              widthFactor: 1,
              height: screenHeight * 0.38,
              padding: const EdgeInsets.all(16),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 10,
                radius: const Radius.circular(12),
                child: GridView.builder(
                  key: const Key('healing-pokemon-grid'),
                  controller: _scrollController,
                  padding: const EdgeInsets.only(right: 24),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth < 360 ? 3 : 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: available
                      .where((id) => !_slots.contains(id) && !_healed.contains(id))
                      .length,
                  itemBuilder: (context, index) {
                    final id = available
                        .where((item) => !_slots.contains(item) && !_healed.contains(item))
                        .skip(index)
                        .first;
                    final tile = Column(
                      children: [
                        Expanded(
                          child: AspectRatio(aspectRatio: 1, child: _ball(id)),
                        ),
                        Text(
                          '#$id',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                    return LongPressDraggable<int>(
                      key: ValueKey('healing-pokemon-$id'),
                      data: id,
                      maxSimultaneousDrags: _healing ? 0 : 1,
                      feedback: SizedBox(
                        width: 64,
                        height: 64,
                        child: _ball(id),
                      ),
                      childWhenDragging: Opacity(opacity: 0.25, child: tile),
                      child: tile,
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.4,
            top: screenHeight * 0.10,
            width: screenWidth * 0.20,
            height: screenHeight * 0.60,
            child: Center(
              child: IconButton(
                key: const Key('healing-machine-button'),
                tooltip: _healing ? 'Curando…' : 'Curar Pokémon',
                padding: EdgeInsets.zero,
                onPressed: !_healing && _slots.any((id) => id != null)
                    ? _heal
                    : null,
                icon: Image.asset(
                  'assets/images/poke_center/x.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
