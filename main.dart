import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro e Agendamento',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'DancingScript', fontSize: 18),
          bodyText2: TextStyle(fontFamily: 'DancingScript', fontSize: 16),
        ),
        fontFamily: 'DancingScript',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BoasVindasPage(),
        '/cadastro': (context) => CadastroPage(),
        '/agendamento': (context) => AgendamentoPage(),
        '/agendamentos': (context) => AgendamentosPage(),
      },
    );
  }
}

// Página de Boas-Vindas
class BoasVindasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seja Bem-vinda!'),
        backgroundColor: Colors.pink[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mais que design, Empoderamento!',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'DancingScript',
                color: Colors.pink[400],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[300],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Cadastrar-se',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'DancingScript',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Página de Cadastro
class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _cadastrar() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simula um cadastro bem-sucedido
      Navigator.pushReplacementNamed(context, '/agendamento');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Cadastre-se!',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'DancingScript',
                  color: Colors.pink[400],
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: Colors.pink[200]),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.pink[200]),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(value)) {
                    return 'Por favor, insira um e-mail válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.pink[200]),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _cadastrar,
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[300],
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'DancingScript',
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

// Página de Agendamento
class AgendamentoPage extends StatefulWidget {
  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
    ) ?? _selectedDate;

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    ) ?? _selectedTime;

    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  void _confirmarAgendamento() {
    // Simula o armazenamento do agendamento
    agendamentos.add({
      'data': _selectedDate,
      'hora': _selectedTime.format(context),
    });

    Navigator.pushReplacementNamed(context, '/agendamentos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamento'),
        backgroundColor: Colors.pink[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Data: ${_selectedDate.toLocal()}'.split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text('Hora: ${_selectedTime.format(context)}'),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmarAgendamento,
              child: Text('Confirmar Agendamento'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[300],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Lista de Agendamentos
List<Map<String, dynamic>> agendamentos = [];

// Página de Agendamentos Realizados
class AgendamentosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Agendamentos'),
        backgroundColor: Colors.pink[300],
      ),
      body: ListView.builder(
        itemCount: agendamentos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Data: ${agendamentos[index]['data']} - Hora: ${agendamentos[index]['hora']}'),
            leading: Icon(Icons.calendar_today),
            trailing: Icon(Icons.access_time),
          );
        },
      ),
    );
  }
}
