library my_router;

import 'package:angular/angular.dart';

void MyRouteInitializer(Router router, ViewFactory views) {
//  views.configure({
//    'hello': ngRoute(
//          path: '/hello',
//          defaultRoute: true,
//          view: '/lib/views/hello.html'),
//    'goodbye': ngRoute(
//        path: '/goodbye',
//        view: '/lib/views/goodbye.html')
//  });
  
  router.root
    ..addRoute(
        name: 'connexion',
        path: '/connexion',
        enter: views('/lib/views/connection.html'))
    ..addRoute(
        name: 'home',
        path: '/home',
        enter: views('/lib/views/home.html'));
}