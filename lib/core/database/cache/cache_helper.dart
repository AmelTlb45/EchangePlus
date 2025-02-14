import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  // Instance de SharedPreferences
  static late SharedPreferences sharedPreferences;

  // Singleton CacheHelper
  static final CacheHelper _instance = CacheHelper._internal();

  // Getter pour l'instance unique
  static CacheHelper get instance => _instance;

  // Constructeur privé
  CacheHelper._internal();

  // Initialisation de SharedPreferences
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Méthode pour récupérer des données
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // Méthode pour sauvegarder des données selon le type
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    } else {
      throw Exception('Unsupported type');
    }
  }

  // Méthode pour supprimer une clé spécifique
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  // Méthode pour vérifier si une clé existe
  static bool containsKey({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  // Méthode pour effacer toutes les données
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
