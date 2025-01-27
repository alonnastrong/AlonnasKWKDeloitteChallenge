//
//  TinderView.swift
//  ecoeat
//
//  Created by Malika Sharma on 2024-05-05.
//
import SwiftUI

struct TinderView: View {
    @State private var index = 0
    @State private var savedRecipes: [String] = []
    @State private var skippedRecipes: [String] = []
    private var images = ["pasta-img", "pasta2-img", "salad-img", "salad2-img", "salad3-img"]
    private var dishNames = ["Pasta", "Pasta 2", "Salad", "Salad 2", "Salad 3"] // Add dish names here
    @State private var done_today = false
    @State private var dragOffset: CGSize = .zero

    var currImg: String {
        images[index]
    }
    
    var currDishName: String {
        dishNames[index] // Fetch dish name by index
    }

    var body: some View {
        NavigationView {
            ZStack {
                Image("kitchen")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if !done_today {
                        Text("Chef's Specials for Today")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.blur(radius: 50))
                            .cornerRadius(10)
                            .font(.title.bold())
                            .shadow(color: .pink, radius: 10)
                            .padding()
                    }

                    if !done_today {
                        ZStack {
                            ForEach(0..<images.count, id: \.self) { i in
                                if i == index {
                                    VStack {
                                        // Image in a pink cell with rounded corners
                                        ZStack {
                                            Color.pink.opacity(0.3)
                                                .cornerRadius(20)
                                                .frame(height: 280)
                                            Image(images[i])
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 250)
                                                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5) // Adding shadow
                                        }
                                        
                                        // Dish name below the image
                                        Text(dishNames[i])
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding(.top, 8)
                                    }
                                    .offset(dragOffset)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { gesture in
                                                dragOffset = gesture.translation
                                            }
                                            .onEnded { gesture in
                                                if gesture.translation.width < -100 {
                                                    skip()
                                                } else if gesture.translation.width > 100 {
                                                    save()
                                                }
                                                dragOffset = .zero
                                            }
                                    )
                                }
                            }
                        }

                        HStack {
                            VStack {
                                Image(systemName: "xmark.circle")
                                    .font(.largeTitle)
                                    .foregroundColor(.pink)
                                Text("No")
                            }
                            .padding(.trailing, 50)
                            
                            VStack {
                                Image(systemName: "checkmark.circle")
                                    .font(.largeTitle)
                                    .foregroundColor(Color.green.opacity(0.4))
                                Text("Yes")
                            }
                            .padding(.leading, 50)
                        }
                    } else {
                        VStack {
                            Image("done-img")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 280)
                            Text("You've finished swiping! View your saved recipes below.")
                                .font(.headline)
                                .padding([.leading, .trailing], 20)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .background(Color.pink.opacity(0.3))
                                .cornerRadius(10)
                            
                            NavigationLink(destination: RecipesView()) {
                                Text("View Saved Recipes")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.pink.opacity(0.3))
                                    .cornerRadius(10)
                            }
                            .padding()

                            Spacer()
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding([.leading, .trailing], 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    func save() {
        savedRecipes.append(currImg)
        nextImg()
    }

    func skip() {
        skippedRecipes.append(currImg)
        nextImg()
    }

    func nextImg() {
        if index < images.count - 1 {
            index += 1
        } else {
            done_today = true
        }
    }
}

struct TinderView_Previews: PreviewProvider {
    static var previews: some View {
        TinderView()
    }
}

