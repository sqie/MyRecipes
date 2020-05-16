//
//  AddRecipeController.swift
//  MyRecipes
//
//  Created by Stephanie Qie on 5/15/20.
//  Copyright © 2020 Stephanie Qie. All rights reserved.
//

import UIKit

class AddRecipeController: UIViewController {

    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var saveRecipeButton: UIButton!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var addStepButton: UIButton!
    @IBOutlet weak var stepsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveRecipe() {
        print("save recipe")
    }
    
    @IBAction func addIngredient() {
        print("add ingredient")
    }
    
    @IBAction func addStep() {
        print("add step")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
