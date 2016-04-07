@import 'helper.js'

function run(context) {
    if ( ! classExists("Plugin")) {
        if (loadFramework("PluginHelper", "/Contents/Sketch")) {
            log("successfully load PluginHelper.framework");
        }
    }
    
    var bundle = loadBundle("", "");
    log(bundle)
    log([Plugin pluginWithBundle:bundle]);
    log([MyClass new]);
}
