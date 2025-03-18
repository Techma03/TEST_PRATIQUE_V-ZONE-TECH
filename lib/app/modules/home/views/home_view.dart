import 'package:e_banck/app/modules/home/controllers/comptebanck_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_View extends GetView<CompteBanck> {
  const Home_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("e-Banck")),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.numbanck.length,
                itemBuilder: (context, index) {
                  final row = controller.numbanck[index];
                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text("CARTE BANCAIRE"),
                      subtitle: Text(row.numbanck),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // controller.deleteAgent(a.id);
                        },
                      ),
                      onTap: () {
                        _showBottomSheet(
                          context,
                          title: "Modifier CARTE BANCAIRE",
                          // user: agent,
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: () =>
                  _showBottomSheet(context, title: "Creer une nouvelle Carte"),
              icon: Icon(Icons.add),
              label: Container(child: Text("Nouveau")),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context,
      {required String title, dynamic user}) {
    final nameController =
        TextEditingController(text: user != null ? user.name : '');   
    final nameFocusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          nameFocusNode.requestFocus();
        });
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    focusNode: nameFocusNode,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Code de la carte bancaire",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Le champ est obligatoire";
                      }
                      return null;
                    },
                  ),               
                    const SizedBox(height: 20),                 
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
