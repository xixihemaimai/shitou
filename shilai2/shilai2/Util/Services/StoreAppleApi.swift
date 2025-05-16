//
//  StoreAppleApi.swift
//  Util
//
//  Created by mac on 2022/5/16.
//

import Foundation
import Moya
import UIKit
import AVFoundation
import SwiftyJSON
//import SwiftUI  


public enum StoreAppleApi{
    case getCategoryInfoList(parameters:[String:String])    //获取经营种类列表(1)
    case getEntInfo                                         //获取企业认证信息（1）
    case uploadFile(parameters:[String:Int],imageDate:Data) //文件（图片）上传(1)
    case batchUpload(parameters:[String:Int],dataAry:[Data])//批量上传  (1)
    case shopAuth(parameters:[String:Any])                  //店铺认证 （1）
    case entCert(parameters:[String:String])                //企业认证 （1）
}


extension StoreAppleApi:TargetType{
    public var baseURL: URL {
        return URL(string: sheQuanMCURL)!
    }
    
    public var path: String {
        switch self {
          case .entCert:
            return "ent/entCert"
          case .getCategoryInfoList:
            return "category/getCategoryInfoList"
         case .shopAuth:
               return "shop/shopAuth"
        case .uploadFile:
            return "upload/uploadFile"
        case .getEntInfo:
            return "ent/getEntInfo"
        case .batchUpload:
            return "upload/batchUpload"
        }
        
    }
    
    public var method: Moya.Method {
        switch self {
        case .entCert,.getCategoryInfoList,.shopAuth,.uploadFile,.getEntInfo,.batchUpload:
               return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .entCert(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getCategoryInfoList(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .shopAuth(let parameters):
            LXFLog(parameters)
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .uploadFile(let parameters,let imageDate):
            let formData = MultipartFormData(provider: .data(imageDate), name: "file",
                                              fileName: "shopAvatar.png", mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case .getEntInfo:
            return .requestPlain
        case .batchUpload(let parameters,let dataAry):
             let formDataAry:NSMutableArray = NSMutableArray()
               for (index,imageData) in dataAry.enumerated() {
                   //图片转成Data
//                  let data:Data = UIImageJPEGRepresentation(image as! UIImage, 1.0)!
                  //根据当前时间设置图片上传时候的名字
                  let date:Date = Date()
                  let formatter = DateFormatter()
                  formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                  var dateStr:String = formatter.string(from: date as Date)
                  //别忘记这里给名字加上图片的后缀哦
                  dateStr = dateStr.appendingFormat("-%i.png", index)
                  let formData = MultipartFormData(provider: .data(imageData), name: "file", fileName: dateStr, mimeType: "image/png")
                  formDataAry.add(formData)
             }
            return .uploadCompositeMultipart(formDataAry as! [MultipartFormData], urlParameters: parameters)
        }
    }
    
    public var headers: [String : String]? {
        
        switch self {
            //,.uploadFile,.batchUpload
        case .getEntInfo:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
            return returnParameters(time, nonce, deviceId)
            
        case .uploadFile,.batchUpload:
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time,nonce,deviceId),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId,"fileType":"20"]
            
            return returnParameters(time, nonce, deviceId,false,"",true)
            
            
            
            
        case .entCert(let parameters),.getCategoryInfoList(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
            let returnStr = dictSory(parameters)
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId,true,returnStr),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
            return returnParameters(time, nonce, deviceId,true,returnStr)
            
        case .shopAuth(let parameters):
            let time = Date().currentMilliStamp
            let nonce = String.nonce
            let deviceId = String.deviceUUID
//            let returnStr = dictSory(parameters)
//            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId,true,getJSONStringFromData(obj: parameters,isEscape: true)),"appId":appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
            
            return returnParameters(time, nonce, deviceId,true,getJSONStringFromData(obj: parameters,isEscape: true))
            
        default:
            return ["Accept": "*/*","Content-Type":"application/json"]
        }
    }
    
    
    public var sampleData: Data{
        return "".data(using: String.Encoding.utf8)!
    }

}




////获取sign的值--没有data的情况下
//func obtainSignValue(_ time:String,_ nonce:String,_ deviceId:String) -> String{
//    var sign:String = ""
//    sign = "accessToken=" + (StoreService.shared.accessToken ?? "") + "&apiVer=" + String.apiVersion + "&appId=" + appId +  "&appSecret=1f794aa641b5c1528e92aaf38074d35c&appVer=" + String.appVersion + "&data=&deviceId=" + deviceId + "&nonce=" + nonce + "&timeStamp=" + time
//    sign = sign.md5
//    return sign
//}
//
////获取sign的值--有data的情况下
//func obtainSignValueData(_ time:String,_ nonce:String,_ deviceId:String,_ data:String) -> String{
//    var sign:String = ""
//    sign = "accessToken=" + (StoreService.shared.accessToken ?? "") + "&apiVer=" + String.apiVersion + "&appId=" + appId + "&appSecret=1f794aa641b5c1528e92aaf38074d35c&appVer=" + String.appVersion + "&data=" + data + "&deviceId=" + deviceId + "&nonce=" + nonce + "&timeStamp=" + time
//    LXFLog(sign)
//    sign = sign.md5
//    LXFLog(sign)
//    return sign
//}
//
//
//func dictSory(_ parameters:[String:String]) -> String{
//    let keys = parameters.sorted { t1, t2 in
//        return t1.0 < t2.0
//    }
//    LXFLog(keys)
//    var returnStr:String = ""
//    for (index,value) in keys.enumerated() {
//        LXFLog(value.value)
//            if index == 0{
//                returnStr = "{" + "\"" + value.key + "\"" + ":" + "\"" + value.value + "\""
//            }else{
//                returnStr = returnStr + "," + "\"" + value.key + "\"" + ":" + "\"" + value.value + "\""
//            }
//        if index == keys.count - 1{
//            returnStr = returnStr + "}"
//        }
//    }
//    return returnStr
//}




//func getJSONStringFromData(obj:Any) -> String {
//    if (!JSONSerialization.isValidJSONObject(obj)) {
//        print("无法解析出JSONString")
//        return ""
//    }
//    if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
//        if var JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) {
//            LXFLog(JSONString)
//            JSONString = JSONString.replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
//            JSONString = JSONString.replacingOccurrences(of: "{", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
//            JSONString = JSONString.replacingOccurrences(of: "}", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
//            let fullNameArr = JSONString.components(separatedBy: ",")
//            let sortedWords = fullNameArr.sorted()
//            var body:String = ""
//            for (index,value) in sortedWords.enumerated(){
//                if index == 0{
//                   body = "{" + value
//                }else{
//                    body = body + "," + value
//                }
//            }
//            body = body + "}"
//            return body
//        }
//    }
//    return ""
//}











