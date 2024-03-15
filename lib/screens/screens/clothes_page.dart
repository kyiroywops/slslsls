import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClothesScreen extends StatefulWidget {
  const ClothesScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ClothesScreen> {
  bool isChecked = false; // Añadido para manejar el estado del check

  final int _clothesLimit = 20;
  final ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> _clothes = [];
  bool _hasMoreClothes = true;
  bool _isLoading = false;
  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchClothes();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !_isLoading) {
      _fetchClothes();
    }
  }

  Future<void> _fetchClothes() async {
    if (!_hasMoreClothes) return;

    setState(() {
      _isLoading = true;
    });

    QuerySnapshot querySnapshot;
    Query query = FirebaseFirestore.instance.collection('ropas').orderBy('nombre').limit(_clothesLimit);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    querySnapshot = await query.get();
    if (querySnapshot.docs.length < _clothesLimit) {
      _hasMoreClothes = false;
    }

    if (querySnapshot.docs.isNotEmpty) {
      _lastDocument = querySnapshot.docs.last;
    }

    setState(() {
      _clothes.addAll(querySnapshot.docs);
      _isLoading = false;
    });
  }

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
          
         Expanded(
          child: ListView.builder(
            itemCount: _clothes.length + (_hasMoreClothes ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _clothes.length) {
                return _hasMoreClothes ? Center(child: CircularProgressIndicator()) : Container();
              }
              DocumentSnapshot doc = _clothes[index];
              return ListTile(
                title: Text(doc['nombre']),
                // Aquí puedes agregar más propiedades como subtitulo, leading, etc.
              );
            },
            controller: _scrollController,
          ),
        ),



        ],
      
            // Continúa añadiendo más widgets aquí según sea necesario
          
        ),
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  final TextEditingController bagNameController =
      TextEditingController(); // Controlador para el nombre de la maleta
  final TextEditingController clothesCategoryController =
      TextEditingController(); // Controlador para la categoría de la ropa
  final TextEditingController brandController =
      TextEditingController(); // Controlador para la marca

  void showSelectBagDialog(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      // Si no hay un usuario logueado, mostrar un mensaje o redirigir al login.
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Elige una maleta'),
          content: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('maletas')
                .where('userId', isEqualTo: currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              List<DocumentSnapshot> maletas = snapshot.data!.docs;

              return SingleChildScrollView(
                child: ListBody(
                  children: maletas.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return ListTile(
                      leading:
                          Text(data['emoji'], style: TextStyle(fontSize: 24)),
                      title: Text(data['nombre']),
                      onTap: () {
                        // Aquí puedes recuperar los datos de la maleta seleccionada.
                        var selectedBag = {
                          'id': document.id,
                          'nombre': data['nombre'],
                          'emoji': data['emoji'],
                        };
                        Navigator.of(context)
                            .pop(); // Cierra el diálogo de selección de maleta
                        showAddClothesDialog(context,
                            selectedBag); // Abre el diálogo para añadir ropa con los datos de la maleta seleccionada
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void showAddClothesDialog(
      BuildContext context, Map<String, dynamic> selectedBag) {
    final User? currentUser =
        FirebaseAuth.instance.currentUser; // Obtén el usuario actual

    // Definir los colores disponibles para seleccionar
    final List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.brown,
    ];

    // Variable para manejar el color seleccionado
    Color? selectedColor;

    int?
        selectedClothingIndex; // Agrega esta línea para rastrear el índice de la ropa seleccionada

    bool isDirty = false;
    bool isCheck = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // Esto permite actualizar el estado dentro del diálogo
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Add clothes',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          SizedBox(height: 20),
                          Text('Name of cloth',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          TextField(
                            controller: bagNameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Name of cloth',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Categoria de la ropa',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          TextField(
                            controller: clothesCategoryController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Polera, pantalón, etc.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Marca',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          TextField(
                            controller: brandController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Marca',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text('Selecciona tu color',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          // GridView para seleccionar colors
                         Container(
                          height: 60, // Altura del contenedor para los círculos
                          // Utiliza un ListView.builder en lugar de un GridView.builder
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                            itemCount: colors.length, // La cantidad de colores disponibles
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = colors[index];
                                  });
                                },
                                child: Container(
                                  width: 20, // Ancho de cada círculo
                                  margin: EdgeInsets.symmetric(horizontal: 4), // Margen horizontal entre círculos
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors[index],
                                    border: selectedColor == colors[index]
                                        ? Border.all(color: Colors.black, width: 2)
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                          ),
                        Container(
                          height: 50, // La altura del contenedor para los avatares
                          // Usa un ListView.builder en lugar de un GridView.builder
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal, // Desplazamiento horizontal
                            itemCount: 10, // El número total de avatares de ropa
                            itemBuilder: (context, index) {
                              // Genera los nombres de las imágenes basándonos en el índice
                              String imageName = 'ropa${index + 1}.png';
                              bool isSelected = selectedClothingIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedClothingIndex = index; // Actualiza el índice seleccionado
                                  });
                                },
                                child: Container(
                                  width: 50, // Ajusta el ancho del contenedor para cada avatar
                                  margin: EdgeInsets.symmetric(horizontal: 4), // Espaciado horizontal entre avatares
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: isSelected
                                        ? Border.all(color: Colors.blue, width: 3)
                                        : null, // Resalta si está seleccionado
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/iconos/ropa/$imageName'),
                                    backgroundColor: isSelected
                                        ? Colors.blue.withOpacity(0.3)
                                        : Colors.transparent, // Fondo semitransparente si está seleccionado
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              isDirty ? 'No Lavado' : 'Lavado',
                              style: TextStyle(
                                color: isDirty ? Colors.red : Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Switch(
                              value: !isDirty, // El Switch está "on" si la ropa está lavada (isDirty es false)
                              onChanged: (value) {
                                setState(() {
                                  isDirty = !value; // Actualiza el estado de isDirty basado en el Switch
                                });
                              },
                              activeColor: Colors.green, // Color cuando está "on"
                              inactiveThumbColor: Colors.red, // Color del pulgar cuando está "off"
                              inactiveTrackColor: Colors.red.withOpacity(0.5), // Color de la pista cuando está "off"
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              isCheck ? 'Check' : 'Not Check',
                              style: TextStyle(
                                color: isCheck ? Colors.green : Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Switch(
                              value: isCheck, // El Switch está "on" (true) si isCheck es true
                              onChanged: (value) {
                                setState(() {
                                  isCheck = value; // Actualiza el estado de isCheck basado en el Switch
                                });
                              },
                              activeColor: Colors.green, // Color cuando está "on"
                              inactiveThumbColor: Colors.red, // Color del pulgar cuando está "off"
                              inactiveTrackColor: Colors.red.withOpacity(0.5), // Color de la pista cuando está "off"
                            ),
                          ],
                        ),
                                                                      
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  ' ${selectedBag['emoji']}  ${selectedBag['nombre']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  // Asegúrate de que todos los campos necesarios están llenos y que `selectedColor` y `selectedClothingIndex` no son nulos.
                                  if (bagNameController.text.isNotEmpty &&
                                      clothesCategoryController.text.isNotEmpty &&
                                      brandController.text.isNotEmpty &&
                                      selectedColor != null &&
                                      selectedClothingIndex != null) {
                                    
                                    // Realiza la operación de Firestore aquí.
                                    await FirebaseFirestore.instance.collection('ropas').add({
                                      'nombre': bagNameController.text,
                                      'categoria': clothesCategoryController.text,
                                      'marca': brandController.text,
                                      'color': selectedColor.toString(),
                                      'indiceRopa': selectedClothingIndex,
                                      'limpio': !isDirty,
                                      'checkeado': isCheck,
                                      'maletaId': selectedBag['id'], // Asegúrate de asociar la ropa con la maleta correcta.
                                      // ... cualquier otro campo que necesites.
                                    });

                                    // Cierra el diálogo después de agregar la ropa
                                    Navigator.of(context).pop();

                                    // Limpia los controladores y resetea las variables de estado si es necesario
                                    bagNameController.clear();
                                    clothesCategoryController.clear();
                                    brandController.clear();
                                    // ... restablece cualquier otra variable de estado si es necesario.
                                  } else {
                                    // Muestra un mensaje de error o realiza alguna acción si la validación falla.
                                  }
                                },
                                child: Text('Agregar'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showSelectBagDialog(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "👕 +",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
