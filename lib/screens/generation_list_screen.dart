import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poke_center/models/generation_list_response.dart';
import 'package:poke_center/screens/generation_detail_screen.dart';
import 'package:poke_center/screens/pokemon_center_screen.dart';
import 'package:provider/provider.dart';
import 'package:poke_center/providers/poke_api_provider.dart';
import 'package:http/http.dart' as http;


class GenerationListScreen extends StatelessWidget {
  const GenerationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(
          child: const Text('Generaciones'),
        ) 
        
      ),
      body: FutureBuilder<http.Response>(
        future: Provider.of<PokeApiProvider>(context, listen: false).getGenerations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.statusCode != 200) {
            return const Center(child: Text('Failed to load generations'));
          } else {
           final generationListResponse = GenerationListResponse.fromJson(json.decode(snapshot.data!.body));
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: generationListResponse.results.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final generation = generationListResponse.results[index];
                return Card(
                  margin: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(generation.name),
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => GenerationDetailScreen(generationId: index+1)
                        ));
                    }
                    ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.local_hospital),
        label: const Text('Centro Pokemon'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PokemonCenterScreen(),
            ),
          );
        },
      ),
    );
  }
}