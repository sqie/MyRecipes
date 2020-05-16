//
//  ViewController.swift
//  MyRecipes
//
//  Created by Stephanie Qie on 5/15/20.
//  Copyright © 2020 Stephanie Qie. All rights reserved.
//

import UIKit
import CoreData

var addedRecipe = true

class RecipesController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var addRecipeButton: UIButton!
    @IBOutlet weak var recipesTableView: UITableView!
    
    var recipes = [String]()
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        recipesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        cell.backgroundColor = UIColor.systemGray5
        cell.textLabel?.text = recipes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("This cell from the chat list was selected: \(indexPath.row)")
    }
    
    func refresh(){
        
        let query: NSFetchRequest<Recipe> = Recipe.fetchRequest()

        //if has stored recipes
        if let results = try? AppDelegate.viewContext.fetch(query) {
            recipes = results.map { $0.name! }
        }
        
        self.recipesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //if first load or added a new recipe
        if addedRecipe {
            refresh()
            addedRecipe = false
        }
    }
}

