//
//  ViewController.swift
//  Todoey
//
//  Created by apple on 24/09/19.
//  Copyright © 2019 VasilisGreen. All rights reserved.
//

import UIKit


// by subclassing this todolist class to the table view controller
// we dont need to set it as a delegate and do any of the setup
// because obviously our class is inheriting all of table view controller's attributes
class TodoListVC: UITableViewController {
    
    // sample items to use for now
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    // An interface to the user’s defaults database,
    // where you store key-value pairs persistently across launches of your app.
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // we check if array exists in local storage
        // if yes we use it as the source to populate the cells of the tableView
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    
    
    /// - TableView Delegate Methods (append cell to rows)
    //MARK: - TableView Delegate Methods (append cell to rows)

    //ui methods
    // do something when a row is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // removes the grey background from a selected row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // get current tapped row
        let tappedRow = tableView.cellForRow(at: indexPath)
        // check if has checkmark and add or remove acordingly
        if tappedRow?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    /// /// ///
    
    
    
    
    /// - Tableview Datasource Methods (cell)
    //MARK: - Tableview Datasource Methods (cell)
    
    // set the number of rows in table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // set table cell for each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell
        //pass the name we gave it on the identifier editor
        //index path we give the current index passed in this function by the table
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        //set the inner text of each cell
        // selecting each item of the array by passing the current index of the row
        cell.textLabel?.text = itemArray[indexPath.row]
        //return the cell back to the tableView
        return cell
    }
    /// /// ///
    
    
    
    
    
    /// - Add New Items (+alert)
    //MARK: - Add New Items (+alert)
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //setup local var to save user's input inside
        //and share with other methods in this function
        var textField = UITextField()
        
        // create an alert item
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // this is a method to confirm the action (whatever we do with the alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user clicks the add item button on the alert
            self.itemArray.append(textField.text!)
            // save our updated todo array in the local storage
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            // make tableView to re-print the screen with new data
            self.tableView.reloadData()
        }
        
        // add a textfield into the alert to be able to write new items
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Create New Item"
            textField = alertTextFiled
        }
        
        // add action in alerrt
        alert.addAction(action)
        // make alert apear on screen
        present(alert, animated: true, completion: nil)
        
    }
    /// /// ///
}

