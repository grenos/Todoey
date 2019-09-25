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
    var itemArray = [Item]()
    
    // An interface to the user’s defaults database,
    // where you store key-value pairs persistently across launches of your app.
    let defaults = UserDefaults.standard

    
    /// viewDidLoad()
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Buy Eggos"
        itemArray.append(newItem1)
        
        
        // we check if array exists in local storage
        // if yes we use it as the source to populate the cells of the tableView
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    /// /// ///
    
    
    
    
    /// - TableView Delegate Methods (tableView UI)
    //MARK: - TableView Delegate Methods (tableView UI)

    //ui methods
    // do something when a row is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // on cell tap toggles the done property of the item object
        // if true then false ecc
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // removes the grey background from a selected row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // update tableView with latest "state" changes after the tap
        tableView.reloadData()
        
    }
    /// /// ///
    
    
    
    
    /// - Tableview Datasource Methods (append cell to rows)
    //MARK: - Tableview Datasource Methods (append cell to rows)
    
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
        // indermediate let
        // select each item of the array by passing the current index of the row
        let item = itemArray[indexPath.row]
        //set the inner text of each cell
        // passing the title property of object
        cell.textLabel?.text = item.title
        // check if object has property done == true
        // show or hide checkmark
        cell.accessoryType = item.done ? .checkmark : .none
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
            // we create a new Item object and we pass the value of the text input
            // as the title property of the object, then we push it on out itemsArray
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
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

