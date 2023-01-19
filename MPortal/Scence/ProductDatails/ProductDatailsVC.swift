//
//  ProductDatailsVC.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH

class ProductDatailsVC: UIViewController {

    @IBOutlet weak var sliderCV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageControlView: UIView!
    @IBOutlet weak var datesView: UIView!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var pricesCV: UICollectionView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var sellerTitleLbl: UILabel!
    @IBOutlet weak var sellerNameLbl: UILabel!
    @IBOutlet weak var sellerNumberLbl: UILabel!
    @IBOutlet weak var productsNumLbl: UILabel!
    @IBOutlet weak var biddersTV: UITableView!
    @IBOutlet weak var bidderTVHeight: NSLayoutConstraint!
    @IBOutlet weak var productsTV: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    
    
    var timer : Timer?
    var coordinator: HomeCoordinator?
    var currentIndex = 0
    var ads_banners = [Ads_banners]()
    var tVCellHeight: CGFloat = 56*iPhoneXFactor
    var tvCellHeaderHight: CGFloat = 44*iPhoneXFactor
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.biddersTV.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.biddersTV.removeObserver(self, forKeyPath: "contentSize", context: nil)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        dismiss()
    }
    
}

extension ProductDatailsVC{
    func initUI(){
        
        
        if MOLHLanguage.isArabic(){
            self.sendBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        initTV(tvs: [biddersTV,productsTV])
        productsNumLbl.customLabel(color: .C808080, size: .size_11, font: .W300, text: "٤ منتجات")
        sellerTitleLbl.customLabel(color: .C1D1D1D, size: .size_14, font: .W300, text: "البائع")
        sellerNumberLbl.customLabel(color: .C44215D, size: .size_12, font: .W300, text: "+966598398")
        
        sellerNameLbl.customLabel(color: .C44215D, size: .size_14, font: .W400, text: "إسم البائع")
        print(ads_banners, "THIS IS ADS BANNER")
        timeView.circleCornerRadius()
        priceTxtField.customTxtField(color: .C44215D, size: .size_13, font: .W400, placeholder: "اكتب المبلغ", text: "")
        priceView.addRadius(radius: 6)
        sendView.addShadow()
        datesView.addRadius(radius: 13)
        datesView.addShadow()
        pageControlView.circleCornerRadius()
        print(ads_banners.count, "ads_banners count")
        startTimer()
        initCV(cvs: [sliderCV,pricesCV])
        pageControl.numberOfPages = ads_banners.count
    }
    func initTV(tvs: [UITableView]){
        for tv in tvs{
            tv.delegate = self
            tv.dataSource = self
            
        }
        tvs[0].registerNib(cellClass: BiddersTVCell.self)
        tvs[0].registerNib(cellClass: BiddersTVHeaderCell.self)
        tvs[1].registerNib(cellClass: ProductsTVCell.self)
        tvs[1].registerNib(cellClass: ProductsTVHeaderCell.self)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                    bidderTVHeight.constant = newSize.height
                }
            }
        }
        }
    
    func initCV(cvs: [UICollectionView]) {
        for cv in cvs {
            cv.dataSource = self
            cv.delegate = self
        }
        cvs[0].registerCVNib(cell: ImageSliderCVCell.self)
        cvs[0].registerCVNib(cell: VideoSliderCVCell.self)
        cvs[1].registerCVNib(cell: pricesCVCell.self)
        
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction(){
        let desiredScrollPosition = (currentIndex < ads_banners.count - 1) ? currentIndex + 1 : 0
        sliderCV.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
}
extension ProductDatailsVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        coordinator?.openEPlusPackageDetails()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView.tag{
        case 0: return tvCellHeaderHight
        case 1: return tvCellHeaderHight
        default: return tvCellHeaderHight
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch tableView.tag{
        case 0:
            let headerView = tableView.dequeue() as BiddersTVHeaderCell
            return headerView
        case 1:
            let headerView = tableView.dequeue() as ProductsTVHeaderCell
            return headerView
        default:
            let headerView = tableView.dequeue() as ProductsTVHeaderCell
            return headerView
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag{
        case 0: return 3
        case 1: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView.tag{
        case 0: return tVCellHeight
        case 1: return 500
        default: return 500
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag{
        case 0:
            let cell = tableView.dequeue() as BiddersTVCell
            return cell
        default:
            let cell = tableView.dequeue() as ProductsTVCell
            cell.initCell()
            return cell
        }
        
    }
}

extension ProductDatailsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case 0: return ads_banners.count
        case 2: return 6
        default: return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag{
        case 0:
            if ads_banners[indexPath.row].media_type == "video"{
                let cell = collectionView.dequeueCV(index: indexPath) as VideoSliderCVCell
                return cell
            }else{
                let cell = collectionView.dequeueCV(index: indexPath) as ImageSliderCVCell
                cell.initCell(cellData: ads_banners[indexPath.row])
                return cell
            }
        case 2:
            let cell = collectionView.dequeueCV(index: indexPath) as pricesCVCell
//            cell.initCell(data: "rediologySample")
            return cell
        default:
            let cell = collectionView.dequeueCV(index: indexPath) as ImageSliderCVCell
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag{
        case 0: print("Open Slider cell image or go to details screen")
        case 2: print("coordinator?.openLabDetails()")
            //coordinator?.openLabDetails()
        default:print("go to insurance details")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            switch collectionView.tag{
            case 0: return 0
            case 2: return 10
            default: return 10
            }
        }
}
extension ProductDatailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag{
        case 0:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        case 2:
            let colomnNumber: CGFloat = 2.5
            //collection view width
            let collectionViewWidth = collectionView.bounds.width
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let spaceBetweenCells = flowLayout.minimumLineSpacing
            
            let cellWidth = (collectionViewWidth - (spaceBetweenCells*2)) / colomnNumber
            return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
//        case 2: return 6
        default:
            // number of column
            let colomnNumber: CGFloat = 2.0
            //collection view width
            let collectionViewWidth = collectionView.bounds.width
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let spaceBetweenCells = flowLayout.minimumLineSpacing
            
            let cellWidth = (collectionViewWidth - (spaceBetweenCells)) / colomnNumber
            return CGSize(width: cellWidth, height: cellWidth * 0.825)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / sliderCV.frame.size.width)
        pageControl.currentPage = currentIndex
    }
}





