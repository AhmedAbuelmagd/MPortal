//
//  ProductDatailsVC.swift
//  MPortal
//
//  Created by Ahmed Abuelmagd on 14/01/2023.
//  Copyright © 2023 Ahmed Abuelmagd. All rights reserved.
//

import UIKit
import MOLH
import TagListView

class ProductDatailsVC: UIViewController {

    // MARK: - Outlets
    
    // MARK: - Variables & Constants
    
    // MARK: - View Model
    
    // MARK: - View Did Load
    
    // MARK: - Actions
    
    // MARK: - Binding Data
    
    // MARK: - initCell
    @IBOutlet weak var sliderCV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pageControlView: UIView!
    @IBOutlet weak var datesView: UIView!
    @IBOutlet weak var sendView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceTxtField: UITextField!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var sellerTitleLbl: UILabel!
    @IBOutlet weak var sellerNameLbl: UILabel!
    @IBOutlet weak var sellerNumberLbl: UILabel!
    @IBOutlet weak var productsNumLbl: UILabel!
    @IBOutlet weak var biddersTV: UITableView!
    @IBOutlet weak var bidderTVHeight: NSLayoutConstraint!
    @IBOutlet weak var productsTV: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var pricesListView: TagListView!
    @IBOutlet weak var auctionCurrentPriceLbl: UILabel!
    @IBOutlet weak var auctionCPriceValueLbl: UILabel!
    @IBOutlet weak var startAfterLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dateValueLbl: UILabel!
    @IBOutlet weak var dateHourLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var hourLbl: UILabel!
    @IBOutlet weak var minuteLbl: UILabel!
    @IBOutlet weak var buynowBtn: UIButton!
    @IBOutlet weak var withdrawaBtn: UIButton!
    @IBOutlet weak var priceNowTitleLbl: UILabel!
    @IBOutlet weak var priceNowValueLbl: UILabel!
    @IBOutlet weak var auctionPriceNowLbl: UILabel!
    @IBOutlet weak var auctionPriceAfterTaxLbl: UILabel!
    @IBOutlet weak var auctionNameLbl: UILabel!
    @IBOutlet weak var auctionCodeLbl: UILabel!
    @IBOutlet weak var auctionDetailsLbl: UILabel!
    @IBOutlet var arrowsImg: [UIImageView]!
    @IBOutlet weak var auctionRateLbl: UILabel!
    
    var timer : Timer?
    var coordinator: HomeCoordinator?
    var currentIndex = 0
    var ads_banners = [Ads_banners]()
    var tVCellHeight: CGFloat = 56*iPhoneXFactor
    var tvCellHeaderHight: CGFloat = 37
    
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
        for btn in [buynowBtn,withdrawaBtn]{
            btn?.addRadius(radius: 4)
        }
        if MOLHLanguage.isArabic(){
            for arrowImg in arrowsImg{
                arrowImg.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
        }
        auctionNameLbl.customLabel(color: .C1D1D1D, size: .size_18, font: .W600, text: "اسم المزاد")
        auctionCodeLbl.customLabel(color: .C808080, size: .size_13, font: .W300, text: "code 1234")
        auctionDetailsLbl.customLabel(color: .CD20653, size: .size_14, font: .W400, text: "تفاصيل المزاد")
        auctionRateLbl.customLabel(color: .CD20653, size: .size_14, font: .W400, text: "تقييم المزاد")
        auctionPriceNowLbl.customLabel(color: .C808080, size: .size_13, font: .W300, text: "القيمة الحالية للمزاد")
        auctionPriceAfterTaxLbl.customLabel(color: .C808080, size: .size_13, font: .W300, text: "القيمة الحالية بعد الضريبة")
        priceNowTitleLbl.customLabel(color: .C1D1D1D, size: .size_13, font: .W600, text: "سعر الشراء الفوري")
        priceNowValueLbl.customLabel(color: .C44215D, size: .size_18, font: .W600, text: "200 $")
        
        buynowBtn.custom(titleColor: .CFFFFFF, size: .size_12, title: .BUY_NOW)
        withdrawaBtn.custom(titleColor: .CFFFFFF, size: .size_13, title: .WITHDRAWAL)
        dayLbl.customLabel(color: .CFDBC01, size: .size_08, font: .W600, text: "يوم")
        hourLbl.customLabel(color: .CFDBC01, size: .size_08, font: .W600, text: "ساعه")
        minuteLbl.customLabel(color: .CFDBC01, size: .size_08, font: .W600, text: "دقيقة")
        counterLbl.customLabel(color: .CFDBC01, size: .size_18, font: .W600, text: "31 :22:55")
        
        dateValueLbl.customLabel(color: .C44215D, size: .size_18, font: .W600, text: "19-01-2023")
        dateHourLbl.customLabel(color: .C44215D, size: .size_13, font: .W300, text: "13:59:00")
        startAfterLbl.customLabel(color: .C808080, size: .size_11, font: .W300, text: "المزاد يبدأ بعد")
        dateLbl.customLabel(color: .C808080, size: .size_11, font: .W300, text: "بتاريخ")
        
        pricesListView.addTag("+1000")
        pricesListView.addTag("+2000")
        pricesListView.addTag("+3000")
        auctionCPriceValueLbl.customLabel(color: .C44215D, size: .size_21, font: .W500, text: "200 $")
        
        auctionCurrentPriceLbl.customLabel(color: .C1D1D1D, size: .size_13, font: .W300, text: LBLs.AUCTION_CURRENT_PRICE.title)
        if MOLHLanguage.isArabic(){
            self.sendBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        initTV(tvs: [biddersTV,productsTV])
        productsNumLbl.customLabel(color: .C808080, size: .size_11, font: .W300, text: LBLs.PRODUCTS_NUM.title)
        sellerTitleLbl.customLabel(color: .C1D1D1D, size: .size_14, font: .W300, text: LBLs.SELLER.title)
        sellerNumberLbl.customLabel(color: .C44215D, size: .size_12, font: .W300, text: "+966598398")
        sellerNameLbl.customLabel(color: .C44215D, size: .size_14, font: .W400, text: LBLs.SELLER_NAME.title)
        
        timeView.circleCornerRadius()
        priceTxtField.customTxtField(color: .C1D1D1D, size: .size_13, font: .W400, placeholder:TxtFields.WRITE_PRICE.title, text: "")
        priceView.addRadius(radius: 6)

        datesView.addRadius(radius: 6)
        pageControlView.circleCornerRadius()
        print(ads_banners.count, "ads_banners count")
        startTimer()
        initCV(cv: sliderCV)
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
    
    func initCV(cv: UICollectionView) {
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.registerCVNib(cell: ImageSliderCVCell.self)
        cv.registerCVNib(cell: VideoSliderCVCell.self)
        
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction(){
        if !ads_banners.isEmpty{
            let desiredScrollPosition = (currentIndex < ads_banners.count - 1) ? currentIndex + 1 : 0
            sliderCV.scrollToItem(at: IndexPath(item: desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
}
extension ProductDatailsVC: UITableViewDataSource, UITableViewDelegate{

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
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
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
        case 1: return 222
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
        return ads_banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if ads_banners[indexPath.row].media_type == "video"{
            let cell = collectionView.dequeueCV(index: indexPath) as VideoSliderCVCell
            return cell
        }else{
            let cell = collectionView.dequeueCV(index: indexPath) as ImageSliderCVCell
            cell.initCell(cellData: ads_banners[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
}
extension ProductDatailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / sliderCV.frame.size.width)
        pageControl.currentPage = currentIndex
    }
}





