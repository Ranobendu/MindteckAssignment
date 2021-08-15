//
//  SearchTableViewHeaderCell.swift
//  MindteckAssignment
//
//  Created by MAC on 14/08/21.
//

import UIKit

class SearchTableViewHeaderCell: UITableViewCell {

    @IBOutlet weak var seaarchBar: UISearchBar!
    
    var searchTextCallBack: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SearchTableViewHeaderCell:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTextCallBack?(searchText)
    }
}

