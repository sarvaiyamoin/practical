import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _allSelect = false;
  final List<SelectedItems> _items = [
    SelectedItems('item 1', false),
    SelectedItems('item 2', false),
    SelectedItems('item 3', false),
    SelectedItems('item 4', false),
    SelectedItems('item 5', false),
  ];

  void numberOfItems() {
    for (var element in _items) {
      if (element.isSelected) {
        _counter++;
      }
    }
  }
  initState() {
    super.initState();
    List<String> newData = data.split('#');
    String newString = "";
    newData = List.from(newData.reversed);
    newData.forEach((element) {
      newString += element + '#';
    });
    print(newString);
  }
  String data = "android#ios#flutter#react#vue";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                    value: _counter == _items.length ? true : _allSelect,
                    onChanged: (value) {
                      setState(() {
                        _allSelect = value!;
                        for (var element in _items) {
                          element.isSelected = value;
                        }
                        value ? _counter = _items.length : _counter = 0;
                      });
                    }),
                Text(
                  _counter == _items.length
                      ? 'All item selected'
                      : _counter == 0
                          ? 'No item selected'
                          : '$_counter item selected',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      value: _items[index].isSelected,
                      onChanged: (value) {
                        setState(() {
                          _counter = 0;
                          _allSelect = false;
                          _items[index].isSelected = value!;
                        });
                        numberOfItems();
                      },
                      title: Text(_items[index].itemName),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class SelectedItems {
  String itemName;
  bool isSelected;

  SelectedItems(this.itemName, this.isSelected);
}
