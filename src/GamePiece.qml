import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    property bool isSelected:false
    property bool isRemoved:false
    property int zPos:0
    property int xPos:0
    property int yPos:0
    property int number:-1
    property int pieceId:-1

    signal clicked(int number)

    width: 240/3
    height: 330/3
    z:zPos*10000000-1000*xPos-yPos+10000000000
    x:xPos*width/2+zPos*33/3+33/3
    y:yPos*height/2+zPos*33/3+33/3
    color:"transparent"

    Image {
        id: bevel
        source:"gamepieces/Bevel.png"
        antialiasing:  true
        smooth: true
        height: sourceSize.height/3
        x:-33/3
        y:-33/3
        width: sourceSize.width/3
    }
    Colorize {
        visible: isSelected
        anchors.fill: bevel
        source: bevel
        hue: 0.0
        saturation: 0.5
        lightness: -0.2
    }

    Image {
        id: pieceImage
        source:"gamepieces/1.png"
        antialiasing: true
        smooth:true
        height: parent.height
        width: parent.width
    }
    Colorize {
        visible: isSelected
        anchors.fill: pieceImage
        source: pieceImage
        hue: 0.0
        saturation: 0.5
        lightness: -0.2
    }

    onPieceIdChanged: {
        if (pieceId<1) return
        if (pieceId>36) return
        pieceImage.source="gamepieces/"+pieceId+".png"
    }

    onIsRemovedChanged: {
        if (isRemoved) {
            visible=false
        } else {
            visible=true
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.clicked(number)
            //parent.isSelected=!parent.isSelected
        }
    }
}
