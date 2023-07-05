import QtQuick 2.0
import Felgo 3.0

TileEntityBase {

    id:ground
    entityType: "ground"

    Row{
        Repeater{
            model: size
            MultiResolutionImage{
                width: 32
                height: 32
                source:"../../assets/ground/ground.png"
            }
        }
    }




    BoxCollider{
        anchors.fill:parent
        bodyType: Body.Static
        //Collision event
        //Box.catgories1: ground Box.catgories2: player Box.catgories3: spine
        categories: Box.Category1
        
        //Detect whether the player is walking or jumping
        fixture.onBeginContact: {
          var otherEntity = other.getBody().target
          if(otherEntity.entityType === "player") player.contacts++
        }
        fixture.onEndContact: {
          var otherEntity = other.getBody().target
          if(otherEntity.entityType === "player") player.contacts--
        }


    }

}
