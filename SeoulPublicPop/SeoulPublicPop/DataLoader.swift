//
//  DataLoader.swift
//  SeoulPublicPop
//
//  Created by 최윤호 on 2015. 12. 19..
//  Copyright © 2015년 Pacilo's Lab. All rights reserved.
//

import Foundation
import UIKit

class DataLoader : NSObject, NSXMLParserDelegate {
    
    var server_url = "http://52.68.68.177:8080"
    var completeMethod : (AnyObject) ->()?
    var specialParseMethod : ((String,String) -> AnyObject?)?
    var startEnd : String?
    var resParam : [String]?
    var parser = NSXMLParser()
    
    var cur_result : [String:AnyObject?]?
    var cur_element : String?
    var result : [[String:AnyObject?]]?
    
    override init() {
        completeMethod = { (output : AnyObject)->() in }
    }
    
    convenience init(url : String)
    {
        self.init()
        server_url = url
    }
    func Start(reqParam : RequestChunk, resParam : [String], startend : String,
        callBack :([[String:AnyObject?]]?) ->(),
        specialParser : ((String,String) -> AnyObject?)? = nil)
    {
        var paramString = "\(server_url)/?"
        //var paramString = ""
        
        self.resParam = resParam
        
        let ns = NSURL(string : paramString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        let request1 = NSMutableURLRequest(URL: ns!)
        let session = NSURLSession.sharedSession()
        
        
        request1.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(reqParam.requestForm,  options:  [])
        request1.HTTPMethod = "POST"
        print(request1.HTTPBody);
        let task = session.dataTaskWithRequest(request1, completionHandler: {data, response, error -> Void in
            print("mydata : " + String(data))
            self.completeMethod(try! NSJSONSerialization.JSONObjectWithData(data!, options: []));
            //  println("Response: \(response)")
            //self.result = []
            
            //self.parser = NSXMLParser(data: data!)
            //self.parser.delegate = self
            //self.parser.parse()
            //self.completeMethod!(self.result)
        })
        
        task.resume()
    }
    func test()
    {
        let paramString = "\(server_url)/"
        //var paramString = ""
        
        let reqParam = LocalRequest(local:"중랑구",category: "체육시설").requestForm;
        
        let ns = NSURL(string : paramString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        let request1 = NSMutableURLRequest(URL: ns!)
        let session = NSURLSession.sharedSession()
        
        print(String(reqParam));
        
        request1.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(reqParam as NSDictionary,  options:  [])
        request1.HTTPMethod = "POST"
        print(request1.HTTPBody)
        let task = session.dataTaskWithRequest(request1, completionHandler: {data, response, error -> Void in
            let result = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print("mydata : " + String(result["category"]))
            self.completeMethod(result);
            print(error?.code)
            //self.result = []
            
            //self.parser = NSXMLParser(data: data!)
            //self.parser.delegate = self
            //self.parser.parse()
            //self.completeMethod!(self.result)
        })
        
        task.resume()
    }
}