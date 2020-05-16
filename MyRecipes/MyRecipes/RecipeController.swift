//
//  RecipeController.swift
//  MyRecipes
//
//  Created by Stephanie Qie on 5/15/20.
//  Copyright © 2020 Stephanie Qie. All rights reserved.
//

import UIKit
import CoreData

var ingredients = [String]()
var steps = [String]()

class RecipeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cookButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var recipeNameTextField: UILabel!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var stepsTableView: UITableView!
    
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
        
        //-------------------
        
        //if there are no steps
        if steps.count == 0 {
            cookButton.isHidden = true
        }
        
        //------------------
        
        ingredients = ingredients.sorted(by: { $0 < $1 })
        steps = steps.sorted(by: { $0 < $1 })
        
        ingredients = ingredients.map{ String($0.split(separator: ":")[1])}
        steps = steps.map{ String($0.split(separator: ":")[1])}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == ingredientsTableView ? ingredients.count : steps.count
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
    
    @IBAction func cookRecipe() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "StepController") as! StepController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func deleteRecipe() {
        
        let query: NSFetchRequest<Recipe> = Recipe.fetchRequest()

        //delete the current recipe
        if let results = try? AppDelegate.viewContext.fetch(query) {
            
            let toDelete = results[curRecipeLoc]
            AppDelegate.viewContext.delete(toDelete)
        }
        
        //try to save to core data
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print("Couldn't save to core data")
        }
        
        changedRecipes = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeRecipe() {
        dismiss(animated: true, completion: nil)
    }
}
