//
//  ProductsTVCell.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 19/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit

class ProductsTVCell: UITableViewCell {

    @IBOutlet weak var productsCV: UICollectionView!

    func initCell(){
        initCV(cv: productsCV)
    }
    func initCV(cv: UICollectionView) {
        cv.dataSource = self
        cv.delegate = self
        cv.registerCVNib(cell: ProductCVCell.self)
    }
    
}


extension ProductsTVCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCV(index: indexPath) as ProductCVCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 12
        }
}
extension ProductsTVCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2.5, height: 190)

    }
}
