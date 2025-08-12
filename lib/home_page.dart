import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_lab/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // HEADER SECTION
              const _Header(),
              // HERO SECTION
              _HeroSection(),
              // FEATURES SECTION
              const _FeaturesSection(),
              // CALL TO ACTION SECTION
              _CallToActionSection(),
              // FOOTER
              const _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================
// WIDGETS FOR EACH SECTION
// =======================================================

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'S-Lab',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!isMobile)
            Row(
              children: [
                const _NavBarItem('Home'),
                const SizedBox(width: 30),
                const _NavBarItem('Features'),
                const SizedBox(width: 30),
                const _NavBarItem('Contact'),
                const SizedBox(width: 30),
                const _NavBarItem('Login'),
                const SizedBox(width: 30),
                // Toggle Button
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.grey,
                ),
                Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ],
            ),
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // TODO: Implement mobile menu drawer with toggle button
              },
            ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      'S-Lab: Your Campus, Unified.',
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'An AI-powered, mobile-first platform to bridge the communication gap between universities and students.',
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey
                            : Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMobile)
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/app_mockup.png',
                      height: 500,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
      child: Column(
        children: [
          Text(
            'Features That Matter',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: const [
                  _FeatureCard(
                    icon: Icons.school,
                    title: 'Course Materials',
                    description:
                        'Access all your course materials in one place, anytime, anywhere.',
                  ),
                  _FeatureCard(
                    icon: Icons.access_time,
                    title: 'Timetables & Notices',
                    description:
                        'Stay updated with real-time timetables and official university notices.',
                  ),
                  _FeatureCard(
                    icon: Icons.assistant_sharp,
                    title: 'AI Assistant',
                    description:
                        'Get instant answers to academic and administrative questions with our AI.',
                  ),
                  _FeatureCard(
                    icon: Icons.card_membership,
                    title: 'Virtual Student ID',
                    description:
                        'A secure, digital student ID for easy verification and access.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 50,
            color: Theme.of(context).iconTheme.color,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey
                  : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _CallToActionSection extends StatelessWidget {
  _CallToActionSection();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
      color: isDarkMode ? Colors.white : Colors.black,
      child: Column(
        children: [
          Text(
            'Ready to Modernize Your Campus?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Contact us today to schedule a demo and see how S-Lab can transform your university.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: isDarkMode ? Colors.black87 : Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: isDarkMode ? Colors.black : Colors.white,
              foregroundColor: isDarkMode ? Colors.white : Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              // TODO: Implement contact logic
            },
            icon: Icon(Icons.mail,
                color: isDarkMode ? Colors.white : Colors.black),
            label: Text(
              "Contact Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
      padding: const EdgeInsets.all(50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2025 S-Lab. All rights reserved.',
            style: TextStyle(
              color: isDarkMode ? Colors.grey : Colors.black54,
            ),
          ),
          Text(
            'Privacy Policy | Terms of Service',
            style: TextStyle(
              color: isDarkMode ? Colors.grey : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeIn,
//     );
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Column(
//             children: [
//               // HEADER SECTION
//               const _Header(),
//               // HERO SECTION
//               _HeroSection(),
//               // FEATURES SECTION
//               const _FeaturesSection(),
//               // CALL TO ACTION SECTION
//               _CallToActionSection(),
//               // FOOTER
//               const _Footer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // =======================================================
// // WIDGETS FOR EACH SECTION
// // =======================================================
//
// class _Header extends StatelessWidget {
//   const _Header();
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         bool isMobile = constraints.maxWidth < 800;
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'S-Lab',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               if (!isMobile)
//                 const Row(
//                   children: [
//                     _NavBarItem('Home'),
//                     SizedBox(width: 30),
//                     _NavBarItem('Features'),
//                     SizedBox(width: 30),
//                     _NavBarItem('Contact'),
//                     SizedBox(width: 30),
//                     _NavBarItem('Login'),
//                   ],
//                 ),
//               if (isMobile)
//                 IconButton(
//                   icon: const Icon(Icons.menu, color: Colors.white),
//                   onPressed: () {
//                     // TODO: Implement mobile menu drawer
//                   },
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _NavBarItem extends StatelessWidget {
//   final String title;
//   const _NavBarItem(this.title);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 18,
//         color: Colors.white,
//         fontWeight: FontWeight.w400,
//       ),
//     );
//   }
// }
//
// class _HeroSection extends StatelessWidget {
//   _HeroSection();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
//       color: Colors.black,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           bool isMobile = constraints.maxWidth < 800;
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: isMobile
//                       ? CrossAxisAlignment.center
//                       : CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'S-Lab: Your Campus, Unified.',
//                       textAlign: isMobile ? TextAlign.center : TextAlign.start,
//                       style: const TextStyle(
//                         fontSize: 60,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'An AI-powered, mobile-first platform to bridge the communication gap between schools and students.',
//                       textAlign: isMobile ? TextAlign.center : TextAlign.start,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     Center(
//                       // Center the button on mobile
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 40, vertical: 20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Learn More',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (!isMobile)
//                 Expanded(
//                   child: Center(
//                     child: Image.asset(
//                       'assets/app_mockup.png', // Placeholder, replace with your image
//                       height: 500,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _FeaturesSection extends StatelessWidget {
//   const _FeaturesSection();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
//       color: Colors.black,
//       child: Column(
//         children: [
//           const Text(
//             'Features That Matter',
//             style: TextStyle(
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 50),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               return Wrap(
//                 spacing: 40,
//                 runSpacing: 40,
//                 alignment: WrapAlignment.center,
//                 children: const [
//                   _FeatureCard(
//                     icon: Icons.school,
//                     title: 'Course Materials',
//                     description:
//                         'Access all your course materials in one place, anytime, anywhere.',
//                   ),
//                   _FeatureCard(
//                     icon: Icons.access_time,
//                     title: 'Timetables & Notices',
//                     description:
//                         'Stay updated with real-time timetables and official university notices.',
//                   ),
//                   _FeatureCard(
//                     icon: Icons.assistant_sharp,
//                     title: 'AI Assistant',
//                     description:
//                         'Get instant answers to academic and administrative questions with our AI.',
//                   ),
//                   _FeatureCard(
//                     icon: Icons.card_membership,
//                     title: 'Virtual Student ID',
//                     description:
//                         'A secure, digital student ID for easy verification and access.',
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _FeatureCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String description;
//
//   const _FeatureCard({
//     required this.icon,
//     required this.title,
//     required this.description,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       padding: const EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         color: Colors.grey[900],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             icon,
//             size: 50,
//             color: Colors.white,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             description,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _CallToActionSection extends StatelessWidget {
//   _CallToActionSection();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
//       color: Colors.white,
//       child: Column(
//         children: [
//           const Text(
//             'Ready to Modernize Your Campus?',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 40,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Contact us today to schedule a demo and see how S-Lab can transform your school.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 40),
//           TextButton.icon(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//             ),
//             onPressed: () {
//               // TODO: Implement contact logic, like opening a mail client
//             },
//             icon: const Icon(Icons.mail, color: Colors.white),
//             label: const Text(
//               "Contact Us",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _Footer extends StatelessWidget {
//   const _Footer();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[900],
//       padding: const EdgeInsets.all(50),
//       child: const Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             '© 2025 S-Lab. All rights reserved.',
//             style: TextStyle(
//               color: Colors.grey,
//             ),
//           ),
//           Text(
//             'Privacy Policy | Terms of Service',
//             style: TextStyle(
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
