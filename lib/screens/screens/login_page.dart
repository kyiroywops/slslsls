import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Asegúrate de tener los paquetes necesarios para la autenticación de Google y Facebook.

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

   bool isEmailEntered = false;

  final TextEditingController passwordController = TextEditingController();

  

  @override
  
  Widget build(BuildContext context) {
    double frostedContainerTopPosition = MediaQuery.of(context).size.height * 0.3;
    double paddingVertical = 20; // El padding vertical de tu contenedor
    double titleTopPosition = frostedContainerTopPosition - 60; // Sube el título más arriba

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Fondo con imagen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Botón para retroceder
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        Positioned(
  top: titleTopPosition,
  left: 20,
  child: isEmailEntered
      ? Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                setState(() {
                  isEmailEntered = false; // Esto permitirá al usuario volver al estado anterior
                });
              },
            ),
            Text(
              'Log in',
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        )
      : Text('Hi!', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
),
          // Container con efecto "frosted"
          Positioned(
            top: frostedContainerTopPosition, // Posición calculada para el contenedor
            left: 20,
            right: 20, // Agrega esto para tener un margen en ambos lados
            child: ClipRRect( // Asegura que el filtro se aplique dentro de los bordes redondeados
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Ajusta los valores de sigma para aumentar o disminuir el efecto de desenfoque
                child: Container(
                  padding: EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3), // Cambia el color aquí a gris con cierta transparencia
                    borderRadius: BorderRadius.circular(25),
                  ),
              child: Column(
                children: <Widget>[
                   if (!isEmailEntered) ...[
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.green, // Color del cursor
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            hintText: 'Email',
                            // Personaliza la apariencia del borde en foco
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.green, // Borde verde cuando el TextField está en foco
                                width: 3.0, // Aumenta el grosor del borde aquí
                              ),
                            ),
                            // Personaliza la apariencia del borde cuando el TextField está sin foco
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey[200]!, // Borde gris claro en el estado normal
                                width: 1.0, // Grosor estándar del borde
                              ),
                            ),
                            // Asegúrate de eliminar la propiedad prefixIcon para no mostrar ningún icono
                          ),
),
                        SizedBox(height: 20),
                       ElevatedButton(
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontFamily: 'Cabin', fontWeight: FontWeight.w700), // Texto blanco
                        ),
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Fondo negro
                        disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12), // Color del botón cuando está deshabilitado o en press
                        minimumSize: Size(double.infinity, 60), // Ancho máximo y alto fijo
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18), // Padding vertical para que coincida con la altura del TextField
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // Mismo radio de borde que el TextField
                        ),
                      ),
                        onPressed: () {
                          setState(() {
                            isEmailEntered = true; // Actualiza el estado para mostrar el campo de contraseña
                          });
                        },
                      ),
                      
                      ] else ...[
                        TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.green, // Color del cursor
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            hintText: 'Password',
                            // Personaliza la apariencia del borde en foco
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.green, // Borde verde cuando el TextField está en foco
                                width: 3.0, // Aumenta el grosor del borde aquí
                              ),
                            ),
                            // Personaliza la apariencia del borde cuando el TextField está sin foco
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey[200]!, // Borde gris claro en el estado normal
                                width: 1.0, // Grosor estándar del borde
                              ),
                            ),
                            // Asegúrate de eliminar la propiedad prefixIcon para no mostrar ningún icono
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                         child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white), // Texto blanco
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black, // Fondo negro
                          disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12), // Color del botón cuando está deshabilitado o en press
                          minimumSize: Size(double.infinity, 60), // Ancho máximo y alto fijo
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18), // Padding vertical para que coincida con la altura del TextField
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Mismo radio de borde que el TextField
                          ),
                        ),
                          onPressed: () {
                            // Lógica para iniciar sesión con la contraseña
                          },
                        ),
                        TextButton(
                          child: Text('Forgot your password?'),
                          onPressed: () {
                            // Lógica para recuperar contraseña
                          },
                        ),
                      ],


                      if (!isEmailEntered) ...[
                       SizedBox(height: 20), // Espacio entre el botón 'Continue' y el texto 'or'
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80.0), // Ajusta este valor según tus necesidades
                        child: Center(
                          child: Text(
                            'or',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Espacio entre el texto 'or' y los botones de autenticación social
                      SizedBox(
                        width: double.infinity, // Esto hará que el botón se expanda al ancho del contenedor
                        child: TextButton.icon(
                          icon: SvgPicture.asset(
                            'assets/icons/facebook.svg', // Asegúrate de que la ruta del asset es correcta
                            width: 24.0,
                            height: 24.0,
                          ),
                          label: Text(
                            'Continue with Facebook',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blue, // El color de fondo de Facebook
                            padding: EdgeInsets.symmetric(vertical: 18.0), // Alinea el padding vertical con el botón "Continue"
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ), // El color del texto e icono cuando se presiona el botón
                          ),
                          onPressed: () {
                            // Tu lógica de autenticación con Facebook aquí
                          },
                        ),
                      ),

                  Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: SizedBox(
                          width: double.infinity, // Esto hará que el botón se expanda al ancho del contenedor
                          child: TextButton.icon(
                            icon: SvgPicture.asset(
                              'assets/icons/google.svg', // Asegúrate de que la ruta del asset es correcta
                              width: 24.0,
                              height: 24.0,
                            ),
                            label: Text(
                              'Continue with Google',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black, backgroundColor: Colors.grey[200], // El color de fondo de Facebook
                              padding: EdgeInsets.symmetric(vertical: 18.0), // Alinea el padding vertical con el botón "Continue"
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ), // El color del texto e icono cuando se presiona el botón
                            ),
                            onPressed: () {
                              // Tu lógica de autenticación con Facebook aquí
                            },
                          ),
                        ),
                  ),
 
                     Padding(
                       padding: const EdgeInsets.all(30.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start, // Alinea los widgets a la izquierda
                         children: [
                           Row(
                             children: [
                               Text(
                                 "Don't have an account? ",
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontSize: 16,
                                 ),
                               ),
                               GestureDetector(
                                 onTap: () {
                                   // Acción para navegar al registro
                                 },
                                 child: Text(
                                   "Sign up",
                                   style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ),
                             ],
                           ),
                           TextButton(
                             onPressed: () {
                               // Acción para navegar a Forgot your password
                             },
                             child: Text(
                               "Forgot your password?",
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: Colors.black,
                                 fontSize: 16,
                               ),
                             ),
                             style: TextButton.styleFrom(
                               padding: EdgeInsets.zero, // Remueve el padding para alinear el texto
                               alignment: Alignment.centerLeft, // Alinea el texto a la izquierda
                             ),
                           ),
                         ],
                       ),
                     ),


                      ]
                    
                ],
              ),
            ),
          ),
            )
          )
        ],
      
    
      ),
    );
  }
}
