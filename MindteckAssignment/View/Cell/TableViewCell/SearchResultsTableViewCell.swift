//
//  SearchResultsTableViewCell.swift
//  MindteckAssignment
//
//  Created by MAC on 14/08/21.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var txtSearchName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfiguration(searchData:SearchResultsModel){
        searchImage.image = searchData.image
        txtSearchName.text = searchData.name
    }
}
