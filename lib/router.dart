import 'package:auto_route/auto_route_annotations.dart';
import 'package:todo_app/screens/dashboard_screen.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  DashboardScreen dashboardScreen;
}