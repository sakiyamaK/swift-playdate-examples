import Playdate

struct Sprites: ~Copyable {
    var player: Sprite
}

struct Game: ~Copyable {
    
    private var sprites: Sprites
    // sound playerを用意
    private var soundPlayer: FilePlayer = FilePlayer()

    init() {
        srand(System.getSecondsSinceEpoch(milliseconds: nil))
        Display.setRefreshRate(rate: 50)
        
        sprites = .init(player: .sizue)
        
        sprites.player.addSprite()
        sprites.player.forget()
        
        Sprite.drawSprites()

        System.setPeripheralsEnabled(mask: PDPeripherals(rawValue: 1))
        
        // mp3の読み込み
        soundPlayer.loadIntoPlayer(path: "atsumori_op")
    }
    
    mutating func updateGame() {
        Sprite.updateAndDrawSprites()
        
        let current = System.buttonState.current
        if current == .a {
            if soundPlayer.isPlaying {
                soundPlayer.pause()
            } else {
                soundPlayer.play(loop: 0)
            }
        } else if current == .b {
            soundPlayer.pause()
        }
        
        let (accelX, accelY, accelZ) = System.accelerometer
        
        Graphics.setDrawMode(mode: .drawModeFillBlack)
        Graphics.drawText("x = ", x: 0, y: 0)
        Graphics.drawText(accelX.getCChars(), x: 30, y: 0)

        Graphics.drawText("y = ", x: 0, y: 20)
        Graphics.drawText(accelY.getCChars(), x: 30, y: 20)

        Graphics.drawText("z = ", x: 0, y: 40)
        Graphics.drawText(accelZ.getCChars(), x: 30, y: 40)
    }
}

