import 'package:get/get.dart';
import 'package:medfest/screens/app/home/binding/binding.dart';
import 'package:medfest/screens/app/intro_sub.dart';
import 'package:medfest/screens/app/main_view.dart';
import 'package:medfest/screens/app/map/binding/binding.dart';
import 'package:medfest/screens/app/medical/binding/binding.dart';
import 'package:medfest/screens/app/pay/binding/binding.dart';
import 'package:medfest/screens/app/profile/binding/binding.dart';
import 'package:medfest/screens/auth/login/binding/binding.dart';
import 'package:medfest/screens/auth/login/view/login.dart';
import 'package:medfest/screens/auth/reset_password/binding/reset_password_binding.dart';
import 'package:medfest/screens/auth/reset_password/view/pages/reset_otp.dart';
import 'package:medfest/screens/auth/reset_password/view/reset_password.dart';
import 'package:medfest/screens/auth/signup/binding/signup_binding.dart';
import 'package:medfest/screens/auth/signup/view/signup.dart';
import 'package:medfest/screens/onboarding/binding/init_binding.dart';
import 'package:medfest/screens/onboarding/view/onboarding.dart';
import 'package:medfest/screens/onboarding/view/splash.dart';

part 'app_routes.dart';

class AppPages {
  static const SPLASHSCREEN = Routes.INITIAL;

  static final routes = [
    GetPage(
        name: SPLASHSCREEN,
        page: () => const SplashScreen(),
        binding: InitBinding()),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => const Signup(),
      binding: SignupBinding(),
    ),
    // GetPage(
    //     name: Routes.RESET_PASSWORD,
    //     page: () => const ResetPassword(),
    //     binding: ResetPasswordBinding()),
        GetPage(
        name: Routes.RESET_PASSWORD,
        page: () => const ResetPassword(),
        binding: ResetPasswordBinding()),
        GetPage(
        name: Routes.RESET_OTP,
        page: () => const CompleteResetEmail(),
       ),
    GetPage(
        name: Routes.ONBOARD_SCREEN, page: () => const OnboardingScreenOne()),
    GetPage(name: Routes.MAIN_VIEW, page: () => const MainView(), bindings: [
      HomeBinding(),
      MapBinding(),
      MedicalBinding(),
      PaymentBinding(),
      ProfileBinding(),
    ]),
    GetPage(name: Routes.INTRO_SUB, page: () => const IntroSubscription()),
  ];
}
