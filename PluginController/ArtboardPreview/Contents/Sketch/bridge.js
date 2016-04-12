var _bridge = {};

_bridge.init = function(context) {
    this.context = context;
};


_bridge.imageFromSelection = function(context) {
    var selectedLayers = context.selection;
    var selectedCount = selectedLayers.count();

    if (selectedCount == 0) {
        log('No layers are selected.');
    } else {
        log('Selected layers:');
        for (var i = 0; i < selectedCount; i++) {
            var layer = selectedLayers[i];
            log((i+1) + '. ' + layer.name());
        }
        var flattener = MSLayerFlattener.alloc().init();

        var array = MSLayerArray.arrayWithLayers(selectedLayers);
        var page = context.document.currentPage().cachedImmutableModelObject();
        var image = flattener.imageFromLayers_immutablePage_(array, page);
        log("image: " + image);
        return image;
    }
};

_bridge.imageFromLayer = function(layer) {
    var flattener = MSLayerFlattener.alloc().init();

    var array = MSLayerArray.arrayWithLayer(layer);
    var page = layer.parentPage().cachedImmutableModelObject();
    var image = flattener.imageFromLayers_immutablePage_(array, page);
    log("image: " + image);
    return image;
}