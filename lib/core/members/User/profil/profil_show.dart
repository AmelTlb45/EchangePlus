import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart'; // Importer le package url_launcher
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importer Firestore
import 'package:go_router/go_router.dart'; // Pour la navigation

class ProfilePage extends StatefulWidget {
  final Position? userPosition;

  ProfilePage({Key? key, required this.userPosition}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String location = "Chargement..."; // Variable pour afficher l'adresse détaillée
  late String latitude;
  late String longitude;

  // Variables pour afficher les données de l'utilisateur
  String firstName = '';
  String lastName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Charger les données utilisateur depuis Firestore
    if (widget.userPosition != null) {
      latitude = widget.userPosition!.latitude.toString();
      longitude = widget.userPosition!.longitude.toString();
      _getAddressFromCoordinates(widget.userPosition!); // Appel de la méthode pour obtenir l'adresse
    }
  }

  // Charger les données de l'utilisateur depuis Firestore
  void _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          firstName = userDoc['firstName'] ?? 'Prénom';
          lastName = userDoc['lastName'] ?? 'Nom';
          email = userDoc['email'] ?? 'Email';
        });
      } else {
        setState(() {
          firstName = 'Prénom';
          lastName = 'Nom';
          email = 'Email';
        });
      }
    }
  }

  // Méthode pour obtenir l'adresse à partir de la latitude et longitude
  Future<void> _getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;
      setState(() {
        location = "${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print("Erreur lors de la récupération de l'adresse: $e");
      setState(() {
        location = "Impossible de récupérer l'adresse";
      });
    }
  }

  // Méthode pour ouvrir Google Maps avec les coordonnées
  Future<void> _openGoogleMaps() async {
    final String googleMapsUrl = "https://www.google.com/maps?q=$latitude,$longitude";  // Format correct de l'URL
    final String appleMapsUrl = "https://maps.apple.com/?q=$latitude,$longitude";  // URL pour Apple Maps (iOS)

    try {
      // Vérifier si l'URL de Google Maps peut être lancée
      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } 
      // Vérifier si l'URL de Apple Maps peut être lancée
      else if (await canLaunch(appleMapsUrl)) {
        await launch(appleMapsUrl);
      } 
      // Si aucun des deux ne fonctionne, afficher un message d'erreur
      else {
        throw 'Impossible d\'ouvrir Google Maps ou Apple Maps';
      }
    } catch (e) {
      // Si l'URL ne peut pas être lancée, afficher un message d'erreur
      print("Erreur lors de l'ouverture de la carte: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Impossible d\'ouvrir Google Maps ou Apple Maps')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil de l'utilisateur"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Redirige vers la page de modification du profil
              context.go("/profil_edit", extra: widget.userPosition);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Avatar de l'utilisateur
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, color: Colors.white, size: 60),
              ),
            ),
            SizedBox(height: 20),

            // Informations utilisateur (Non modifiables)
            _buildUserInfo(),
            SizedBox(height: 30),

            // Localisation utilisateur
            _buildLocationInfo(),
          ],
        ),
      ),
    );
  }

  // Afficher les informations utilisateur (non modifiables)
  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(
          "$firstName $lastName",  // Affiche le nom complet
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          email,  // Affiche l'email
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ],
    );
  }

  // Afficher la localisation de l'utilisateur
  Widget _buildLocationInfo() {
    return Column(
      children: [
        Text(
          "Votre position actuelle :",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: _openGoogleMaps, // Ouvre Google Maps quand on clique sur la localisation
          child: Text(
            location,  // Affiche la localisation détaillée (pays, wilaya, quartier)
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
