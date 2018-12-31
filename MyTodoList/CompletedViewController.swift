//
//  CompletedViewController.swift
//  MyTodoList
//
//  Created by ryosuke kubo on 2018/12/31.
//  Copyright © 2018 ryosuke kubo. All rights reserved.
//

import UIKit

class CompletedViewController: UIViewController {
    
    var completedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Completed Todo"
        
        completedTableView = UITableView(frame: view.frame)
        completedTableView.dataSource = self
        completedTableView.delegate = self
        view.addSubview(completedTableView)
    }
    

}

extension CompletedViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "completedCell")
        return cell
    }
}
