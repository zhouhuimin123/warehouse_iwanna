import Felgo 3.0
import QtQuick 2.0
import "scenes"

GameWindow {
    id: window
    screenWidth: 960
    screenHeight: 640


    // create and remove entities at runtime
    EntityManager {
        id: entityManager
    }


    // level editor
    LevelEditor {
      id: levelEditor

      Component.onCompleted: levelEditor.loadAllLevelsFromStorageLocation(authorGeneratedLevelsLocation)

      // These are the entity types, that the can be stored and removed by the entityManager.
      // Note, that the player is not here.
      toRemoveEntityTypes: [ "ground", "platform", "spikes", "opponent", "coin", "mushroom", "star", "finish" ]
      toStoreEntityTypes: [ "ground", "platform", "spikes", "opponent", "coin", "mushroom", "star", "finish" ]

      // set the gameNetwork
      gameNetworkItem: gameNetwork

      // directory where the predefined json levels are
      applicationJSONLevelsDirectory: "levels/"

    }

    // menu scene
    MenuScene {
        id: menuScene
        // listen to the button signals of the scene and change the state according to it
        onPlayPressed: window.state = "play"
        onMakeLevelPressed: window.state = "makeLevel"

        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackButtonPressed: {
            nativeUtils.displayMessageBox(qsTr("Really quit the game?"), "", 2);
        }
        // listen to the return value of the MessageBox
        Connections {
            target: nativeUtils
            onMessageBoxFinished: {
                // only quit, if the activeScene is menuScene - the messageBox might also get opened from other scenes in your code
                if(accepted && window.activeScene === menuScene)
                    Qt.quit()
            }
        }
    }



    // credits scene
    MakeLevelScene {
        id: makeLevelScene
        onBackButtonPressed: window.state = "menu"
        onPlayPressed: window.state="play"

        onNewLevelPressed: {
          // create a new level
          var creationProperties = {
            levelMetaData: {
              levelName: "newLevel"
            }
          }
          levelEditor.createNewLevel(creationProperties)

          // switch to gameScene, edit mode
          gameWindow.state = "game"
          gameScene.state = "edit"

          // initialize level
          gameScene.initLevel()
        }

    }

    // game scene to play a level
    GameScene {
        id: gameScene
        onBackButtonPressed: window.state = "menu"
    }

    // menuScene is our first scene, so set the state to menu initially
    state: "menu"
    activeScene: menuScene

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
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        }
    ]
}
