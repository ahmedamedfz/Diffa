//
//  Date+component.swift
//  ddiffa
//
//  Created by Dimas on 04/05/23.
//

import Foundation

extension Date {
    func component(_ component: Calendar.Component) -> Int {
        Calendar.current.component(component, from: self)
    }
}


