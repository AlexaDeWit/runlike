from tiled import *
from string import Template


class HaskellExport(Plugin):

    tileItemTemplate = Template('${prefix}${body}')
    backgroundItems = [
            "Grass", "Snow", "Rocks", "Water", "Dirt"
            ]
    foregroundItems = [
            "Cedar", "Deciduous", "Bush", "Flowers",
            "Plants", "Weeds", "Cactus", "Rocks"
            ]
    movementTileDefinitions = [
            "[]", "[Walk, Fly]", "[Fly]", "[Fly, Swim]"
            ]

    @classmethod
    def nameFilter(cls):
        return "Haskell maps (*.hs)"

    @classmethod
    def shortName(cls):
        return "Haskell Exporter"

    @classmethod
    def backgroundLayerComponent(cls, tile):
        if tile is None:
            return cls.backgroundItems[0]
        idNum = tile.id()
        if idNum < len(cls.backgroundItems):
            return cls.backgroundItems[idNum]
        else:
            return cls.backgroundItems[0]

    @classmethod
    def foregroundLayerComponent(cls, tile):
        if tile is None:
            return "Nothing"
        idNum = tile.id()
        if idNum < len(cls.foregroundItems):
            return '( Just ' + cls.foregroundItems[idNum] + ' )'
        else:
            return "Nothing"

    @classmethod
    def movementLayerComponent(cls, tile):
        if tile is None:
            return "[]"
        idNum = tile.id()
        if idNum < len(cls.movementTileDefinitions):
            return cls.movementTileDefinitions[idNum]
        else:
            return '[]'

    @classmethod
    def characterLayerComponent(cls, tile):
        return "Nothing"

    @classmethod
    def objectLayerComponent(cls, tile):
        if tile is None:
            return "[]"
        idNum = tile.id()
        indices = []
        return indices[idNum] if idNum < len(indices) else "[]"

    @classmethod
    def tilestackToHaskellTile(cls, tileMap, x, y):
        return ''

    @classmethod
    def hasAllNeededTileLayers(cls, tileMap, requiredLayers):
        neededLayerNumbers = range(0, requiredLayers)
        if all(isTileLayerAt(tileMap, index) for index in neededLayerNumbers):
            backgroundLayer = tileLayerAt(tileMap, requiredLayers)
            for layerNumber in range(1, 5):
                layer = tileLayerAt(tileMap, layerNumber)
                if(layer.width() != backgroundLayer.width()
                        or layer.height() != backgroundLayer.height()):
                            return False
            return True
        return False

    @classmethod
    def write(cls, tileMap, fileName):
        requiredLayers = 5
        with open(fileName, 'w') as fileHandle:
            if cls.hasAllNeededTileLayer(cls, tileMap, requiredLayers):
                backgroundTileLayer = tileLayerAt(tileMap, 0)
                textLines = []
                for y in range(backgroundTileLayer.height()):
                    for x in range(backgroundTileLayer.width()):
                        prefix = '    [ ' if x == 0 else '    , '
                        textLines.append(
                            cls.tileItemTemplate.substitute(
                                prefix=prefix,
                                body=cls.tilestackToHaskellTile(
                                    cls, tileMap, x, y
                                )
                            ))
                    textLines.append('    ]')
                for line in textLines:
                    print >>fileHandle, line
