from tiled import *
from string import Template


class HaskellExport(Plugin):

    @classmethod
    def fileHeader(cls, fileName):
        name = fileName.split('/')[-1].split('.')[0]
        moduleLine = 'module Maps.' + name + ' where'
        imports = [
            '',
            '',
            'import         Data.Array',
            'import         Data.Map        (fromList)',
            'import         Types.GameMap',
            'import         Types.Tile',
            'import         Types.Character',
            '',
            ''
        ]
        definitions = [
            'map :: GameMap',
            'map =',
            '  GameMap {'
        ]
        return [moduleLine] + imports + definitions

    @classmethod
    def fileFooter(cls, fileName):
        closings = [
            '  }'
        ]
        return closings

    BACKGROUND_LAYER = 'Background'
    FOREGROUND_LAYER = 'Foreground'
    OBJECTS_LAYER = 'Objects'
    CHARACTER_LAYER = 'Character'
    MOVEMENT_LAYER = 'Movement'

    tileLayerIndices = {
            BACKGROUND_LAYER: 0,
            FOREGROUND_LAYER: 1,
            MOVEMENT_LAYER: 2,
            OBJECTS_LAYER: 4,
            CHARACTER_LAYER: 3
        }

    tileItemTemplate = Template('${prefix}${body}')

    backgroundItems = [
            "Grass", "Snow", "Rocky", "Water", "Dirt"
            ]
    foregroundItems = [
            "Weeds", "Bush", "Rocks", "Tree"
            ]
    movementTileDefinitions = [
            "[]", "[Walk, Fly]", "[Fly]", "[Fly, Swim]"
            ]

    characterTileDefinitions = [
        "rat", "direRat"
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
    def tilestackToHaskellTile(cls, tileMap, x, y):
        backgroundTileLayer = tileLayerAt(
                tileMap, cls.tileLayerIndices.get(cls.BACKGROUND_LAYER)
                )
        foregroundTileLayer = tileLayerAt(
                tileMap, cls.tileLayerIndices.get(cls.FOREGROUND_LAYER)
                )
        movementTileLayer = tileLayerAt(
                tileMap, cls.tileLayerIndices.get(cls.MOVEMENT_LAYER)
                )
        bgPart = cls.backgroundLayerComponent(
                backgroundTileLayer.cellAt(x, y)
                .tile())
        fgPart = cls.foregroundLayerComponent(
                foregroundTileLayer.cellAt(x, y)
                .tile())
        mvPart = cls.movementLayerComponent(
                movementTileLayer.cellAt(x, y)
                .tile())
        return '((' + str(x).rjust(3) + ', ' + str(y).rjust(3) + '), Tile    ' + bgPart.ljust(10) + ' ' + fgPart.ljust(15) + ' ' + mvPart.ljust(15) + ')'

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
    def tileArrayLines(cls, tileMap, backgroundTileLayer):
        lines = ['    tiles =']
        lines.append('      array ((0,0),(' + str(backgroundTileLayer.width() - 1) + ',' + str(backgroundTileLayer.height() - 1) + '))')
        for y in range(backgroundTileLayer.height()):
            for x in range(backgroundTileLayer.width()):
                prefix = '        [ ' if x == 0 and y == 0 else '        , '
                lines.append(
                    cls.tileItemTemplate.substitute(
                        prefix=prefix,
                        body=cls.tilestackToHaskellTile(
                            tileMap, x, y
                        )
                    ))
        lines.append('        ]')
        return lines

    @classmethod
    def characterMapLines(cls, tileMap):
        charactersLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(cls.CHARACTER_LAYER))
        lines = ['    , characters =']
        lines.append('      fromList')
        itemLines = []
        openArray = '        ['
        for y in range(charactersLayer.height()):
            for x in range(charactersLayer.width()):
                prefix = openArray if len(itemLines) == 0 else '        , '
                tile = charactersLayer.cellAt(x, y).tile()
                if tile is not None:
                    print(tile.id())
                    itemLines.append(prefix + str(cls.characterTileDefinitions[tile.id()]))
        if len(itemLines) == 0:
            itemLines.append(openArray)
        lines = lines + itemLines
        lines.append('        ]')
        return lines



    @classmethod
    def write(cls, tileMap, fileName):
        with open(fileName, 'w') as fileHandle:
            if cls.hasAllNeededTileLayers(tileMap):
                backgroundTileLayer = tileLayerAt(tileMap, cls.tileLayerIndices.get(cls.BACKGROUND_LAYER))
                # Header
                textLines = cls.fileHeader(fileName)
                # Body
                textLines += cls.tileArrayLines(tileMap, backgroundTileLayer)
                textLines += cls.characterMapLines(tileMap)
                # Footer
                textLines = textLines + cls.fileFooter(fileName)
                for line in textLines:
                    print >>fileHandle, line
        return True
