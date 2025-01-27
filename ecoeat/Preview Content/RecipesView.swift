//
//  RecipesView.swift
//  ecoeat
//
//  Created by Malika Sharma on 2024-05-05.
//

import SwiftUI

struct Recipe: Identifiable {
    var id = UUID()
    var name: String
    var img_name: String
    var ingredients: [String]
    var inst: String
    var sustainabilityRating: Int 
}

class Recipes: ObservableObject {
    @Published var recipes: [Recipe] = [
        Recipe(name: "Chicken Salad", img_name: "salad-img", ingredients: ["orange", "onion", "tomato"], inst: """
        Ingredients:

        24 ounces dry fettuccine pasta
        1 cup butter
        ¾ pint heavy cream
        salt and pepper to taste
        1 dash garlic salt
        ¾ cup grated Romano cheese
        ½ cup grated Parmesan cheese

        Directions:
        - Bring a large pot of lightly salted water to a boil.
        - Add fettuccine and cook for 8 to 10 minutes or until al dente; drain.
        - Melt butter into cream in a large saucepan over low heat; add salt, pepper, and garlic salt.
        - Increase the heat to medium; stir in grated Romano and Parmesan cheese until melted and sauce has thickened.
        - Add cooked pasta to sauce and toss until thoroughly coated; serve immediately.
        """, sustainabilityRating: 2),
        
        Recipe(name: "Avocado Salad", img_name: "salad2-img", ingredients: ["rice", "water", "milk"], inst: """
        Ingredients and Recipe:

        - Avocados – big and ripe!
        - Cucumbers – regular cucumbers, around 17cm/7″ long.
        - Red pepper flakes (chilli flakes) – Adds a hint of warmth.
        - Red onion – Just a quarter, finely sliced.
        - Fresh herbs – Dill and coriander/cilantro.
        - Lime juice and extra virgin olive oil – For the dressing.

        Directions:
        - Combine all ingredients in a bowl and toss lightly.
        - Serve immediately.
        """, sustainabilityRating: 4),
        
        Recipe(name: "Alfredo Pasta", img_name: "pasta-img", ingredients: ["egg", "oil", "pepper"], inst: """
        Ingredients and Directions:

        - Fettuccine pasta, butter, heavy cream, salt, pepper, grated cheese.
        - Cook pasta, prepare sauce, and combine for a creamy dish.
        """, sustainabilityRating: 3)
    ]
}

struct RecipesView: View {
    @ObservedObject var recipeManager = Recipes()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("RecipeWallpaper")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                TabView {
                    ForEach(recipeManager.recipes) { recipe in
                        VStack {
                            Text(recipe.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                                .padding(.top, 20)
                            
                            Image(recipe.img_name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .cornerRadius(15)
                                .shadow(radius: 10)
                            
                            ScrollView {
                                Text(recipe.inst)
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding(20)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.top, 10)
                            
                            // Sustainability Rating
                            HStack {
                                Text("Sustainability Rating: ")
                                    .font(.body)
                                    .foregroundColor(.black)
                                ForEach(0..<5) { index in
                                    Image(systemName: index < recipe.sustainabilityRating ? "star.fill" : "star")
                                        .foregroundColor(index < recipe.sustainabilityRating ? .yellow : .gray)
                                }
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
