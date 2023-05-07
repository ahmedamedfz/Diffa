//
//  TempStretchModel.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
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
        MainStretch(id: UUID(), title: "Healthy Neck", category: "Neck Stretch", thumbnail: "contoh-upper-1", duration: 2,
                    substretch: [
                        SubStretch(id: UUID(), title: "Jumping Neck 1", duration: 20, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Ankle Neck 1", duration: 30, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Plank Neck 1", duration: 40, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim.")
                    ]),
        MainStretch(id: UUID(), title: "Legging", category: "Neck Stretch", thumbnail: "contoh-upper-2", duration: 4,
                    substretch: [
                        SubStretch(id: UUID(), title: "Jumping Neck 2", duration: 20, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Ankle Neck 2", duration: 30, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Plank Neck 2", duration: 40, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim.")
                    ])]
    static let lowerAll = [
        MainStretch(id: UUID(), title: "Lower Neck", category: "Lower Stretch", thumbnail: "contoh-lower-1", duration: 2,
                    substretch: [
                        SubStretch(id: UUID(), title: "Jumping Lower 1", duration: 20, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Ankle Lower 1", duration: 30, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Plank Lower 1", duration: 40, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim.")
                    ]),
        MainStretch(id: UUID(), title: "Lower Legging", category: "Lower Stretch", thumbnail: "contoh-lower-2", duration: 4,
                    substretch: [
                        SubStretch(id: UUID(), title: "Jumping Lower 2", duration: 20, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Ankle Lower 2", duration: 30, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Plank Lower 2", duration: 40, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim.")
                    ])]
    static let backAll = [
        MainStretch(id: UUID(), title: "Back Neck", category: "Back Stretch", thumbnail: "contoh-back-1", duration: 2,
                    substretch: [
                        SubStretch(id: UUID(), title: "Jumping Back 1", duration: 20, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Ankle Back 1", duration: 30, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Plank Back 1", duration: 40, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim.")
                    ]),
        MainStretch(id: UUID(), title: "Back Legging", category: "Back Stretch", thumbnail: "contoh-back-2", duration: 4,
                    substretch: [
                        SubStretch(id: UUID(), title: "Jumping Back 2", duration: 20, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Ankle Back 2", duration: 30, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim."),
                        SubStretch(id: UUID(), title: "Plank Back 2", duration: 40, animation: "", description: "Esse veniam sit ad Lorem ut amet nulla eiusmod id Lorem anim est anim elit. Amet irure laborum reprehenderit culpa dolor voluptate eu. Sunt incididunt elit consectetur sit eu labore aliqua adipisicing dolor minim aliqua et sint sint voluptate. Mollit labore et labore culpa et ipsum ipsum. Ea pariatur incididunt anim.")
                    ])]
    
    static let allStretch : [[MainStretch]] = [neckAll,lowerAll,backAll]
}
