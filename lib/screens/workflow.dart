import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../core/theme.dart';

class WorkflowScreen extends StatelessWidget {
  const WorkflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Ambient Glow Background
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF571BC1).withOpacity(0.2), // secondary-container
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF571BC1).withOpacity(0.2),
                    blurRadius: 100,
                    spreadRadius: 20,
                  )
                ],
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              children: [
                _buildUserPrompt(context),
                const SizedBox(height: 32),
                _buildExecutionGraph(context),
                const SizedBox(height: 32),
                _buildPreviewArea(context),
                const SizedBox(height: 100), // padding for bottom nav
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
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

  Widget _buildUserPrompt(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerHigh.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
            topRight: Radius.circular(4),
          ),
          border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
        ),
        child: Text(
          '"Find pending payments and draft follow-ups."',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }

  Widget _buildExecutionGraph(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            'EXECUTION GRAPH',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  letterSpacing: 2,
                ),
          ),
        ),
        _buildStepItem(
          context,
          icon: Icons.mail_outline_rounded,
          title: 'Searching Gmail for unread invoices...',
          status: 'completed',
        ),
        const SizedBox(height: 12),
        _buildStepItem(
          context,
          icon: Icons.folder_open_rounded,
          title: 'Analyzing Invoices in Drive...',
          subtitle: 'Extracting dates and amounts',
          status: 'active',
        ),
        const SizedBox(height: 12),
        _buildStepItem(
          context,
          icon: Icons.description_outlined,
          title: 'Preparing Notion update...',
          status: 'pending',
        ),
      ],
    );
  }

  Widget _buildStepItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required String status,
  }) {
    Color bgColor;
    Color iconColor;
    Color iconBgColor;
    Color borderColor;

    if (status == 'completed') {
      bgColor = AppTheme.surfaceContainer.withOpacity(0.4);
      iconColor = Theme.of(context).colorScheme.onSurface;
      iconBgColor = AppTheme.surfaceContainerHigh;
      borderColor = AppTheme.outlineVariant.withOpacity(0.2);
    } else if (status == 'active') {
      bgColor = AppTheme.surfaceContainerHigh.withOpacity(0.6);
      iconColor = Theme.of(context).colorScheme.secondary;
      iconBgColor = const Color(0xFF571BC1).withOpacity(0.3);
      borderColor = Theme.of(context).colorScheme.secondary.withOpacity(0.3);
    } else {
      // pending
      bgColor = const Color(0xFF0E0E0E).withOpacity(0.3);
      iconColor = AppTheme.outline;
      iconBgColor = AppTheme.surfaceContainer;
      borderColor = AppTheme.outlineVariant.withOpacity(0.1);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: status == 'active'
            ? [
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                  blurRadius: 60,
                  spreadRadius: 10,
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
              border: Border.all(
                  color: status == 'active'
                      ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                      : Colors.white.withOpacity(0.05)),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: status == 'completed'
                            ? AppTheme.onSurfaceVariant.withOpacity(0.7)
                            : status == 'active'
                                ? Theme.of(context).colorScheme.onSurface
                                : AppTheme.outline,
                        fontWeight: status == 'active' ? FontWeight.w500 : FontWeight.normal,
                        decoration: status == 'completed' ? TextDecoration.lineThrough : null,
                      ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(width: 16),
          if (status == 'completed')
            Icon(Icons.check_circle_rounded, color: AppTheme.tertiaryFixed, size: 24)
          else if (status == 'active')
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
              ),
            )
          else
            Icon(Icons.radio_button_unchecked_rounded, color: AppTheme.outline, size: 24),
        ],
      ),
    );
  }

  Widget _buildPreviewArea(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHigh.withOpacity(0.5),
              border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.edit_document, size: 16, color: AppTheme.onSurfaceVariant),
                    const SizedBox(width: 8),
                    Text(
                      'DRAFT PREVIEW',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                            letterSpacing: 2,
                          ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF571BC1).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Generating',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: Text('To:', style: TextStyle(color: AppTheme.outline, fontSize: 12)),
                    ),
                    Expanded(
                      child: Container(
                        height: 20,
                        margin: const EdgeInsets.only(right: 40),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: Text('Subj:', style: TextStyle(color: AppTheme.outline, fontSize: 12)),
                    ),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(color: AppTheme.outlineVariant.withOpacity(0.2)),
                const SizedBox(height: 16),
                Container(
                  height: 16,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 16,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 16,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
