//
//  ViewController.swift
//  fastImageDemo
//
//  Created by  green on 15/10/13.
//  Copyright © 2015年 com.fgl. All rights reserved.
//

import UIKit
import Alamofire
import FastImageCache

class PhotoBrowserViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let formatName = KMSmallImageFormatName
    
    var photos = [PhotoInfo]()
    let refreshControl = UIRefreshControl()
    
    let PhotoBrowserCellIdentifier = "PhotoBrowserCell"
    
    // MARK: Life-cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        handleRefresh()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Set Up
    
    private func setUp() {
        
        setUpCollectiionViewLayout()
        setUpCollectionView()
        setUpRefreshControl()
    }
    
    /**
    设置CollectionView布局
    */
    private func setUpCollectiionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (view.bounds.size.width - 2) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)
        collectionView!.collectionViewLayout = layout
    }
    
    /**
    设置CollectionView
    */
    private func setUpCollectionView() {
        
        collectionView!.registerClass(PhotoBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoBrowserCellIdentifier)
    }
    
    /**
    设置下拉刷新
    */
    private func setUpRefreshControl() {
        
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
        collectionView!.addSubview(refreshControl)
    }
    
    func handleRefresh() {
        
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://file25.mafengwo.net/M00/E9/A0/wKgB4lNsRQaAZNWkAAmyI-GLJJQ18.rbook_comment.w470.jpeg")!))
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://file20.mafengwo.net/M00/AD/8A/wKgB21BdjCatOGGdAAuemwyJrdE92.m_rbook_comment.w475.jpeg")!))
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://file21.mafengwo.net/M00/E8/1B/wKgB3FFGyk-AcDBRAAw51-Qie5Y55.m_rbook_comment.w475.jpeg")!))
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://file26.mafengwo.net/M00/E3/9B/wKgB4lMJTjuATDl3AAE6bJLxcps24.rbook_comment.w535.jpeg")!))
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://file27.mafengwo.net/M00/91/B0/wKgB6lRQR8mAZ9acAAIByPyBbUs94.sales.w400_h268.jpeg")!))
        
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://pic41.nipic.com/20140521/4619680_130452333000_2.jpg")!))
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://img5.imgtn.bdimg.com/it/u=1465053960,2685072887&fm=21&gp=0.jpg")!))
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://h.hiphotos.baidu.com/image/h%3D200/sign=3497f1919645d688bc02b5a494c37dab/f703738da97739124471bdc3fc198618367ae239.jpg")!))
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://v1.qzone.cc/avatar/201408/22/21/13/53f741f95904e103.jpg!200x200.jpg")!))
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://m.tuniucdn.com/filebroker/cdn/res/bf/93/bf93969f0a6dc912965a21e1cc7fdce3_w500_h280_c1_t0.jpg")!))
        
        photos.append(PhotoInfo(sourceImageURL: NSURL(string: "http://m.tuniucdn.com/filebroker/cdn/olb/1f/31/1f316d656ee170c083b93ebcb6ee761b_w800_h0_c0_t0.jpg")!))
        
        refreshControl.endRefreshing()
        collectionView!.reloadData()
        
    }
    
    // MARK: CollectionView
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCollectionViewCell
        let sharedImageCache = FICImageCache.sharedImageCache()
        cell.imageView.image = nil
        
        let photo = photos[indexPath.row] as PhotoInfo
        if (cell.photoInfo != photo) {
            
            sharedImageCache.cancelImageRetrievalForEntity(cell.photoInfo, withFormatName: formatName)
            
            cell.photoInfo = photo
        }
        
        sharedImageCache.retrieveImageForEntity(photo, withFormatName: formatName, completionBlock: {
            (photoInfo, _, image) -> Void in
            if (photoInfo as! PhotoInfo) == cell.photoInfo {
                cell.imageView.image = image
            }
        })
        
        return cell
    }


}

