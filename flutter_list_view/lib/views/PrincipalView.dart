import 'package:flutter/material.dart';
import 'package:flutter_list_view/models/item.dart';

class PrincipalView extends StatefulWidget {
  var items = List<Item>();

  PrincipalView() {
    items = [];
    items.add(Item("BCFF11",false));
    items.add(Item("HGCR11",true));
    items.add(Item("RNDP11",false));
    items.add(Item("XPTO11",false));
  }

  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Listagem"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
                    
            final item = widget.items[index];
            return CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              key: Key(item.title),
              onChanged: (value){
                setState(() {
                  item.done = value;
                });
              },
            );
          },
        ),
      );
  }
}
