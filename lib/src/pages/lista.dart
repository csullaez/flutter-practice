import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Lista());
}

class Lista extends StatefulWidget {
  const Lista({super.key});
  @override
  State<Lista> createState() => _Lista();
}

class _Lista extends State<Lista> {
  late Future<List<Pokemon>> futurePokemon;

  @override
  void initState() {
    futurePokemon = fetchPokemon();
    super.initState();
    // super.initState();
    // futurePokemon = fetchPokemon();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Pokemones'),
        ),
        body: Center(
          child: FutureBuilder(
            future: futurePokemon,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                List<Pokemon> data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      child: Center(
                        child: ListTile(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(pokemon: data[index]),
                              ),
                            );
                          }),
                          title: Text(data[index].name),
                          subtitle: Text(data[index].url),
                          leading: CircleAvatar(
                            child: Text(
                              data[index].name.substring(0, 1).toUpperCase(),
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  }),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // Declara un campo que contenga el objeto Todo
  final Pokemon pokemon;

  // En el constructor, se requiere un objeto Todo
  DetailScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usa el objeto Todo para crear nuestra UI
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(pokemon.url),
      ),
    );
  }
}



Future<List<Pokemon>> fetchPokemon() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'));
  if (response.statusCode == 200) {
    final jsonResponse = await jsonDecode(response.body);
    final respuesta = List<Pokemon>.from(
      jsonResponse['results'].map((pokemon) => Pokemon.fromJson(pokemon)),
    );
    return respuesta;
  } else {
    throw Exception('Fallo en la peticion');
  }
}

class Pokemon {
  String name;
  String url;

  Pokemon({required this.name, required this.url});
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }
}
