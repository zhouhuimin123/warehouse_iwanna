import Felgo 3.0
import QtQuick 2.0
import "../common"
import "../editorElements"

SceneBase {
  id: gameScene1

  // set the scene alignment
  sceneAlignmentX: "left"
  sceneAlignmentY: "top"

  // the level's grid size
  gridSize: 32


  // background
  Rectangle {
    id: background

    anchors.fill: parent.gameWindowAnchorItem

    gradient: Gradient {
      GradientStop { position: 0.0; color: "#4595e6" }
      GradientStop { position: 0.9; color: "#80bfff" }
      GradientStop { position: 0.95; color: "#009900" }
      GradientStop { position: 1.0; color: "#804c00" }
    }
  }

  // the time the user is playing the current level, since his last death
  property int time: 0

  property alias editorOverlay: editorOverlay
  /**
   * States
   */
  state: "play"

  states: [
    State {
      name: "play"
      StateChangeScript {script: musicManager.handleMusic()}
    },
    State {
      name: "edit"
      PropertyChanges {target: editorOverlay; visible: true} // show the editorOverlay
      PropertyChanges {target: editorOverlay; inEditMode: true}
      StateChangeScript {script: editorOverlay.grid.requestPaint()}
      StateChangeScript {script: musicManager.handleMusic()}
    },
    State {
      name: "test"
      PropertyChanges {target: editorOverlay; visible: true} // show the editorOverlay
      PropertyChanges {target: gameScene1; time: 0}

    },
    State {
      name: "finish"

    }
  ]

  EditorOverlay {
    id: editorOverlay

    visible: false

    scene: gameScene1
  }


}
