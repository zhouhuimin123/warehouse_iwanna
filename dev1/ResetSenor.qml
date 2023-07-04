import QtQuick 2.0
import Felgo 3.0

EntityBase {
    id:resetSenor
    entityType: "resetSenor"
    signal contact

    Rectangle {
        anchors.fill: parent
        color: "red"
    }

    BoxCollider{
        id:boxCollider
        fixture.onBeginContact: {
            var otherEntity = other.getbody().target
            if(otherEntity.EntityType === "player"){
                resetSensor.contact()
            }
        }
    }

}
