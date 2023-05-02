//
//  Color+CustomColors.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import SwiftUI

extension Color {
    static let primaryColor = Color("primary-foreground")
    static let primaryTransluctent = Color("primary-transluctent")
    static let primaryTransluctent48 = Color("primary-background")
    
    struct text {
        static let primary = Color("text-primary")
        static let tertiary = Color("text-tertiary")
    }
    
    struct background {
        static let base = Color("background-base")
        static let secondary = Color("background-secondary")
        static let translucent = Color("background-translucent")
    }
    
    struct tags {
        static let orange = Color("tag-orange")
    }
}
