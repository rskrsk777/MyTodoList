//
//  TodoListViewController.swift
//  MyTodoList
//  Copyright © 2018 ryosuke kubo. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Todo List"
        todoTableView = UITableView(frame: view.frame)

        todoTableView.delegate = self
        todoTableView.dataSource = self
        view.addSubview(todoTableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.pushAddBtn(_:)))

        
    }
    
    @objc func pushAddBtn(_ sender: Any) {
        let makeTodoListViewController = MakeTodoListViewController()
        self.navigationController?.pushViewController(makeTodoListViewController, animated: true)
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (appDelegate?.testList.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "todoCell")
        let todoList = appDelegate?.testList[indexPath.row]
        cell.textLabel?.text = todoList
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.detailTextLabel?.text = "member"
        return cell
    }
}
