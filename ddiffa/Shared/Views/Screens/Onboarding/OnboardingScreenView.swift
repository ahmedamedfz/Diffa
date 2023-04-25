//
//  OnboardingScreenView.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import SwiftUI

struct OnboardingScreenView: View {
    
    @StateObject private var vm: OnboardingScreenViewModel
    
    @Environment(\.mainWindowSize) var mainWindowSize
    
    init(finishedOnboardingHandler: @escaping () -> Void) {
        self._vm = StateObject(wrappedValue: OnboardingScreenViewModel(finishedOnboardingHandler: finishedOnboardingHandler))
    }
   
    var body: some View {
        ZStack {
            Color.background.base
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // MARK: - Toolbar
                
                ZStack {
                    HStack {
                        Spacer()
                        
                        // TODO: refactor to tertiary greyed button style
                        Button {
                            withAnimation {
                                vm.finish()
                            }
                        } label: {
                            Text("Skip")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.text.tertiary)
                                .frame(width: 44, height: 44, alignment: .center)
                        }
                        .padding(.trailing, 12)
                    }
                    
                    ProgressDotIndicator(
                        currentIndex: vm.currentIndex,
                        total: vm.slidesCount
                    )
                }
                
                // MARK: - Content
                
                TabView(selection: $vm.currentIndex) {
                    // vm.imageName will be updated when the index is changing
                    Group {
                        Image(vm.imageName)
                            .resizable()
                            .tag(0)
                        Image(vm.imageName)
                            .resizable()
                            .tag(1)
                        Image(vm.imageName)
                            .resizable()
                            .tag(2)
                    }
                    .frame(
                        width: mainWindowSize.height > 700 ? 312 : 240,
                        height: mainWindowSize.height > 700 ? 312 : 240
                    )
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .disabled(true)
                .frame(
                    width: mainWindowSize.height > 700 ? 312 : 240,
                    height: mainWindowSize.height > 700 ? 312 : 240
                )
                .padding(.top, 40)

                Spacer()
                
                Text(vm.callout)
                    .id(vm.currentIndex)
                    .transition(.springToTop)
                    .font(.system(.callout, design: .rounded))
                    .foregroundColor(.primaryColor)
                
                Text(vm.title)
                    .id(vm.currentIndex)
                    .transition(.springToTop)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.text.primary)
                    .padding(.top, 8)
                
                Text(vm.body)
                    .id(vm.currentIndex)
                    .transition(.springToTop)
                    .multilineTextAlignment(.center)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.text.tertiary)
                    .frame(width: 327)
                    .padding(.top, 16)
                            
                Spacer()
                
                // MARK: Bottom buttons
                
                HStack {
                    
                    if vm.currentIndex > 0 {
                        // TODO: refactor to tertiary button style
                        Button {
                            withAnimation {
                                vm.back()
                            }
                        } label: {
                            Text("Back")
                                .font(.system(.headline, design: .rounded))
                                .frame(width: 50, height: 50)
                        }
                    }
                    
                    Spacer()
                    
                    // TODO: refactor to tertiary button style
                    Button {
                        withAnimation {
                            vm.next()
                        }
                    } label: {
                        Text(vm.isLastIndex ? "Finish" : "Next")
                            .frame(width: vm.isLastIndex ? 160 : 100, height: 50)
                            .foregroundColor(vm.isLastIndex ? Color.white : Color.primaryColor)
                            .background{ vm.isLastIndex ? Color.primaryColor : Color.primaryTransluctent }
                            .cornerRadius(8)
                    }
                }
                .padding(
                    EdgeInsets(top: 0, leading: 25, bottom: mainWindowSize.height > 700 ? 0 : 16, trailing: 16)
                )
                
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingScreenView(finishedOnboardingHandler: {})
                .previewDisplayName("iPhone 14")
            
            OnboardingScreenView(finishedOnboardingHandler: {})
                .previewDevice("iPhone SE (3rd generation)")
                .previewDisplayName("iPhone SE (3rd generation)")
        }
    }
}
