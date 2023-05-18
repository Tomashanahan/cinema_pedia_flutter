import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    int getCurrentIndex() {
      final currentRoute = GoRouterState.of(context).location;
      switch (currentRoute) {
        case '/':
          return 0;
        case '/favorites':
          return 1;
        case '/categories':
          return 2;
        default:
          return 0;
      }
    }

    return BottomNavigationBar(
      currentIndex: getCurrentIndex(),
      // elevation: 0, //* para quitar la linea de separación
      onTap: (value) {
        switch (value) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/favorites');
            break;
          case 2:
            context.go('/categories');
            break;
          default:
            context.go('/');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline_rounded),
          label: 'Categoría',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_rounded),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
