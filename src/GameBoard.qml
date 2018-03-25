import QtQuick 2.0

Rectangle {
    color: "#008000"
    implicitWidth: 240/3*30
    implicitHeight: 330/3*16

    property int gameState:0

    Text {
        id: won
        anchors.fill:parent
        visible: false
        text: "Congratulations"
    }

    Text {
        id: lost
        anchors.fill:parent
        visible: false
        text: "You lost"
    }

    onGameStateChanged: {
        if (gameState==0) {
            won.visible=false;
            lost.visible=false;
        } else if (gameState==1) {
            won.visible=true
            lost.visible=false
        } else if (gameState==2) {
            won.visible=false
            lost.visible=true
        }
    }

}
