import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider {
  final String baseUrl = "http://192.168.51.4/e-banck_api/public/api/";
  Future<List<dynamic>> getCart() async {
    final response = await http.get(Uri.parse("$baseUrl/getcart"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<Map<String, dynamic>?> addCart(String name, String description) async {
    final response = await http.post(
      Uri.parse("$baseUrl/Carts/data.php"),
      headers: {
        'Content-Type': 'application/json'
      }, // Indique que les données sont en JSON
      body: jsonEncode({'name': name, 'description': description}),
    );

    if (response.statusCode == 200) {
       Get.snackbar(
        "Succès",
        "Cart ajouté avec succès.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return jsonDecode(response.body);      
    } else if (response.statusCode == 400) {
      throw Exception("Invalid input: ${response.body}");
    } else if (response.statusCode == 500) {
      throw Exception("Server error: ${response.body}");
    } else {
      throw Exception("Unexpected error: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>?> updateCart(
      int id, String name, String description) async {
    final url = Uri.parse("$baseUrl/addCart");
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'name': name,}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          print("Mise à jour réussie : $responseBody");
          Get.snackbar(
            "Succès",
            "Cart modifié avec succès.",
            backgroundColor: Colors.blue,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          return responseBody;
        } else {
          print("Échec de la mise à jour : ${responseBody['message']}");
          Get.snackbar(
            "Erreur",
            "Échec de la mise à jour de l'Cart : ${responseBody['message']}",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          return null;
        }
      } else {
        print("Erreur HTTP : ${response.statusCode}");
        Get.snackbar(
          "Erreur",
          "Erreur HTTP : ${response.statusCode}.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return null;
      }
    } catch (e) {
      print("Exception : $e");
      Get.snackbar(
        "Erreur",
        "Une erreur s'est produite : $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<bool> deleteCart(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/Carts/data.php"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      Get.snackbar("Succès", "Cart supprimé avec succès.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      return responseBody['success'] == true;
    } else {
      throw Exception(Get.snackbar(
        "Erreur de Connexion",
        "Échec de la suppression de l'Cart.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      ));
    }
  }

  }
