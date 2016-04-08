var codeToRun = "log('Hello')"
var sketchApp = COScript.app("Sketch")
sketchApp.delegate().runPluginScript_name(codeToRun, "coscript Demo")
