//
//  ViewController.swift
//  MindteckAssignment
//
//  Created by MAC on 14/08/21.
//

import UIKit

class CategoryListViewController: UIViewController,UISearchBarDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable declaration
    var searchArrayList = SearchImages()
    var searchResultList = [SearchResultsModel]()
    var selectedIndex = Int()
    var imagesCarouselCell: ImagesCarouselTableViewCell?
    var searchHeader:SearchTableViewHeaderCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResultList = self.searchArrayList.objectsArray[self.selectedIndex].searchResultList
        
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.estimatedSectionHeaderHeight = 64
        
        // Register the xib for tableview cell
        let cellNib = UINib(nibName: Constant.ImagesCarouselTableViewCell, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: Constant.ImagesCarouselTableViewCell)
        
        // Do any additional setup after loading the view.
    }

}


// MARK: - TableViewConfiguration
private typealias CategoryListTableViewConfiguration = CategoryListViewController
extension CategoryListTableViewConfiguration: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return self.searchResultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed(Constant.SearchResultsTableViewCell, owner: self, options: nil)?.first as! SearchResultsTableViewCell
        cell.cellConfiguration(searchData: (self.searchResultList[indexPath.row]))
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if section == 0{
            if imagesCarouselCell == nil{
                imagesCarouselCell = Bundle.main.loadNibNamed(Constant.ImagesCarouselTableViewCell, owner: self, options: nil)?.first as? ImagesCarouselTableViewCell
                imagesCarouselCell?.imagesSliderCallBack = { (index) -> () in
                    print(index)
                    self.selectedIndex = index
                    self.searchResultList = self.searchArrayList.objectsArray[self.selectedIndex].searchResultList
                    self.tableView.reloadData()
                }
            }
            return imagesCarouselCell!
        }
        if section == 1{
            if searchHeader == nil{
                searchHeader = Bundle.main.loadNibNamed(Constant.SearchTableViewHeaderCell, owner: self, options: nil)?.first as? SearchTableViewHeaderCell
                searchHeader?.searchTextCallBack = { (searchText) -> () in
                    print(searchText)
                    self.searchResultList = self.searchArrayList.objectsArray[self.selectedIndex].searchResultList
                    if searchText != ""{
                        self.searchResultList = self.searchResultList.filter { $0.name.contains(searchText) }
                    }
                    tableView.reloadSections(IndexSet(integer: 1), with: .none)
                }
            }
            return searchHeader
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
