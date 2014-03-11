library connectioncontroller;

import 'dart:html';
import 'dart:convert';
import 'dart:async';

import 'package:angular/angular.dart';

import '../class/cachemanager.dart';
import '../class/user.dart';

@NgController(
    selector: '[connection-controller]',
    publishAs: 'cntctrl'
)
class ConnectionController {
  NgRoutingHelper locationService;
  Scope           scope;
  
  String  login;
  String  password;
  
  num  percentComplete;
  
  String  error;
  bool    iserror = false;
  String  errorclass;
  
  bool  loading = false;
  bool  cancalculate = false;
  
  ConnectionController(this.locationService, this.scope) {
    print("load connection controller");
    errorclass = "opacity0";
    if (!window.navigator.onLine)
      setError("Not connected to internet");
    window.onKeyDown.listen((evt) {
      switch (evt.keyCode) {
        case 13:
          connect();
          break;
      }
    });
  }
  
  void clearError() {
    iserror = false;
    error = null;
  }
  
  void changeErrorClass() {
    errorclass = "opacity0";
    new Timer(new Duration(seconds: 1), clearError);
  }
  
  void setError(String message) {
    errorclass = "opacity1";
    iserror = true;
    error = message;
    new Timer(new Duration(seconds: 10), changeErrorClass);
  }
  
  void connect() {
    if (!window.navigator.onLine) {
      setError("Not connected to internet");
    } else if (login != null && password != null) {
      print("we have data");
      if (!loading) {
        loading = true;
        var url = "https://intra.epitech.eu/user/${login}/?format=json";
        Map mappedData = <String, String>{};
        mappedData["login"] = login;
        mappedData["password"] = password;
        HttpRequest.postFormData(url, mappedData, onProgress: (ProgressEvent evt) {
          if (evt.lengthComputable) {
            cancalculate = true;
            percentComplete = (evt.loaded / evt.total) * 100;
          }
        }).then((data) {
          switch (data.status) {
            case 200:
              String cleanStr = data.responseText.startsWith("// Epitech JSON webservice ...\n") ? data.responseText.substring("// Epitech JSON webservice ...\n".length) : data.responseText;
              var jsonMapped = JSON.decode(cleanStr);
              print(jsonMapped);
              User user = new User(jsonMapped["login"], jsonMapped["firstname"], jsonMapped["lastname"], jsonMapped["internal_email"],
                                    jsonMapped["location"],
                                    jsonMapped["promo"], jsonMapped["studentyear"], jsonMapped["semester"], jsonMapped["course_code"]);
              CacheManager.set({"user": user.toJson()}).then((data) {
                scope.$emit('go', ["home"]);
              });
              loading = false;
              break;
            case 403:
              String cleanStr = data.responseText.startsWith("// Epitech JSON webservice ...\n") ? data.responseText.substring("// Epitech JSON webservice ...\n".length) : data.responseText;
              var jsonMapped = JSON.decode(cleanStr);
              print(jsonMapped);
              password = "";
              setError(jsonMapped["message"]);
              loading = false;
              break;
          }
        }, onError: (e) {
          print("Error Future: ${e}");
          loading = false;
          setError("Impossible to connect you to the server, Maybe server is down. Retry later");
        });
      }
    } else {
      print("nothing to submit :(");
    }
  }
}







//var tabData = [];
//        mappedData.forEach((key, value) {
//          tabData.add("${Uri.encodeQueryComponent(key)}=""${Uri.encodeQueryComponent(value)}");
//        });
//        String data = tabData.join("&");
//        print(data);
//        var hr = new HttpRequest();
//        hr.open("POST", url, async: true);
//        Map requestHeaders = <String, String>{};
//        requestHeaders["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8";
//        if (requestHeaders != null) {
//          requestHeaders.forEach((header, value) {
//            hr.setRequestHeader(header, value);
//          });
//        }
//        requestHeaders.putIfAbsent('Content-Type', () => 'application/x-www-form-urlencoded; charset=UTF-8');
//        hr..onProgress.listen((ProgressEvent progevent) {
//            if (progevent.lengthComputable) {
//              cancalculate = true;
//              percentComplete = (progevent.loaded / progevent.total) * 100;
//            }
//          })
//          ..onError.listen((error) {
//            print(error);
//          })
//          ..onLoad.listen((_) {
//            if (hr.readyState == HttpRequest.DONE) {
//              switch (hr.status) {
//                case 200:
//                  String cleanStr = hr.responseText.startsWith("// Epitech JSON webservice ...\n") ? 
//                      hr.responseText.substring("// Epitech JSON webservice ...\n".length) : hr.responseText;
//                  var jsonMapped = JSON.decode(cleanStr);
//                  print(jsonMapped);
//                  User user = new User(jsonMapped["login"], jsonMapped["firstname"], jsonMapped["lastname"], jsonMapped["internal_email"],
//                                        jsonMapped["location"],
//                                        jsonMapped["promo"], jsonMapped["studentyear"], jsonMapped["semester"], jsonMapped["course_code"]);
//                  CacheManager.set({"user": user.toJson()}).then((data) {
//                    scope.$emit('go', ["home"]);
//                  });
//                  loading = false;
//                  break;
//                case 403:
//                  print("Forbiden !!");
//                  print(hr.responseText);
//                  loading = false;
//                  break;
//                default:
//                  print(hr.responseText);
//                  loading = false;
//                  break;
//              }
//            }
//          })
//          ..send(data);