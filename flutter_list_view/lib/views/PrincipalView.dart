import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_list_view/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalView extends StatefulWidget {
  var items = List<Item>();

  PrincipalView() {
    items = [];
    // items.add(Item("BCFF11", false));
    // items.add(Item("HGCR11", true));
    // items.add(Item("RNDP11", false));
    // items.add(Item("XPTO11", false));
  }

  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  TextEditingController tarefaController = TextEditingController();

  _PrincipalViewState() {
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          keyboardType: TextInputType.text,
          controller: tarefaController,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          decoration: InputDecoration(
              labelText: "Nova Tarefa",
              labelStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];

          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                  _save();
                });
              },
            ),
            key: Key(item.title),
            background: Container(color: Colors.pink.withOpacity(0.2)),
            onDismissed: (direction) {
              print(direction);
              _remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _add(tarefaController.text);
        },
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _add(String text) {
    if (text.isEmpty) return;

    Item item = Item(text, false);
    setState(() {
      widget.items.add((item));
    });
    tarefaController.clear();
    _save();
  }

  void _remove(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
    _save();
  }

  Future _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();

      setState(() {
        widget.items = result;
      });
    }
  }

  _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }
}
