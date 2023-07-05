import QtQuick 2.0
import Felgo 3.0

EntityBase {

    id:tileEntityBase

    //Help Set Map Properties
    property int column: 0
    property int row: 0
    property int size

    //Set entity position according to map attribute
    x: row*gamescene.gridSize
    y: map.height - (column+1)*gamescene.gridSize
    width: gamescene.gridSize * size
    height: gamescene.gridSize


}
