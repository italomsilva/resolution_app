import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Importe GoRouter para StatefulNavigationShell
import 'package:resolution_app/app_theme.dart'; // Importe seu tema


class MainScaffold extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({
    required this.navigationShell, 
    super.key,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {

  void _onItemTapped(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final int selectedIndex = widget.navigationShell.currentIndex;
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar( 
        elevation: 60.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Novo Problema',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: selectedIndex, 
        selectedItemColor: theme.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}