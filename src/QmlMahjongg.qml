import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import "GameLogic.js" as Logic

ApplicationWindow {
    id: appWindow
    title: "Mahjongg"
    width: layout.implicitWidth
    height: layout.implicitHeight

    //@bug Is not displayed? Why?
    menuBar: MenuBar {
        Menu {
            title: "File"
            MenuItem {
                text: "New"
                onTriggered: {
                }
            }
            MenuItem {
                text: "Quit"
                onTriggered: appWindow.close();
            }
        }
    }
    ColumnLayout {
        id:layout
        anchors.fill:parent
        Button {
            id: newGame
            text: "New Game"
            onClicked: {
                console.log(gameBoard.centeredGame)
                Logic.createBoard(gameBoard)
            }
        }
        Rectangle {
            GameBoard {
                id: gameBoard
                anchors.centerIn: parent
            }
            implicitHeight: gameBoard.implicitHeight
            implicitWidth: gameBoard.implicitWidth
        }


    }

}
