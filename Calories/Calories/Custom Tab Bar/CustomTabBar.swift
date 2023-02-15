//
//  CustomTabBar.swift
//  Calories
//
//  Created by Анастасия Затолокина on 10/2/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case magazine
    case magnifyingglass
    
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    private var tabColor: Color {
        switch selectedTab{
        case .magazine:
            return .blue
        case .magnifyingglass:
            return .blue
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
                        .foregroundColor(selectedTab == tab ? tabColor : .blue)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
                
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(18)
            .padding()
        }
        
    }
            
            struct CustomTabBar_Previews: PreviewProvider {
                static var previews: some View {
                    CustomTabBar(selectedTab: .constant(.magazine))
                }
            }
}
