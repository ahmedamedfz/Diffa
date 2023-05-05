//
//  StretchModel.swift
//  ddiffa
//
//  Created by Angelica Patricia on 03/05/23.
//

import Foundation

struct MainStretch:Hashable, Identifiable {
    var id : UUID
    var title : String
    var category : String
    var thumbnail : String
    var duration : Int
    var substretch : [SubStretch]
}

struct SubStretch: Hashable, Identifiable{
    var id : UUID
    var title: String
    var duration: Int
    var animation: String
    var description: String
}

extension MainStretch{
    static let neckAll = [
        MainStretch(id: UUID(), title: "Healthy Neck", category: "Neck Stretch", thumbnail: "contoh-neck-1", duration: 2,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Jumping Neck 1", duration: 20, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Ankle Neck 1", duration: 30, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Plank Neck 1", duration: 40, animation: "", description: "")
                                         ]),
        MainStretch(id: UUID(), title: "Legging", category: "Neck Stretch", thumbnail: "contoh-neck-2", duration: 4,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Jumping Neck 2", duration: 20, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Ankle Neck 2", duration: 30, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Plank Neck 2", duration: 40, animation: "", description: "")
                                         ])]
    static let lowerAll = [
        MainStretch(id: UUID(), title: "Lower Neck", category: "Lower Stretch", thumbnail: "contoh-lower-1", duration: 2,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Jumping Lower 1", duration: 20, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Ankle Lower 1", duration: 30, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Plank Lower 1", duration: 40, animation: "", description: "")
                                         ]),
        MainStretch(id: UUID(), title: "Lower Legging", category: "Lower Stretch", thumbnail: "contoh-lower-2", duration: 4,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Jumping Lower 2", duration: 20, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Ankle Lower 2", duration: 30, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Plank Lower 2", duration: 40, animation: "", description: "")
                                         ])]
    static let backAll = [
        MainStretch(id: UUID(), title: "Back Neck", category: "Back Stretch", thumbnail: "contoh-back-1", duration: 2,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Jumping Back 1", duration: 20, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Ankle Back 1", duration: 30, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Plank Back 1", duration: 40, animation: "", description: "")
                                        ]),
        MainStretch(id: UUID(), title: "Back Legging", category: "Back Stretch", thumbnail: "contoh-back-2", duration: 4,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Jumping Back 2", duration: 20, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Ankle Back 2", duration: 30, animation: "", description: ""),
                                            SubStretch(id: UUID(), title: "Plank Back 2", duration: 40, animation: "", description: "")
                                         ])]
    
    static let allStretch : [[MainStretch]] = [neckAll,lowerAll,backAll]
}
