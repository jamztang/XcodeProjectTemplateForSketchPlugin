var scriptPath = coscript.env().scriptURL.path()+""

var root = 	(function(){
             var NSScriptPath = NSString.stringWithString(scriptPath);

             while(NSScriptPath.lastPathComponent().pathExtension() != "sketchplugin"){
             NSScriptPath = NSScriptPath.stringByDeletingLastPathComponent();
             }

             return NSScriptPath+"";
             })();

var installPath = (function() {
                   var appSupportPath = NSFileManager.defaultManager().URLsForDirectory_inDomains(NSApplicationSupportDirectory,NSUserDomainMask).firstObject().path();
                   var pluginFolderPath = appSupportPath.stringByAppendingPathComponent("com.bohemiancoding.sketch3/Plugins")
                   return pluginFolderPath;
                   })();

var loadFramework = function(name, dir) {
    var mocha = Mocha.sharedRuntime();
    var success = [mocha loadFrameworkWithName:name inDirectory:(root + dir)];
    return success
}

var classExists = function(name) {
    return NSClassFromString(name) != null;
}
