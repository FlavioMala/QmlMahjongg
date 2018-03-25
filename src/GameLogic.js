var defaultBoard={
    w:30,
    h:16,
    d:5,
    config:[
        "\
..121212121212121212121212....\
..434343434343434343434343....\
......1212121212121212........\
......4343434343434343........\
....12121212121212121212......\
....43434343434343434343......\
..121212121212121212121212....\
124343434343434343434343431212\
431212121212121212121212124343\
..434343434343434343434343....\
....12121212121212121212......\
....43434343434343434343......\
......1212121212121212........\
......4343434343434343........\
..121212121212121212121212....\
..434343434343434343434343....",
"\
..............................\
..............................\
........121212121212..........\
........434343434343..........\
........121212121212..........\
........434343434343..........\
........121212121212..........\
........434343434343..........\
........121212121212..........\
........434343434343..........\
........121212121212..........\
........434343434343..........\
........121212121212..........\
........434343434343..........\
..............................\
..............................",
"\
..............................\
..............................\
..............................\
..............................\
..........12121212............\
..........43434343............\
..........12121212............\
..........43434343............\
..........12121212............\
..........43434343............\
..........12121212............\
..........43434343............\
..............................\
..............................\
..............................\
..............................",
        "\
..............................\
..............................\
..............................\
..............................\
..............................\
..............................\
............1212..............\
............4343..............\
............1212..............\
............4343..............\
..............................\
..............................\
..............................\
..............................\
..............................\
..............................",
"\
..............................\
..............................\
..............................\
..............................\
..............................\
..............................\
..............................\
.............12...............\
.............43...............\
..............................\
..............................\
..............................\
..............................\
..............................\
..............................\
..............................\
"    ]
}

var gameConfig=[/*
            {x:2,y:0,z:0,piece:2,gamepiece:null,isRemoved:false},
            {x:4,y:4,z:0,piece:2,gamepiece:null,isRemoved:false},
            {x:8,y:6,z:0,piece:3,gamepiece:null,isRemoved:false},
            {x:10,y:6,z:0,piece:4,gamepiece:null,isRemoved:false},
            {x:12,y:6,z:0,piece:4,gamepiece:null,isRemoved:false},
            {x:14,y:6,z:0,piece:3,gamepiece:null,isRemoved:false},
            {x:2,y:0,z:0,piece:9,gamepiece:null,isRemoved:false},
            {x:4,y:4,z:0,piece:9,gamepiece:null,isRemoved:false},
*/
        ]

var gamepieces=[]

// Must be called only once
function initGamePieces(container) {
    if (gamepieces.length>0) return
    for (var i=0; i<144; i++) {
        var gamePiece=createGamePiece(container)
        gamepieces.push(gamePiece)
        gamePiece.clicked.connect(gamePieceClicked)
    }
}

function shuffle(array) {
  var currentIndex = array.length, temporaryValue, randomIndex;

  // While there remain elements to shuffle...
  while (0 !== currentIndex) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}

function readBoard(ids) {
    var idIndex=0
    for (var d=0; d<defaultBoard.config.length; d++) {
        var str=defaultBoard.config[d]
        for (var r=0; r<defaultBoard.h; r++) {
            for (var c=0; c<defaultBoard.w; c++) {
                var index=r*defaultBoard.w+c
                if (str[index]==='1') {
                    //{"xPos":piece.x,"yPos":piece.y,"zPos":piece.z,"pieceId":piece.piece, "isRemoved":piece.isRemoved, "number":index}
                    var pieceConfig={x:c, y:r, z:d, piece:ids[idIndex],gamepiece:gamepieces[idIndex], isRemoved:false};
                    gamepieces[idIndex].xPos=pieceConfig.x
                    gamepieces[idIndex].yPos=pieceConfig.y
                    gamepieces[idIndex].zPos=pieceConfig.z
                    gamepieces[idIndex].pieceId=pieceConfig.piece
                    gamepieces[idIndex].isRemoved=pieceConfig.isRemoved
                    gamepieces[idIndex].number=idIndex

                    gameConfig.push(pieceConfig)
                    idIndex++
                }
            }
        }
    }
}

