import QtQuick 2.0
import QtQuick.Controls.Styles 1.0
import Felgo 3.0

GameButton {
  id: textButton

  width: screenText.width + 20
  height: 30

  // background color
  property color color: "#ffffff"

  // we use screenText instead of the GameButton text property,
  // because the existing text property causes bad fonts
  property alias screenText: screenText.text

  // alias to access the text color
  property alias textColor: screenText.color

  // we override the default Felgo style with our own
  style: ButtonStyle {
    background: Rectangle {
      border.width: 1
      border.color: "black"
      radius: 3

      // add a gradient as background
      gradient: Gradient {
        // take color as the first color
        GradientStop { position: 0.0; color: textButton.color }
        // tint color, to make it a little darker and use it as second color
        GradientStop { position: 1.0; color: Qt.tint(textButton.color, "#24000000") }
      }
    }
  }

  onClicked: audioManager.playSound("click")

  // text displayed in the button
  Text {
    id: screenText

    anchors.centerIn: parent

    font.pixelSize: 12
  }

  // this white rectangle covers the button when the mouse hovers above it
  Rectangle {
    anchors.fill: parent

    radius: 3

    color: "white"
    opacity: hovered ? 0.3 : 0
  }
}
