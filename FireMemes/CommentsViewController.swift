//
//  CommentsTableViewController.swift
//  FireMemes
//
//  Created by Jose Melendez on 6/13/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    //Mark: Variables/Constants
    let cellSpacingHeight: CGFloat = 7
    
    //MARK: - Outlets and Actions
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBAction func postCommentButton(_ sender: Any) {
        guard let meme = meme else { return }
        guard let comment = commentTextView.text, !comment.isEmpty else { return }
        commentTextView.text = ""
        MemeController.shared.addCommentToMeme(meme: meme, comment: comment)
        tableView.reloadData()
    }
    
   
    
//MARK: - Internal Properties
    
    var meme: Meme?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        hideKeyboardWhenTappedAround()
        
        //Stop the tableView from displaying empty cells
        tableView.tableFooterView = UIView()
        tableView.separatorColor = UIColor.clear
    }
    

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let meme = meme else { return 0 }
        return meme.comments.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsShown", for: indexPath)

        // Configure the cell...
        guard let meme = meme else { return cell }
        
        
        
        let comment = meme.comments[indexPath.row]
        if comment != "" {
            //commentLabel.text = comment
            cell.textLabel?.text = comment
            
            //Multi line comments
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textLabel?.sizeToFit()
            
            //Stylize comments
            cell.textLabel?.textColor = UIColor.gray
            cell.backgroundColor = UIColor.white
            cell.layer.borderColor = UIColor.darkGray.cgColor
            cell.layer.borderWidth = 0.02
            cell.layer.cornerRadius = 3
            cell.clipsToBounds = true
            
        }
        return cell
       
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension UITableViewController {
   override func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
   override func dismissKeyboard() {
        view.endEditing(true)
    }
}
    
