from tiled import *

class HaskellExport(Plugin):
    @classmethod
    def nameFilter(cls):
        return "Haskell maps (*.hs)"

    @classmethod
    def shortName(cls):
        return "Haskell Exporter"
        
    @classmethod
    def backgroundLayerComponent(cls, tile):
        if tile is None:
            return "Grass"
        idNum = tile.id()
        indices = ["Grass", "Snow", "Dirt", "Sand", "Water", "Ice", "Rocks", "Mud"]
        return indices [idNum] if idNum < len(idices) else "Grass"
        
    @classmethod
    def foregroundLayerComponent(cls, tile):
        if tile is None:
            return "Nothing" 
        idNum = tile.id()
        indices = ["Cedar", "Deciduous", "Bush", "Flowers", "Plants", "Weeds", "Cactus", "Rocks"]
        return '( Just ${indices[idNum]} )' if idNum < len(indices) else "Nothing"
        
    @classmethod
    def tilestackToHaskellTile(cls, tileMap, x, y):
      return ''
      
    @classmethod
    def hasAllNeededTileLayers(cls, tileMap, requiredLayers):
        neededLayerNumbers = range(0, requiredLayers)
        if all(isTileLayerAt(tileMap, index) for index in neededLayerNumbers):
            backgroundLayer = tileLayerAt(tileMap, requiredLayers)
            for layerNumber in range(1,5):
                layer = tileLayerAt(tileMap, layerNumber)
                if(layer.width() != backgroundLayer.width() or layer.height() != backgroundLayer.height()):
                    return False
            return True
        return False
        
        
    @classmethod
    def write(cls, tileMap, fileName):
        requiredLayers = 5
        with open(fileName, 'w') as fileHandle:
            if hasAllNeededTileLayer(cls, tileMap, requiredLayers):
                backgroundTileLayer = tileLayerAt(tileMap, 0)
                textLines = []
                for y in range(backgroundTileLayer.height()):
                    for x in range(backgroundTileLayer.width()):
                        prefix = '    [ ' if x == 0 else '    , '
                        textLines.append('${prefix}${cls.tilestackToHaskellTile(cls, tileMap, x, y)}')
                    textLines.append('    ]')
                for line in textLines:
                    print >>fileHandle, line


