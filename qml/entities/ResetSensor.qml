import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id:resetSensor
    entityType: "resetSesnor"
    anchors.left: player.left

    //x: player.x
    y: 0
    signal contact
    BoxCollider {
      anchors.fill: parent
      //collisionTestingOnlyMode: true
      fixture.onBeginContact: {
        var otherEntity = other.getBody().target
        //If the player drops, reset the player
        if(otherEntity.entityType === "player") {
            console.debug("111")
          resetSensor.contact()
        }
      }
    }

}
