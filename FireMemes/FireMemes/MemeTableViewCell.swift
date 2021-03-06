//
//  MemeTableViewCell.swift
//  FireMemes
//
//  Created by Jose Melendez on 6/7/17.
//  Copyright © 2017 Colton. All rights reserved.
//

import UIKit
import Social
import Lottie

class MemeTableViewCell: UITableViewCell {
    
    //Variables
    var upVoteCount = 0
    var hasBeenUpvoted = false
    
    //MARK: - Outlets and Actions
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var numberOfUpvotes: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    
    //each cell will have a meme
    
    //Animation for Likes
  
    //Delegates
    var delegate: MemeTableViewCellDelegate?
    
    
    //actions for each button here

    @IBAction func commentButtonTapped(_ sender: Any) {
        delegate?.commentButtonTapped(self)
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        delegate?.facebookClicked(self, image: memeImageView.image!)
    }
    
    @IBAction func twitterButtonTapped(_ sender: Any) {
        delegate?.twitterClicked(self, image: memeImageView.image!)
    }
    
    @IBAction func messageButtonTapped(_ sender: Any) {
        delegate?.messageClicked(self, image: memeImageView.image!)
    }
  
    @IBAction func upvoteButtonTapped(_ sender: Any) {
        delegate?.upVoteButtonTapped(sender: self, hasBeenUpvoted: hasBeenUpvoted)
    }
    
    @IBAction func reportButtonTapped(_ sender: Any) {
        delegate?.reportButtonTapped(sender: self)
    }
    
    func didDoubleTap(recognizer: UIGestureRecognizer) {
        delegate?.doubleTapUpVote(sender: self, hasBeenUpvoted: hasBeenUpvoted, recognizer: recognizer)
    }
    
}

//MARK: - UpdateViews Method

extension MemeTableViewCell {
    
    func updateViews(meme: Meme, upVoteCount: Int, hasUpvoted: Bool) {
        
        memeImageView.image = meme.image
        numberOfComments.text = "\(meme.comments.count)"
        
        facebookButton.layer.cornerRadius = 15
        twitterButton.layer.cornerRadius = 15
        
        facebookButton.layer.borderColor = UIColor.black.cgColor
        twitterButton.layer.borderColor = UIColor.black.cgColor
        
        facebookButton.layer.borderWidth = 0.5
        twitterButton.layer.borderWidth = 0.5
        
        //let voteNumber = upVoteCount
        numberOfUpvotes.text = "\(upVoteCount)"
        if hasUpvoted == true {
            numberOfUpvotes.textColor = .red
         
        } else {
            numberOfUpvotes.textColor = .black
        }
        
        //Adding Tap gesture recognizer, So user can like image
        let didLikedImage = UITapGestureRecognizer(target: self, action: #selector(MemeTableViewCell.didDoubleTap(recognizer:)))
        
        //requires two taps for didLikeImage recognizer
        didLikedImage.numberOfTapsRequired = 2
        
        //Add didLikeGesture to tableView
        self.addGestureRecognizer(didLikedImage)
        
    }
}
//Protocols
protocol MemeTableViewCellDelegate: class{
    
    func facebookClicked(_ sender: MemeTableViewCell, image: UIImage)
    
    func twitterClicked(_ sender: MemeTableViewCell, image: UIImage)
    
    func messageClicked(_ sender: MemeTableViewCell, image: UIImage)
    
    func commentButtonTapped(_ sender: MemeTableViewCell)
    
    func reportButtonTapped(sender: MemeTableViewCell)
    
    func upVoteButtonTapped(sender: MemeTableViewCell, hasBeenUpvoted: Bool)
    
    func doubleTapUpVote(sender: MemeTableViewCell, hasBeenUpvoted: Bool, recognizer: UIGestureRecognizer)

}

