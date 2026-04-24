import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../core/theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Ambient glow background
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                    blurRadius: 60,
                    spreadRadius: 20,
                  )
                ],
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              children: [
                _buildWelcomeSection(context),
                const SizedBox(height: 32),
                _buildWorkspaceHealth(context),
                const SizedBox(height: 32),
                _buildSuggestedActions(context),
                const SizedBox(height: 100), // padding for bottom nav
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
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
            backgroundColor: AppTheme.surfaceContainer,
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

  Widget _buildWelcomeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good evening.',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          "System operations are nominal. I've processed your latest data feeds.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildWorkspaceHealth(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'DIGITAL WORKSPACE HEALTH',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                    letterSpacing: 2,
                  ),
            ),
            Text(
              'All systems active',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildAppCard(
                context,
                title: 'Gmail',
                subtitle: '42 unread • Last sync: 2m ago',
                icon: Icons.mail_outline_rounded,
                isSynced: true,
              ),
              const SizedBox(width: 16),
              _buildAppCard(
                context,
                title: 'Drive',
                subtitle: '3 new docs • Indexing complete',
                icon: Icons.folder_open_rounded,
                isSynced: true,
              ),
              const SizedBox(width: 16),
              _buildAppCard(
                context,
                title: 'Notion',
                subtitle: 'Project alpha updated',
                icon: Icons.description_outlined,
                isSynced: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSynced,
  }) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.02)),
                ),
                child: Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 20),
              ),
              if (isSynced)
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.greenAccent, blurRadius: 10),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Synced',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.greenAccent.withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SUGGESTED ACTIONS',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
                letterSpacing: 2,
              ),
        ),
        const SizedBox(height: 16),
        _buildActionTile(
          context,
          title: 'Summarize 3 new invoices',
          subtitle: 'From Acme Corp and Globex. Totaling \$4,250.',
          icon: Icons.receipt_long_rounded,
          iconColor: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(height: 12),
        _buildActionTile(
          context,
          title: 'Draft reply to Client X',
          subtitle: 'Regarding the Q3 deliverables timeline.',
          icon: Icons.edit_document,
          iconColor: AppTheme.tertiaryFixed,
        ),
      ],
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHigh.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_rounded, color: AppTheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
