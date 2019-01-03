//
//  CompletedViewController.swift
//  MyTodoList
//
//  Created by ryosuke kubo on 2018/12/31.
//  Copyright © 2018 ryosuke kubo. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class CompletedViewController: UIViewController {
    
    var completedTableView: UITableView!
    var realm: Realm!
    var results: Results<TodoCompleted>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Completed Todo"
        
        completedTableView = UITableView(frame: view.frame)
        completedTableView.dataSource = self
        completedTableView.delegate = self
        view.addSubview(completedTableView)
        
        realm = try! Realm()
        results = realm.objects(TodoCompleted.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        completedTableView.reloadData()
    }

}


extension CompletedViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "completedCell")
        
        cell.textLabel?.text = results[indexPath.row].todoName
        cell.detailTextLabel?.text = "Date: " + results[indexPath.row].todoName + "  Priority: " + String(results[indexPath.row].todoPriority)
        return cell
    }
}
