import QtQuick 2.0
import Felgo 3.0

TileEntityBase {

    id:spine
    entityType: "spine"

    //property int startX: 0
    //property int startY: 0
    property bool hidden: false



    Row{
        Repeater{
            model: size
            MultiResolutionImage{
                width:32
                height: 32
                source:"../../assets/spine/spine.png"
            }
        }
    }

    BoxCollider{
        anchors.fill:parent
        bodyType: Body.Static
    }

//    PolygonCollider{
//        vertices: [
//            Qt.point(15,0),Qt.point(16.0),Qt.point(32,32),
//            Qt.point(0,32)


//        ]

//        bodyType: Body.Dynamic

//        categories: Box.Category3
//        collidesWith: Box.Category2 |Box.Category5
//    }

    //image.visible:!hidden

//    function reset_super(){
//        vertices
//    }






    

}
