//
//  ViewController.swift
//  toDoApp
//
//

import UIKit
import MessageUI


class ViewController: UITableViewController,AddToDoItemDelegate,UINavigationControllerDelegate,MFMailComposeViewControllerDelegate{

    let cellId = "toDoCell"
    let toDoCell = toDoTableViewCell()
    var sectionTitles: [String] = ["High Priority", "Medium Priority","Low Priority"]
    
    var toDoItems: [[toDoItem]] = [[toDoItem(name: "Drink a beer",date: "2021/01/11"), toDoItem(name: "Eat Tacos",date:  "2021/01/22"), toDoItem(name: "Watch Netflix",date:  "2021/01/22")], [toDoItem(name: "Drink a Cerveza",date:  "2021/01/23"), toDoItem(name: "Exercising",date:  "2021/03/25"), toDoItem(name: "Watch Youtube",date:  "2021/03/25")], [toDoItem(name: "Study iOS",date:  "2030/11/11")]]
    


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "You Can Do It"

        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(toDoTableViewCell.self, forCellReuseIdentifier: cellId)
        


        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToDo))
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(multipleDelete))
        let emailButton = UIBarButtonItem(title: "email", style: .plain, target: self, action: #selector(emailBUttonTapped))
        navigationItem.rightBarButtonItems = [addButton,deleteButton,emailButton]
    }
    @objc func emailBUttonTapped() {
        var priorityHigh = ""
           var priorityMedium = ""
          var priorityLow = ""

          for itemNum in 0...toDoItems[0].count - 1 {
              priorityHigh = priorityHigh + "\nItem \(itemNum + 1)  : "  + toDoItems[0][itemNum].name + "\n" + "Due date : " + toDoItems[0][itemNum].date + "\n"
          }
          for itemNum in 0...toDoItems[1].count - 1 {
              priorityMedium = priorityMedium + "\nItem \(itemNum + 1)  : "  + toDoItems[1][itemNum].name + "\n" + "Due date : " + toDoItems[1][itemNum].date + "\n"
          }
          for itemNum in 0...toDoItems[2].count - 1 {
              priorityLow = priorityLow + "\nItem \(itemNum + 1)  : "  + toDoItems[2][itemNum].name + "\n" + "Due date : " + toDoItems[1][itemNum].date + "\n"
          }

        let textForEmail = "~~~High Priority~~~\n" + priorityHigh + "\n" + "~~~Medium Priority~~~\n" + priorityMedium + "\n" + "~~~Low Priority~~~\n" + priorityLow
        
        if !MFMailComposeViewController.canSendMail() {
            print("Can not send mail")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["e.rivadeneira1991gmail.com","edu.wolf.11@gmail.com"])
        mailComposer.setSubject("To Do Lists")
        mailComposer.setMessageBody("\(textForEmail)", isHTML: false)
        
        present(mailComposer, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
   
    @objc func multipleDelete () {
        if (tableView.indexPathsForSelectedRows != nil) {
        let sortedIndexPaths = tableView.indexPathsForSelectedRows!.sorted(by: {$0.row > $1.row})
        for indexPathList in sortedIndexPaths {
            toDoItems[indexPathList.section].remove(at: indexPathList.row)
            tableView.deleteRows(at: [indexPathList], with: .middle)
        }
        tableView.reloadData()
        }
    }
    
    
    @objc func addToDo () {
        let addEditVC = AddToDoTableViewController(style: .grouped)
        addEditVC.delegate = self
        let addToDoVC = UINavigationController(rootViewController: addEditVC)
        present(addToDoVC, animated: true, completion: nil)
    }
    
    func add(_ toDoItem: toDoItem) {
        toDoItems[1].append(toDoItem)
        tableView.insertRows(at: [IndexPath(row: toDoItems[1].count - 1, section: 1)], with: .automatic)
        tableView.reloadData()
    }
    
    func edit(_ toDoItem: toDoItem,_ row: Int, _ section:Int) {
        if let index = tableView.indexPathForSelectedRow {
            toDoItems[index.section].remove(at:index.row)
            toDoItems[index.section].insert(toDoItem, at: index.row)
            tableView.reloadRows(at: [index], with: .automatic)
            tableView.deselectRow(at: index, animated: true)
        }
        let index = IndexPath(row: row, section: section)
        toDoItems[section].remove(at:row)
        toDoItems[section].insert(toDoItem, at:row)
        tableView.reloadRows(at: [index], with: .automatic)
        tableView.deselectRow(at: index, animated: true)
        print(row,section)
        print(toDoItem)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.isUserInteractionEnabled = false
        tableView.allowsSelection = false
        tableView.deselectRow(at: indexPath, animated: false)
        }
    


    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return  toDoItems[section].count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! toDoTableViewCell
        cell.nameLabel.text = toDoItems[indexPath.section][indexPath.row].name
        cell.dateLabel.text = "Deadline : \(toDoItems[indexPath.section][indexPath.row].date)"
        cell.showsReorderControl = true
        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let addEditVC = AddToDoTableViewController(style: .grouped)
        addEditVC.delegate = self
        addEditVC.toDoItem = toDoItems[indexPath.section][indexPath.row]
        addEditVC.row = indexPath.row
        addEditVC.section = indexPath.section
        let addToDoVC = UINavigationController(rootViewController: addEditVC)
        present(addToDoVC, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removedToDoItem = toDoItems.remove(at: sourceIndexPath.row)
        toDoItems.insert(removedToDoItem, at: destinationIndexPath.row)
    }
}
