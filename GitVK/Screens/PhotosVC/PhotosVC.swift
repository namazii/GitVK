//
//  PhotosVC.swift
//  GitVK
//
//  Created by Назар Ткаченко on 03.07.2022.
//

import UIKit

final class PhotosVC: UIViewController {
    
    //MARK: - Properties
    var photosAPI = PhotosAPI()
    
    var photos: [Photo] = []
    
    var isPhotosLoading = false
    
    //MARK: - private Properties
    private lazy var collectionView: UICollectionView = {

        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        
        return collectionView
    }()
//    private var collectionView: UICollectionView {
//
//        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewLayout())
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
//
//        return collectionView
//    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchPhotos()
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        view.addSubview(collectionView)
    }

    func fetchPhotos(offset: Int = 0) {
        
        photosAPI.fetchPhotos(offset: offset) { [weak self] photos  in
            guard let self = self else { return }
            
            self.isPhotosLoading = false
            
            if offset == 0 {
//                print("FETCHpHOTOS|| \(photos) |||")
                self.photos = photos
//                print("self Photos|| \(self.photos) |||")
                self.collectionView.reloadData()
                return
            }
            
            self.photos.append(contentsOf: photos)
//            print("self Photos append || \(self.photos) |||")
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension PhotosVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Item selected")
    }
}

//MARK: - UICollectionViewDataSource
extension PhotosVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(photos)
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("COLLECTION VIEW")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        let photo = photos[indexPath.row]
//        print("PHOTO - \(photo)")
        
        cell.configure(photo)
        
//        print("OKK")
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotosVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let inset = 20 // внутренний отступ
        let itemsInRow = 3 // |[]|[]|
        let insetsWidth = inset * (itemsInRow + 1)//ширина отступов всех
        let availableWith = collectionView.bounds.width - CGFloat(insetsWidth)
        let widthForItem = availableWith / CGFloat(itemsInRow)
        
        return CGSize(width: widthForItem, height: widthForItem) //размер ячейки
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) //отступы от секции
    }
}
extension PhotosVC: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        print(indexPaths)
        
        let maxRow = indexPaths.map { $0.last ?? 0 }.max() ?? 0
        
        print(maxRow)
        
        if maxRow > photos.count - 5, isPhotosLoading == false {
            
            isPhotosLoading = true
            fetchPhotos(offset: photos.count)
            collectionView.reloadData()
        }
    }
}
