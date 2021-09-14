import QtQuick 2.0

Rectangle {
    color: "#008000"
    visible: true
    implicitWidth: 1920/3*15+20
    implicitHeight: 1080/3*8+20

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

        Behavior on visible {
            SequentialAnimation {
               // PropertyAction { target: won; property: "visible"; value: visible }
                ParallelAnimation {
                    NumberAnimation { target: won; property: "opacity"; from: 0.; to: 1.0; duration: 1000 }
                    NumberAnimation { target: won; property: "font.pointSize"; from: 1.; to: 60.0; duration: 1000}
                    NumberAnimation { target: won; property: "rotation"; from: 0.; to: 360; duration: 1000}
                }
            }
        }
    }



    Text {
        id: lost
        anchors.centerIn:parent
        visible: false
        text: "You lost"
        font.pointSize: 60
        color: "red"
        Behavior on visible {
            SequentialAnimation {
               // PropertyAction { target: won; property: "visible"; value: visible }
                ParallelAnimation {
                    NumberAnimation { target: lost; property: "opacity"; from: 0.; to: 1.0; duration: 1000 }
                    NumberAnimation { target: lost; property: "font.pointSize"; from: 1.; to: 60.0; duration: 1000}

                }
            }
        }

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
