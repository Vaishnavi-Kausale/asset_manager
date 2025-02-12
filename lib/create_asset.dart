import 'package:flutter/material.dart';

class AssetForm extends StatefulWidget {
  @override
  _AssetFormState createState() => _AssetFormState();
}

class _AssetFormState extends State<AssetForm> {
  final _formKey = GlobalKey<FormState>();
  String _assetName = '';
  String _assetType = 'soft';
  List<String> _assetImages = [];
  bool _isRenewable = false;
  DateTime? _warrantyDate;
  DateTime? _expiryDate;
  String _maintenanceFrequency = 'monthly';
  String _verificationFrequency = 'monthly';

  void _createAsset() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you can handle the asset creation logic
      print('Asset Created: $_assetName, Type: $_assetType');
    }
  }

    void _pickWarrantyDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _warrantyDate = date;
      });
    }
  }

      void _pickExpiryDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _expiryDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Asset Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an asset name';
                  }
                  return null;
                },
                onSaved: (value) => _assetName = value!,
              ),
              DropdownButtonFormField<String>(
                value: _assetType,
                decoration: InputDecoration(labelText: 'Asset Type'),
                items: ['soft', 'hard', 'consumable'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _assetType = newValue!;
                  });
                },
              ),

              GestureDetector(
                onTap: () => _pickWarrantyDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Warranty Date",
                      hintText: _warrantyDate != null
                          ? "${_warrantyDate!.day}/${_warrantyDate!.month}/${_warrantyDate!.year}"
                          : "Select Date",
                    ),
                    validator: (value) => _warrantyDate == null ? "Select a Date" : null,
                  ),
                ),
              ),

                GestureDetector(
                onTap: () => _pickExpiryDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Expiry Date",
                      hintText: _warrantyDate != null
                          ? "${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}"
                          : "Select Date",
                    ),
                    validator: (value) => _expiryDate == null ? "Select a Date" : null,
                  ),
                ),
              ),


              // Add more fields here
              SwitchListTile(
                title: Text('Renewable'),
                value: _isRenewable,
                onChanged: (bool value) {
                  setState(() {
                    _isRenewable = value;
                  });
                },
              ),
              // Add date pickers, dropdowns for maintenance and verification frequencies
              ElevatedButton(
                child: Text('Create Asset'),
                onPressed: _createAsset,
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  // Handle cancel
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}