function createIds() {
    var ids=[]
    for (var i=1; i<=36; i++) {
        ids=ids.concat([i,i,i,i]);
    }
    return ids;
}

function createBoard(container) {
    gameConfig=[]
    var randomIds=shuffle(createIds())
    readBoard(randomIds)

}

var previousSelectedPiece=-1

function blockedByAdjacentPieces(index) {
    var myPiece=gameConfig[index]
    var nonRemoved=gameConfig.filter(function(gamePiece) { return !gamePiece.isRemoved && Math.abs(gamePiece.y-myPiece.y)<=1; })
    var hasLeft=nonRemoved.filter(  function(gamePiece) { return gamePiece.x===myPiece.x-2 && gamePiece.z===myPiece.z }).length>0
    var hasRight=nonRemoved.filter( function(gamePiece) { return gamePiece.x===myPiece.x+2 && gamePiece.z===myPiece.z }).length>0
    var hasOnTop=nonRemoved.filter( function(gamePiece) { return gamePiece.z>myPiece.z && Math.abs(gamePiece.x-myPiece.x)<=1; }).length>0
    console.log(hasLeft,hasRight,hasOnTop)
    if (hasOnTop) return true
    if (hasLeft && hasRight) return true
    return false
}

function setPreviousSelection(index) {
    if (previousSelectedPiece!=-1) {
        gameConfig[previousSelectedPiece].gamepiece.isSelected=false
    }
    previousSelectedPiece=index
    if (previousSelectedPiece!=-1) {
        gameConfig[previousSelectedPiece].gamepiece.isSelected=true
    }

}

function isGameWon() {
    return gameConfig.filter(function(gamePiece) { return !gamePiece.isRemoved }).length===0
}

function isGameLost() {
    var selectableGamePieces=[]
    for (var index1 in gameConfig) {
        if (!isSelectableGamePiece(index1)) continue
        selectableGamePieces.push(gameConfig[index1])
    }
    var ids=selectableGamePieces.map(function(piece){ return piece.piece})
    ids=ids.sort()
    while (ids.length>0) {
        if (ids[0]===ids[1]) return false
        ids.shift()
        ids.shift()
    }
    return true
}

function arePiecesEqual(index1, index2) {
    return gameConfig[index1].piece===gameConfig[index2].piece
}

function removePiece(index) {
    gameConfig[index].isRemoved=true
    gameConfig[index].gamepiece.isRemoved=true
}

function removePieces(index1, index2) {
    if (!arePiecesEqual(index1,index2)) return false
    removePiece(index1)
    removePiece(index2)
    setPreviousSelection(-1)
}

function isSelectableGamePiece(index) {
    if (index<0) return false
    if (index>=gameConfig.length) return false
    var gamePiece=gameConfig[index]
    if (gamePiece.isRemoved) return false
    if (blockedByAdjacentPieces(index)) return false
    return true
}

function gamePieceClicked(index) {
    console.log("Game piece clicked"+index)
    console.log(gameConfig.length)
    if (!isSelectableGamePiece(index)) return
    if (previousSelectedPiece==-1) {
        // Noch kein Stein gewählt
        setPreviousSelection(index)
    } else if (previousSelectedPiece===index) {
        // Deselectieren
        setPreviousSelection(-1)
    } else {
        // Wenn beide Steine gleich, dann entfernen
        removePieces(previousSelectedPiece,index)
        if (isGameWon()) {
            gameBoard.gameState=1
        } else if (isGameLost()) {
            gameBoard.gameState=2
        } else {
            gameBoard.gameState=0
        }
    }

    console.log("IsSelectable")
}

//function addPiece(container, index) {
//    var piece=gameConfig[index]
//    var component = Qt.createComponent("GamePiece.qml");
//    if (component.status == Component.Ready) {
//        return component.createObject(container,{"xPos":piece.x,"yPos":piece.y,"zPos":piece.z,"pieceId":piece.piece, "isRemoved":piece.isRemoved, "number":index});
//    }
//}

function createGamePiece(container) {
    var component = Qt.createComponent("GamePiece.qml");
    if (component.status == Component.Ready) {
        return component.createObject(container);
    }
}
