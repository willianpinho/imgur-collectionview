//
//  ViewController.swift
//  Imgur CollectionView
//
//  Created by Willian Junior Peres De Pinho on 15/03/20.
//  Copyright © 2020 Willian Pinho. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data = [GalleryItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupCollectionView()
        GalleryService.getCats { (e,items) in
            if let cats = items {
                self.data = cats
            }
            self.collectionView.reloadData()
        }
        
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }
        let gi = data[indexPath.row]
        cell.galleryItemImageView.kf.indicatorType = .activity
        cell.galleryItemImageView.kf.setImage(with: URL(string: gi.itemUrl))
        return cell
    }
}

