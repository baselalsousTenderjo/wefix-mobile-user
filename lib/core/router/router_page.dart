import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/auth/pages/auth_screen.dart';
import '../../presentation/auth/pages/verify_screen.dart';
import '../../presentation/chat/pages/chat_screen.dart';
import '../../presentation/drawer/pages/content_screen.dart';
import '../../presentation/drawer/pages/edit_profile_screen.dart';
import '../../presentation/ticktes_details/pages/check_list/completion_checklist_screen.dart';
import '../../presentation/ticktes_details/pages/ticktes_details_screen.dart';
import '../../presentation/ticktes_details/pages/select_products_screen.dart';
import '../../presentation/layout/pages/layout_screen.dart';
import '../../presentation/layout/pages/notification_screen.dart';
import '../../presentation/splash/pages/splash_screen.dart';
import '../context/global.dart';
import '../widget/webview_screen.dart';
import 'router_key.dart';

final goRouter = GoRouter(
  initialLocation: RouterKey.splash,
  navigatorKey: GlobalContext.navigatorKey,
  observers: [BotToastNavigatorObserver()],
  debugLogDiagnostics: true,
  routes: [
    // --- Splash and
    _pageRouter(path: RouterKey.splash, screen: const SplashScreen()),
    // ---Authentication Routes ---
    _pageRouter(
      path: RouterKey.login,
      screen: const AuthScreen(),
      routes: [
        GoRoute(
          path: RouterKey.otp,
          pageBuilder: (context, state) {
            String? mobile = state.uri.queryParameters['mobile'];
            String? otp = state.uri.queryParameters['otp'];
            
            // Normalize phone number from URL
            if (mobile != null) {
              // Decode URL encoding (%2B becomes +, spaces might be from +)
              mobile = Uri.decodeComponent(mobile);
              
              // Handle case where + was converted to space in URL
              if (mobile.startsWith(' ') && mobile.length > 1) {
                mobile = '+${mobile.substring(1).trim()}';
              }
              
              // Ensure it has + prefix if it starts with 00
              if (mobile.startsWith('00')) {
                mobile = '+${mobile.substring(2)}';
              }
              
              // Remove any remaining spaces
              mobile = mobile.replaceAll(' ', '').trim();
            }
            
            // Decode OTP if present
            if (otp != null) {
              otp = Uri.decodeComponent(otp);
            }
            
            return _fadeTransitionPage(VerifyScreen(mobile: mobile ?? '', otp: otp), state);
          },
        ),
      ],
    ),
    // --- Layout Routes ---
    GoRoute(
      path: RouterKey.layout,
      pageBuilder: (context, state) {
        final index = state.uri.queryParameters['index'] ?? '0';
        return _fadeTransitionPage(LayoutScreen(index: int.tryParse(index)), state);
      },
      routes: [
        // --- Ticket & Request Routes ---
        GoRoute(
          path: RouterKey.requestDetails,
          pageBuilder: (context, state) {
            final id = state.uri.queryParameters['id'];
            return _fadeTransitionPage(TicktesDetailsScreen(id: id.toString()), state);
          },
          routes: [
            GoRoute(
              path: RouterKey.selectProduct,
              pageBuilder: (context, state) {
                final id = state.uri.queryParameters['id'];
                return _fadeTransitionPage(SelectProductsScreen(id: id!), state);
              },
            ),
            GoRoute(
              path: RouterKey.chat,
              pageBuilder: (context, state) {
                final id = state.uri.queryParameters['id'];
                final userId = state.uri.queryParameters['userId'];
                return _fadeTransitionPage(ChatScreen(ticketId: id!, userId: userId), state);
              },
            ),
            GoRoute(
              path: RouterKey.completionChecklist,

              pageBuilder: (context, state) {
                final id = state.uri.queryParameters['id'];
                return _fadeTransitionPage(CompletionChecklistScreen(id: id!), state);
              },
            ),
          ],
        ),
        // --- Notification Routes ---
        _pageRouter(path: RouterKey.notification, screen: const NotificationScreen()),
        // --- Drawer Routes ---
        _pageRouter(path: RouterKey.editProfile, screen: EditProfileScreen()),

        GoRoute(
          path: RouterKey.content,
          pageBuilder: (context, state) {
            final title = state.uri.queryParameters['title'];
            return _fadeTransitionPage(ContentScreen(title: title!), state);
          },
        ),
      ],
    ),
    GoRoute(
      path: RouterKey.webview,
      pageBuilder: (context, state) {
        final url = state.uri.queryParameters['url'];
        final title = state.uri.queryParameters['title'];
        return _fadeTransitionPage(WebviewScreen(url: url, title: title ?? ''), state);
      },
    ),
  ],
);

RouteBase _pageRouter({required String path, required Widget screen, List<RouteBase>? routes}) {
  return GoRoute(path: path, pageBuilder: (context, state) => _fadeTransitionPage(screen, state), routes: routes ?? []);
}

Page _fadeTransitionPage(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child); // This is what creates the FadeTransition widget
    },
  );
}
