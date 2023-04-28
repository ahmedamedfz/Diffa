//
//  StretchingModel.swift
//  ddiffa
//
//  Created by Angelica Patricia on 28/04/23.
//

import Foundation
struct Stretch: Hashable, Codable, Identifiable{
    var id = UUID()
    var category: String
    var title: String
    var duration: String
    var image_thumbnail: String
}

extension Stretch {
    static let all: [Stretch] = [
        Stretch(category: "Upper Stretch", title: "Ankle Stretch", duration: "2", image_thumbnail: "contoh-upper-1"),
        Stretch(category: "Upper Stretch", title: "Calves Stretch", duration: "1", image_thumbnail: "contoh-upper-2"),
        Stretch(category: "Lower Stretch", title: "Quadriceps Stretch", duration: "4", image_thumbnail: "contoh-lower-1"),
        Stretch(category: "Lower Stretch", title: "Hamstrings Stretch", duration: "2", image_thumbnail: "contoh-lower-2"),
        Stretch(category: "Back Stretch", title: "Back Pain Release", duration: "1", image_thumbnail: "contoh-back-1"),
        Stretch(category: "Back Stretch", title: "Piriformis Stretch", duration: "3", image_thumbnail: "contoh-back-2")
        
    ]
}
