import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../editorElements"

// EMPTY SCENE

SceneBase {

    id: gameScene

    // set the scene alignment
    sceneAlignmentX: "left"
    sceneAlignmentY: "top"

    // the level's grid size
    gridSize: 32

    // the time the user is playing the current level, since his last death
    property int time: 0

}
