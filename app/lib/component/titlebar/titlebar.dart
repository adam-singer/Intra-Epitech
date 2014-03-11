library titlebar;

import 'dart:html';
import 'package:angular/angular.dart';

import '../../controller/navigationcontroller.dart';

@NgComponent(
    selector: 'titlebar',
    templateUrl: '/lib/component/titlebar/titlebar.html',
    cssUrl: '/lib/component/titlebar/titlebar.css',
    publishAs: 'titlebar',
    applyAuthorStyles: true)
class TitleBar {
  @NgTwoWay('delegate')
  NavigationController delegate;
  
  @NgTwoWay('title')
  String title;
  
  TitleBar() {
    print("load TitleBar Component");
  }
}