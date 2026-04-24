import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF09090B).withOpacity(0.9),
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 40,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            icon: Icons.home_rounded,
            index: 0,
            route: '/',
          ),
          _buildNavItem(
            context,
            icon: Icons.storefront_rounded,
            index: 1,
            route: '/marketplace',
          ),
          _buildNavItem(
            context,
            icon: Icons.auto_awesome_rounded,
            index: 2,
            route: '/workflow',
          ),
          _buildNavItem(
            context,
            icon: Icons.history_rounded,
            index: 3,
            route: '/memory',
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required IconData icon, required int index, required String route}) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () {
        if (!isActive) {
          context.go(route);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 15,
                  )
                ]
              : [],
        ),
        child: Icon(
          icon,
          color: isActive ? const Color(0xFF09090B) : const Color(0xFFA1A1AA),
          size: 24,
        ),
      ),
    );
  }
}
