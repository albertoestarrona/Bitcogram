//
//  FeedUserScreen.swift
//  Bitcogram
//
//  Created by Alberto R. Estarrona on 5/7/19.
//  Copyright © 2019 Estarrona.me. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Parse

class FeedUserScreen : UIViewController, UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {
 
    var posts = [PFObject]()
    let postsTableView = UITableView()
    private let postCellIdentifier = "PostCellIdentifier"
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI(in: view)
        self.startAnimating()
        getPosts()
    }
    
    func createUI(in container: UIView) {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.tintColor = UIColor.gray
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "isotype_nav")
        imageView.image = image
        navigationItem.titleView = imageView
        
        container.backgroundColor = .white
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        postsTableView.addSubview(refreshControl)
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(PostCellIdentifier.self, forCellReuseIdentifier: postCellIdentifier)
        postsTableView.backgroundColor = .clear
        postsTableView.separatorColor = .clear
        container.addSubview(postsTableView)
        
        postsTableView.snp.makeConstraints { make -> Void in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func didPullToRefresh() {
        print("Refersh")
        getPosts()
        
        // For End refrshing
        refreshControl.endRefreshing()
    }
    
    func getPosts() {
        let query = PFQuery(className:"Post")
        // query.whereKey("playerName", equalTo:"Sean Plott")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            self.stopAnimating()
            if let error = error {
                print(error.localizedDescription)
            } else if let objects = objects {
                self.posts = objects
                self.postsTableView.reloadData()
            }
        }
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO Got to Details
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.width + 190
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier, for: indexPath) as! PostCellIdentifier
        
        cell.selectionStyle = .none
        cell.customize(with: posts[indexPath.row])
        
        return cell
    }
}
