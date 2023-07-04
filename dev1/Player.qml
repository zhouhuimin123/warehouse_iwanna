import QtQuick 2.0
import Felgo 3.0

TileEntityBase {
    id:player
    entityType: "player"
    width: 50
    height: 50


    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x
    property alias verticalVelocity: collider.linearVelocity.y
    property bool doubleJump: true
    property int contacts: 0  //

    state: contacts > 0 ? "walking":"jumping"

    MultiResolutionImage{
        source:"../../assets/player/run.png"
    }

    BoxCollider{
        id:collider
        height: parent.height
        width: 50
        anchors.horizontalCenter:parent.horizontalCenter
        //anchors.bottom: parent.bottom
        fixedRotation: true  //running
        bullet: true  //collision detection

        force: Qt.point(controller.xAxis*170*32,0) //left&right

        categories: Box.Category2
        collidesWith: Box.Category3

        //limit speed
        onLinearVelocityChanged: {
          if(linearVelocity.x > 170) linearVelocity.x = 170
          if(linearVelocity.x < -170) linearVelocity.x = -170
        }

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entitytype === "spine" ){
                reset()
            }

        }
    }

    function jump(){
        console.debug("jump requested at player.state " + state)
        if(player.state == "walking"){
            console.debug("do the jump")
            collider.linearVelocity.y = -520
        }
    }

    function reset(){
        x:32
        y:20
    }
}
