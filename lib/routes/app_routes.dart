import 'package:expensepoket/middlewares/auth_middleware.dart';
import 'package:expensepoket/routes/route_name.dart';
import 'package:expensepoket/views/auth/login/login_view.dart';
import 'package:expensepoket/views/auth/signup/basic_details/basic_details.dart';
import 'package:expensepoket/views/auth/signup/mobile_auth/mobile_auth_view.dart';
import 'package:expensepoket/views/auth/signup/signup_view.dart';
import 'package:expensepoket/views/home/home_view.dart';
import 'package:expensepoket/views/loan_input/loan_input.dart';
import 'package:expensepoket/views/screens/budget_home_view.dart';
import 'package:expensepoket/views/screens/budget_page_view.dart';
import 'package:expensepoket/views/screens/budget_planner_emi_view.dart';
import 'package:expensepoket/views/screens/budget_view.dart';
import 'package:expensepoket/views/screens/loan_detail_view.dart';
import 'package:expensepoket/views/screens/loans_view.dart';
import 'package:get/route_manager.dart';

class AppRoutes {
  static appRoute() => [
     GetPage(
      name: RouteName.home, 
      page: () => HomeView(),
      middlewares: [AuthMiddleware()]
    ),

    GetPage(
      name: RouteName.loginView, 
      page: () => LoginView()
    ),

    GetPage(
      name: RouteName.signUpView, 
      page: () => SignupView()
    ),

    GetPage(
      name: RouteName.mobileAuthView, 
      page: () => MobileAuthView()
    ),

    GetPage(
      name: RouteName.basicDetailView, 
      page: () => BasicDetails()
    ),

    GetPage(
      name: RouteName.loanView, 
      page: () => LoansView()
    ),

    GetPage(
      name: RouteName.loanDetailsView, 
      page: () => LoanDetailView()
    ),

    GetPage(
      name: RouteName.loanInput, 
      page: () => LoanInput()
    ),

    GetPage(
      name: RouteName.budgetHomeView, 
      page: () => BudgetHomeView()
    ),

    GetPage(
      name: RouteName.budgetView, 
      page: () => BudgetView()
    ),

    GetPage(
      name: RouteName.budgetPageView, 
      page: () => BudgetPageView()
    ),

    GetPage(
      name: RouteName.budgetPlannerEmiView, 
      page: () => BudgetPlannerEmiView()
    ),
  ];
}