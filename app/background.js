
chrome.app.runtime.onLaunched.addListener(function(data) {
  chrome.app.window.create('index.html',
    {id: 'Kleak', frame: "none", minWidth: 320, minHeight: 600},
    function(app_win) {
      app_win.contentWindow.__RESTART__ = false;
    }
  );
  console.log('app launched');
});

chrome.app.runtime.onRestarted.addListener(function() {
  chrome.app.window.create('index.html',
    {id: 'Kleak', frame: "none", minWidth: 320, minHeight: 600},
    function(app_win) {
      app_win.contentWindow.__RESTART__ = true;
    }
  );
  console.log('app restarted');
});