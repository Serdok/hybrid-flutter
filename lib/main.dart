import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My first Flutter app',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Appbar title'),
          ),
          body: const Center(
            child: RandomWords(),
          ),
        ));
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final randomWordPairs = <WordPair>[];
  final toggledWordPairs = Set<WordPair>();


  Widget buildRow(WordPair pair) {
    final toggled = toggledWordPairs.contains(pair);

    return ListTile(
      title: Text(pair.asLowerCase, style: const TextStyle(fontSize: 29, fontFamily: 'Roboto', color: Colors.cyan)),
      trailing: Icon(Icons.access_alarm, color: toggled ? Colors.red : null,),
      onTap: () {
        setState(() {
          if (toggled) {
            toggledWordPairs.remove(pair);
          } else {
            toggledWordPairs.add(pair);
          }
        });
      },
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemBuilder: (context, item) {
        randomWordPairs.add(generateWordPairs().take(5).first);
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
