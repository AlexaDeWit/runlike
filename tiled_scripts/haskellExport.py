from tiled import *
from string import Template


class HaskellExport(Plugin):

    @classmethod
    def fileHeader(cls, fileName):
        return '''
        '''

    @classmethod
    def fileFooter(cls, fileName):
        return '''
        '''

    BACKGROUND_LAYER = 'Background'
    FOREGROUND_LAYER = 'Foreground'
    OBJECTS_LAYER = 'Objects'
    CHARACTER_LAYER = 'Character'
    MOVEMENT_LAYER = 'Movement'

    tileLayerIndices = {
            BACKGROUND_LAYER: 0,
            FOREGROUND_LAYER: 1,
            MOVEMENT_LAYER: 2,
            OBJECTS_LAYER: 3,
            CHARACTER_LAYER: 4
        }

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
        backgroundTileLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(cls.BACKGROUND_LAYER))
        foregroundTileLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(cls.FOREGROUND_LAYER))
        objectsTileLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(cls.OBJECTS_LAYER))
        movementTileLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(cls.MOVEMENT_LAYER))
        characterTileLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(cls.CHARACTER_LAYER))
        bgPart = cls.backgroundLayerComponent(
                backgroundTileLayer.cellAt(x, y)
                .tile())
        fgPart = cls.foregroundLayerComponent(
                foregroundTileLayer.cellAt(x, y)
                .tile())
        ojPart = cls.objectLayerComponent(
                objectsTileLayer.cellAt(x, y)
                .tile())
        chrPart = cls.characterLayerComponent(
                characterTileLayer.cellAt(x, y)
                .tile())
        mvPart = cls.movementLayerComponent(
                movementTileLayer.cellAt(x, y)
                .tile())
        return ('Tile ' + bgPart + ' ' + fgPart + ' ' + mvPart + ' ' + ojPart +
                ' ' + chrPart)

    @classmethod
    def hasAllNeededTileLayers(cls, tileMap):
        if not isTileLayerAt(tileMap, cls.tileLayerIndices.get(cls.BACKGROUND_LAYER)):
            return False
        backgroundLayer = tileLayerAt(
                tileMap,
                cls.tileLayerIndices.get(cls.BACKGROUND_LAYER)
                )
        for layerConfigKey in cls.tileLayerIndices.keys():
            if not isTileLayerAt(tileMap, cls.tileLayerIndices.get(layerConfigKey)):
                return False
            currLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(layerConfigKey))
            if(currLayer.width() != backgroundLayer.width()
                    or currLayer.height() != backgroundLayer.height()):
                    return False
        return True

    @classmethod
    def write(cls, tileMap, fileName):
        with open(fileName, 'w') as fileHandle:
            if cls.hasAllNeededTileLayers(tileMap):
                backgroundTileLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(cls.BACKGROUND_LAYER))
                textLines = [cls.fileHeader(fileName)]
                for y in range(backgroundTileLayer.height()):
                    for x in range(backgroundTileLayer.width()):
                        prefix = '    [ ' if x == 0 else '    , '
                        textLines.append(
                            cls.tileItemTemplate.substitute(
                                prefix=prefix,
                                body=cls.tilestackToHaskellTile(
                                    tileMap, x, y
                                )
                            ))
                    textLines.append('    ]')
                textLines.append(cls.fileFooter(fileName))
                for line in textLines:
                    print >>fileHandle, line
        return True
