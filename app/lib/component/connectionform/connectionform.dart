library connectionform;

import 'dart:html';
import 'package:angular/angular.dart';

import '../../controller/navigationcontroller.dart';

@NgComponent(
    selector: 'connectionform',
    templateUrl: '/lib/component/connectionform/connectionform.html',
    cssUrl: '/lib/component/connectionform/connectionform.css',
    publishAs: 'cntform',
    applyAuthorStyles: true)
class ConnectionForm {
  @NgTwoWay('delegate')
  NavigationController delegate;
  
  ConnectionForm() {
    print("load Connection Component");
  }

}