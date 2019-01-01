//
//  MakeTodoListViewController.swift
//  MyTodoList
//  Copyright © 2018 ryosuke kubo. All rights reserved.
//

import UIKit

class MakeTodoListViewController: UIViewController {
    
    var todoLabel: UILabel!
    var todoTextField: UITextField!
    var todoDateLabel: UILabel!
    var todoDateTextField: UITextField!
    var todoPriorityLabel: UILabel!
    var todoPriorityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Todoを入力"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        // todo label
        todoLabel = UILabel(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoLabel.text = "todoを入力"
        todoLabel.textAlignment = NSTextAlignment.center
        todoLabel.font = UIFont.systemFont(ofSize: 30)
        todoLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(todoLabel)
        
        // todo label textfield
        todoTextField = UITextField(frame: CGRect(x: 20, y: todoLabel.frame.maxY + 30, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoTextField.placeholder = "todo"
        todoTextField.layer.cornerRadius = 10
        todoTextField.layer.borderWidth = 1
        todoTextField.textAlignment = NSTextAlignment.center
        todoTextField.font = UIFont.systemFont(ofSize: 30)
        todoTextField.adjustsFontSizeToFitWidth = true
        view.addSubview(todoTextField)
        
        // todoDateLabel
        todoDateLabel = UILabel(frame: CGRect(x: 20, y: todoTextField.frame.maxY + 60, width: UIScreen.main.bounds.maxX - 40, height: 50))
        print("maxY \(todoTextField.frame.maxY)")
        print("origin.y + frame.height \(todoTextField.frame.origin.y + todoTextField.frame.height)")
        todoDateLabel.text = "Deadline"
        todoDateLabel.textAlignment = NSTextAlignment.center
        todoDateLabel.font = UIFont.systemFont(ofSize: 30)
        todoDateLabel.adjustsFontSizeToFitWidth = true
        todoDateLabel.layer.shadowOpacity = 0.2
        view.addSubview(todoDateLabel)
        
        // todoDate Textfield
        todoDateTextField = UITextField(frame: CGRect(x: 20, y: todoDateLabel.frame.maxY + 30, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoDateTextField.placeholder = "Deadline"
        todoDateTextField.layer.cornerRadius = 10
        todoDateTextField.layer.shadowOpacity = 0.2
        todoDateTextField.layer.borderWidth = 1
        todoDateTextField.textAlignment = NSTextAlignment.center
        todoDateTextField.font = UIFont.systemFont(ofSize: 30)
        todoDateTextField.adjustsFontSizeToFitWidth = true
        view.addSubview(todoDateTextField)
        
        // todo priority label
        todoPriorityLabel = UILabel(frame: CGRect(x: 20, y: todoDateTextField.frame.maxY + 60, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoPriorityLabel.text = "Priority value"
        todoPriorityLabel.textAlignment = NSTextAlignment.center
        todoPriorityLabel.font = UIFont.systemFont(ofSize: 30)
        todoDateTextField.adjustsFontSizeToFitWidth = true
        view.addSubview(todoPriorityLabel)
        
        // todo priority textfield
        todoPriorityTextField = UITextField(frame: CGRect(x: 20, y: todoPriorityLabel.frame.maxY + 30, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoPriorityTextField.placeholder = "Priority"
        todoPriorityTextField.layer.cornerRadius = 10
        todoPriorityTextField.layer.shadowOpacity = 0.2
        todoPriorityTextField.layer.borderWidth = 1
        todoPriorityTextField.font = UIFont.systemFont(ofSize: 30)
        todoPriorityTextField.textAlignment = NSTextAlignment.center
        todoPriorityTextField.adjustsFontSizeToFitWidth = true
        view.addSubview(todoPriorityTextField)
    }

}
