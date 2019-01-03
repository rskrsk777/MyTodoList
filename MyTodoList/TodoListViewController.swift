//
//  TodoListViewController.swift
//  MyTodoList
//  Copyright © 2018 ryosuke kubo. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class TodoListViewController: UIViewController {

    var todoTableView: UITableView!
    var realm: Realm!
    var results: Results<TodoRLMDB>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Todo List"
        todoTableView = UITableView(frame: view.frame)

        todoTableView.delegate = self
        todoTableView.dataSource = self
        view.addSubview(todoTableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.pushAddBtn(_:)))
        
        let documentDirPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(documentDirPath)
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        try! realm = Realm()
        results = realm.objects(TodoRLMDB.self)
        try! realm.write {
            realm.add(TodoRLMDB(value: ["todoName": "aaa", "todoDate": "1991/1/1", "todoPriority": 3]))
        }
        print(type(of: results[0]))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("viewDidAppear")
        todoTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
    }
    
    @objc func pushAddBtn(_ sender: Any) {
        let makeTodoListViewController = MakeTodoListViewController()
        self.navigationController?.pushViewController(makeTodoListViewController, animated: true)
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "todoCell")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.textLabel?.text = results[indexPath.row].todoName
        cell.detailTextLabel?.text = "Deadline: " + results[indexPath.row].todoDate + "  Priority: " + String(results[indexPath.row].todoPriority)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap cell")
        let cell = tableView.cellForRow(at: indexPath)
        guard let cellTitle = cell?.textLabel?.text else {
            return
        }
        guard let cellDetail = cell?.detailTextLabel?.text else {
            return
        }
        let alert = UIAlertController(title: "\(cellTitle)", message: "\(cellDetail)", preferredStyle: UIAlertController.Style.alert)

        let complete = UIAlertAction(title: "Complete", style: UIAlertAction.Style.default, handler: { Void in
            try! self.realm.write {
                self.realm.add(TodoCompleted(value: ["todoName": self.results[indexPath.row].todoName, "todoDate": self.results[indexPath.row].todoDate, "todoPriority": self.results[indexPath.row].todoPriority]))
                print("add TodoCompleted")
                self.realm.delete(self.results[indexPath.row])
                print("delete TodoRLMDB")
            }
            self.todoTableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        let delete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive, handler: { Void in
            try! self.realm.write {
                self.realm.delete(TodoRLMDB(value: [self.results[indexPath.row]]))
            }
            self.todoTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        })
        
        alert.addAction(complete)
        alert.addAction(delete)
        present(alert, animated: true, completion: nil)

    }
}
