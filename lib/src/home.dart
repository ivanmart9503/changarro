import 'dart:io';
import 'dart:convert';
import 'package:changarro/src/widgets/dialogo_deuda.dart';
import 'package:changarro/src/widgets/lista_personas.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _jsonFile;
  Directory _dir;
  String _fileName = 'adeudos.json';
  bool _fileExists = false;
  Map<String, dynamic> _fileContent = {};
  String _persona;
  dynamic _deuda;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      _dir = directory;
      _jsonFile = new File(_dir.path + "/" + _fileName);
      _fileExists = _jsonFile.existsSync();
      if (_fileExists)
        this.setState(
            () => _fileContent = json.decode(_jsonFile.readAsStringSync()));
    });
  }

  void _createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print('Creating file');
    File file = File('${dir.path}/$fileName');
    file.createSync();
    _fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void _writeToFile(String key, dynamic value) {
    if (key.isNotEmpty || value.toString().isNotEmpty) {
      Map<String, dynamic> content = {key: value};
      if (_fileExists) {
        Map<String, dynamic> jsonFileContent =
            json.decode(_jsonFile.readAsStringSync());
        jsonFileContent.addAll(content);
        _jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      } else {
        _createFile(content, _dir, _fileName);
      }

      setState(() {
        _fileContent = json.decode(_jsonFile.readAsStringSync());
      });
    }
  }

  void _writeFile(Map<String, dynamic> modifiedFile) {
    _jsonFile.writeAsStringSync(json.encode(modifiedFile));
    setState(() {
      _fileContent = json.decode(_jsonFile.readAsStringSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Abarrotes Doña Brisia',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: ListaPersonas(_fileContent, _pagado),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          EvaIcons.plus,
          size: 24.0,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).backgroundColor,
        onPressed: () => DialogoDeuda(_persona, _deuda, _writeToFile)
            .mostrarDialogo(context),
      ),
    );
  }

  void _pagado(String nombre) {
    Map<String, dynamic> modifiedFile = Map.of(_fileContent);
    modifiedFile.remove(nombre);
    _writeFile(modifiedFile);
  }
}
