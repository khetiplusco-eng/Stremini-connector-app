import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../core/theme.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Ambient Glow Background (Bottom)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF571BC1).withOpacity(0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              children: [
                _buildHeader(context),
                const SizedBox(height: 32),
                _buildTimeline(context),
                const SizedBox(height: 100), // padding for bottom nav
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF09090B).withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'STREMINI AI',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.surfaceContainerHigh,
            child: const Icon(Icons.person, size: 20, color: Colors.white),
          ),
        ),
      ],
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstOut),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contextual Memory',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Recent workflows and learned preferences.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 24),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: TextField(
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
            decoration: InputDecoration(
              hintText: 'Search Memory...',
              hintStyle: TextStyle(color: AppTheme.outlineVariant),
              prefixIcon: Icon(Icons.search, color: AppTheme.outlineVariant),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return Stack(
      children: [
        // Vertical Timeline Line
        Positioned(
          left: 20, // offset for the line
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppTheme.outlineVariant.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSection(context, 'TODAY'),
            const SizedBox(height: 24),
            _buildTimelineItem(
              context,
              icon: Icons.analytics_outlined,
              iconColor: Theme.of(context).colorScheme.secondary,
              title: 'Weekly Financial Summary',
              time: '2:30 PM',
              description: 'Analyzed Q3 spending reports, generated visualizations, and drafted executive summary email.',
              tags: [
                {'icon': Icons.description_outlined, 'label': 'Docs', 'color': AppTheme.tertiaryFixed},
                {'icon': Icons.table_chart_outlined, 'label': 'Sheets', 'color': Theme.of(context).colorScheme.secondary},
                {'icon': Icons.mail_outline_rounded, 'label': 'Mail', 'color': Theme.of(context).colorScheme.error},
              ],
            ),
            const SizedBox(height: 32),
            _buildTimelineItem(
              context,
              icon: Icons.flight_takeoff_rounded,
              iconColor: AppTheme.tertiaryFixed,
              title: 'Tokyo Trip Itinerary',
              time: '10:15 AM',
              description: 'Researched boutique hotels in Shinjuku, created 5-day dining plan, and set calendar reminders.',
              tags: [
                {'icon': Icons.travel_explore_rounded, 'label': 'Web', 'color': Theme.of(context).colorScheme.primary},
                {'icon': Icons.calendar_month_rounded, 'label': 'Calendar', 'color': AppTheme.tertiaryFixed},
              ],
            ),
            const SizedBox(height: 48),
            _buildDateSection(context, 'YESTERDAY'),
            const SizedBox(height: 24),
            _buildTimelineItem(
              context,
              icon: Icons.code_rounded,
              iconColor: Theme.of(context).colorScheme.primary,
              title: 'Debug React Component',
              time: '4:45 PM',
              description: 'Identified state mutation bug in user profile component and suggested refactored hook implementation.',
              tags: [
                {'icon': Icons.terminal_rounded, 'label': 'Terminal', 'color': Theme.of(context).colorScheme.onSurface},
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateSection(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.only(left: 40),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
          )
        ],
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
              letterSpacing: 2,
            ),
      ),
    );
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required String description,
    required List<Map<String, dynamic>> tags,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Node
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.surfaceContainerHigh, width: 2),
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 2,
              )
            ],
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        // Content Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF141414).withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.15))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) => _buildTag(context, tag)).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(BuildContext context, Map<String, dynamic> tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(tag['icon'] as IconData, color: tag['color'] as Color, size: 14),
          const SizedBox(width: 4),
          Text(
            tag['label'] as String,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
