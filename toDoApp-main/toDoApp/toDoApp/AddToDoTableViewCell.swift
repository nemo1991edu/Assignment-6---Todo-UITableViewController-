//
//  AddToDoTableViewCell.swift
//  toDoApp
//
//

import UIKit

class AddToDoTableViewCell: UITableViewCell {

    let textField:UITextField = {
        let field = UITextField()
       
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
        textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        textField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
        textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class AddToDoTableViewCell2: UITableViewCell {

    let textField:UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
        textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        textField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
        textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
       let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        contentView.addGestureRecognizer((tapGesture))
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        contentView.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        textField.text = dateFormatter.string(from: datePicker.date)
        contentView.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
