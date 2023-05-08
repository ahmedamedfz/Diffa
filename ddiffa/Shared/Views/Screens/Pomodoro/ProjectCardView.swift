//
//  ProjectCardView.swift
//  ddiffa
//
//  Created by Dinda Alifiya Ramadhina on 02/05/23.
//

import SwiftUI

struct ProjectCardView: View {
    
    
    var body: some View {
        ZStack {
            Color(red: 3/255, green: 7/255, blue: 18/255)
                .ignoresSafeArea()
            
            HStack (spacing :4) {
                VStack(spacing: 4) {
                    HStack(spacing: 6) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(Color(red: 34/255, green: 197/255, blue: 94/255))
                        
                        Text ("Mini Challenge 1")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: 156, height: 25, alignment: .leading)
                    }
                    
                    
                    HStack {
                        Text ("Work")
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(Color(red: 249/255, green: 115/255, blue: 22/255))
                            .frame(width: 53, height: 22, alignment: .center)
                            .background(Color(red: 249/255, green: 115/255, blue: 2/255, opacity: 0.16))
                            .cornerRadius(100)
                        
                        
                        
                        Text ("Programming")
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(Color(red: 244/255, green: 63/255, blue: 94/255))
                            .frame(width: 98, height: 22, alignment: .center)
                            .background(Color(red: 244/255, green: 63/255, blue: 94/255, opacity: 0.16 ))
                            .cornerRadius(100)
                        
                    }
                    .frame(width: 168, height: 25, alignment: .leading)
                    
                    
                }
                
                
                Image(systemName: "play")
                    .resizable()
                    .fixedSize()
                    .foregroundColor(Color(red: 68/255, green: 60/255, blue: 255/255))
                    .frame(width: 20, height: 20, alignment: .center)
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 12))
            .frame(width: 220, height: 67, alignment: .leading)
            .background {Color(red:14/255 , green: 20/255, blue: 32/255)}
            .cornerRadius(8)
        
        
        
                        
                        
                        
                    }
                }
                
                
                
                struct ProjectCardView_Privews: PreviewProvider {
                    static var previews: some View {
                        ProjectCardView()
                    }
                }
            }
        
    
