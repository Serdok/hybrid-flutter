import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Ici c'est le main de l'application
void main() {
  runApp(const MyApp());
}

// Le widget principal, ici l'application est stateless (ne garde aucun etat en memoire)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Chaque widget etendu de StatelessWidget ou State<...> doit avoir cette fonction definie
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My first Flutter app', // Titre de l'application
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        // home = Route par defaut (equivalent de /)
        appBar: AppBar(
          // Barre affichee en haut de l'ecran
          title: const Text('Appbar title'),
        ),
        body: const Center(
          // Corps de l'application
          child: RandomWords(),
        ),
      ),
    );
  }
}

// Classe Stateful: elle garde en memoire la liste des mots generes
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  // Appelee a la creation de la classe
  @override
  State createState() => _RandomWordsState();
}

// Definition d'un etat
class _RandomWordsState extends State<RandomWords> {
  final randomWordPairs = <WordPair>[]; // Liste des mots generes
  final toggledWordPairs = <WordPair>{}; // Liste des mots cliques

  // Construction d'une ligne
  Widget buildRow(WordPair pair) {
    final toggled = toggledWordPairs.contains(pair);

    return ListTile(
      // ListTile = 1 element de liste
      title: Text(pair.asLowerCase,
          style: const TextStyle(
              fontSize: 29, fontFamily: 'Roboto', color: Colors.cyan)),
      trailing: Icon(
        // Trailing = a la fin
        Icons.access_alarm,
        color: toggled ? Colors.red : null,
      ),
      onTap: () {
        // onTap = callback appele des qu'on tape sur un element de liste
        setState(() {
          // Mise a jour de l'etat
          toggled ? toggledWordPairs.remove(pair) : toggledWordPairs.add(pair);
        });
      },
    );
  }

  // Construction de la liste
  Widget buildList() {
    return ListView.builder(
      // builder nous permet de creer une liste a la demande
      itemBuilder: (context, item) {
        // callback qui ajoute les elements a notre liste
        randomWordPairs.add(generateWordPairs().first);
        return buildRow(randomWordPairs[item]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildList(),
    );
  }
}
