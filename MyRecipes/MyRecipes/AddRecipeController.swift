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
        
        ingredientsTableView.isEditing = true
        stepsTableView.isEditing = true
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //if modifying ingredients table
        if tableView == ingredientsTableView {
            
            let movedObjTemp = ingredients[sourceIndexPath.item]
            ingredients.remove(at: sourceIndexPath.item)
            ingredients.insert(movedObjTemp, at: destinationIndexPath.item)
        }
        
        //if modifying steps table
        else {
            
            let movedObjTemp = steps[sourceIndexPath.item]
            steps.remove(at: sourceIndexPath.item)
            steps.insert(movedObjTemp, at: destinationIndexPath.item)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            //if modifying ingredients table
            if tableView == ingredientsTableView {
                ingredients.remove(at: indexPath.item)
                ingredientsTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            //if modifying steps table
            else {
                steps.remove(at: indexPath.item)
                stepsTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    @IBAction func saveRecipe() {
        
        let recipe = Recipe(context: AppDelegate.viewContext)
        recipe.name = recipeNameTextField.text!
        var loc = 1
        
        
        //save ingredients to recipe in core data
        for ingredient in ingredients {
            let curIngredient = Ingredient(context: AppDelegate.viewContext)
            curIngredient.name = "\(loc):" + ingredient
            curIngredient.recipe = recipe
            
            loc += 1
        }
        
        loc = 1
        
        //save steps to recipe in core data
        for step in steps {
            
            let curStep = Step(context: AppDelegate.viewContext)
            curStep.name = "\(loc):" + step
            curStep.recipe = recipe
            
            loc += 1
        }
        
        //try to save to core data
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("Couldn't save to core data")
        }
        
        changedRecipes = true
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
