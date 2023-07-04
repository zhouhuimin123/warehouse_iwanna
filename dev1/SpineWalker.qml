import QtQuick 2.0
import Felgo 3.0

Spine {

    id: spineWalker
    variationType:"walker"

    property int direction:-1
    property int speed: 40

    //image
    Row{
        Repeater{
            model: size
            MultiResolutionImage{
                source:"../../assets/spine/spine.png"
            }
        }
    }

    PolygonCollider{
        vertices: [
            Qt.point(15,0),Qt.point(16.0),Qt.point(32,32),
            Qt.point(0,32)


        ]

        bodyType: Body.Dynamic

        categories: Box.Category3
        collidesWith: Box.Category2 |Box.Category5
    }

    BoxCollider{

        id:moveChecker

        anchors.bottom: parent.bottom
        height: 32*8
        width: parent.width

        categories: Box.Category4
        collidesWith: Box.Category2


    }

}
