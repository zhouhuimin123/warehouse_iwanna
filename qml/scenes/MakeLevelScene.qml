import Felgo 3.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:makeLevelScene

    signal playPressed
    signal newLevelPressed

    // background
    Image {
        id:menu_bg
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/bg/menu_bg.WEBP"

    }


    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: makeLevelScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: makeLevelScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    Row{

        height: 30
        spacing: 5

        SelectTextButton {
            id: playGameButton

            screenText: "PlayGame"
            width: 80

            onClicked: playPressed()
        }

        SelectTextButton {
            id: newdLevelsButton

            screenText: "Created +"
            width: 80

            onClicked: newLevelPressed()
        }
    }



}

