//
//  MenuView.swift
//  ecoeat
//
//  Created by Alonna Strong on 2024-05-05.
//

import SwiftUI

struct MenuView: View {
    @State private var selectedButton: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("kitchen")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    NavigationLink(destination: ViewControllerRepresentable()) {
                        buttonContent(title: "Scan", icon: "lightbulb", description: "Have the ingredients and want\n recommendations?", tag: "Scan")
                    }
                    
                    NavigationLink(destination: RecipesView()) {
                        buttonContent(title: "Saved Recipes", icon: "questionmark", description: "Want to see past suggestions? \n Click here!", tag: "Browse")
                    }
                    
                    NavigationLink(destination: TinderView()) {
                        buttonContent(title: "TinderFood", icon: "magnifyingglass", description: "Ready to explore sustainable recipes?", tag: "TinderFood")
                    }
                }
                .background(Color.white.blur(radius: 350))
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func buttonContent(title: String, icon: String, description: String, tag: String) -> some View {
        VStack(spacing: 20) {
            HStack {
                Text(title)
                    .font(Font.system(size: 30).weight(.bold))
                Image(systemName: icon)
                    .font(Font.system(size: 30).weight(.bold))
            }
            Text(description)
        }
        .padding()
        .foregroundColor(.white)
        .background(selectedButton == tag ? Color(UIColor.systemGreen) : Color.pink.opacity(0.5))
        .font(.system(size: 20, weight: .semibold))
        .cornerRadius(15)
        .frame(width: selectedButton == tag ? 520 : 500, height: selectedButton == tag ? 210 : 200)
        .animation(.easeInOut(duration: 0.3), value: selectedButton)
        .onTapGesture {
            selectedButton = tag
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
