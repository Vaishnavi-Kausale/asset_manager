import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AssetFormScreen()));
}

class AssetFormScreen extends StatefulWidget {
  @override
  _AssetFormScreenState createState() => _AssetFormScreenState();
}

class _AssetFormScreenState extends State<AssetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? assetType;
  DateTime? purchaseDate;

  void _pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        purchaseDate = date;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Asset Submitted Successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Asset Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Asset Name"),
                validator: (value) => value!.isEmpty ? "Enter Asset Name" : null,
              ),
              DropdownButtonFormField<String>(
                value: assetType,
                decoration: InputDecoration(labelText: "Asset Type"),
                items: ["Electronics", "Furniture", "Software", "Vehicle"]
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) => setState(() => assetType = value),
                validator: (value) => value == null ? "Select Asset Type" : null,
              ),
              TextFormField(
                controller: idController,
                decoration: InputDecoration(labelText: "Asset ID"),
                validator: (value) => value!.isEmpty ? "Enter Asset ID" : null,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter Price" : null,
              ),
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Purchase Date",
                      hintText: purchaseDate != null
                          ? "${purchaseDate!.day}/${purchaseDate!.month}/${purchaseDate!.year}"
                          : "Select Date",
                    ),
                    validator: (value) => purchaseDate == null ? "Select a Date" : null,
                  ),
                ),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
