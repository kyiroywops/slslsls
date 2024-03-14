import 'dart:ui';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false; // Añadido para manejar el estado del check

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset('assets/images/logo.png', width: 50, height: 50),
                  MyElevatedButton()
                ],
              ),
            ),
            // Añade aquí el Container personalizado
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  width: MediaQuery.of(context)
                      .size
                      .width, // Ancho completo de la pantalla
                  height: MediaQuery.of(context).size.height *
                      0.1, // 10% de la altura de la pantalla
                  decoration: BoxDecoration(
                    color: Colors.grey[400], // Color de fondo grey[400]
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)), // Bordes redondeados
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Un poco de padding para el contenido interno
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/iconos/camisa.png'), // Imagen del avatar
                            radius: 30, // Tamaño del avatar
                          ),
                          SizedBox(
                              width: 10), // Espacio entre el avatar y el texto
                          Expanded(
                            // Hace que la columna ocupe el espacio disponible, permitiendo al texto ajustarse según el ancho
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Centrar verticalmente el texto
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Alinear texto a la izquierda
                              children: <Widget>[
                                Text(
                                  'Camisa', // Primer texto
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  // Este Row contiene el círculo rojo y el texto "XL"
                                  children: <Widget>[
                                    Container(
                                      width: 10, // Tamaño del círculo
                                      height: 10, // Tamaño del círculo
                                      decoration: BoxDecoration(
                                        color: Colors.red, // Color del círculo
                                        shape: BoxShape
                                            .circle, // Forma del círculo
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            10), // Espacio entre el círculo y el texto
                                    Text(
                                      'XL', // Texto "XL"
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Nike', // Marca o descripción adicional
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(), // Empuja el Checkbox hacia la derecha
                          Transform.scale(
                            scale: 1.5, // Ajusta el tamaño del Checkbox
                            child: Checkbox(
                              checkColor: Colors.white, // color del tick
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected))
                                  return Colors
                                      .green; // color cuando está marcado
                                return Colors.grey[200]!; // color por defecto
                              }),
                              value: isChecked,
                              shape:
                                  CircleBorder(), // Hace que el Checkbox sea circular
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                )),
            // Continúa añadiendo más widgets aquí según sea necesario
          ],
        ),
      ),
    );
  }
}


class MyElevatedButton extends StatelessWidget {
  void showAddItemDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Hace que el fondo del diálogo sea transparente
        child: ClipRRect( // Proporciona bordes redondeados al contenedor
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Aplica el efecto de desenfoque
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7), // Color del contenedor con transparencia
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Aquí puedes agregar los widgets que necesitas, como campos de texto para agregar artículos
                  Text('Añadir Artículo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(hintText: 'Nombre del artículo'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Acción para cuando se presiona el botón de añadir artículo
                    },
                    child: Text('Agregar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showAddItemDialog(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF6F4E37),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("🧳+"),
        ],
      ),
    );
  }
}