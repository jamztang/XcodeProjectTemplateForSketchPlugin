var _bridge = {};

_bridge.init = function(context) {
    this.context = context;
};

_bridge.imageFromLayer = function(context, layer) {
    var flattener = MSLayerFlattener.alloc().init();

    var array = MSLayerArray.arrayWithLayer(layer);
    var page = layer.parentPage().cachedImmutableModelObject();
    var image = nil;

    try {
        // Sketch Hamburg
        var doc = context.document.immutableDocumentData()  // can't do on 3.7??
        image = flattener.imageFromLayers_immutablePage_immutableDoc_(array, page, doc);
    } catch(err) {
        // Sketch 3.6.1
        image = flattener.imageFromLayers_immutablePage(array, page);
    }
    log("image: " + image);
    return image;
}