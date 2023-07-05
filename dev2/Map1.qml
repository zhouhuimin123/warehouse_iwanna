import QtQuick 2.0
import Felgo 3.0
import "../enity"
import "." as Map

Map.Mapbase {

    id: map
    width: 42 * gamescene.gridSize

//Map Settings

    //row:distance to the leftmost position
    //column:distance to the bottom position
    //size:entity-length

   Ground {
       row:0
       column:0
       size:4

   }

   Ground{
       row:4
       column:4
       size:3
   }

   Spine{
       row:6
       column:5
       size:1

   }

   Ground{
       row:6
       column:0
       size:3
   }

   Spine{
       row:6
       column:1
       size:3
   }

   Ground{
       row:10
       column:4
       size:4
   }

   Ground{
       row:14
       column: 0
       size:5
   }

   Ground{
       row:16
       column:6
       size:2
   }

   SpineDown{
       row:16
       column:5
       size:2
   }

   Spine{
       row:16
       column:1
       size:2
   }

   Ground{
       row:20
       column:0
       size:4
   }

}
