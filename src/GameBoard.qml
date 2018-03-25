import QtQuick 2.0

Rectangle {
    color: "#008000"
    width: 800
    height: 800
    property int gameState:0

    Text {
        id: won
        visible: false
        text: "Congratulations"
    }

    Text {
        id: lost
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
