import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:poke_center/models/pokemon_detail_response.dart';
import 'package:poke_center/providers/poke_api_provider.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int pokemonId;
  final String pokemonName;

  const PokemonDetailScreen({
    super.key,
    required this.pokemonId,
    required this.pokemonName,
  });

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late Future<PokemonDetailResponse> _pokemon;

  @override
  void initState() {
    super.initState();
    _pokemon = _loadPokemon();
  }

  @override
  void didUpdateWidget(covariant PokemonDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pokemonId != widget.pokemonId) {
      _pokemon = _loadPokemon();
    }
  }

  Future<PokemonDetailResponse> _loadPokemon() async {
    final response = await context.read<PokeApiProvider>().getPokemonDetail(
      widget.pokemonId,
    );
    return PokemonDetailResponse.fromRawJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_displayName(widget.pokemonName))),
      body: SafeArea(
        child: FutureBuilder<PokemonDetailResponse>(
          future: _pokemon,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Cargando Pokémon',
                ),
              );
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off_rounded, size: 48),
                      const SizedBox(height: 16),
                      const Text(
                        'No pudimos cargar este Pokémon.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Revisa tu conexión e inténtalo de nuevo.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      FilledButton.icon(
                        onPressed: () => setState(() {
                          _pokemon = _loadPokemon();
                        }),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return _PokemonDetails(pokemon: snapshot.data!);
          },
        ),
      ),
    );
  }
}

String _displayName(String name) => name
    .split('-')
    .where((word) => word.isNotEmpty)
    .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
    .join(' ');

const _typeNames = {
  'normal': 'Normal',
  'fire': 'Fuego',
  'water': 'Agua',
  'electric': 'Eléctrico',
  'grass': 'Planta',
  'ice': 'Hielo',
  'fighting': 'Lucha',
  'poison': 'Veneno',
  'ground': 'Tierra',
  'flying': 'Volador',
  'psychic': 'Psíquico',
  'bug': 'Bicho',
  'rock': 'Roca',
  'ghost': 'Fantasma',
  'dragon': 'Dragón',
  'dark': 'Siniestro',
  'steel': 'Acero',
  'fairy': 'Hada',
};
const _statNames = {
  'hp': 'PS',
  'attack': 'Ataque',
  'defense': 'Defensa',
  'special-attack': 'Ataque especial',
  'special-defense': 'Defensa especial',
  'speed': 'Velocidad',
};

class _PokemonDetails extends StatelessWidget {
  final PokemonDetailResponse pokemon;
  const _PokemonDetails({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 450);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: duration,
            builder: (context, value, child) =>
                Opacity(opacity: value, child: child),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'POKÉDEX  /  #${pokemon.id.toString().padLeft(3, '0')}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _displayName(pokemon.name),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 240,
                  child: pokemon.sprites.imageUrl == null
                      ? const Icon(Icons.catching_pokemon, size: 100)
                      : Image.network(
                          pokemon.sprites.imageUrl!,
                          fit: BoxFit.contain,
                          semanticLabel: _displayName(pokemon.name),
                          loadingBuilder: (context, child, progress) =>
                              progress == null
                              ? child
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                          errorBuilder: (context, error, stack) => const Center(
                            child: Icon(Icons.catching_pokemon, size: 100),
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: pokemon.types
                      .map(
                        (type) => Chip(
                          backgroundColor: colors.primary,
                          side: BorderSide.none,
                          label: Text(
                            _typeNames[type.name] ?? _displayName(type.name),
                            style: TextStyle(color: colors.onPrimary),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 28),
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: 24,
                  runSpacing: 20,
                  children: [
                    _Measurement(
                      label: 'Altura',
                      value: '${(pokemon.height / 10).toStringAsFixed(1)} m',
                    ),
                    _Measurement(
                      label: 'Peso',
                      value: '${(pokemon.weight / 10).toStringAsFixed(1)} kg',
                    ),
                    _Measurement(
                      label: 'Experiencia base',
                      value: pokemon.baseExperience?.toString() ?? '—',
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Divider(),
                const SizedBox(height: 20),
                const Text(
                  'Habilidades',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                if (pokemon.abilities.isEmpty)
                  const Text('Sin habilidades disponibles.'),
                ...pokemon.abilities.map(
                  (ability) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          _displayName(ability.name),
                          style: const TextStyle(fontSize: 16),
                        ),
                        if (ability.isHidden)
                          Text(
                            'Oculta',
                            style: TextStyle(
                              color: colors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Estadísticas base',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (pokemon.stats.isEmpty)
                  const Text('Sin estadísticas disponibles.'),
                ...pokemon.stats.map(
                  (stat) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                _statNames[stat.name] ??
                                    _displayName(stat.name),
                              ),
                            ),
                            Text(
                              '${stat.baseStat}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TweenAnimationBuilder<double>(
                          tween: Tween(
                            begin: 0,
                            end: (stat.baseStat / 255).clamp(0.0, 1.0),
                          ),
                          duration: duration,
                          builder: (context, value, child) =>
                              LinearProgressIndicator(
                                value: value,
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(8),
                                color: colors.primary,
                                backgroundColor: colors.onPrimary,
                                semanticsLabel:
                                    _statNames[stat.name] ?? stat.name,
                                semanticsValue: '${stat.baseStat}',
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: ${pokemon.stats.fold<int>(0, (total, stat) => total + stat.baseStat)}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Measurement extends StatelessWidget {
  final String label;
  final String value;
  const _Measurement({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Text(label),
    ],
  );
}
