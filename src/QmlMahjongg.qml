import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1
import "GameLogic.js" as Logic

ApplicationWindow {
    id: appWindow
    title: "Mahjongg"

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
                Logic.createBoard(gameBoard)
            }
        }

        GameBoard {
            id: gameBoard
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

    }
    width: 600
    height: 800
}
