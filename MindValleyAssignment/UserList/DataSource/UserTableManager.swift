//
//  UserTableManager.swift
//  MindValleyAssignment
//
//  Created by Soham Ray on 18/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit

protocol UserTableLoadMoreDelegate: class {
    func loadMore()
}


class UserTableViewManager: NSObject  {
    
    var tableView: UITableView
    var users: [UserListReponseElement] = []
    var isLoading = false
    weak var delegate: UserTableLoadMoreDelegate?
    
    init(tableView: UITableView, delegate: UserTableLoadMoreDelegate) {
        self.tableView = tableView
        self.delegate = delegate
    }
}

extension UserTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self), for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        cell.fillWithUser(data: users[indexPath.row])
        return cell
    }
    
    
}

extension UserTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = tableView.numberOfRows(inSection: indexPath.section)
        if indexPath.row == lastRow - 1 && !isLoading {
            // load more
            let view = UIView(frame: cell.contentView.frame)
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.center = view.center
            spinner.startAnimating()
            view.addSubview(spinner)
            tableView.tableFooterView = view
            
            isLoading = true
            delegate?.loadMore()
        }
    }
}
