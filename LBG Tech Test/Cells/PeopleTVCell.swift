//
//  PeopleTVCell.swift
//  LBG Tech Test
//
//  Created by Nithin Cheruthala on 20/10/2022.
//

import UIKit
class PeopleTVCell: UITableViewCell {
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var jobTitleLbl : UILabel!
    @IBOutlet weak var profilePicImgVw: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func bindData(_ people: PeopleViewModel){
        self.nameLbl.text = people.firstName + " " + people.lastName
        self.jobTitleLbl.text = people.jobtitle
        if let url = URL(string: people.avatar) {
            self.profilePicImgVw.downloadedFrom(url: url)
        }
    }
}

extension PeopleTVCell: ReusableView { }
extension PeopleTVCell: NibLoadableView {}
