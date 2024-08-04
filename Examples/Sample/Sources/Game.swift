import Playdate

struct Sprites: ~Copyable {
    var player: Sprite
}

struct Game: ~Copyable {
    
    private var sprites: Sprites

    init() {
        // Setup the device before any other operations.
        srand(System.getSecondsSinceEpoch(milliseconds: nil))
        Display.setRefreshRate(rate: 50)
        
        sprites = .init(player: .sizue)
        
        sprites.player.addSprite()
        sprites.player.forget()
        
        Sprite.drawSprites()

        // これを設定しないとaccelerometerは更新されなかった
        System.setPeripheralsEnabled(mask: PDPeripherals(rawValue: 1))
    }
    
    mutating func updateGame() {
        Sprite.updateAndDrawSprites()
        
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

