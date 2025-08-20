// splash_screen.dart
import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Logo scale animation
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    // Text fade animation
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    // Slide animation
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    // Start animations
    _logoController.forward();

    // Start text animation after logo animation is halfway
    _logoController.addListener(() {
      if (_logoController.value > 0.5 && !_textController.isAnimating) {
        _textController.forward();
      }
    });
  }

  Future<void> _initializeApp() async {
    try {
      // Add minimum splash duration for better UX
      await Future.delayed(const Duration(milliseconds: 500));

      // Perform initialization tasks
      await _performInitializationTasks();

      // Check authentication status
      if (mounted) {
        context.read<AuthBloc>().add(CheckAuthStatus());
      }
    } catch (e) {
      // Handle initialization errors
      debugPrint('Initialization error: $e');
      if (mounted) {
        context.read<AuthBloc>().add(CheckAuthStatus());
      }
    }
  }

  Future<void> _performInitializationTasks() async {
    // Add your initialization tasks here
    final tasks = [
      _initializeServices(),
      _preloadAssets(),
      _checkConnectivity(),
      _loadUserPreferences(),
    ];

    // Execute all tasks concurrently
    await Future.wait(tasks);
  }

  Future<void> _initializeServices() async {
    // Initialize any services that need setup
    await Future.delayed(const Duration(milliseconds: 300));
    debugPrint('Services initialized');
  }

  Future<void> _preloadAssets() async {
    // Preload any critical assets
    await Future.delayed(const Duration(milliseconds: 200));
    debugPrint('Assets preloaded');
  }

  Future<void> _checkConnectivity() async {
    // Check network connectivity
    await Future.delayed(const Duration(milliseconds: 100));
    debugPrint('Connectivity checked');
  }

  Future<void> _loadUserPreferences() async {
    // Load user preferences from storage
    await Future.delayed(const Duration(milliseconds: 150));
    debugPrint('User preferences loaded');
  }

  void _navigateToAuthWrapper() {
    if (mounted) {
      context.go(AppRoutes.authWrapper);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // Only navigate after initialization is complete and we have an auth state
          if (_isInitialized) return;

          if (state is! AuthLoading && state is! AuthChecking) {
            _isInitialized = true;

            // If user is authenticated, bootstrap the role cubit before navigation
            if (state is AuthSuccess) {
              context
                  .read<RoleResolverCubit>()
                  .bootstrap(state.authResult)
                  .then((_) {
                    // Add a small delay to let animations complete
                    Future.delayed(const Duration(milliseconds: 800), () {
                      _navigateToAuthWrapper();
                    });
                  });
            } else {
              // Not authenticated, navigate directly
              Future.delayed(const Duration(milliseconds: 800), () {
                _navigateToAuthWrapper();
              });
            }
          }
        },
        child: Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //       Theme.of(context).primaryColor,
          //       Theme.of(context).primaryColor.withOpacity(0.8),
          //       Theme.of(context).colorScheme.secondary.withOpacity(0.6),
          //     ],
          //   ),
          // ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo Animation
                        AnimatedBuilder(
                          animation: _logoAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _logoAnimation.value,
                              child:
                                  // Container(
                                  //   width: 120,
                                  //   height: 120,
                                  //   decoration: BoxDecoration(
                                  //     color: ColorConstant.primaryColorLight,
                                  //     borderRadius: BorderRadius.circular(30),
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: ColorConstant.primaryColorLight
                                  //             .withOpacity(0.2),
                                  //         blurRadius: 20,
                                  //         offset: const Offset(0, 10),
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   child: const Icon(
                                  //     Icons.school_rounded,
                                  //     size: 60,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                  Image.asset(
                                    'assets/images/logo.png',
                                    height: 200,
                                  ),
                            );
                          },
                        ),

                        // const SizedBox(height: 40),

                        // App Title Animation
                        // SlideTransition(
                        //   position: _slideAnimation,
                        //   child: FadeTransition(
                        //     opacity: _textAnimation,
                        //     child: Column(
                        //       children: [
                        //         Text(
                        //           'Edmento Resolve',
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .headlineMedium
                        //               ?.copyWith(
                        //                 color: ColorConstant.primaryColorLight,
                        //                 fontWeight: FontWeight.bold,
                        //                 letterSpacing: 1.2,
                        //               ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),

                // Loading Indicator
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: FadeTransition(
                    opacity: _textAnimation,
                    child: Column(
                      children: [
                        // SizedBox(
                        //   width: 30,
                        //   height: 30,
                        //   child: CircularProgressIndicator(
                        //     strokeWidth: 3,
                        //     valueColor: AlwaysStoppedAnimation<Color>(
                        //       Colors.black.withOpacity(0.8),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(height: 20),
                        Text(
                          'Powered by Edmento',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.black.withOpacity(0.8),
                                letterSpacing: 0.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }
}
