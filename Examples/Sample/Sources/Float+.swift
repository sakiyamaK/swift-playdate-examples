//
//  Float+.swift
//  
//
//  Created by sakiyamaK on 2024/08/03.
//

import Playdate

public extension Float {
    func clamp(min minValue: Float, max maxValue: Float) -> Float {
        max(min(self, maxValue), minValue)
    }
    
    func getCChars(significantdDigits: Int = 6) -> [CChar] {
        var result: [CChar] = []
        
        // 符号を判定
        if self < 0 {
            result.append(CChar(45)) // ASCIIコードで'-'
        }
        
        // 絶対値を扱う
        let absValue = abs(self)
        
        // 整数部分を取り出す
        var integerPart = Int(absValue)
        
        // 小数部分を取り出す
        var fractionalPart = absValue - Float(integerPart)
        
        // 整数部分を[CChar]に変換
        var integerChars: [CChar] = []
        repeat {
            let digit = integerPart % 10
            integerChars.append(CChar(48 + digit)) // ASCIIコードで'0'は48
            integerPart /= 10
        } while integerPart > 0
        
        // 整数部分を逆順にして結果に追加
        result.append(contentsOf: integerChars.reversed())
        
        // 小数点を追加
        result.append(CChar(46)) // ASCIIコードで'.'
        
        // 小数部分を適当な桁数まで[CChar]に変換
        for _ in 0..<significantdDigits { // 小数点以下6桁までとする
            fractionalPart *= 10
            let digit = Int(fractionalPart)
            result.append(CChar(48 + digit)) // ASCIIコードで'0'は48
            fractionalPart -= Float(digit)
        }
        
        // null文字を追加してC文字列として完結させる
        result.append(0)
        
        return result
    }
}
