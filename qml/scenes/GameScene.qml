import QtQuick 2.0
import Felgo 3.0
import "../enity"
import "../map"

// EMPTY SCENE

Scene {
    id:gamescene
    width: 480
    height: 320
    gridSize: 32

    property int offsetBeforeScrollingStarts: 240

    EntityManager{
        id:entityManager
    }

    Image {
        id: backgroundImage
        width: parent.width
        height: parent.height
        anchors.fill:parent
        source: "../../assets/bg/background.png"
    }
//    Rectangle {
//      anchors.fill:parent
//      color: "#74d6f7"
//    }

    /*Text {
        text: "Felgo"
        color: "blue"

        anchors.centerIn: parent
    }*/

    Item {
        id: viewPort
        width: map.width
        height: map.height
        //anchors.bottom: gamescene.gamewindowAnchorItem.bottom
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-player.x : 0

        PhysicsWorld{
            id:physicsWorld
            gravity: Qt.point(0, 25)
            z: 1000

            debugDrawVisible: false

            Map1{
                id:map
            }


            Player{
                id:player

                y:20
            }

            ResetSensor {
              width: player.width
              height: 10
              x: player.x
              anchors.bottom: parent.bottom
              // if the player collides with the reset sensor, he goes back to the start
              onContact: {
               player.x = 20
                player.y = 100
              }
              // this is just for you to see how the sensor moves, in your real game, you should position it lower, outside of the visible area
//              Rectangle {
//                anchors.fill: parent
//                color: "yellow"
//                opacity: 0.5
//              }
            }
        }
    }
    Keys.forwardTo: controller
    TwoAxisController{
        id:controller
        onInputActionPressed: {
            console.debug("key pressed actionName " + actionName)
            if(actionName=="up"){
                player.jump()
            }

        }
    }


}
