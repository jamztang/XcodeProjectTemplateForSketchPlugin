@import 'SketchLibrary.js'

var root = $.paths.pluginPath

// e.g. loadBundle("Plugin.bundle", "/Contents/Sketch/")
var loadBundle = function(name, dir) {
    return $.runtime.loadBundle(root + dir + "/" + name);
}

// e.g. loadFramework("Plugin.framework", "/Contents/Sketch/")
var loadFramework = function(name, dir) {
    return $.runtime.loadFramework(name, root + dir);
}

var classExists = function(name) {
    return $.runtime.classExists(name);
}