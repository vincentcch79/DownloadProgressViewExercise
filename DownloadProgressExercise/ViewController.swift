//
//  ViewController.swift
//  DownloadProgressExercise
//
//  Created by 張智涵 on 2016/6/22.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var firstProgressView: UIProgressView!
    
    @IBOutlet weak var firstPicLabel: UILabel!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
        
    var timer: NSTimer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func firstDownloadButton(sender: AnyObject) {
        
        let urlString = "https://www.apple.com/support/assets/images/products/ipad/hero_ipad_family_2015_2x.jpg"
        
        
        let url = NSURL(string: urlString)
        
        let urlRequest = NSURLRequest(URL: url!, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 5)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) {
            
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue(), {
                () -> Void in
                let image = UIImage(data: data!)
                self.firstImageView.image = image
                
            })
        }
        setImage(urlString)
        task.resume()
    }
    
    
    
    
    
    
    
    
    @IBAction func secondDownloadButton(sender: AnyObject) {
        let urlSecondString = "http://images.apple.com/ipad/home/images/social/og.jpg"
        
        
        let urlSecond = NSURL(string: urlSecondString)
        
        let urlSecondRequest = NSURLRequest(URL: urlSecond!, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 5)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlSecondRequest) {
            
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue(), {
                () -> Void in
                let image = UIImage(data: data!)
                self.secondImageView.image = image
                
            })
        }
        setImage(urlSecondString)
        task.resume()
    }
    
    
    
    
    func simulateLoading() {
        if firstProgressView.progress == 1.0 {
            firstProgressView.hidden = false
            self.firstImageView.image = UIImage(named: timer.userInfo as! String)
            timer.invalidate()
        } else {
            firstProgressView.progress += 0.1
        }
    }
    
    func setImage(name: String) {
        firstProgressView.hidden = false
        firstProgressView.progress = 0
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ViewController.simulateLoading), userInfo: name, repeats: true)
    }

    
    

}

