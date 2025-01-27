//
//  HomeView.swift
//  ecoeat
//
//  Created by Malika Sharma on 2024-05-05.
//
import SwiftUI

struct HomeView: View {
    
    // Array of food sustainability facts
    let sustainabilityFacts = [
        "Did you know? Eating less meat can significantly reduce your carbon footprint.",
        "Food waste accounts for nearly 8% of global greenhouse gas emissions.",
        "Eating locally grown food helps reduce transportation emissions.",
        "Choosing organic food can be better for the environment as it reduces the use of synthetic pesticides.",
        "Growing your own food at home can help save water and reduce your environmental impact."
    ]
    
    // Function to get a random sustainability fact
    func getRandomFact() -> String {
        sustainabilityFacts.randomElement() ?? "Eating seasonally can reduce your carbon footprint!"
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    // Background Image
                    Image("kitchen")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 40) {  // Increased the spacing between elements
                        
                        // Sustainability Fact Text
                        Text(getRandomFact())
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.top, 30)
                        
                        // Main Icon Image
                        Image("MainImage")  
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .padding(.top, 30)

                        // Welcome Text with no background and shadow
                        Text("Welcome to EcoEats!")
                            .foregroundColor(.white)
                            .font(.title.bold())
                            .shadow(radius: 10)  // Shadow to text
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)  // Vertical padding to create space around text
                        
                        // Circular Button Stack
                        ZStack {
                            Color.gray.opacity(0).ignoresSafeArea()
                            
                            Button {
                                // Outer circle action
                            } label: {
                                Circle()
                                    .foregroundColor(Color.green.opacity(0.4))  // Lighter pastel green
                                    .frame(width: 150, height: 150)
                            }
                            
                            Button {
                                // Inner circle action
                            } label: {
                                Circle()
                                    .foregroundColor(Color.green.opacity(0.6))  // Slightly darker pastel green for the inner circle
                                    .frame(width: 90, height: 90)
                            }
                            
                            Text("START!")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                        }

                        // Scan to Pan Text with no background and added shadow
                        Text("Scan to Pan!")
                            .foregroundColor(.black)
                            .font(.title.bold())
                            .shadow(radius: 10)  // Shadow to text
                            .padding(.horizontal, 40)
                            .padding(.vertical, 10)  // Vertical padding to create space around text
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
