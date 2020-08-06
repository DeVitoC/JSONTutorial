//
//  ViewController.swift
//  JSONExample
//
//  Created by Christopher Devito on 8/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    let modelController = ModelController()

    // MARK: - Outlets
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var firstItemTextField: UITextField!
    @IBOutlet weak var firstAmountTextField: UITextField!
    @IBOutlet weak var secondItemTextField: UITextField!
    @IBOutlet weak var secondAmountTextField: UITextField!
    @IBOutlet weak var craftingTableSwitch: UISwitch!


    // MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        modelController.fetchFromJSONFile()
    }

    // MARK: - IBActions
    @IBAction func addItemTapped(_ sender: UIButton) {
        guard let name = recipeNameTextField.text, !name.isEmpty,
            let firstItem = firstItemTextField.text, !firstItem.isEmpty,
            let firstAmountString = firstAmountTextField.text, !firstAmountString.isEmpty, let firstAmount = Int(firstAmountString), firstAmount <= 9,
            let secondItem = secondItemTextField.text, !secondItem.isEmpty,
            let secondAmountString = secondAmountTextField.text, !secondAmountString.isEmpty, let secondAmount = Int(secondAmountString), secondAmount <= 9
            else { return }

        let craftingTableNeeded = craftingTableSwitch.isOn
        let model = Model(name: name, firstItem: firstItem, firstAmount: firstAmount, secondItem: secondItem, secondAmount: secondAmount, craftingTableNeeded: craftingTableNeeded)
        modelController.appendToJSONFile(model: model)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? CollectionViewController {
            detailVC.modelController = modelController
        }
    }

}

