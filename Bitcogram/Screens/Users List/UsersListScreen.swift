//
//  UsersListScreen.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/10/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Parse

class UsersListScreen : UIViewController, UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {
    
    var users = [PFObject]()
    let usersTableView = UITableView()
    private let userCellIdentifier = "UserCellIdentifier"
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        self.startAnimating()
        getUsers()
    }
    
    func createUI(in container: UIView) {
        
        navigationItem.title = "Users"
        
        container.backgroundColor = .white
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        usersTableView.addSubview(refreshControl)
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.register(UserCellIdentifier.self, forCellReuseIdentifier: userCellIdentifier)
        usersTableView.backgroundColor = .clear
        usersTableView.separatorColor = .lightGray
        usersTableView.delaysContentTouches = false
        container.addSubview(usersTableView)
        
        usersTableView.snp.makeConstraints { make -> Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func didPullToRefresh() {
        getUsers()
        
        // For End refrshing
        refreshControl.endRefreshing()
    }
    
    func getUsers() {
        let query = PFUser.query()
        query?.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            self.stopAnimating()
            if let error = error {
                print(error.localizedDescription)
            } else if let objects = objects {
                self.users = objects
                self.usersTableView.reloadData()
            }
        }
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileViewController = ProfileUserScreen()
        profileViewController.userFromSearch = true
        profileViewController.currentUser = users[indexPath.row] as? PFUser
        self.navigationController?.pushViewController(profileViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier, for: indexPath) as! UserCellIdentifier
        
        let user:PFUser = users[indexPath.row] as! PFUser
        cell.customize(with: user)
        
        return cell
    }
}
