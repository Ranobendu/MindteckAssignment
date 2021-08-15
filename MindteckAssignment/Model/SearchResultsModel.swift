//
//  SearchResultsModel.swift
//  MindteckAssignment
//
//  Created by MAC on 15/08/21.
//

import Foundation
import UIKit

struct TableViewCellModel {
    var searchResultList: [SearchResultsModel]
}

struct SearchResultsModel {
    var image: UIImage
    var name: String
}
