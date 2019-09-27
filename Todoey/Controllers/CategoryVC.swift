//
//  CategoryVC.swift
//  Todoey
//
//  Created by apple on 26/09/19.
//  Copyright © 2019 VasilisGreen. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryVC: UITableViewController {
    
    let realm = try! Realm()
    
    var CategoryArray: Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
  
    
    /// Tableview Datasource Methods
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // nil coalasing operator
        
        return CategoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // make cells reusable
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        // set cell's textlabel equal to what the user has entered as an input in the alert
        cell.textLabel?.text = CategoryArray?[indexPath.row].name ?? "No categories found"
        return cell
    }
    /// /// ///
    
    
    
    
    
    /// Tableview Delegate Methods
    //MARK: - Tableview Delegate Methods
    
    // on tap of a cell/row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    // do somethig before the segue happens
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get the destination of the segue
        let destinationVC = segue.destination as! TodoListVC
        
        // if we have selected a category
        // so there IS an active index
        if let activeIndex = tableView.indexPathForSelectedRow {
            // set the value of selectedCategory declared on TodoListVC
            // with the index of the tapped cell/row
            destinationVC.selectedCategory = CategoryArray?[activeIndex.row]
        }
    }
    /// /// ///
    
    
    
    

    /// TableView Manipulation Methods
    //MARK: - TableView Manipulation Methods
    func saveCategories(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving in context: \(error)")
        }
        // reload tableView to get new changes on screen
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        CategoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    /// /// ///
    
    
    
    
    
    /// Add New Categories
    //MARK - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // init a new textfiled for the alert
        var textFiled = UITextField()
        // create the alert window
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        // create the button that on click will do:
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            // create an object from the Category Class from context
            let newCategory = Category()
            // set its name property equal to the user's input
            newCategory.name = textFiled.text!
            // call the function that saves the array into context
            self.saveCategories(category: newCategory)

        }
        
        // add the action to the alert window
        alert.addAction(action)
        // add the textfield from above in the allert
        alert.addTextField { (field) in
            textFiled = field
            textFiled.placeholder = "Add a new category"
        }
        // call the alert to show up on screen
        present(alert, animated: true, completion: nil)
    }
    /// /// ///
    
}
