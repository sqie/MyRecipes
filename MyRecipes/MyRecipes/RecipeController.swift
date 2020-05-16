//
//  RecipeController.swift
//  MyRecipes
//
//  Created by Stephanie Qie on 5/15/20.
//  Copyright © 2020 Stephanie Qie. All rights reserved.
//

import UIKit
import CoreData

//var recipes = [String]()
//var curRecipeLoc = -1
//var addedRecipe = true

class RecipeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var cookButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var recipeNameTextField: UILabel!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var stepsTableView: UITableView!
    
    var ingredients = [String]()
    var steps = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeNameTextField.text! = recipes[curRecipeLoc]
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        stepsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        //----------------------
        
        let query: NSFetchRequest<Recipe> = Recipe.fetchRequest()

        //update the recipe's ingredients and steps
        if let results = try? AppDelegate.viewContext.fetch(query) {

            let curRecipe = results[curRecipeLoc]

            ingredients = (curRecipe.ingredients?.allObjects as! [Ingredient]).map{ $0.name!}
            steps = (curRecipe.steps?.allObjects as! [Step]).map{ $0.name!}
        }

        self.ingredientsTableView.reloadData()
        self.stepsTableView.reloadData()
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
    
    @IBAction func editRecipe() {
        
    }
    
    @IBAction func cookRecipe() {
        
    }
    
    @IBAction func deleteRecipe() {
        
    }
    
    @IBAction func closeRecipe() {
        dismiss(animated: true, completion: nil)
    }
}
