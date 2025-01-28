//
//  OnionViewController.swift
//  ecoeat
//
//  Created by Michaela Penn on 1/23/25.
//
import UIKit

class OnionViewController: UIViewController {
    
    let questionLabel = UILabel()
    let tableView = UITableView()
    let submitButton = UIButton()
    
    let ingredients = ["Tomato", "Garlic", "Chicken", "Bell Pepper", "Cheese", "Mushroom"]
    var selectedIngredients: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        // Question Label
        questionLabel.text = "Which ingredients do you have?"
        questionLabel.font = UIFont.boldSystemFont(ofSize: 24)
        submitButton.layer.shadowColor = UIColor(red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0).cgColor
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        
        // TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 12
        tableView.clipsToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Submit Button
        submitButton.setTitle("Get Recipe", for: .normal)
        submitButton.backgroundColor = UIColor.systemPink.withAlphaComponent(0.7)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 15
        submitButton.layer.shadowColor = UIColor(red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0).cgColor
        submitButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        submitButton.layer.shadowOpacity = 0.2
        submitButton.layer.shadowRadius = 5
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(submitIngredients), for: .touchUpInside)
        view.addSubview(submitButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 250),
            
            submitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 220),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func submitIngredients() {
        let recommendedRecipe = getRecipeRecommendation()
        
        let alert = UIAlertController(title: "Recommended Recipe", message: recommendedRecipe, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Save", style: .default))
        present(alert, animated: true)
    }
    
    private func getRecipeRecommendation() -> String {
        if selectedIngredients.contains("Tomato") && selectedIngredients.contains("Garlic") {
            return "We recommend making Tomato Garlic Soup!"
        } else if selectedIngredients.contains("Chicken") && selectedIngredients.contains("Bell Pepper") {
            return "How about a delicious Chicken Stir-Fry?"
        } else if selectedIngredients.contains("Cheese") && selectedIngredients.contains("Mushroom") {
            return "You could try a Mushroom Cheese Omelette!"
        } else {
            return "Try making Onion Soup with your available ingredients!"
        }
    }
}

extension OnionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ingredients[indexPath.row]
        cell.textLabel?.textColor = .gray
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient = ingredients[indexPath.row]
        if !selectedIngredients.contains(ingredient) {
            selectedIngredients.append(ingredient)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let ingredient = ingredients[indexPath.row]
        if let index = selectedIngredients.firstIndex(of: ingredient) {
            selectedIngredients.remove(at: index)
        }
    }
}
