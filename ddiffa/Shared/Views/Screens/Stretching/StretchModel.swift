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
    static let upperBody = [
        MainStretch(id: UUID(), title: "Relaxing shoulder", category: "Upper Body", thumbnail: "contoh-neck-1", duration: 48,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Shoulder Rotation Left", duration: 16 , animation: "", description: " Sit with your back straight. \n Straighten your left arm upwards.\n Move your arms slowly in big clockwise circles for 8 second and do counterclockwise after that for 8 second. /n Repeat the same process with your right arm."),
                                            
                                            SubStretch(id: UUID(), title: "Shoulder Rotation right", duration: 16, animation: "", description: "Sit with your back straight. \n Straighten your right arm upwards. \n Move your arms slowly in big clockwise circles for 8 second and do counterclockwise after that for 8 second"),

                                            SubStretch(id: UUID(), title: "Triceps Stretch Left", duration: 8, animation: "", description: "Lift your left arm and bend it behind your head. \n Place your other hand on the bent elbow to help stretch your upper arm and shoulder. \n Hold the stretch for 8 seconds, then relax and slowly return to the starting position.\n Repeat with the other arm."),
                                            
                                            SubStretch(id: UUID(), title: "Triceps Strestch Right", duration: 8, animation: "", description: "Lift your left arm and bend it behind your head. \n Place your other hand on the bent elbow to help stretch your upper arm and shoulder.\n Hold the stretch for 8 seconds, then relax and slowly return to the starting position.\n Repeat with the other arm.")
                                         ]),
       
        MainStretch(id: UUID(), title: "Neck Flexion", category: "Upper Body", thumbnail: "contoh-neck-2", duration: 32,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Lateral Neck Flexion", duration: 8, animation: "", description: "Sit or stand with your spine straight.\n Drop your right ear to your right shoulder, and hold for about 8 seconds.\n Do the same stretch to your left shoulder. \n This stretch can help to reduce tension in the neck and shoulders, and can also improve posture and flexibility in the neck muscles."),
                                            
                                            SubStretch(id: UUID(), title: "Neck Rotation", duration: 16, animation: "", description: "While keeping the back straight and shoulders still, gradually turn the head to make clockwise circle this until 8 rotation. \n Repeat the same stretch counterclockwise. \n This stretch reduce your neck stiffness"),
                                         ])]
  
    static let lowerBody = [
        MainStretch(id: UUID(), title: "Leg Flexibility", category: "Lower Body", thumbnail: "contoh-lower-1", duration: 32,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Hip Opener Left", duration: 8, animation: "", description: " Sit on the edge of your chair with your feet hip-width apart, directly under your knees.\n Cross your left ankle over the opposite knee.\n Gently stretch forward and hold for 8 seconds. \n Your hips and low back get tight from too much sitting. This seated stretch can open both."),
                                            
                                            SubStretch(id: UUID(), title: "Hip Opener Right", duration: 8, animation: "", description: "Sit on the edge of your chair with your feet hip-width apart, directly under your knees.\n Cross your right ankle over the opposite knee.\n Gently stretch forward and hold for 8 seconds."),
                                           
                                            SubStretch(id: UUID(), title: "Hip Raises Left", duration: 8, animation: "", description: "Sit forward in your chair.\n Bring your left knee toward your chest. \n Use your hands to grab the back of your thigh and gently pull it toward you.\n Keep your back straight, being careful not to lean forward.\n Hold the stretch for 8 seconds. You'll feel tension in your lower back and the upper part of your buttock.\n Relax and slowly return to the starting position.\n Repeat the stretch with the other leg."),
                                           
                                            SubStretch(id: UUID(), title: "Hip Raises Right", duration: 8, animation: "", description: "Sit forward in your chair.\n Bring your right knee toward your chest. Use your hands to grab the back of your thigh and gently pull it toward you.\n Keep your back straight, being careful not to lean forward.\n Hold the stretch for 8 seconds. You'll feel tension in your lower back and the upper part of your buttock.\n Relax and slowly return to the starting position."),
                                         ]),
        
        MainStretch(id: UUID(), title: "Lower Back Release", category: "Lower Body", thumbnail: "contoh-lower-2", duration: 24,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Toe Touch", duration: 8, animation: "", description: " Begin by sit at the edge of your seat.\n  Straighten out both of your legs.\n Reach out to try and touch your toes while keep your legs straight."),
                                            
                                            SubStretch(id: UUID(), title: "Hip Twist Right", duration: 8, animation: "", description: "Turn sideways in a chair and facing right side.\n Hold the back of the chair with the both of your arms.\n Gently twist the front of your body toward the back of the chair."),
                                           
                                            SubStretch(id: UUID(), title: "Hip Twist Left", duration: 8, animation: "", description: "Turn sideways in a chair and facing left side.\n  Hold the back of the chair with the both of your arms.\n Gently twist the front of your body toward the back of the chair.")
                                         ])]
    
    static let fullBody = [
        MainStretch(id: UUID(), title: "Standing Stretch", category: "Full Body", thumbnail: "contoh-back-1", duration: 34,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Half Downward Dog", duration: 10, animation: "", description: " Stand facing the back of your chair.\n Place your hands on the back of the chair.\n Step back as far as you can.\n  Try to keep your arms and legs straight as you stretch your spine.\n This version of the well-known yoga pose is an all-purpose, full-body stretch that’s especially good for your hamstrings."),
                                           
                                            SubStretch(id: UUID(), title: "Calf Raises", duration: 8, animation: "", description: "Raise your heels slowly, keeping your knees extended (but not locked).\n Slowly go up and down with your heels raise for 8s"),
                                           
                                            SubStretch(id: UUID(), title: "Wall Sretch", duration: 16, animation: "", description: "With palm open and fingers pointing away from body.\n Put one of your hand on the wall at shoulder height, keep elbow straight.\n Turn away from the wall to feel a stretch across the front of your arm/elbow.")
                                        ]),
        
        MainStretch(id: UUID(), title: "Sitting Down Stretch", category: "Full Body", thumbnail: "contoh-back-2", duration: 26,
                                         substretch: [
                                            SubStretch(id: UUID(), title: "Low Back Release", duration: 10, animation: "", description: " Turn sideways in a chair.\n Hold the back of the chair with the arm closest to it.\n Gently twist the front of your body toward the back of the chair.\n Reach your other arm to the opposite knee or farther if you can manage it.\n This stretch targets the lower back, which can become tight and achy from sitting for long periods of time. The twisting motion can help to release tension and improve mobility in the spine."),
                                           
                                            SubStretch(id: UUID(), title: "Torso Stretch", duration: 16, animation: "", description: " Start in a seated or standing position.\n Lace the fingers together and stretch them up towards the ceiling.\n Take a deep breath as you stretch up as high as you can.\n Lean to the right and hold for 8s. Do the same to the left side.\n Poor posture can not only cause a hunchback appearance, it can also make your back ache. This simple move will stretch all the muscles in your back, sides, and arms. You can also take the arms to either side to deepen the stretch down the sides of the torso."),
                                         ])]
    
    static let allStretch : [[MainStretch]] = [upperBody,lowerBody,fullBody]
}
