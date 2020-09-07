//
//  ViewController.swift
//  DemoAnimation
//
//  Created by le  anh on 8/31/20.
//  Copyright © 2020 le  anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    var COLOR_GRAY = UIColor(red: 148/255, green: 150/255, blue: 155/255, alpha: 1.0)
    enum CardState {
        case expanded
        case collapsed
    }
    var arrayImportant : [String] = ["IMPORTANT 1", "IMPORTANT 2", "IMPORTANT 3", "IMPORTANT 4"]
    var arrayDocs : [String] = ["Doc 1", "Doc 2", "Doc 3", "Doc 4"]
    var arrayStarred : [String] = ["Starred 1", "Starred 2", "Starred 3", "Starred 4"]
    var arrayNew : [String] = ["New 1", "New 2", "New 3", "new 4"]
    var arrayOther : [String] = ["Other 1", "Other 2", "Other 3", "Other 4"]
    
    
    var arrayTable: [String] = ["IMPORTANT 1", "IMPORTANT 2", "IMPORTANT 3", "IMPORTANT 4"]
    var cardViewController:CardViewController!
    var visualEffectView:UIVisualEffectView!
    
    var cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 80
    
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    var indexSelectedTab : Int = 0
    
    //Label tab
    @IBOutlet weak var viewLine: UIView!
    
    @IBOutlet weak var viewTab1: UIView!
    @IBOutlet weak var lbTab1: UILabel!
    
    @IBOutlet weak var viewTab2: UIView!
    @IBOutlet weak var labelTab2: UILabel!
    @IBOutlet weak var labelNumberTab2: UILabel!
    
    @IBOutlet weak var viewTab3: UIView!
    @IBOutlet weak var labelTab3: UILabel!
    @IBOutlet weak var labelNumberTab3: UILabel!
    
    @IBOutlet weak var viewTab4: UIView!
    @IBOutlet weak var labelTab4: UILabel!
    @IBOutlet weak var labelNumber4: UILabel!
    
    @IBOutlet weak var viewTab5: UIView!
    @IBOutlet weak var labelTab5: UILabel!
    @IBOutlet weak var labelNumber5: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var tblViewController: UITableView!
    var arrayLabelTab : [UILabel] = []
    var arrayLabelNumber : [UILabel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        cardHeight = self.view.frame.height - 60
        setupCard()
        self.scrollView.delegate = self
        
        //Array Label Tab
        self.arrayLabelTab.append(lbTab1)
        self.arrayLabelTab.append(labelTab2)
        self.arrayLabelTab.append(labelTab3)
        self.arrayLabelTab.append(labelTab4)
        self.arrayLabelTab.append(labelTab5)
        
        //Array Label number
        self.arrayLabelNumber.append(labelNumberTab2)
        self.arrayLabelNumber.append(labelNumberTab3)
        self.arrayLabelNumber.append(labelNumber4)
        self.arrayLabelNumber.append(labelNumber5)
        setUpTableView()
    }
    
    func setUpTableView()
    {
        tblViewController.delegate = self
        tblViewController.dataSource = self
        tblViewController.register(UINib(nibName: "CellContent", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        visualEffectView.isUserInteractionEnabled = false
        cardViewController = CardViewController(nibName:"CardViewController", bundle:nil)
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        cardViewController.view.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        let panGestureRecognize2r = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))

        cardViewController.viewContent.addGestureRecognizer(panGestureRecognize2r)
        cardViewController.setBackground()
    }
    
    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
        
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.setBackgroundCustomColor()
                    self.cardViewController.setVisibleLineView()
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.cardViewController.setBackground()
                    self.cardViewController.setInvibleLinewView()
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.viewBottom.layer.shadowColor = UIColor.black.cgColor
        self.viewBottom.layer.shadowOpacity = 1
        self.viewBottom.layer.shadowOffset = .zero
        self.viewBottom.layer.shadowRadius = 10
        self.viewBottom.layer.shadowPath = UIBezierPath(rect: viewBottom.bounds).cgPath
        self.viewBottom.layer.shouldRasterize = true
        self.viewBottom.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    
    func isVisible(view: UIView) -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        return isVisible(view: view, inView: view.superview)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).x > 0 {
            //Right to Left
            if self.scrollView.bounds.contains(viewTab1.frame)
            {
                updateUiForViewTab1()
                return
            }else if self.scrollView.bounds.contains(viewTab2.frame)
            {
                updateUiForViewTab2()
                return
            }else if self.scrollView.bounds.contains(viewTab3.frame)
            {
                updateUiForViewTab3()
                return
            }else if self.scrollView.bounds.contains(viewTab4.frame)
            {
                updateUiForViewTab4()
                return
            }else if self.scrollView.bounds.contains(viewTab5.frame){
                updateUiForViewTab5()
                return
            }
        } else {
            //Left To Right
            if self.isVisible(view: viewTab1) {
                updateUiForViewTab1()
                return
            }else if self.isVisible(view: viewTab2){
                updateUiForViewTab2()
                return
            }else if self.isVisible(view: viewTab3){
                updateUiForViewTab3()
                return
            }else if self.isVisible(view: viewTab4){
                updateUiForViewTab4()
                return
            }else if self.isVisible(view: viewTab5){
                updateUiForViewTab5()
                return
            }
        }
    }
    
    func updateUiForViewTab1()
    {
        if indexSelectedTab != 0{
            indexSelectedTab = 0
            DispatchQueue.main.async() {
                self.updateUILabel()
                self.viewLine.setWidth(self.lbTab1.frame.width)
            }
            self.arrayTable = self.arrayImportant
            tblViewController.reloadData()
        }
    }
    
    func updateUiForViewTab2(){
        if indexSelectedTab != 1{
            indexSelectedTab = 1
            DispatchQueue.main.async() {
                self.updateUILabel()
                self.viewLine.setWidth(self.labelTab2.frame.width)
            }
            self.arrayTable = self.arrayDocs
            tblViewController.reloadData()
        }
    }
    
    func updateUiForViewTab3()
    {
        if indexSelectedTab != 2{
            indexSelectedTab = 2
            DispatchQueue.main.async() {
                self.updateUILabel()
                self.viewLine.setWidth(self.labelTab3.frame.width)
            }
            self.arrayTable = self.arrayStarred
            tblViewController.reloadData()
        }
    }
    
    func updateUiForViewTab4()
    {
        if indexSelectedTab != 3{
            indexSelectedTab = 3
            DispatchQueue.main.async() {
                self.updateUILabel()
                self.viewLine.setWidth(self.labelTab4.frame.width)
            }
            self.arrayTable = self.arrayNew
            tblViewController.reloadData()
        }
    }
    
    func updateUiForViewTab5()
    {
        if indexSelectedTab != 4{
            indexSelectedTab = 4
            DispatchQueue.main.async() {
                self.updateUILabel()
                self.viewLine.setWidth(self.labelTab5.frame.width)
            }
            self.arrayTable = self.arrayOther
            tblViewController.reloadData()
        }
    }
    
    func updateUILabel()
    {
        for i in 0..<self.arrayLabelTab.count
        {
            if i == self.indexSelectedTab
            {
                arrayLabelTab[i].textColor = .white
            }else{
                arrayLabelTab[i].textColor = COLOR_GRAY
            }
        }
        
        for i in 0..<self.arrayLabelNumber.count
        {
            if (i+1) == self.indexSelectedTab
            {
                arrayLabelNumber[i].textColor = .white
            }else{
                arrayLabelNumber[i].textColor = COLOR_GRAY
            }
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellContent
        cell?.setText(content: arrayTable[indexPath.item])
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 70
    }
    
}

extension UIView {
    func setWidth(_ w:CGFloat, animateTime:TimeInterval?=nil) {
        
        if let c = self.constraints.first(where: { $0.firstAttribute == .width && $0.relation == .equal }) {
            c.constant = CGFloat(w)
            
            if let animateTime = animateTime {
                UIView.animate(withDuration: animateTime, animations:{
                    self.superview?.layoutIfNeeded()
                })
            }
            else {
                self.superview?.layoutIfNeeded()
            }
        }
    }
}
