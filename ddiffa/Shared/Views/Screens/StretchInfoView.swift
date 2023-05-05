//
//  StretchInfoView.swift
//  ddiffa
//
//  Created by Dinda Alifiya Ramadhina on 03/05/23.
//

import SwiftUI

struct StretchInfoView: View {
    var body: some View {
        
            ZStack {
                Color(red: 15/255, green: 23/255, blue: 42/255).ignoresSafeArea()
                
                
                VStack {
                    Rectangle ()
                        .fill(Color(red: 33/255, green: 47/255, blue: 81/255))
                        .frame(width: 323, height: 284, alignment: .center)
                        .cornerRadius(10)
                        .padding(.top, 60)
                    Spacer()
                        .frame(height: 30)
                    
                    
                    VStack {
                        Text ("Shoulder Stretch")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.white)
                            .bold()
                            .padding(.leading, 16)
                        
                        
                        Text ("Upper Body | **30 secs**")
                            .font(.system(.title2, design: .rounded))
                            .foregroundColor(Color(red: 241/255, green: 245/255, blue: 249/255, opacity: 0.65))
                            .padding(.leading, 16)
                        
                        Spacer()
                            .frame(height: 31)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    ScrollView {
                        Text ("""
Begin by standing next to a wall with your left shoulder touching it. Straighten your left arm upwards, with your palm facing the wall.

Next, move your arms slowly in big clockwise circles.

Repeat the same process with your right arm.

""")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        
                    }
                    
                    //                ZStack {
                    
                    
                    Button {
                        
                    }
                label: {
                    
                    Text("Close")
                        .frame(width: 323, height: 38)
                        .background(Color(red: 68/255, green: 60/255, blue: 255/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(9)
                }
                    
                    //                }
                    
                    
                }
                
            }
        }
    }
    
    struct StretchInfoView_Previews: PreviewProvider {
        static var previews: some View {
            StretchInfoView()
        }
    }
    

