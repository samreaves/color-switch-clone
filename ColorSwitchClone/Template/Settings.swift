//
//  Settings.swift
//  ColorSwitchClone
//
//  Created by Samuel Reaves on 9/4/21.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1
    static let switchCategory: UInt32 = 0x1 << 1
}

enum ZPositions {
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}
