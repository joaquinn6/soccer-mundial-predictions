import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Información de la aplicación',
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Acerca de nosotros'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '''
    ¡Hola Mundo!, ¿Cómo están? espero que bien, les venimos a presentar nuestra nueva aplicación de predicciones para que puedan competir con sus amigos, demostrando quién sabe más de fútbol.
    
    Pondrán sus predicciones en cada partido (antes de iniciar) disputado en el mundial. Si logras acertar el resultado ganarás un punto y si además aciertas el marcador ganarás otro punto.
    
    Si llegaste hasta aquí es porque ya te has registrado, podrás ver tus puntos acumulados en la tabla de posiciones, donde también podrás agregar a tus amigos por su nombre de usuario y ver quién conoce mejor a las selecciones que están disputando Qatar 2022.
                    ''',
                textAlign: TextAlign.justify,
              ),
              Semantics(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      _launchUrl('https://www.linkedin.com/in/joaquin-n6');
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    label: Text(
                      'Joaquín Núñez Vega',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    _launchUrl('https://www.linkedin.com/in/marlon-jdu');
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.linkedin,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  label: Text(
                    'Marlon José Dávila Urroz',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    _launchUrl('https://www.linkedin.com/in/jonathan-ney21');
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.linkedin,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  label: Text(
                    'Jonathan Tomás Ney Mayorga',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  Uri urlF = Uri.parse(url);
  if (!await launchUrl(
    urlF,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $urlF';
  }
}
