import 'package:flutter/material.dart';

class TradeTrainer {
  final int id;
  final String name;

  const TradeTrainer({required this.id, required this.name});
}

// Datos locales hasta conectar el buscador con el backend.
const _demoTrainers = [
  TradeTrainer(id: 101, name: 'Ash Ketchum'),
  TradeTrainer(id: 102, name: 'Misty'),
  TradeTrainer(id: 103, name: 'Brock'),
  TradeTrainer(id: 104, name: 'Serena'),
  TradeTrainer(id: 105, name: 'Dawn'),
  TradeTrainer(id: 106, name: 'May'),
  TradeTrainer(id: 107, name: 'Andrés'),
  TradeTrainer(id: 108, name: 'Sofía'),
];

class TrainerSearchDialog extends StatefulWidget {
  final int? selectedTrainerId;

  const TrainerSearchDialog({super.key, this.selectedTrainerId});

  @override
  State<TrainerSearchDialog> createState() => _TrainerSearchDialogState();
}

class _TrainerSearchDialogState extends State<TrainerSearchDialog> {
  final _searchController = TextEditingController();
  String _query = '';

  String _normalize(String value) {
    var result = value.trim().toLowerCase();
    const accents = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'ü': 'u',
    };
    for (final entry in accents.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trainers = _demoTrainers
        .where(
          (trainer) => _normalize(trainer.name).contains(_normalize(_query)),
        )
        .toList();

    return Dialog(
      key: const Key('trainer-search-dialog'),
      backgroundColor: const Color(0xFF5345AB),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFE5D36D), width: 3),
      ),
      child: SizedBox(
        width: 440,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Buscar entrenador',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Cerrar buscador',
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Text(
                'Elige con quién intercambiar.',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              TextField(
                key: const Key('trainer-search-field'),
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                style: const TextStyle(color: Color(0xFF30275C)),
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre',
                  filled: true,
                  fillColor: const Color(0xFFF4F1E9),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Limpiar búsqueda',
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: trainers.isEmpty
                    ? const Center(
                        child: Text(
                          'No se encontraron entrenadores.\nPrueba con otro nombre.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.separated(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: trainers.length,
                        separatorBuilder: (_, index) =>
                            const Divider(height: 1, color: Colors.white24),
                        itemBuilder: (context, index) {
                          final trainer = trainers[index];
                          final selected =
                              trainer.id == widget.selectedTrainerId;
                          return ListTile(
                            key: ValueKey('trainer-${trainer.id}'),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFFE5D36D),
                              foregroundColor: const Color(0xFF30275C),
                              child: Text(trainer.name[0]),
                            ),
                            title: Text(
                              trainer.name,
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: selected
                                ? const Text(
                                    'Seleccionado',
                                    style: TextStyle(color: Color(0xFFE5D36D)),
                                  )
                                : null,
                            trailing: Icon(
                              selected
                                  ? Icons.check_circle
                                  : Icons.chevron_right,
                              color: const Color(0xFFE5D36D),
                            ),
                            onTap: () => Navigator.pop(context, trainer),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
