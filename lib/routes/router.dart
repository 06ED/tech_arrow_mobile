import 'package:flutter_app/resources/pages/pages.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
| Learn more https://nylo.dev/docs/5.20.0/router
|-------------------------------------------------------------------------- */

appRouter() => nyRoutes((router) {
      router.route(
        DashboardPage.path,
        (context) => DashboardPage(),
        initialRoute: true,
      );
      router.route(
        SignInPage.path,
        (context) => SignInPage(),
      );
      router.route(
        SignUpPage.path,
        (context) => SignUpPage(),
      );
    });
