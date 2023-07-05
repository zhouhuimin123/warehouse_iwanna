import QtQuick 2.0
import Felgo 3.0

TileEntityBase {
    id:player
    entityType: "player"
    width: 32
    height: 32


    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x
    property alias verticalVelocity: collider.linearVelocity.y
    property bool doubleJump: true

    property int contacts: 0
    //Detect whether the player is walking or jumping
    state: contacts > 0 ? "walking":"jumping"

    MultiResolutionImage{
        width: 32
        height: 32
        source:"../../assets/player/kid.png"
    }

    BoxCollider{
        id:collider
        height: parent.height
        width: 32
        anchors.horizontalCenter:parent.horizontalCenter

        fixedRotation: true  //running
        bullet: true  //collision detection

        force: Qt.point(controller.xAxis*120*32,0) //left&right

        //Collision event
        //Box.catgories1: ground Box.catgories2: player Box.catgories3: spine
        categories: Box.Category2


        //limit speed
        onLinearVelocityChanged: {
          if(linearVelocity.x > 170) linearVelocity.x = 120
          if(linearVelocity.x < -170) linearVelocity.x = -120
        }

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entitytype === "spine" ){
                console.debug("1do reset")
                player.reset()
            }

        }
    }
    //Enable players to jump through buttons
    function jump(){
        console.debug("jump requested at player.state " + state)
        if(player.state == "walking"){
            console.debug("do the jump")
            collider.linearVelocity.y = -520
        }
    }

    function reset(){
        console.debug("do reset")
        player.width=30
    }
}
