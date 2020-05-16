//
//  StepController.swift
//  MyRecipes
//
//  Created by Stephanie Qie on 5/15/20.
//  Copyright © 2020 Stephanie Qie. All rights reserved.
//

import UIKit

class StepController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var stepTextField: UITextView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var stepLoc = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        prevButton.isHidden = true
        stepTextField.text = steps[stepLoc]
    }
    
    @IBAction func exit() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedPrev() {
        
        stepLoc -= 1
        
        //if at first step
        if stepLoc == 0 {
            prevButton.isHidden = true
        }
        
        nextButton.isHidden = false
        stepTextField.text = steps[stepLoc]
    }
    
    @IBAction func pressedNext() {
        
        stepLoc += 1
       
        //if at the last step
        if stepLoc == (steps.count - 1) {
            nextButton.isHidden = true
        }
        
        //if not at the last step
        else {
            prevButton.isHidden = false
        }
        
        stepTextField.text = steps[stepLoc]
    }
}
