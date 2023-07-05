import QtQuick 2.0
import Felgo 3.0

TileEntityBase {

    id:spineDown
    entityType: "spineDown"


    property bool hidden: false
    signal contact

    //Properties set to enable entities to move(To be optimized)
    //property int startX: 0
    //property int startY: 0
//    property int direction: 1
//    property bool isActive: false
//    property int speed: 50

    Row{
        Repeater{
            model: size
            MultiResolutionImage{
                width:32
                height: 32
                source:"../../assets/spine/spinedown.png"
            }
        }
    }

    onContact: {
     player.x = 20
      player.y = 100
    }
    BoxCollider{
        id:spinecollider

        //polygoncollider make collision detection more accurate
//        vertices: [
//            Qt.point(15, 1),
//            Qt.point(18, 1),
//            Qt.point(31, 30),
//            Qt.point(1, 30)
//        ]

        anchors.fill:parent
        bodyType: Body.Static
        categories: Box.Category3
        collidesWith: Box.Category2|Box.Category1

        fixture.onBeginContact: {
          var otherEntity = other.getBody().target
          // If the player touches the spike, reset the player
          if(otherEntity.entityType === "player") {
            spineDown.contact()
          }
        }
    }


}
