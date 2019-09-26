//
//  CategoryVC.swift
//  Todoey
//
//  Created by apple on 26/09/19.
//  Copyright © 2019 VasilisGreen. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {
    
    var CategoryArray = [Category]()
    let contextState = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
  
    
    /// Tableview Datasource Methods
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CategoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = CategoryArray[indexPath.row].name
        return cell
    }
    /// /// ///
    
    
    
    
    
    /// Tableview Delegate Methods
    //MARK: - Tableview Delegate Methods
    
    
    
    

    /// TableView Manipulation Methods
    //MARK: - TableView Manipulation Methods
    func saveCategories() {
        
        do {
            try contextState.save()
        } catch {
            print("Error saving in context: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            CategoryArray = try contextState.fetch(request)
        } catch {
            print("Error fetching from context: \(error)")
        }
        
        tableView.reloadData()
    }
    /// /// ///
    
    
    
    
    
    /// Add New Categories
    //MARK - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.contextState)
            newCategory.name = textFiled.text!
            self.CategoryArray.append(newCategory)
            
            self.saveCategories()

        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textFiled = field
            textFiled.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    /// /// ///
    
}
