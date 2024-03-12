import 'dart:ui';

import 'package:flutter/material.dart';
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
          // Título "Hi!"
           Positioned(
            top: titleTopPosition, // Posición calculada para el texto "Hi!"
            left: 20,
            child: Text('Hi!', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
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
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text('Continue'),
                          onPressed: () {
                            setState(() {
                              isEmailEntered = true; // Actualiza el estado para mostrar el campo de contraseña
                            });
                          },
                        ),
                      ] else ...[
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text('Log In'),
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
                        TextButton.icon(
                          icon: Icon(FontAwesomeIcons.facebookF),
                          label: Text('Continue with Facebook'),
                          onPressed: () {
                            // Lógica para inicio de sesión con Facebook
                          },
                        ),
                        TextButton.icon(
                          icon: Icon(FontAwesomeIcons.google),
                          label: Text('Continue with Google'),
                          onPressed: () {
                            // Lógica para inicio de sesión con Google
                          },
                        ),
                        TextButton(
                          child: Text('Don’t have an account? Sign up'),
                          onPressed: () {
                            // Lógica para ir a la pantalla de registro
                          },
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
