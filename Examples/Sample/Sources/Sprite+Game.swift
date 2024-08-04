//
//  Sprite+.swift
//
//
//  Created by sakiyamaK on 2024/08/03.
//

import Playdate

extension Sprite {
    static var sizue: Sprite {
        var sizue = Sprite(bitmapPath: "sizue.png")
        sizue.collisionsEnabled = false
        sizue.zIndex = 0
        sizue.setUpdateFunction { spritePtr in
//            guard case .running = game.state else { return }
            
            let sprite = Sprite(borrowing: spritePtr.unsafelyUnwrapped)
            let current = System.buttonState.current
            let (accelX, accelY, accelZ) = System.accelerometer
                                    
            let dx: Float = if current == .left, current != .right {
                -5.0
            } else if current != .left, current == .right {
                5.0
            } else {
                accelX.clamp(min: -5.0, max: 5.0)
//                System.crankChange
            }
            
            let dy: Float = if current == .up, current != .down {
                -5.0
            } else if current != .up, current == .down {
                5.0
            } else {
                accelY.clamp(min: -5.0, max: 5.0)
//                System.crankChange
//                0
            }
            
            let (x, y) = sprite.position
            let bounds = sprite.bounds
            
            let minX = -bounds.width
            let maxX = Float(LCD_COLUMNS) - (bounds.width / 10)
            let newX = (x + dx).clamp(min: minX, max: maxX)
            
            let minY = -bounds.height
            let maxY = Float(LCD_COLUMNS) - (bounds.height / 10)
            let newY = (y + dy).clamp(min: minY, max: maxY)

            sprite.moveWithCollisions(goalX: newX, goalY: newY)
        }
        return sizue
    }
}
