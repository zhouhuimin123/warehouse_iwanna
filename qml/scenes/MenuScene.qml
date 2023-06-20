import Felgo 3.0
import QtQuick 2.0
import "../common"


SceneBase {
    id: menuScene

    // signal indicating that the selectLevelScene should be displayed
    signal playPressed
    // signal indicating that the creditsScene should be displayed
    signal makeLevelPressed

    // background
    Image {
        id: menu_bg
        source: "../../assets/bg/menu_bg.WEBP"
    }
    // the "logo"
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        font.pixelSize: 50
        color: "white"
        text: "I W A N N A"
    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 10
        MenuButton {
            text: "PlayGame"
            color: "white"
            onClicked: playPressed()
            opacity: 0.9

        }
        MenuButton {
            text: "MakeLevel"
            color: "white"
            onClicked: makeLevelPressed()
            opacity:0.9
        }
    }

    // a little Felgo logo is always nice to havCreditse, right?
    Image {
        source: "../../assets/img/felgo-logo.png"
        width: 60
        height: 60
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 10
    }
}
