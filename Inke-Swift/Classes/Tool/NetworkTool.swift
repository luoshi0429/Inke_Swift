//
//  NetworkTool.swift
//  Inke_Swift
//
//  Created by Lumo on 16/10/3.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit
import Alamofire

class NetworkTool: Alamofire.Manager {
    
    // Swift中的单例写法
    static let shareNetworkTool: NetworkTool = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders 
        return NetworkTool(configuration: config)
    }()
}

// MARK: - 方法
extension NetworkTool {
    func ik_get(URLStr: String,parameters: [String : AnyObject]?,finished:((successInfo:AnyObject?,errorInfo:NSError?)->())) {
        request(.GET, URLStr, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                finished(successInfo: response.result.value, errorInfo: nil)
            } else {
                finished(successInfo: nil, errorInfo: response.result.error)
            }
        }
    }
    
    func ik_post(URLStr: String,parameters: [String : AnyObject]?,finished:((successInfo:AnyObject?,errorInfo:NSError?)->())) {
        request(.POST, URLStr, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                finished(successInfo: response.result.value, errorInfo: nil)
            } else {
                finished(successInfo: nil, errorInfo: response.result.error)
            }
        }
    }
}
