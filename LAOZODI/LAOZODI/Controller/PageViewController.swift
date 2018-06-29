//
//  PageViewController.swift
//  LAOZODI
//
//  Created by NguyenThanhTri on 6/29/18.
//  Copyright © 2018 Phạm Anh Tuấn. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let WIDTH = UIScreen.main.bounds.width
    let images: [String] = ["banner1.jpg","banner2.jpg","banner3.jpg"]
    fileprivate var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    fileprivate var currentPage = 0
    fileprivate var timer: Timer?
    var loadingTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        pageControl.numberOfPages = 3
        configUI()
        loadImageAndShow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingTime = 0
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateLoadingBar), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
        timer = nil
    }
    
    func configUI(){
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.scrollViewTapped(_:)))
        scrollView.addGestureRecognizer(tapAction)
    }
    
    @objc func updateLoadingBar(){
        loadingTime += 1
        if loadingTime == 200 {
            loadingTime = 0
            currentPage += 1
            if(currentPage >= 3){
                currentPage = 0
            }
            scrollView.setContentOffset(CGPoint(x: Int(WIDTH) * currentPage, y: 0), animated: true)
            pageControl.currentPage = currentPage
        }
    }
    
    func loadImageAndShow(){
        for i in 0..<images.count{
            frame.origin.x = WIDTH * CGFloat(i)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[i])
            self.scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: WIDTH * CGFloat(images.count), height: scrollView.frame.size.height)
    }
    
    @objc func scrollViewTapped(_ sender: UITapGestureRecognizer? = nil){
        print(currentPage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PageViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / WIDTH)
        pageControl.currentPage = currentPage
    }
    
}
