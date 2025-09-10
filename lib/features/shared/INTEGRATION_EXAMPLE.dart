// Example integration of Compose Email feature
// This shows how to integrate the compose email feature into existing pages

import 'package:edmentoresolve/features/shared/presentation/pages/compose_email_provider.dart';
import 'package:edmentoresolve/features/shared/presentation/widgets/compose_email/compose_floating_button.dart';
import 'package:flutter/material.dart';

// Example 1: Adding compose button to a dashboard page
class ExampleDashboardPage extends StatelessWidget {
  const ExampleDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => navigateToComposeEmail(context),
            tooltip: 'Compose Email',
          ),
        ],
      ),
      body: const Center(child: Text('Dashboard Content')),
      floatingActionButton: const ComposeFloatingButton(),
    );
  }
}

// Example 2: Adding compose button to a list page
class ExampleListPage extends StatelessWidget {
  const ExampleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mail),
            onPressed: () => navigateToComposeEmail(
              context,
              // initialSubject: 'Quick Message',
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Message ${index + 1}'),
            subtitle: const Text('This is a sample message'),
            trailing: IconButton(
              icon: const Icon(Icons.reply),
              onPressed: () => navigateToComposeEmail(
                context,
                // initialTo: 'user${index + 1}@example.com',
                // initialSubject: 'Re: Message ${index + 1}',
              ),
            ),
          );
        },
      ),
      floatingActionButton: const ComposeFloatingButtonCompact(),
    );
  }
}

// Example 3: Custom compose button with specific styling
class ExampleCustomPage extends StatelessWidget {
  const ExampleCustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Page')),
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Page Content'))),
          // Custom compose button at bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () => navigateToComposeEmail(
                context,
                // initialTo: 'admin@example.com',
                // initialSubject: 'Support Request',
                // initialBody: 'Hi,\n\nI need help with...',
              ),
              icon: const Icon(Icons.email),
              label: const Text('Send Support Email'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example 4: Integration with existing teacher communication page
class TeacherCommunicationPageExample extends StatelessWidget {
  const TeacherCommunicationPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication'),
        actions: [
          IconButton(
            icon: const Icon(Icons.email_outlined),
            onPressed: () => navigateToComposeEmail(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Existing communication content
          const Expanded(
            child: Center(child: Text('Existing Communication Content')),
          ),
          // Gmail-style compose button
          const GmailComposeButton(),
        ],
      ),
    );
  }
}

// Example 5: Integration with student dashboard
class StudentDashboardExample extends StatelessWidget {
  const StudentDashboardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Dashboard')),
      body: Column(
        children: [
          // Quick actions section
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => navigateToComposeEmail(
                      context,
                      // initialTo: 'teacher@school.com',
                      // initialSubject: 'Question about Assignment',
                    ),
                    icon: const Icon(Icons.help),
                    label: const Text('Ask Teacher'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => navigateToComposeEmail(
                      context,
                      // initialTo: 'parent@example.com',
                      // initialSubject: 'School Update',
                    ),
                    icon: const Icon(Icons.family_restroom),
                    label: const Text('Contact Parent'),
                  ),
                ),
              ],
            ),
          ),
          // Rest of dashboard content
          const Expanded(child: Center(child: Text('Dashboard Content'))),
        ],
      ),
      floatingActionButton: const ComposeFloatingButton(),
    );
  }
}

// Example 6: Integration with parent dashboard
class ParentDashboardExample extends StatelessWidget {
  const ParentDashboardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Dashboard')),
      body: Column(
        children: [
          // Quick compose options
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickActionCard(
                        context,
                        'Contact Teacher',
                        Icons.school,
                        () => navigateToComposeEmail(
                          context,
                          // initialTo: 'teacher@school.com',
                          // initialSubject: 'Regarding My Child',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildQuickActionCard(
                        context,
                        'School Office',
                        Icons.business,
                        () => navigateToComposeEmail(
                          context,
                          // initialTo: 'office@school.com',
                          // initialSubject: 'General Inquiry',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Rest of dashboard content
          const Expanded(child: Center(child: Text('Dashboard Content'))),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 32, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
