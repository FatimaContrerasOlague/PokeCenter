import 'package:flutter/material.dart';
import 'package:PokeCenter/widgets/pokeball_painter.dart';
import 'package:PokeCenter/screens/pokemon_trade_screen.dart';
import 'package:PokeCenter/widgets/menu_button.dart';
import 'package:PokeCenter/widgets/responsive_panel.dart';

class PokemonSelectionScreen extends StatefulWidget {
  const PokemonSelectionScreen({super.key});

  @override
  State<PokemonSelectionScreen> createState() => _PokemonSelectionScreenState();
}

class _PokemonSelectionScreenState extends State<PokemonSelectionScreen> {
  // Identificadores de prueba hasta conectar los Pokémon capturados del usuario.
  final List<int> capturedPokemon = List.generate(36, (index) => index + 1);
  final Set<int> selectedPokemon = {};
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void togglePokemon(int id) {
    setState(() {
      if (selectedPokemon.contains(id)) {
        selectedPokemon.remove(id);
      } else if (selectedPokemon.length < 6) {
        selectedPokemon.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color(0xFFB9B9D5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
          child: Column(
            children: [
              Row(
                children: [
                  const MenuButton(),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Elige 6 Pokémon',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'Poké Balls provisionales · Toca para seleccionar o quitar',
              ),
              SizedBox(height: screenHeight * 0.015),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ResponsivePanel(
                        height: double.infinity,
                        borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        padding: const EdgeInsets.fromLTRB(20, 24, 12, 16),
                        child: Scrollbar(
                          controller: scrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          thickness: 10,
                          radius: const Radius.circular(12),
                          child: GridView.builder(
                            key: const Key('captured-pokemon-grid'),
                            controller: scrollController,
                            padding: const EdgeInsets.only(left: 20, right: 24),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: screenWidth < 360 ? 3 : 4,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.85,
                                ),
                            itemCount: capturedPokemon.length,
                            itemBuilder: (context, index) {
                              final id = capturedPokemon[index];
                              final selected = selectedPokemon.contains(id);
                              final enabled =
                                  selected || selectedPokemon.length < 6;
                              return Semantics(
                                label: 'Pokémon provisional $id',
                                selected: selected,
                                child: InkWell(
                                  key: ValueKey('pokemon-$id'),
                                  onTap: enabled
                                      ? () => togglePokemon(id)
                                      : null,
                                  borderRadius: BorderRadius.circular(16),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? const Color(0xFFE5D36D)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Opacity(
                                      opacity: enabled ? 1 : 0.45,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                const AspectRatio(
                                                  aspectRatio: 1,
                                                  child: CustomPaint(
                                                    painter: PokeballPainter(),
                                                  ),
                                                ),
                                                if (selected)
                                                  const Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Icon(
                                                      Icons.check_circle,
                                                      color: Color(0xFF246634),
                                                      size: 20,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '#$id',
                                            style: TextStyle(
                                              color: selected
                                                  ? const Color(0xFF30275C)
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${selectedPokemon.length} / 6 seleccionados',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const Key('continue-to-trade'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5345AB),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 48),
                  ),
                  onPressed: selectedPokemon.isNotEmpty
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PokemonTradeScreen(
                                selectedPokemonIds: List.unmodifiable(
                                  selectedPokemon,
                                ),
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Llevar a la máquina de intercambio'),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
