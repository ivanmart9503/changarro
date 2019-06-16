import 'package:changarro/src/providers/lista_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogoCambiarDeuda {
  String _deuda = '';
  final String _nombre;
  final String _deudaVieja;

  DialogoCambiarDeuda(this._nombre, this._deudaVieja);

  void mostrarDialogo(BuildContext context) {
    showDialog(
      context: context,
      builder: _buildDialogo,
    );
  }

  Widget _buildTitulo(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Modificar deuda de ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              _nombre,
              style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.0,
        ),
        Text(
          'Actualmente debe: \$$_deudaVieja',
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  List<Widget> _buildContenido(BuildContext context) {
    final listado = Provider.of<ListaProvider>(context);
    return [
      Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Nueva deuda',
              prefixText: '\$',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => _deuda = value,
          ),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(
            child: Text('Actualizar'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () {
              listado.modificarDeuda(_nombre, _deuda);
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
