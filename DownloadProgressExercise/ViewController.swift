//
//  ViewController.swift
//  DownloadProgressExercise
//
//  Created by 張智涵 on 2016/6/22.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit



class ViewController: UIViewController, NSURLSessionDownloadDelegate {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var firstProgressView: UIProgressView!
    
    @IBOutlet weak var firstPicLabel: UILabel!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    
    var timer: NSTimer!
    var downloadTask: NSURLSessionDownloadTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func firstDownloadButton(sender: AnyObject) {
        
//        let urlString = "https://www.apple.com/support/assets/images/products/ipad/hero_ipad_family_2015_2x.jpg"
//        
//        
//        let url = NSURL(string: urlString)
//        
//        let urlRequest = NSURLRequest(URL: url!, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 5)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) {
//            
//            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
//            
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                () -> Void in
//                let image = UIImage(data: data!)
//                self.firstImageView.image = image
//                
//            })
//        }
//        setImage(urlString)
//        task.resume()
        let downloadRequest = NSMutableURLRequest(URL: NSURL(string: "https://9to5mac.files.wordpress.com/2016/06/sierra.jpg")!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        downloadTask = session.downloadTaskWithRequest(downloadRequest)
        downloadTask!.resume()
        
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
    
    func updateProgressViewWith(totalSent: Float, totalFileSize: Float) {
        firstPicLabel.text = NSString(format: "%.1f MB / %.1f MB", convertFileSizeToMegabyte(totalSent), convertFileSizeToMegabyte(totalFileSize)) as String
    }
    
    private func convertFileSizeToMegabyte(size: Float) -> Float {
        return (size / 1024) / 1024
    }
    
    
    func simulateLoading() {
        if firstProgressView.progress == 1.0 {
            firstProgressView.hidden = true
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
    


    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percent:Float = Float(totalBytesWritten/totalBytesExpectedToWrite)
        
        firstProgressView.setProgress(percent, animated: true)
        
        firstPicLabel.text = "\((Int)(firstProgressView.progress * 100))%"
        
        updateProgressViewWith(Float(totalBytesWritten), totalFileSize: Float(totalBytesExpectedToWrite))
    
        print(firstProgressView.progress)
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        let data: NSData = NSData(contentsOfURL: location)!
        if data.length > 0 {
            let myImage = UIImage(data: data)
            firstImageView.image = myImage
            print("data is found")
        }
       
    }
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        firstProgressView.progress = 0
        firstProgressView.setProgress(1.0, animated: true)
//        firstPicLabel.text = "100%"
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("failed")
            print(error)
        } else {
            print("finished")
        }
    }
   
    
//    func updateProgressViewLabelWithProgress(percent: Float) {
//        firstPicLabel.text = String(format: "%.0f %@", percent, "%")
//    }
    


    
}



