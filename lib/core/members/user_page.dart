import 'package:echange_plus/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // Liste simulée des services
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

  // Filtrer les services en fonction de la requête de recherche
  List<String> get filteredServices {
    return services
        .where((service) => service.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 244, 67),
        title: const Text(AppStrings.homeTitle), // "Page d'accueil"
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app), // Icône de déconnexion
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(AppStrings.settingsTitle),  // "Paramètres"
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(AppStrings.helpTitle),  // "Aide"
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(AppStrings.termsAndConditions),  // "Conditions d'utilisation"
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(AppStrings.privacyPolicy),  // "Politique de confidentialité"
              onTap: () {
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

            // Barre de recherche pour filtrer les services
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
                setState(() {}); // Rafraîchir l'UI lorsque la recherche change
              },
            ),
            const SizedBox(height: 20),

            // Liste des services filtrée
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
                        // Action pour afficher les détails du service
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action pour naviguer vers la page d'ajout de service
              },
              child: const Text(AppStrings.addServiceButton),  // "Ajouter un service"
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour afficher un dialogue de confirmation de déconnexion
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
                Navigator.of(context).pop(); // Fermer le dialogue
              },
            ),
            TextButton(
              child: const Text(AppStrings.confirmSignOutYes),  // "Oui, déconnecter"
              onPressed: () {
                // Appeler la méthode de déconnexion
                Navigator.of(context).pop(); // Fermer le dialogue
                _signOut();
              },
            ),
          ],
        );
      },
    );
  }

  // Fonction pour déconnecter l'utilisateur
  void _signOut() {
    FirebaseAuth.instance.signOut();
    print('User signed out');
    context.go("/signIn");  // Rediriger vers la page de connexion
  }
}
