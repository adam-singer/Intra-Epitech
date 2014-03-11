library cachemanager;

import 'dart:async';

import 'package:chrome/chrome_app.dart' as chrome;

class CacheManager {
  CacheManager();
  
  static Future get([dynamic key]) {
    Completer completer = new Completer();
    chrome.storage.local.get(key != null ? key : null).then((Map data) {
      completer.complete(data);
    });
    return completer.future;
  }
  
  static Future set(Map<String, dynamic> items) {
    Completer completer = new Completer();
    chrome.storage.local.set(items).then((data) {
      completer.complete(data);
    });
    return completer.future;
  }
  
  static Future clear() {
    return chrome.storage.local.clear();
  }
}