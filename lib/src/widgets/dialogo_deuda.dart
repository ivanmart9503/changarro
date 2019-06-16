import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class DialogoDeuda {
  String _persona;
  String _deuda;
  final Function _writeToFile;

  DialogoDeuda(this._persona, this._deuda, this._writeToFile);

  void mostrarDialogo(BuildContext context) {
    showDialog(
      context: context,
      builder: _buildDialogo,
    );
  }

  Widget _buildTitulo(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Agregar a la lista negra',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  List<Widget> _buildContenido(BuildContext context) {
    return [
      Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Nombre'),
            onChanged: (value) => _persona = value,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Deuda',
              prefixText: '\$',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => _deuda = value,
          ),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            child: Text('Agregar'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              _writeToFile(_persona, _deuda);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ];
  }

  SimpleDialog _buildDialogo(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      titlePadding:
          EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0, bottom: 5.0),
      contentPadding:
          EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0, bottom: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: _buildTitulo(context),
      children: _buildContenido(context),
    );
  }
}
