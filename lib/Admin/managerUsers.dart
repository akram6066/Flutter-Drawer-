import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'constant.dart'; // Color palette

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final List<Map<String, String>> users = [
    {'name': 'Alice Smith', 'role': 'Admin'},
    {'name': 'John Doe', 'role': 'Staff'},
    {'name': 'Jane Doe', 'role': 'Staff'},
  ];

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _role = 'Admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.purple,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      body: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => _buildUserCard(context, users[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purple,
        child: const FaIcon(FontAwesomeIcons.userPlus, color: AppColors.white),
        onPressed: () => _showAddEditUserModal(context),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, Map<String, String> user) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        leading: const CircleAvatar(
          backgroundColor: AppColors.lightPurple,
          child: FaIcon(FontAwesomeIcons.user, color: AppColors.purple),
        ),
        title: Text(user['name'] ?? 'Unknown', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.purple)),
        subtitle: Text(user['role'] ?? 'Unknown Role', style: const TextStyle(fontSize: 16, color: AppColors.lightPurple)),
        trailing: _buildUserActions(context, user),
      ),
    );
  }

  Widget _buildUserActions(BuildContext context, Map<String, String> user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.pen, color: AppColors.orange),
          onPressed: () => _showAddEditUserModal(context, user: user),
        ),
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.trashAlt, color: AppColors.lightOrange),
          onPressed: () => _deleteUser(user),
        ),
      ],
    );
  }

  void _showAddEditUserModal(BuildContext context, {Map<String, String>? user}) {
    _name = user?['name'] ?? '';
    _role = user?['role'] ?? 'Admin';

    showMaterialModalBottomSheet(
      context: context,
      
      // isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user == null ? 'Add User' : 'Edit User',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.purple),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _name,
                  decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                  validator: RequiredValidator(errorText: 'Name is required'),
                  onChanged: (val) => _name = val,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _role,
                  decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
                  items: ['Admin', 'Staff'].map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
                  onChanged: (val) => setState(() => _role = val!),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(user == null ? 'Add User' : 'Save Changes', style: const TextStyle(color: AppColors.white)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      user == null ? _addUser() : _editUser(user);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addUser() {
    setState(() => users.add({'name': _name, 'role': _role}));
  }

  void _editUser(Map<String, String> user) {
    setState(() {
      user['name'] = _name;
      user['role'] = _role;
    });
  }

  void _deleteUser(Map<String, String> user) {
    setState(() => users.remove(user));
  }
}
