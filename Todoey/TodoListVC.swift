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
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon",]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    /// - Tableview Datasource Methods
    //MARK: - Tableview Datasource Methods
    
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
        
        return cell
    }

}

