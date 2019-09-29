//
//  ViewController.swift
//  Todoey
//
//  Created by apple on 24/09/19.
//  Copyright © 2019 VasilisGreen. All rights reserved.
//

import UIKit
import CoreData

// by subclassing this todolist class to the table view controller
// we dont need to set it as a delegate and do any of the setup
// because obviously our class is inheriting all of table view controller's attributes
class TodoListVC: UITableViewController {
    
  var itemArray = [Item]()
    
  // call loadItems() only if selectedCategory has a value
  // otherwise it will crash the app
  var selectedCategory : Category? {
    didSet{
      loadItems()
    }
  }
    
    
  // CORE DATA
  // we grab a reference of the persistentContainer's context
  // where we save the data (think redux store/state)
  // CONTEXT is like an action/reducer -->
  // pass the information of what we want to change -->
  // to the database(persistentContainer)
  let contextState = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    

  /// viewDidLoad()
  //MARK: - viewDidLoad()
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  /// /// ///
    
    
    
    
    
  /// - TableView Delegate Methods (tableView UI - onTap)
  //MARK: - TableView Delegate Methods (tableView UI - onTap)

  //ui methods
  // do something when a row is tapped
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // on cell tap toggles the done property of the item object
    // if true then false ecc
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
      ///UPDATE DATA
      //itemArray[indexPath.row].setValue("Completed Maybe?", forKey: "Title")
        
      ///DELETE DATA
      //contextState.delete(itemArray[indexPath.row])
      //itemArray.remove(at: indexPath.row)
        
      // save the array to the plist file after
      // we have made any changes to the done property of the object
      saveItems()
      // make tableView to re-print the screen with new data
      tableView.reloadData()
      // removes the grey background from a selected row
      tableView.deselectRow(at: indexPath, animated: true)
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
            
      // we grab contextState from the global var
      // we init an object from the Item class to save out data in
      let newItem = Item(context: self.contextState)
      newItem.title = textField.text!
      newItem.done = false
      // we set the parent category with the index of the current category
      // we have access to the parent category from the relationships we set on the dataModel
      newItem.parentCategory = self.selectedCategory
      self.itemArray.append(newItem)
      // call method that creates and saves itemArray on the plist
      self.saveItems()
            
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
    
    
    
    
    
  /// - Model Manipulation Methods (db calls)
  //MARK: - Model Manipulation methods (db calls)
    
  func saveItems() {
    do {
      // save data to cntext (think store/state)
      try contextState.save()
    } catch {
      print("Error saving context \(error)")
    }
  }
    
    
  // we pass the request arg so we can re-use
  // we also provide a default in case we call loadItems() but dont pass an arg
  // like we do at the viewDidLoad() method
  // we also pass a parameter for the predicate, we give a default of nil
  // and also make it an optional
  // because we call loadItems with diferent or no predicates at times
  func loadItems(request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
    // make a fetch request with a fetch call
    // from context so we can read the data
    // passing the rquest we created above
      
    // set a predicate to tell that every time we tap into a category
    // we want to load only item created with the index of that category
    // as a value for the parentCategory attribute
    let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
    // if predicate arg is passed set it inside the compoundPredicate
    // with the categoryPredicate
    if let additionalPredicate = predicate {
      /// compoundPredicate
      // something like Redux compose
      // A specialized predicate that evaluates logical combinations of other predicates.
      request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
      } else {
        // else use only the categoryPredicate
        request.predicate = categoryPredicate
      }
        
      do {
        // the fetch call return an array of objects
        // that we then save in our itemsArray
        itemArray = try contextState.fetch(request)
      } catch {
        print("Error requesting data \(error)")
      }
        
      //re-print table view once we have all the fetched data
      tableView.reloadData()
  }
  /// /// ///
    
} // class end



/// EXTENSIONS

//MARK: - Search bar methods
extension TodoListVC: UISearchBarDelegate {
    
  // method is going to be triggered once the user
  // clicks the search button on the search bar
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //query our database
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    //we use the NSPredicate method to query our database
    //format: title CONTAINS[cd] %@ --> https://academy.realm.io/posts/nspredicate-cheatsheet/
    //arg: argument is the value we provide to search
    let myPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
    // set the predicate for the request as our predicate
    request.predicate = myPredicate
    // declare sortDescriptor method to sort our returned data
    let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
    // set the sortDescriptor for the request as our sortDescriptor
    request.sortDescriptors = [sortDescriptor]
        
    // call function that makes the actual request
    loadItems(request: request, predicate: myPredicate)
  }
    
    
  // listen for changes in the text bar
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    // if searchBar is empty
    if searchBar.text?.count == 0 {
      // call load items without any specific param
      // so it returns the entire db
      loadItems()
            
      /// DISPATCH MANAGER
      // assigns the tasks and proccesses to diferent threads
      // main == main thread (where all UI tasks should be)
      DispatchQueue.main.async {
      // put searchbar out of focus i.e. -->
      // close the keyboard unFocus search bar
      searchBar.resignFirstResponder()
      }
    }
  }
        
} // Extensions end
