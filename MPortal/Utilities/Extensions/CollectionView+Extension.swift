//
//  CollectionView+Extension.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 16/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
extension UICollectionView {
    func registerCVNib<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    func dequeueCV<Cell: UICollectionViewCell>(index: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: index) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
}
