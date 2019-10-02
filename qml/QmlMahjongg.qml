import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import "GameLogic.js" as Logic

ApplicationWindow {
    id: appWindow
    title: "Mahjongg"
    width: root.width
    height: root.height

    //@bug Menu is not displayed? Why?

    ColumnLayout {
        id:layout
        anchors.fill:parent
        Component.onCompleted: { 
      
                Logic.initGamePieces(gameBoard)
                Logic.createBoard()
            
        }
//        Button {
//            id: test
//            text: "Test"
//            onClicked: {
//                gameBoard.gameState=(gameBoard.gameState+1)%3
//            }
//        }

        Rectangle {
         Image {
    anchors.fill:parent
    source: "wood.jpg"
}
            GameBoard {
                id: gameBoard
                anchors.centerIn: parent
                 Rectangle {
    z:10009969984
 anchors.centerIn:parent
    width: 2000
    height: 2000
        color: "#10000000"

    }
     Rectangle {
    z:2*10000000-1000*30-16+10000000000
 anchors.centerIn:parent
    width: 2000
    height: 2000
        color: "#10000000"

    }
     Rectangle {
    z:3*10000000-1000*30-16+10000000000
 anchors.centerIn:parent
    width: 2000
    height: 2000
        color: "#10000000"

    }
     Rectangle {
    z:4*10000000-1000*30-16+10000000000
    anchors.centerIn:parent
    width: 2000
    height: 2000
        color: "#10000000"

    }
            }
            Layout.minimumWidth: gameBoard.implicitWidth
            Layout.minimumHeight: gameBoard.implicitHeight
            Layout.fillWidth: true
            Layout.fillHeight: true
            //implicitHeight: gameBoard.implicitHeight
            //implicitWidth: gameBoard.implicitWidth
        }


    }

}
