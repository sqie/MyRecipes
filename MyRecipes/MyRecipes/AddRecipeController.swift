//
//  AddRecipeController.swift
//  MyRecipes
//
//  Created by Stephanie Qie on 5/15/20.
//  Copyright © 2020 Stephanie Qie. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var saveRecipeButton: UIButton!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var addStepButton: UIButton!
    @IBOutlet weak var stepsTableView: UITableView!
    
    let cellReuseIdentifier = "cell"
    
    var ingredients = [String]()
    var steps = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        stepsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == ingredientsTableView ? self.ingredients.count : self.steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        cell.backgroundColor = UIColor.systemGray5
        
        //if modifying ingredients table
        if tableView == ingredientsTableView {
            cell.textLabel?.text = ingredients[indexPath.row]
        }
        
        //if modifying steps table
        else {
            cell.textLabel?.text = steps[indexPath.row]
        }
        
        return cell
    }
    
    
    @IBAction func saveRecipe() {
        
        let recipeName = recipeNameTextField.text!
        
        let recipe = Recipe(context: AppDelegate.viewContext)
        recipe.name = recipeName
        
        //save ingredients to recipe in core data
        for ingredient in ingredients {
            let curIngredient = Ingredient(context: AppDelegate.viewContext)
            curIngredient.name = ingredient
            curIngredient.recipe = recipe
        }
        
        //save steps to recipe in core data
        for step in steps {
            let curStep = Step(context: AppDelegate.viewContext)
            curStep.name = step
            curStep.recipe = recipe
        }
        
        //try to save to core data
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("Couldn't save to core data")
        }
        
        addedRecipe = true
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func addIngredient() {
        
        let alert = UIAlertController(title: "Add ingredient", message: "Enter the ingredient", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        }))
        
        alert.addTextField(configurationHandler: { textField in
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            //if the user added an ingredient
            if let ingredient = alert.textFields?.first?.text {
                
                self.ingredients.append(ingredient)
                
                self.ingredientsTableView.beginUpdates()
                self.ingredientsTableView.insertRows(at: [IndexPath(row: self.ingredients.count - 1, section: 0)], with: .automatic)
                self.ingredientsTableView.endUpdates()
            }
        }))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func addStep() {
        
        let alert = UIAlertController(title: "Add step", message: "Enter the step", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        }))
        
        alert.addTextField(configurationHandler: { textField in
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            //if the user added a step
            if let step = alert.textFields?.first?.text {
                
                self.steps.append(step)
                
                self.stepsTableView.beginUpdates()
                self.stepsTableView.insertRows(at: [IndexPath(row: self.steps.count - 1, section: 0)], with: .automatic)
                self.stepsTableView.endUpdates()
            }
        }))
        
        self.present(alert, animated: true)
    }
}
