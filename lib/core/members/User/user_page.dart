import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final List<Map<String, String>> services = [];
  TextEditingController _searchController = TextEditingController();

  Position? _currentPosition; // Pour stocker la position de l'utilisateur

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchServices();
    _getUserLocation(); // Appeler la fonction pour récupérer la localisation
  }

  // Fonction pour récupérer la localisation de l'utilisateur
  Future<void> _getUserLocation() async {
    // Vérifiez si les services de localisation sont activés
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Les services de localisation sont désactivés");
      return;
    }

    // Vérifiez les autorisations
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permission refusée");
        return;
      }
    }

    // Si tout est ok, obtenez la position de l'utilisateur
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position; // Mettez à jour la position de l'utilisateur
    });
    print(
        'Position de l\'utilisateur: ${position.latitude}, ${position.longitude}');
  }

  // Fonction pour récupérer les services depuis Firestore
  Future<void> _fetchServices() async {
    final serviceSnapshot =
        await FirebaseFirestore.instance.collection('services').get();
    setState(() {
      services.clear();
      serviceSnapshot.docs.forEach((doc) {
        services.add({
          'name': doc['name'],
          'category': doc['category'],
          'location': doc['location'],
          'image': doc['image'],
          'paymentMode': doc['paymentMode'],
        });
      });
    });
  }

  List<Map<String, String>> get filteredServices {
    return services
        .where((service) =>
            service['name']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            service['category']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
        .toList();
  }

  void _navigateToProfile() {
    if (_currentPosition != null) {
      // Passer la position à la page de profil via le contexte
      context.go("/profile", extra: _currentPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Journal des Services",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () => _showSignOutDialog(),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: Icon(Icons.search, color: Colors.black54),
                hintText: 'Rechercher un service...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                return _buildServiceCard(filteredServices[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddService,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            accountName: Text("Utilisateur"),
            accountEmail: Text("email@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blueAccent, size: 40),
            ),
          ),
          _buildDrawerItem(
              Icons.person, AppStrings.profileTitle, _navigateToProfile),
          _buildDrawerItem(
              Icons.settings, AppStrings.settingsTitle, _navigateToSettings),
          _buildDrawerItem(Icons.help, AppStrings.helpTitle, _navigateToHelp),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, Function() onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  Widget _buildServiceCard(Map<String, String> service) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: service['image'] != null
            ? Image.asset(service['image']!,
                width: 60, height: 60, fit: BoxFit.cover)
            : Icon(Icons.work_outline, color: Colors.blueAccent, size: 30),
        title: Text(service['name']!,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(
            'Catégorie: ${service['category']} - Localisation: ${service['location']}'),
        onTap: () => _navigateToServiceDetails(service['name']!),
      ),
    );
  }

 

  //void _navigateToProfile() => context.go("/profile");
  void _navigateToSettings() => context.go("/settings");
  void _navigateToHelp() => context.go("/help");
  void _navigateToServiceDetails(String service) =>
      context.go("/serviceDetails", extra: service);
  void _navigateToAddService() => context.go("/addService");

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings.confirmSignOutMessage),
          actions: <Widget>[
            TextButton(
                child: Text(AppStrings.confirmSignOutNo),
                onPressed: () => Navigator.of(context).pop()),
            TextButton(
                child: Text(AppStrings.confirmSignOutYes), onPressed: _signOut),
          ],
        );
      },
    );
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    context.go("/signIn");
  }
}
