//
//  ImagesCarouselTableViewCell.swift
//  MindteckAssignment
//
//  Created by MAC on 14/08/21.
//

import UIKit

class ImagesCarouselTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imagesSliderCallBack: ((Int) -> Void)?

    var carouselImageArray = CarouselImages()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            // Put your code which should be executed with a delay here
            
            pageControl.numberOfPages = carouselImageArray.objectsArray.count
            // TODO: need to setup collection view flow layout
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: self.collectionView.frame.size.width , height: 216)
            flowLayout.minimumLineSpacing = 2.0
            flowLayout.minimumInteritemSpacing = 5.0
            self.collectionView.collectionViewLayout = flowLayout
            self.collectionView.showsHorizontalScrollIndicator = false
            
            // Comment if you set Datasource and delegate in .xib
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            
            // Register the xib for collection view cell
            let cellNib = UINib(nibName: Constant.ImageCollectionViewCell, bundle: nil)
            self.collectionView.register(cellNib, forCellWithReuseIdentifier: Constant.ImageCarouselCell)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        self.pageControl.currentPage = indexPath.row
        imagesSliderCallBack?(indexPath.row )
    }
    
}

extension ImagesCarouselTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselImageArray.objectsArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.ImageCarouselCell, for: indexPath) as! ImageCollectionViewCell
        cell.carouseImageView.image = carouselImageArray.objectsArray[indexPath.row].image
                return cell
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
