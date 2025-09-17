import 'package:flutter/material.dart';

// Import role-specific home pages
import 'buyer_home.dart';
import 'policymaker_home.dart';
// later: import 'screens/farmer/farmer_home.dart';
// later: import 'screens/vet/vet_home.dart';

void main() {
  runApp(MyFarmApp());
}

class MyFarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Digital Farm Management",
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedRole = "buyer"; // default role for demo

  void _login() {
    if (_selectedRole == "buyer") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BuyerHomePage()),
      );
    } else if (_selectedRole == "farmer") {
      // Placeholder until FarmerHomePage is ready
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text("Farmer Home (Placeholder)")),
            body: Center(child: Text("👩‍🌾 Farmer Home Page")),
          ),
        ),
      );
    } else if (_selectedRole == "vet") {
      // Placeholder until VetHomePage is ready
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text("Veterinarian Home (Placeholder)")),
            body: Center(child: Text("🐾 Vet Home Page")),
          ),
        ),
      );
    } else if (_selectedRole == "policymaker") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PolicymakerHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Farm Management Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.agriculture, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Welcome to Digital Farm",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // Dropdown for role selection
            DropdownButtonFormField<String>(
              value: _selectedRole,
              items: [
                DropdownMenuItem(value: "buyer", child: Text("Buyer")),
                DropdownMenuItem(value: "farmer", child: Text("Farmer")),
                DropdownMenuItem(value: "vet", child: Text("Veterinarian")),
                DropdownMenuItem(
                    value: "policymaker", child: Text("Policymaker")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
              decoration: InputDecoration(
                labelText: "Select Role",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _login,
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
