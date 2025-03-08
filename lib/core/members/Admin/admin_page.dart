import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart'; // For animations

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<Map<String, dynamic>> featuredServices = [
    {
      'title': 'Gestion des utilisateurs',
      'description': 'Gérez les comptes et les permissions des utilisateurs.',
      'icon': Icons.people,
      'color': Colors.deepPurple,
      'gradient': [Colors.purple, Colors.deepPurple],
    },
    {
      'title': 'Statistiques',
      'description': 'Consultez les données et les performances du système.',
      'icon': Icons.bar_chart,
      'color': Colors.blueAccent,
      'gradient': [Colors.blue, Colors.lightBlue],
    },
    {
      'title': 'Surveillance des demandes',
      'description': 'Suivez et gérez les demandes des utilisateurs.',
      'icon': Icons.monitor_heart,
      'color': Colors.green,
      'gradient': [Colors.teal, Colors.green],
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      'title': 'Ajouter un service',
      'icon': Icons.add,
      'color': Colors.orange,
      'gradient': [Colors.orange, Colors.deepOrange],
    },
    {
      'title': 'Vérifier les alertes',
      'icon': Icons.notifications,
      'color': Colors.red,
      'gradient': [Colors.red, Colors.pink],
    },
    {
      'title': 'Ajuster les points',
      'icon': Icons.trending_up,
      'color': Colors.teal,
      'gradient': [Colors.teal, Colors.cyan],
    },
  ];

  final List<Map<String, dynamic>> recentStats = [
    {'label': 'Utilisateurs actifs', 'value': '1,234', 'change': '+12%'},
    {'label': 'Demandes traitées', 'value': '567', 'change': '+8%'},
    {'label': 'Revenus générés', 'value': '\$9,876', 'change': '+15%'},
  ];

  int _currentIndex = 0;  // To track selected bottom nav item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tableau de bord Admin',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: _showSignOutDialog,
          ),
        ],
      ),
      body: _buildPageContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Utilisateurs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistiques',
          ),
        ],
      ),
    );
  }

  // Content for the selected section based on _currentIndex
  Widget _buildPageContent() {
    switch (_currentIndex) {
      case 0:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Utilisateurs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildFeaturedServices(),
            ],
          ),
        );
      case 1:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildQuickActions(),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Statistiques', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildRecentStats(),
            ],
          ),
        );
      default:
        return Container();  // Return empty container if index doesn't match
    }
  }

  // Method to handle tap on bottom nav
  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Other widgets (existing code)
  Widget _buildFeaturedServices() {
    return Column(
      children: featuredServices.map((service) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _navigateToServiceDetails(service['title']),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: service['gradient'],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Icon(service['icon'], size: 40, color: Colors.white),
                title: Text(
                  service['title'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                subtitle: Text(
                  service['description'],
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ),
            ),
          ),
        ).animate().slideX(duration: 500.ms);
      }).toList(),
    );
  }

  Widget _buildQuickActions() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: quickActions.length,
      itemBuilder: (context, index) {
        final action = quickActions[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _handleQuickAction(action['title']),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: action['gradient'],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(action['icon'], size: 40, color: Colors.white),
                    const SizedBox(height: 8),
                    Text(
                      action['title'],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).animate().scale(duration: 500.ms);
      },
    );
  }

  Widget _buildRecentStats() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Activité récente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...recentStats.map((stat) {
              return ListTile(
                leading: const Icon(Icons.trending_up, color: Colors.green),
                title: Text(stat['label']),
                subtitle: Text(stat['value']),
                trailing: Text(
                  stat['change'],
                  style: TextStyle(
                    color: stat['change'].contains('+') ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 900.ms);
  }

  // Methods for navigating and signing out (existing code)
  void _navigateToServiceDetails(String service) {
    context.go("/serviceDetails", extra: service);
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'Ajouter un service':
        context.go("/addService");
        break;
      case 'Vérifier les alertes':
        context.go("/alerts");
        break;
      case 'Ajuster les points':
        context.go("/adjustPoints");
        break;
    }
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la déconnexion'),
          actions: <Widget>[
            TextButton(child: const Text('Non'), onPressed: () => Navigator.of(context).pop()),
            TextButton(child: const Text('Oui'), onPressed: _signOut),
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
