import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MaterialApp(title: "Stateful widget", home: RandomWord()));
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //final wordPair = WordPair.random();
//   }
// }

class RandomWord extends StatefulWidget {
  @override
  RandomWordState createState() => new RandomWordState();
}

class RandomWordState extends State<RandomWord> {
  final List<WordPair> _words = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    //return Text(wordPair.asUpperCase);
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful widget"),
        actions: [new IconButton(icon: Icon(Icons.add), onPressed: _addSaved)],
      ),
      body: Center(child: ListView.builder(itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        }
        if (index >= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_words[index]);
      })),
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final bool alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(wordPair.asUpperCase, style: _biggerFont),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  void _addSaved() {
    Navigator.of(context).push(
      // ignore: missing_return
        new MaterialPageRoute(builder: (BuildContext buildContext) {
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asUpperCase,
                style: _biggerFont,
              ),
            );
          });

          final List<Widget> divided = ListTile.divideTiles(tiles: tiles, context: context).toList();

          return new Scaffold(
            appBar: AppBar(
              title: Text("Saved"),
            ),
            body: ListView(children: divided),
          );
        }));
  }
}
