import 'package:ecom/widgets/Admin_drawer_widget.dart';
import 'package:ecom/widgets/costum_draw_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin Panel"),
        ),
        drawer: AdminDrawerWidget());
  }
}
