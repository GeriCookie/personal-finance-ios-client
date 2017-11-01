//
//  ChooseColorVC.swift
//  PersonalFinance
//
//  Created by Cookie on 29.10.17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import UIKit

class ChooseColorVC: UIViewController {
    
    var delegate: ChooseColorVCDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.title = "Choose color"
    }

}

extension ChooseColorVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCell {
            cell.configureCell(index: indexPath.item)
            return cell
        }
        
        return ColorCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 48
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let offset = 0.2
        let columnsCount = 5
        
        let cellsTotalSize = CGFloat(1 - offset) * collectionView.bounds.width
        let cellSize = cellsTotalSize / CGFloat(columnsCount)
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = CATEGORY_COLORS[indexPath.item]
        delegate?.didChooseColor(color: color)
        self.navigationController?.popViewController(animated: true)
    }
}

protocol ChooseColorVCDelegate {
    func didChooseColor(color: UIColor)
}
