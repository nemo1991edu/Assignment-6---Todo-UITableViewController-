//
//  AddToDoTableViewController.swift
//  toDoApp
//
//

import UIKit

protocol AddToDoItemDelegate: class{
    func add(_ toDoItem: toDoItem)
    func edit(_ toDoItem: toDoItem,_ row: Int,_ section:Int)
}

class AddToDoTableViewController: UITableViewController {
let headers = ["Name","Due date"]
    let nameCell = AddToDoTableViewCell()
    let dateCell = AddToDoTableViewCell2()
    let saveButton = UIBarButtonItem(barButtonSystemItem:.save, target: self, action: #selector(saveToDo))

    weak var delegate: AddToDoItemDelegate?
    
    var toDoItem: toDoItem?
    var row: Int?
    var section: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItem == nil {
            title = "Add To Do"
        } else {
            title = "Edit To Do"
            nameCell.textField.text = toDoItem?.name
            dateCell.textField.text = toDoItem?.date
        }
           
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissFunc))
        navigationItem.rightBarButtonItem = saveButton

        nameCell.textField.addTarget(self, action: #selector(textEditingChanged), for: .editingChanged)
        
        updateSaveButtonState()
    }

    @objc func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @objc func dismissFunc() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveToDo() {
        if toDoItem == nil {
            let itemToDo = toDoApp.toDoItem(name: nameCell.textField.text! ,date:dateCell.textField.text!)
        delegate?.add(itemToDo)
        } else {
            let itemToDo = toDoApp.toDoItem(name: nameCell.textField.text! ,date: dateCell.textField.text!)
            let rowValue = row
            let sectionValue = section
            delegate?.edit(itemToDo, rowValue!, sectionValue!)
            dismissFunc()
        }
        dismissFunc()
    }
    
    private func updateSaveButtonState() {
        let nameText = nameCell.textField.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == [0,0] {
            return nameCell
        } else {
            return dateCell
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
