var sketchApp = COScript.app("Sketch")
var pluginURL = NSURL.fileURLWithPath("%@")
sketchApp.delegate().runPluginCommandWithIdentifier_fromBundleAtURL('runAsCommand',pluginURL)