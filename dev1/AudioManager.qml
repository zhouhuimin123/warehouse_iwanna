import QtQuick 2.0
import Felgo 3.0

Item {

    id: audioManager
    
    Component.onCompleted: handleMusic()
    
    //background music
    //
    BackgroundMusic{
        id:playmusic
    }

    //sounds change move jump save
    SoundEffect{
        id:jump
    }
    
    SoundEffect{
        id:move
    }
    
    SoundEffect{
        id:change
    }
    
    SoundEffect{
        id:save
    }
    
    SoundEffect{
        id:shoot
    }
    
    
    function playSound(sound){
        
    }
}
