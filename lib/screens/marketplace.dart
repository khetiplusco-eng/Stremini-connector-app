import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../core/theme.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Ambient Glow Background
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF571BC1).withOpacity(0.1), // secondary-container
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF571BC1).withOpacity(0.1),
                    blurRadius: 120,
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
                _buildHeaderSection(context),
                const SizedBox(height: 24),
                _buildConnectorsGrid(context),
                const SizedBox(height: 100), // padding for bottom nav
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
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

  Widget _buildHeaderSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connectors Marketplace',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Integrate your essential tools. Stremini AI requires these connections to index context, automate workflows, and synthesize reasoning across your ecosystem.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  Widget _buildConnectorsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1 : 1.6,
      children: [
        _buildConnectorCard(
          context,
          title: 'WhatsApp Business',
          description: 'Real-time conversational memory and customer interaction indexing.',
          icon: Icons.chat_bubble_outline_rounded,
          color: AppTheme.tertiaryFixed,
          isActive: true,
        ),
        _buildConnectorCard(
          context,
          title: 'Gmail',
          description: 'Semantic search across threads and automated response drafting.',
          icon: Icons.mail_outline_rounded,
          color: AppTheme.secondaryFixed,
          isActive: true,
        ),
        _buildConnectorCard(
          context,
          title: 'Notion',
          description: 'Sync knowledge bases, documents, and project tracking databases.',
          icon: Icons.description_outlined,
          color: AppTheme.onSurfaceVariant,
          isActive: false,
        ),
        _buildConnectorCard(
          context,
          title: 'Google Drive',
          description: 'File indexing, automated organization, and document summarization.',
          icon: Icons.cloud_queue_rounded,
          color: AppTheme.onSurfaceVariant,
          isActive: false,
        ),
      ],
    );
  }

  Widget _buildConnectorCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive
            ? AppTheme.surfaceContainerLow.withOpacity(0.8)
            : const Color(0xFF0E0E0E).withOpacity(0.6), // surface-container-lowest
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive ? color.withOpacity(0.3) : AppTheme.outlineVariant.withOpacity(0.2),
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 8),
                )
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: color.withOpacity(0.2)),
                  ),
                  child: Text(
                    'Active',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: color),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive
                    ? Theme.of(context).colorScheme.primary
                    : const Color(0xFF3A3939).withOpacity(0.5), // surface-bright
                foregroundColor: isActive
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                  side: isActive
                      ? BorderSide.none
                      : BorderSide(color: AppTheme.outlineVariant.withOpacity(0.3)),
                ),
              ),
              onPressed: () {},
              child: Text(
                isActive ? 'Manage Connection' : 'Connect',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
