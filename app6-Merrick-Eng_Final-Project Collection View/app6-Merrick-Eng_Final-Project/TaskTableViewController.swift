//
//  TasksTableViewController.swift
//  app4-Merrick-Eng
//
//  Created by Merrick Eng on 3/2/21.
//

import UIKit

class TasksTableViewController: UITableViewController, AddTaskDelegate, UITabBarDelegate {

    // array to store all contacts
//    var TaskData.sharedInstance.array = [Task]()
    var currContactPosition = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // add first task
        TaskData.sharedInstance.array.append(Task(task: "Add Radio buttons", details: "", deadline: Date.init(), timeBucket: 1, isUrgent: true, isImportant: true))
        
        // add second task
        TaskData.sharedInstance.array.append(Task(task: "Figure out scroll picker", details: "See if can make it more conpact and readable and fits in with rest of design", deadline: Date.init(), timeBucket: 2, isUrgent: true, isImportant: false))
        
        // add third task
        TaskData.sharedInstance.array.append(Task(task: "Task 3", details: "Stuff", deadline: Date.init(), timeBucket: 2, isUrgent: false, isImportant: true))
        
        // add 4th task
        TaskData.sharedInstance.array.append(Task(task: "Task 4", details: "Stuff", deadline: Date.init(), timeBucket: 3, isUrgent: false, isImportant: false))
        
        // add 5th task
        TaskData.sharedInstance.array.append(Task(task: "important task!", details: "Stuff", deadline: Date.init(), timeBucket: 0, isUrgent: true, isImportant: true))
        
        // refresh data
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    /*
     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
     Get the new view controller using segue.destination.
    
     /Users/merrick/Documents/2020-2021 Spring Semester/CIS 195 iOS/apps/app6-Merrick-Eng_Final-Project/app6-Merrick-Eng_Final-Project/TasksTableViewController.swift     Pass th6e selected object to the new view controller.
    }
    */

    @IBAction func goToACVC(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToATVC", sender: self)
    }
    
    // MARK: - Basic table view methods
    // no changes needed for this one
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // size of row
        return 60.0
    }
    
    // gets number of rows in the section, which is dependent on news array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: How many rows in our section?
        return TaskData.sharedInstance.array.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: How many sections? (Hint: we have 1 section and x rows)
        return 1
    }
    
    // get the specific cell we are referring to
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Deque a cell from the table view and configure its UI. Set the label and star image by using cell.viewWithTag(..)
        
        // deque with identifier and get cell reference; all cells have same identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell")
        
        // current contact referenced
        let currentTask = TaskData.sharedInstance.array[indexPath.row]
        
        // set features of cell labels; subtitle cell style provides the reference so no need for tags
        cell?.textLabel?.text = ("\(currentTask.task)")
        cell?.detailTextLabel?.text = ("\(currentTask.details)")
        
        return cell ?? UITableViewCell()
    }
    
    
    // MARK: - Handle user interaction
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Deselect the cell, and pass to DVC
        
        // deselect cell
        tableView.deselectRow(at: indexPath, animated: true)
        
        // save current contact position
        currContactPosition = indexPath.row

        // do the actions
        // pass to DVC
        // call segue
        self.performSegue(withIdentifier: "segueToDVC", sender: self)
        
        // refresh data
        self.tableView.reloadData()
        
        
    }
    
    // prepare for segue; performed any time segue performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // current contact we're looking at is contact field
        
        // pass data to detail view controller
        if let dvc = segue.destination as? DetailViewController {
            // get contact at specific index path
            dvc.task = TaskData.sharedInstance.array[currContactPosition]
        }
        
        // pass data to add task controller
        if let navc = segue.destination as? UINavigationController {
            // get acvc
            let atvc = navc.topViewController as? AddTaskViewController
            
            // get contact at specific index path
            atvc!.delegate = self
        }
        
        // pass data to to do list view controller
        if let navc = segue.destination as? UINavigationController {
            // get acvc
            let acvc = navc.topViewController as? AddTaskViewController
            
            // get contact at specific index path
            acvc!.delegate = self
        }
        
    }
    
    // MARK: - Swipe to delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // TODO: If the editing style is deletion, remove the newsItem from your model and then delete the rows. CAUTION: make sure you aren't calling tableView.reloadData when you update your model -- calling both tableView.deleteRows and tableView.reloadData will make the app crash.
        
        // remove item from model
        if editingStyle == .delete {
            TaskData.sharedInstance.array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Add protocol conformance
    // append contact from the delegate class
    func didCreate(_ contact: Task) {
        // dismiss ACVC controller
        dismiss(animated: true, completion: nil)
        
        // add new contact to contacts array
        TaskData.sharedInstance.array.append(contact)
        
//        // sort array alphabetically by last name >> change later based on algoirthm
//        tasks.sort(by: { $0.task.uppercased() < $1.task.uppercased()})
        
        // reload table view; refresh data
        self.tableView.reloadData()
    }
    
//    // MARK: - Tab Bar
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//        print("tab bar task table view called")
//        tabBar.delegate = self
//        self.tableView.reloadData()
//    }
}
