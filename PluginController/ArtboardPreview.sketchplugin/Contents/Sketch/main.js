@import 'helper.js'

var openWindow = function(context) {

    log("Open Window Started");
    context.document.showMessage("Open Window Started2");
    if ( ! classExists("ArtboardPreviewController")) {
        // context.document.showMessage("framework loading... " + root + "/Contents/Sketch" );
        log("don't have ArtboardPreviewController");
        var loaded = loadFramework("ArtboardPreview", "/Contents/Sketch");
        log("finish loading " + loaded);
        context.document.showMessage("framework loaded ");

    } else {
      log("framework loaded ");
      context.document.showMessage("framework loaded ");
    }

    if ( ! classExists("ArtboardPreviewController")) {
      context.document.showMessage("Class Still Doesnt Exists");
      return;
    }

    context.shouldKeepAround = true;
    var controller = ArtboardPreviewController.alloc().init()
    controller.context = context;
    // log("controller.string ", controller.string());
    controller.launch()
    context.document.showMessage("controller initalized");

    NSThread.mainThread().threadDictionary().setObject_forKey_(controller, "artboardpreview");
    log(NSThread.mainThread().threadDictionary().objectForKey("artboardpreview"));
}
