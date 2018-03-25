import QtQuick 2.0

Rectangle {
    color: "#008000"
    visible: true
    implicitWidth: 240/3*15+20
    implicitHeight: 330/3*8+20

    property int gameState:0

    Text {
        id: won
        anchors.centerIn:parent
        visible: false
        text: "Congratulations"
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignLeft
        clip: false
        font.pointSize: 60
        color: "#0500ff"
    }

    Text {
        id: lost
        anchors.centerIn:parent
        visible: false
        text: "You lost"
        font.pointSize: 60
        color: "red"
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
