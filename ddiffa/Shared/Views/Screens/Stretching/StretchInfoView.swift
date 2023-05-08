//
//  StretchInfoView.swift
//  ddiffa
//
//  Created by Dinda Alifiya Ramadhina on 03/05/23.
//

import SwiftUI

struct StretchInfoView: View {
    @Binding var isInfoOpen: Bool
    var body: some View {
        
            ZStack {
                Color.black
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                
                ZStack {
                    VStack {
                        Rectangle ()
                            .fill(Color(red: 33/255, green: 47/255, blue: 81/255))
                            .frame(width: 300, height: 220, alignment: .center)
                            .cornerRadius(10)
                            .padding(30)
                            
                        
                            VStack (alignment: .leading) {
                                Text ("Shoulder Stretch")
                                    .font(.system(.title, design: .rounded))
                                    .foregroundColor(.text.primary)
                                    .bold()
                                
                                Text ("Upper Body | **30 secs**")
                                    .font(.system(.title2, design: .rounded))
                                    .foregroundColor(.text.secondary)
                                    .padding(.bottom,10)

                            
                        }
                        
                        Text ("Begin by standing next to a wall with your left shoulder touching it. Straighten your left arm upwards, with your palm facing the wall. \n \nNext, move your arms slowly in big clockwise circles.")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.text.primary)
                        .padding([.leading,.trailing],30)
                        
                        Button {
                            isInfoOpen = false
                        }
                    label: {
                        
                        Text("Close")
                            .frame(width: 323, height: 38)
                            .background(Color.primaryColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(9)
                        }
                    .padding()
                        
                        
                    }
                    
                }
                .background(Color.background.secondary)
                .cornerRadius(20)
                .padding(30)
                
            }
        }
    }
    
    struct StretchInfoView_Previews: PreviewProvider {
        static var previews: some View {
            StretchInfoView(isInfoOpen: .constant(true))
        }
    }
    

