import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"


GameWindow {
    id: gamewindow
    screenWidth: 960
    screenHeight: 640


    // update background music when scene changes
    onActiveSceneChanged: {
      musicManager.handleMusic()
    }

    MusicManager{
        id:musicManager

    }

    GameScene {
        id: gamescene
        //onBackButtonPressed: window.state = "selectLevel"
    }

    EntityManager {
        id: entityManager

    }

    // level editor
    LevelEditor {
      id: levelEditor

      Component.onCompleted: levelEditor.loadAllLevelsFromStorageLocation(authorGeneratedLevelsLocation)

      // These are the entity types, that the can be stored and removed by the entityManager.
      // Note, that the player is not here.
      toRemoveEntityTypes: [ "ground", "platform", "finish" ]
      toStoreEntityTypes: [ "ground", "platform", "finish" ]

      // set the gameNetwork
      gameNetworkItem: gameNetwork


    }
    // menu scene
    MenuScene {
        id: menuScene
        // listen to the button signals of the scene and change the state according to it
        onPlayPressed: gamewindow.state = "play"
        onMakeLevelPressed: gamewindow.state = "makeLevel"

        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackButtonPressed: {
            nativeUtils.displayMessageBox(qsTr("Really quit the game?"), "", 2);
        }
        // listen to the return value of the MessageBox
        Connections {
            target: nativeUtils
            onMessageBoxFinished: {
                // only quit, if the activeScene is menuScene - the messageBox might also get opened from other scenes in your code
                if(accepted && gamewindow.activeScene === menuScene)
                    Qt.quit()
            }
        }
    }
    // credits scene
    MakeLevelScene {
        id: makeLevelScene
        onBackButtonPressed: gamewindow.state = "menu"
        onPlayPressed: gamewindow.state="play"

        onNewLevelPressed: {
          // create a new level
          var creationProperties = {
            levelMetaData: {
              levelName: "newLevel"
            }
          }
          levelEditor.createNewLevel(creationProperties)

          // switch to gameScene, edit mode
          gameWindow.state = "edit_1"
          gameScene1.state = "edit"

          // initialize level
          gameScene1.initLevel()
        }

    }

    // game scene to play a level
    GameScene1 {
        id: gameScene1
        onBackButtonPressed: gamewindow.state = "menu"
    }

    // menuScene is our first scene, so set the state to menu initially
    state: "menu"
    activeScene: gamescene

    // state machine, takes care reversing the PropertyChanges when changing the state, like changing the opacity back to 0
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {
            name: "selectLevel"
            PropertyChanges {target: selectLevelScene; opacity: 1}
            PropertyChanges {target: window; activeScene: selectLevelScene}
        },
        State {
            name: "makeLevel"
            PropertyChanges {target: makeLevelScene; opacity: 1}
            PropertyChanges {target: window; activeScene: makeLevelScene}
        },
        State {
            name: "play"
            PropertyChanges {target: gamescene; opacity: 1}
            PropertyChanges {target: window; activeScene: gamescene}
        },
        State{
            name: "edit_1"
            PropertyChanges {target: gameScene1; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene1}
        }
    ]
}



