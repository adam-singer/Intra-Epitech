library navigationcontroller;

import 'dart:html';

import 'package:chrome/chrome_app.dart' as chrome;
import 'package:angular/angular.dart';

import '../class/cachemanager.dart';

@NgController(
    selector: '[navigation-controller]',
    publishAs: 'navctrl'
)
class NavigationController {
  Scope           scope;
  NgRoutingHelper locationService;
  
  String  title = "Connexion";
  
  bool    rightisset = false;
  bool    leftisset = false;
  
  String  styleright;
  String  styleleft;
  
  Function right;
  Function left;
  
  void clickleft() {
    left();
  } 
  
  void clickright() {
    right(); 
  }
  
  NavigationController(this.scope, this.locationService) {
    print("load nav controller");
    scope.$on('go', (ScopeEvent scopeevent, data) {
      print(data);
      go(data);
    });
    
    chrome.sockets.tcp.create().then((data) {
      print(data);
    });
    
    if (chrome.storage.available) {
      CacheManager.get().then((Map map) {
        if (map.containsKey("user")) {
          go('home');
        } else {
          go('connexion');
        }
      }, onError: (e) {
        go('connexion');
      });
    } else {
      go('connexion');
    }
  }
  
  void go(String url) {
    switch (url) {
      case 'connexion':
        styleright = "close";
        right = close;
        left = null;
        leftisset = false;
        rightisset = true;
        Router router = locationService.router;
        router.go('connexion', {}, replace: true);
        title = "Connexion";
        break;
      case "home":
        styleleft = "read";
        left = openPanel;
        right = null;
        leftisset = true;
        rightisset = false;
        Router router = locationService.router;
        router.go('home', {}, replace: true);
        title = "Home";
        CacheManager.clear();
        break;
    }
  }
  
  void openPanel() {
    print("open panel");
  }
  
  void close() {
    window.close();  
  }
}