import QtQuick 2.0
import Felgo 3.0

TileEntityBase {

    id:ground
    entityType: "ground"
    //size:2

    property bool show: true

    Row{
        Repeater{
            model: size
            MultiResolutionImage{
                source:"../../assets/ground/mid.png"
            }
        }
    }




    BoxCollider{
        anchors.fill:parent
        bodyType: Body.Static
        
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
