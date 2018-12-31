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
        todoLabel = UILabel(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.maxX - 40, height: 50))
        todoLabel.text = "todoを入力"
        todoLabel.textAlignment = .center
        todoLabel.font = UIFont.systemFont(ofSize: 30)
        todoLabel.adjustsFontSizeToFitWidth = true
        todoLabel.backgroundColor = .gray
        view.addSubview(todoLabel)
    }

}
