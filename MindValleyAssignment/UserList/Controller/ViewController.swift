//
//  ViewController.swift
//  MindValleyAssignment
//
//  Created by Soham Ray on 08/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var userVM = UserViewModel()
    var userTableViewManger: UserTableViewManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
        getUserData()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 180
        userTableViewManger = UserTableViewManager(tableView: tableView, delegate: self)
        tableView.delegate = userTableViewManger
        tableView.dataSource = userTableViewManger
    }
    
    func getUserData() {
        userVM.getUserData { [weak self] (status) in
            if status {
                self?.userTableViewManger.users.append(contentsOf: self?.userVM.users ?? [])
                self?.userTableViewManger.isLoading = false
                self?.userTableViewManger.tableView.reloadData()
            } else {
                print(self?.userVM.failureMessage)
            }
        }
    }
    
}

// Mocking Pagination from frontend
extension ViewController: UserTableLoadMoreDelegate {
    func loadMore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.getUserData()
        }
    }
}
