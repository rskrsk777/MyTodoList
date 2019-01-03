//
//  MakeTodoListViewController.swift
//  MyTodoList
//  Copyright © 2018 ryosuke kubo. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MakeTodoListViewController: UIViewController {

    var scroll = UIScrollView()
    var todoLabel: UILabel!
    var todoTextField: UITextField!
    var todoDateLabel: UILabel!
    var todoDateTextField: UITextField!
    var todoPriorityLabel: UILabel!
    var todoPriorityTextField: UITextField!
    var datePicker: UIDatePicker!
    var priorityPicker: UIPickerView!
    let priorityNumber = [1, 2, 3, 4, 5]
    var realm: Realm!
    var results: Results<TodoRLMDB>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Todoを入力"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.save))
        scroll.frame = UIScreen.main.bounds
        scroll.backgroundColor = UIColor.white
        scroll.contentMode = UIView.ContentMode.bottom
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width, height: view.frame.maxY + 200)
        scroll.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapScroll)))
        view.addSubview(scroll)
        // realm
        realm = try! Realm()
        results = realm.objects(TodoRLMDB.self)
        
        // todo label
        todoLabel = UILabel(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoLabel.text = "todoを入力"
        todoLabel.textAlignment = NSTextAlignment.center
        todoLabel.font = UIFont.systemFont(ofSize: 30)
        todoLabel.adjustsFontSizeToFitWidth = true
        scroll.addSubview(todoLabel)
        
        // todo label textfield
        todoTextField = UITextField(frame: CGRect(x: 20, y: todoLabel.frame.maxY + 30, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoTextField.placeholder = "todo"
        todoTextField.layer.cornerRadius = 10
        todoTextField.layer.borderWidth = 1
        todoTextField.textAlignment = NSTextAlignment.center
        todoTextField.font = UIFont.systemFont(ofSize: 30)
        todoTextField.adjustsFontSizeToFitWidth = true
        scroll.addSubview(todoTextField)
        
        // todoDateLabel
        todoDateLabel = UILabel(frame: CGRect(x: 20, y: todoTextField.frame.maxY + 60, width: UIScreen.main.bounds.maxX - 40, height: 50))
        print("maxY \(todoTextField.frame.maxY)")
        print("origin.y + frame.height \(todoTextField.frame.origin.y + todoTextField.frame.height)")
        todoDateLabel.text = "Deadline"
        todoDateLabel.textAlignment = NSTextAlignment.center
        todoDateLabel.font = UIFont.systemFont(ofSize: 30)
        todoDateLabel.adjustsFontSizeToFitWidth = true
        scroll.addSubview(todoDateLabel)
        
        // todoDate Textfield
        todoDateTextField = UITextField(frame: CGRect(x: 20, y: todoDateLabel.frame.maxY + 30, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoDateTextField.placeholder = "Deadline"
        todoDateTextField.layer.cornerRadius = 10
        todoDateTextField.layer.borderWidth = 1
        todoDateTextField.textAlignment = NSTextAlignment.center
        todoDateTextField.font = UIFont.systemFont(ofSize: 30)
        todoDateTextField.adjustsFontSizeToFitWidth = true
        scroll.addSubview(todoDateTextField)
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/mm/dd"
        
        // todo priority label
        todoPriorityLabel = UILabel(frame: CGRect(x: 20, y: todoDateTextField.frame.maxY + 60, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoPriorityLabel.text = "Priority value"
        todoPriorityLabel.textAlignment = NSTextAlignment.center
        todoPriorityLabel.font = UIFont.systemFont(ofSize: 30)
        todoDateTextField.adjustsFontSizeToFitWidth = true
        scroll.addSubview(todoPriorityLabel)
        
        // todo priority textfield
        todoPriorityTextField = UITextField()
        todoPriorityTextField.placeholder = "Priority"
        todoPriorityTextField.layer.cornerRadius = 10
        todoPriorityTextField.layer.borderWidth = 1
        todoPriorityTextField.font = UIFont.systemFont(ofSize: 30)
        todoPriorityTextField.textAlignment = NSTextAlignment.center
        todoPriorityTextField.adjustsFontSizeToFitWidth = true
        scroll.addSubview(todoPriorityTextField)
        // translatesAutoresizingMaskIntoConstraintsをfalseにしないとエラーになる
        todoPriorityTextField.translatesAutoresizingMaskIntoConstraints = false
        // todoPriorityLabelの左端(leadingAnchor)と同じにする
        todoPriorityTextField.leadingAnchor.constraint(equalTo: todoPriorityLabel.leadingAnchor).isActive = true
        // todoPriorityLabelの最下部(bottomAnchor)より30pt下にする
        todoPriorityTextField.topAnchor.constraint(equalTo: todoPriorityLabel.bottomAnchor, constant: 30).isActive = true
        // todoPriorityLabelと横幅を同じにする
        todoPriorityTextField.widthAnchor.constraint(equalTo: todoPriorityLabel.widthAnchor).isActive = true
        todoPriorityTextField.heightAnchor.constraint(equalTo: todoPriorityLabel.heightAnchor).isActive = true
        todoPriorityTextField.text = "1"
        // DatePicker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        todoDateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControl.Event.valueChanged)
        // toolbar
        let dateToolbar = UIToolbar()
        let dateToolBarItem = UIBarButtonItem(title: "done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.pushDoneBtn))
        dateToolbar.sizeToFit()
        dateToolbar.items = [dateToolBarItem]
        todoDateTextField.inputAccessoryView = dateToolbar
        
        // pickerview
        priorityPicker = UIPickerView()
        priorityPicker.delegate = self
        priorityPicker.dataSource = self
        
        // toolbar
        let priorityToolBar = UIToolbar()
        let priorityBarItem = UIBarButtonItem(title: "done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.pushDoneBtnPriority))
        priorityToolBar.sizeToFit()
        priorityToolBar.items = [priorityBarItem]
        todoPriorityTextField.inputView = priorityPicker
        todoPriorityTextField.inputAccessoryView = priorityToolBar
    
        
    }

    @objc func save() {
        guard let todo = todoTextField.text else {
            return
        }
        guard  let date = todoDateTextField.text else {
            return
        }
        guard let priority = todoPriorityTextField.text else {
            return
        }
        
        try! realm.write {
            realm.add(TodoRLMDB(value: ["todoName": todo, "todoDate": date, "todoPriority": Int(priority)!]))
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func datePickerValueChanged() {
        print(datePicker.date)
    }
    
    @objc func pushDoneBtn() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MMMM/dd"
        todoDateTextField.text = formatter.string(from: datePicker.date)
        todoDateTextField.resignFirstResponder()
    }
    
    @objc func pushDoneBtnPriority() {
        todoPriorityTextField.resignFirstResponder()
    }
    

    
    @objc func tapScroll() {
        scroll.endEditing(true)
    }
}


extension MakeTodoListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityNumber.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(priorityNumber[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 選択されたときのコード
        todoPriorityTextField.text = String(priorityNumber[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension MakeTodoListViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        todoTextField.text = textField.text
        textField.resignFirstResponder()
    }
    
}
