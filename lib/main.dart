import 'package:flutter/material.dart';
import 'package:emojis/emojis.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de divisas',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Conversor de divisas'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class calculadora {
  final titulo;
  final icono;
  final color;

  calculadora(this.titulo, this.icono, this.color);
}

//Declaración variales input KeyPad
final textOrigen = TextEditingController();
final textDestino = TextEditingController();

var parser = EmojiParser();

String op1 = "USD";
String op2 = "COP";

List<DropdownMenuItem<String>> moneda = <DropdownMenuItem<String>>[
  DropdownMenuItem(
    value: "USD",
    child: Text(
      "${Emojis.flagUnitedStates} USD",
    ),
  ),
  DropdownMenuItem(
    value: "EUR",
    child: Text(
      "${Emojis.flagEuropeanUnion} EUR",
    ),
  ),
  DropdownMenuItem(
    value: "COP",
    child: Text(
      " ${Emojis.flagColombia} COP",
    ),
  ),
];

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<calculadora> lc = <calculadora>[
    calculadora("9", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("8", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("7", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("6", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("5", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("4", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("3", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("2", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("1", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora("0", Icon(Icons.person), Color.fromARGB(255, 130, 213, 252)),
    calculadora(
        "Limpiar",
        Icon(Icons.cleaning_services_rounded,
            color: Color.fromARGB(255, 85, 3, 3)),
        Color.fromARGB(255, 250, 74, 74)),
    calculadora(
        "Calcular",
        Icon(Icons.calculate_rounded, color: Color.fromARGB(255, 6, 92, 25)),
        Color.fromARGB(255, 67, 218, 62)),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      "Origen : "),
                  DropdownButton(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(15),
                      value: op1,
                      items: moneda,
                      onChanged: (String? X) {
                        setState(() {
                          op1 = X.toString();
                        });
                      }),
                  Text(
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      "Destino : "),
                  DropdownButton(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      borderRadius: BorderRadius.circular(15),
                      value: op2,
                      items: moneda,
                      onChanged: (String? X) {
                        setState(() {
                          op2 = X.toString();
                        });
                      }),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Moneda Origen",
                    hintText: '0',
                    icon: Icon(Icons.monetization_on_outlined)),
                controller: textOrigen,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Moneda Destino",
                    hintText: '0',
                    icon: Icon(Icons.monetization_on_outlined)),
                controller: textDestino,
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: (2 / 1),
                    ),
                    itemCount: lc.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                        elevation: 5,
                        color: lc[index].color,
                        child: ListTile(
                          title: Center(
                            child: index > 9
                                ? lc[index].icono
                                : Text(lc[index].titulo,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                          ),
                          onTap: () {
                            if (index == 10) {
                              textOrigen.text = "";
                              textDestino.text = "";
                            } else if (index < 10) {
                              textOrigen.text =
                                  textOrigen.text + lc[index].titulo;
                            } else {
                              if (op1 == "USD" && op2 == "COP") {
                                textDestino.text =
                                    (double.parse(textOrigen.text) * 5090)
                                        .toString();
                              } else if (op1 == "COP" && op2 == "USD") {
                                textDestino.text =
                                    (double.parse(textOrigen.text) / 5090)
                                        .toString();
                              } else if (op1 == "EUR" && op2 == "COP") {
                                textDestino.text =
                                    (double.parse(textOrigen.text) * 5044)
                                        .toString();
                              } else if (op1 == "COP" && op2 == "EUR") {
                                textDestino.text =
                                    (double.parse(textOrigen.text) / 5044)
                                        .toString();
                              } else if (op1 == "USD" && op2 == "EUR") {
                                textDestino.text =
                                    (double.parse(textOrigen.text) * 0.99)
                                        .toString();
                              } else if (op1 == "EUR" && op2 == "USD") {
                                textDestino.text =
                                    (double.parse(textOrigen.text) / 0.99)
                                        .toString();
                              } else {
                                textDestino.text = textOrigen.text;
                              }
                            }
                            print(
                                lc[index].titulo); //probar el onTap en consola
                          },
                        ),
                      );
                    }),
              ),
              Text(
                'EQUIPO 3\nYuly Andrea Castro Torres\nAlexander Anillo Trocha\nDaniel Esteban Agudelo Duque\nHeyder Barbosa Oreego\nLina Rocio Cardenas Fernandez',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
