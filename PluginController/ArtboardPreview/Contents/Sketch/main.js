@import 'helper.js'
@import 'bridge.js'

var openWindow = function(context) {

//    _bridge.init(context);

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
    var controller = ArtboardPreviewController.alloc().init();
     log("controller.string " + controller);

    var image = _bridge.imageFromSelection(context);
    log("image: ", image);
//    controller.launchWithImage(image);
//    log("2");
//
//    context.document.showMessage("controller initalized");

    log("3");
//    NSThread.mainThread().threadDictionary().setObject_forKey_(controller, "artboardpreview" + NSDate.date());
//    log("thraed: " +  NSThread.mainThread().threadDictionary().objectForKey("artboardpreview"));
}
