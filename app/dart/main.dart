
@MirrorsUsed(
  targets: const [ 'navigationcontroller', 'connectioncontroller', 'my_router', 'titlebar', 'connectionform' ],
  override: '*')
import 'dart:mirrors';


import 'package:angular/angular.dart' as angular;
import 'package:di/di.dart' as di;

import '../lib/component/titlebar/titlebar.dart';
import '../lib/component/connectionform/connectionform.dart';

import '../lib/route/route.dart';

import '../lib/controller/navigationcontroller.dart';
import '../lib/controller/connectioncontroller.dart';

class KleakModule extends di.Module {
  KleakModule() {
    type(NavigationController);
    type(ConnectionController);
    
    type(TitleBar);
    type(ConnectionForm);
    
    value(angular.RouteInitializerFn, MyRouteInitializer);
    factory(angular.NgRoutingUsePushState, (_) => new angular.NgRoutingUsePushState.value(false));
  }
}

void main() {
  angular.ngBootstrap(module: new KleakModule());  
}
