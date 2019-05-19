//
//  UserTableViewCell.swift
//  MindValleyAssignment
//
//  Created by Soham Ray on 15/05/19.
//  Copyright © 2019 MindValley. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var uploadedImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        userImage.image = nil
        uploadedImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithUser(data : UserListReponseElement) {
        activityIndicator.startAnimating()
        let url = URL(string: (data.user?.profileImage?.medium)!)!
        ImageCacher.shared.image(with: url, progress: nil) { [weak self] (image) in
            self?.userImage?.image = image
        }
        let uploadedImageURL = URL(string: (data.urls?.regular)!)!
        ImageCacher.shared.image(with: uploadedImageURL, progress: nil) { [weak self] (image) in
            self?.activityIndicator.stopAnimating()
            self?.uploadedImage?.image = image
        }
        nameLabel.text = data.user?.name!
        likeCountLabel.text = "\(data.likes!)"
    }

}
