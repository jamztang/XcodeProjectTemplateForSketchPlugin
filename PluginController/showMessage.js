var codeToRun = "context.document.showMessage('Hello, World!')"
var sketchApp = COScript.app("Sketch")
sketchApp.delegate().runPluginScript_name(codeToRun, "coscript Demo")