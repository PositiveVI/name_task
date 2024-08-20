import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UsernameScreen(),
    );
  }
}

//klasse und state
class UsernameScreen extends StatefulWidget {
  @override
  _UsernameScreenState createState() => _UsernameScreenState();
}

//state
class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _controller = TextEditingController();
  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

//laden
  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username") ?? '';
    });
  }

//speichern
  _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _controller.text);
    setState(() {
      _username = _controller.text;
    });
  }

//widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Username"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Input Username"),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveUsername,
              child: Text("SAVE", style: TextStyle(color: Colors.amber)),
            ),
            SizedBox(height: 40),
            Text(
              _username.isNotEmpty
                  ? "Saved Username: $_username"
                  : "Not Username has been Saved",
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 207, 207, 207),
    );
  }
}
