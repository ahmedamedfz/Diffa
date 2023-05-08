//
//  FinishedView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI
import ConfettiSwiftUI
import CoreData

struct FinishedView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], animation: .default) private var stretchingFrequencies: FetchedResults<StretchingFrequency>
    
    @Environment(\.presentationMode) var presentationMode
    @State private var counter: Int = 1
    var sumTime : Int
    var body: some View {
        ZStack {
            Color.background.base
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack (alignment: .leading) {
                        Text("Congratulations!")
                            .foregroundColor(.text.primary)
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                        Text("You Finished the Stretcherxice")
                            .foregroundColor(.text.secondary)
                            .font(.system(.title2, design: .rounded))
                    }
                    
                    Spacer()
                }
                .padding()
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.background.secondary)
                        .cornerRadius(35)
                        .padding(.bottom,-150)
                    
                    VStack (spacing: 40) {
                        VStack {
                            Text("Stretching Time")
                                .font(.system(.title3, design: .rounded))
                                .foregroundColor(.text.primary)
                            
                            HStack (alignment: .bottom){
                                HStack (spacing: 0) {
                                    Text("\(sumTime/60)")
                                        .font(.system(size: 64, design: .rounded))
                                    Text("min")
                                        .font(.system(.largeTitle, design: .rounded))
                                        .baselineOffset(-20)
                                }
                                HStack (spacing: 0) {
                                    Text("\(sumTime%60)")
                                        .font(.system(size: 64, design: .rounded))
                                    Text("sec")
                                        .font(.system(.largeTitle, design: .rounded))
                                        .baselineOffset(-20)
                                }
                            }
                            .foregroundColor(.text.green)
                            .bold()
                        }
                        //MarkDown
                        //                        VStack (spacing: 0) {
                        //                            HStack (spacing: 30) {
                        //                                VStack {
                        //                                    Text("Avg Heart Rate")
                        //                                    HStack (spacing: 0) {
                        //                                        Text("180")
                        //                                            .font(.system(.largeTitle, design: .rounded))
                        //                                        Text("bpm")
                        //                                            .font(.system(.title3, design: .rounded))
                        //                                            .baselineOffset(-10)
                        //                                    }
                        //                                    .foregroundColor(.text.red)
                        //                                    .bold()
                        //                                }
                        //
                        //                                Divider()
                        //                                    .frame(width: 1)
                        //                                    .overlay(.gray)
                        //
                        //                                VStack {
                        //                                    Text("Total Calories")
                        //                                    HStack (spacing: 0) {
                        //                                        Text("0.7")
                        //                                            .font(.system(.largeTitle, design: .rounded))
                        //                                        Text("kcal")
                        //                                            .font(.system(.title3, design: .rounded))
                        //                                            .baselineOffset(-10)
                        //                                    }
                        //                                    .foregroundColor(.text.orange)
                        //                                    .bold()
                        //                                }
                        //
                        //                            }
                        //                            .frame(maxHeight: 80)
                        //
                        //
                        //                            Button(action: {
                        //                                }, label: {
                        //                                NavigationLink(destination: EmptyView())
                        //                                {
                        //                                    HStack {
                        //                                        Text("Go to analytics")
                        //                                        Image(systemName: "chevron.right")
                        //                                    }
                        //                                    .foregroundColor(.text.secondary)
                        //                                    .font(.system(.body, design: .rounded))
                        //                                }
                        //
                        //                            })
                        //                            .padding()
                        //                        }
                        //
                        
                        VStack (spacing: 10) {
                            Text("How do you feel?")
                                .foregroundColor(.text.primary)
                                .font(.system(.title3, design: .rounded))
                                .bold()
                            
                            HStack (spacing: 30){
                                Button(action: {
                                }) {
                                    Text("😩")
                                }
                                Button(action: {
                                }) {
                                    Text("😤")
                                }
                                Button(action: {
                                }) {
                                    Text("️😌")
                                }
                            }
                            .font(.system(size: 64, design: .rounded))
                        }
                        
                        Button(action:{ },label:{
                            NavigationLink(destination: StretchingScroll(allStretchs: MainStretch.allStretch)) {
                                Text("Finish")
                                    .foregroundColor(.white)
                                    .font(.system(.title3, design: .rounded))
                                    .frame(width: 323, height: 41)
                                    .background(Color.primaryColor)
                                    .cornerRadius(10)
                            }
                        })
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.counter += 1
            
            // Save stretching frequency data to Core Data
            let today = Calendar.current.startOfDay(for: Date())
            let frequencyFetchRequest: NSFetchRequest<StretchingFrequency> = StretchingFrequency.fetchRequest()
            frequencyFetchRequest.predicate = NSPredicate(format: "day == %@", today as NSDate)

            let newFrequency = StretchingFrequency(context: viewContext)
                newFrequency.day = today
                newFrequency.duration = Int64(sumTime)
            
            
            PersistenceController.shared.save()
        }
        .confettiCannon(counter: $counter, num: 100, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 250)
    }
}
