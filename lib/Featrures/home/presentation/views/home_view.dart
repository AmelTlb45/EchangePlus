import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:echange_plus/utils/app_strings.dart';
import 'package:go_router/go_router.dart';  // Assuming the file containing your AppStrings

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Simulating a list of services
  final List<String> services = [
    'Plomberie',
    'Cours de langues',
    'Développement de sites web',
    'Aide à domicile',
    'Design graphique'
  ];

  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter services based on the search query
  List<String> get filteredServices {
    return services
        .where((service) => service.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.homeTitle), // "Page d'accueil"
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app), // Log out icon
            onPressed: () {
              _showSignOutDialog();
              
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 110, 110),
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text(AppStrings.profileTitle),  // "Profil"
              onTap: () {
                // Action to navigate to profile page
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(AppStrings.settingsTitle),  // "Paramètres"
              onTap: () {
                // Action to navigate to settings
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(AppStrings.helpTitle),  // "Aide"
              onTap: () {
                // Action to navigate to help page
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(AppStrings.termsAndConditions),  // "Conditions d'utilisation"
              onTap: () {
                // Action to navigate to terms & conditions
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(AppStrings.privacyPolicy),  // "Politique de confidentialité"
              onTap: () {
                // Action to navigate to privacy policy
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.b,  // "Bienvenue!"
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              AppStrings.splashSubtitle,  // "L'application d'échange de services"
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // Search bar for filtering services
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher un service...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 1),
                ),
              ),
              onChanged: (query) {
                setState(() {}); // Refresh the UI when search query changes
              },
            ),
            const SizedBox(height: 20),

            // List of services (journal)
            Expanded(
              child: ListView.builder(
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.work_outline, color: Colors.blue),
                      title: Text(filteredServices[index]),
                      subtitle: const Text('Cliquez pour voir plus de détails'),
                      onTap: () {
                        // Action to show service details
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action to navigate to add service page
              },
              child: const Text(AppStrings.addServiceButton),  // "Ajouter un service"
            ),
          ],
        ),
      ),
    );
  }

  // Method to show a dialog for confirming sign out
  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.confirmSignOutMessage),  // "Voulez-vous vraiment vous déconnecter ?"
          actions: <Widget>[
            TextButton(
              child: const Text(AppStrings.confirmSignOutNo),  // "Non, rester connecté"
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text(AppStrings.confirmSignOutYes),  // "Oui, déconnecter"
              onPressed: () {
                // Handle sign out logic
                Navigator.of(context).pop(); // Close the dialog
                _signOut();
              },
            ),
          ],
        );
      },
    );
  }

  // Simulate sign out functionality
  void _signOut() {
    // Call your sign out method (e.g., FirebaseAuth.instance.signOut())
    FirebaseAuth.instance.signOut();
    print('User signed out');
    context.go("/signIn");
    // Navigate to sign in page or show a message
  }
}
