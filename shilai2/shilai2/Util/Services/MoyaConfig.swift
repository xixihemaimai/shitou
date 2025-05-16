//
//  MoyaConfig.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 4/3/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

import Foundation
import SwiftUI
import RealmSwift
/// 定义基础域名
#if DEBUG
public let sheQuanMCURL = "http://27.154.225.198:8996/sqshop/api/"
//public let sheQuanMCURL = "http://sqshop.ldhnkj.com/sqshop/api/"
#else
public let sheQuanMCURL = "http://sqshop.ldhnkj.com/sqshop/api/"
#endif

//header加签
//public let appId = "IOS"
//请求配置信息
//let appSecret = "1f794aa641b5c1528e92aaf38074d35c"


/// 定义返回的JSON数据字段
//public let RESULT_CODE = "flag"      //状态码

//public let RESULT_MESSAGE = "message"  //错误消息提示


/*  错误情况的提示
 {
 "flag": "0002",
 "msg": "手机号码不能为空",
 "lockerFlag": true
 }
 **/


//字典之后拼接不同类型的value，最后拼接成字符串
public func getJSONStringFromData(obj:Any,isEscape:Bool) -> String {
    if (!JSONSerialization.isValidJSONObject(obj)) {
        print("无法解析出JSONString")
        return ""
    }
    if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
        if var JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) {
            if isEscape{
                JSONString = JSONString.replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
            }
            JSONString = JSONString.replacingOccurrences(of: "{", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
            JSONString = JSONString.replacingOccurrences(of: "}", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
            let fullNameArr = JSONString.components(separatedBy: ",")
            let sortedWords = fullNameArr.sorted()
            var body:String = ""
            for (index,value) in sortedWords.enumerated(){
                if index == 0{
                   body = "{" + value
                }else{
                    body = body + "," + value
                }
            }
            body = body + "}"
//            LXFLog("-----------------2-1------------\(body)")
            return body
        }
    }
    return ""
}



//public func getArrayOrDicFromJSONString(jsonString:String) -> Any {
//    let jsonData:Data = jsonString.data(using: .utf8)!
//    //可能是字典也可能是数组，再转换类型就好了
//    if let info = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
//        return info
//    }
//    return ""
//}


//添加商品规格组 ， 补库存
public func getArrayJSONStringFromAddSpec(obj:[String:Any]) -> String{
    if (!JSONSerialization.isValidJSONObject(obj)) {
        print("无法解析出JSONString")
        return ""
    }
    if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
        var body:String = ""
        do{
            let items = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? Dictionary<String, Any>
            let dictlist = items?.sorted { t1, t2 in
                return t1.key < t2.key ? true : false
            }
            if let dicts = dictlist{
                for (_ ,element) in dicts.enumerated() {
                    if let code = element.value as? Int {
                       let result = String(code)
                        body += "{" + "\"" + element.key + "\"" + ":" + result
                    }
                    if let code = element.value as? String{
                        let result = String(code)
                        body += "," + "\"" + element.key + "\"" + ":" + result
                    }
                }
            }
            body += "}"
        }catch{
          return body
        }
        return body
    }
    return ""
}



//新建和更新运费模板
public func getArrayJSONStringFromUpdateAndNewTemplate(obj:[String:Any]) -> String{
    if (!JSONSerialization.isValidJSONObject(obj)) {
        print("无法解析出JSONString")
        return ""
    }
    if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
        var body:String = ""
        do{
            let items = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? Dictionary<String, Any>
            let dictlist = items?.sorted { t1, t2 in
                return t1.key < t2.key ? true : false
            }
            if let dicts = dictlist{
                for (_ ,element) in dicts.enumerated() {
                    if let code = element.value as? Int {
                       let result = String(code)
                        if element.key == "freightId" || element.key == "freightType" || element.key == "freightVerId"{
                            body += "," + "\"" + element.key + "\"" + ":" + result
                        }else{
                            body += "{" + "\"" + element.key + "\"" + ":" + result
                        }
                    }
                    if let code = element.value as? String{
                        let result = String(code)
                        if element.key == "templateName"{
                            body += "," + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                        }else{
                            body += "," + "\"" + element.key + "\"" + ":" + result
                        }
                    }
                }
            }
            body += "}"
        }catch{
          return body
        }
        return body
    }
    return ""
}






//发布商品
public func getJSONStringFromPushblish(obj:[String:Any],isEscape:Bool) -> String{
    if (!JSONSerialization.isValidJSONObject(obj)) {
        print("无法解析出JSONString")
        return ""
    }
    if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
//        if var JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) {
//            if isEscape{
//                JSONString = JSONString.replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
//            }
////            JSONString = JSONString.replacingOccurrences(of: "{", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
////            JSONString = JSONString.replacingOccurrences(of: "}", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
////            JSONString = JSONString.substring(from: 1) as NSString
////            JSONString = JSONString.substring(to: JSONString.length - 1) as NSString
//            LXFLog("=========\(JSONString)")
//            let jsonData:Data = jsonString.data(using: .utf8)!
            var body:String = ""
            do {
                let items = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? Dictionary<String, Any>
//                LXFLog("---2323--------\(items)")
                let dictlist = items?.sorted { t1, t2 in
                    return t1.key < t2.key ? true : false
                }
                if let dicts = dictlist{
                    for (index,element) in dicts.enumerated() {
                        if let code = element.value as? Int {
                        let result = String(code)
//                          LXFLog("======================\(result)")
                            if index == 0 {
                                if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
                                    if result == "1"{
                                        body +=  "," + "\"" + element.key + "\"" + ":" + "true"
                                    }else{
                                        body += "," + "\"" + element.key + "\"" + ":" + "false"
                                    }
                                }else{
                                    body += "{" + "\"" + element.key + "\"" + ":" + result
                                }
                            }else{
//                                body += "," + "\"" + element.key + "\"" + ":" + result
                                if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
                                    if result == "1"{
                                        body += "," + "\"" + element.key + "\"" + ":" + "true"
                                    }else{
                                        body += "," + "\"" + element.key + "\"" + ":" + "false"
                                    }
                                }else{
                                    body += "," + "\"" + element.key + "\"" + ":" + result
                                }
                            }
                        }
                        if let code = element.value as? Decimal {
                           let doubleValue = Double(truncating: code as? NSNumber ?? 0.0)
                           let result = String(format: "%0.2f", doubleValue)
//                           LXFLog("======================\(result)")
//                            if index == 0 {
//                                if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
//                                    if result == "1"{
//                                        body +=  "," + "\"" + element.key + "\"" + ":" + "true"
//                                    }else{
//                                        body += "," + "\"" + element.key + "\"" + ":" + "false"
//                                    }
//                                }else{
//                                    body += "{" + "\"" + element.key + "\"" + ":" + result
//                                }
//                            }else{
////                                body += "," + "\"" + element.key + "\"" + ":" + result
//                                if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
//                                    if result == "1"{
//                                        body += "," + "\"" + element.key + "\"" + ":" + "true"
//                                    }else{
//                                        body += "," + "\"" + element.key + "\"" + ":" + "false"
//                                    }
//                                }else{
                                    body += "," + "\"" + element.key + "\"" + ":" + result
//                                }
//                            }
                        }
                        if let code = element.value as? NSNumber {
                            if !body.contains("price"){
                                if element.key == "price"{
                                    let doubleValue = Double(truncating: code ?? 0.0)
                                    let result = String(format: "%0.2f", doubleValue)
                                    body += "," + "\"" + element.key + "\"" + ":" + result
                                }
                            }
                        }
                      //productDesc  productId productCode productName
                        if let code = element.value as? String{
//                            LXFLog("+=======3========\(code)")
                            let result = String(code)
                            if index == 0 {
                                if element.key == "productDesc" || element.key == "productId" || element.key == "productCode" || element.key == "productName"{
                                    body += "{" + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                                }else{
                                    body += "{" + "\"" + element.key + "\"" + ":" + result
                                }
                            }else{
                                if element.key == "productDesc" || element.key == "productId" || element.key == "productCode" || element.key == "productName"{
                                    body += "," + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                                }else{
                                    body += "," + "\"" + element.key + "\"" + ":" + result
                                }
                            }
                        }
                    }
                    body += "}"
//                    LXFLog("=========232============\(body)")
                }
            } catch {
                print(error)
                return body
            }
        return body
    }
    return ""
}

//生成随机数
public func generateRandomNumber(_ numDigits:Int) -> Int{
   var place = 1
   var finalNumber = 0
    for _ in 0..<numDigits  {
        place *= 10
        let randomNumber = arc4random_uniform(10)
        finalNumber += (Int(randomNumber) * place)
    }
   return finalNumber
}

//获取sign的值--没有data的情况下
public func obtainSignValue(_ time:String,_ nonce:String,_ deviceId:String,_ isNeedData:Bool = false,_ data:String = "") -> String{
//    var sign:String = ""
//    sign = "accessToken=" + (StoreService.shared.accessToken ?? "") + "&apiVer=" + String.apiVersion + "&appId=" + appId +  "&appSecret=\(appSecret)&appVer=" + String.appVersion + "&data=&deviceId=" + deviceId + "&nonce=" + nonce + "&timeStamp=" + time
    var sign = "accessToken=\(StoreService.shared.accessToken ?? "")&apiVer=\(String.apiVersion)&appId=\(shopConfig.share.appId)&appSecret=\(shopConfig.share.appSecret)&appVer=\(String.appVersion)&data=\(isNeedData ? data : "")&deviceId=\(deviceId)&nonce=\(nonce)&timeStamp=\(time)"
    sign = sign.md5
    return sign
}

public func returnParameters(_ time:String,_ nonce:String,_ deviceId:String,_ isNeedData:Bool = false,_ paramters:String = "",_ isPicture:Bool = false) -> [String:String]{
    if isPicture{
        return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId),"appId":shopConfig.share.appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId,"fileType":"20"]
    }else{
        if isNeedData{
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId,true,paramters),"appId":shopConfig.share.appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        }else{
            return ["Accept": "*/*","Content-Type":"application/json","accessToken":StoreService.shared.accessToken ?? "","sign":obtainSignValue(time, nonce, deviceId),"appId":shopConfig.share.appId,"appVer":String.appVersion,"apiVer":String.apiVersion,"nonce":nonce,"timeStamp":time,"deviceId":deviceId]
        }
    }
}



//获取sign的值--有data的情况下
//public func obtainSignValueData(_ time:String,_ nonce:String,_ deviceId:String,_ data:String) -> String{
//    var sign:String = ""
//    sign = "accessToken=" + (StoreService.shared.accessToken ?? "") + "&apiVer=" + String.apiVersion + "&appId=" + appId + "&appSecret=\(appSecret)&appVer=" + String.appVersion + "&data=" + data + "&deviceId=" + deviceId + "&nonce=" + nonce + "&timeStamp=" + time
//    var sign = "accessToken=\(StoreService.shared.accessToken ?? "")&apiVer=\(String.apiVersion)&appId=\(appId)&appSecret=\(appSecret)&appVer=\(String.appVersion)&data=\(data)&deviceId=\(deviceId)&nonce=\(nonce)&timeStamp=\(time)"
//    sign = sign.md5
//    return sign
//}


//字典的value是相同的拼接的字符串
public func dictSory(_ parameters:[String:String]) -> String{
    let keys = parameters.sorted { t1, t2 in
        return t1.0 < t2.0
    }
    LXFLog(keys)
    var returnStr:String = ""
    for (index,value) in keys.enumerated() {
//        LXFLog(value.value)
            if index == 0{
                returnStr = "{" + "\"" + value.key + "\"" + ":" + "\"" + value.value + "\""
            }else{
                returnStr = returnStr + "," + "\"" + value.key + "\"" + ":" + "\"" + value.value + "\""
            }
        if index == keys.count - 1{
            returnStr = returnStr + "}"
        }
    }
//    LXFLog("--21----12-------------------\(returnStr)")
    return returnStr
}



//请求参数最后的部分的转换
public func getObjFromDataToData(obj:Data,isEscape:Bool) -> Data{
    var parames = (String(data: obj, encoding: String.Encoding.utf8) ?? "")
    if isEscape{
        parames = parames.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
    }
    parames = parames.replacingOccurrences(of: "{", with: "", options: .literal, range: nil)
    parames = parames.replacingOccurrences(of: "}", with: "", options: .literal, range: nil)
    let fullNameArr = parames.components(separatedBy: ",")
    let sortedWords = fullNameArr.sorted()
    var body:String = ""
    for (index,value) in sortedWords.enumerated(){
        if index == 0{
           body = "{" + value
        }else{
            body = body + "," + value
        }
    }
    body = body + "}"
//    LXFLog("-----------------------\(body)")
    return body.data(using: String.Encoding.utf8)!
}



//添加商品规格组 , 补库存
public func getJSONStringFromAddSpec(obj:Data) -> Data{
    var body:String = ""
    do {
        let items = try? JSONSerialization.jsonObject(with: obj, options: []) as? Dictionary<String, Any>
        let dictlist = items?.sorted { t1, t2 in
            return t1.key < t2.key ? true : false
        }
        if let dicts = dictlist{
            for (_ ,element) in dicts.enumerated() {
                if let code = element.value as? Int {
                   let result = String(code)
                    body += "{" + "\"" + element.key + "\"" + ":" + result
                }
                if let code = element.value as? String{
                    let result = String(code)
                    body += "," + "\"" + element.key + "\"" + ":" + result
                }
            }
        }
        body += "}"
    }catch{
        print(error)
        return "".data(using: String.Encoding.utf8)!
    }
    return body.data(using: String.Encoding.utf8)!
}








//发布商品进行整理
public func getJSONStringFromPushblishData(obj:Data,isEscape:Bool) -> Data{
    //    if var JSONString = NSString(data:obj,encoding: String.Encoding.utf8.rawValue) {
    //        if isEscape{
    //            JSONString = JSONString.replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
    //        }
    ////        JSONString = JSONString.replacingOccurrences(of: "{", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
    ////        JSONString = JSONString.replacingOccurrences(of: "}", with: "", options: .literal, range: NSRange(location: 0, length: JSONString.length)) as NSString
    //
    //        LXFLog("------------------32233---------------\(JSONString)")
    var body:String = ""
    do {
        let items = try? JSONSerialization.jsonObject(with: obj, options: []) as? Dictionary<String, Any>
//        LXFLog("---2323--------\(items)")
        let dictlist = items?.sorted { t1, t2 in
            return t1.key < t2.key ? true : false
        }
        if let dicts = dictlist{
            for (index,element) in dicts.enumerated() {
                if let code = element.value as? Int {
                    let result = String(code)
//                    LXFLog("======================\(result)")
                    if index == 0 {
                        if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
                            if result == "1"{
                                body +=  "," + "\"" + element.key + "\"" + ":" + "true"
                            }else{
                                body += "," + "\"" + element.key + "\"" + ":" + "false"
                            }
                        }else{
                            body += "{" + "\"" + element.key + "\"" + ":" + result
                        }
                    }else{
                        //                                body += "," + "\"" + element.key + "\"" + ":" + result
                        if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
                            if result == "1"{
                                body += "," + "\"" + element.key + "\"" + ":" + "true"
                            }else{
                                body += "," + "\"" + element.key + "\"" + ":" + "false"
                            }
                        }else{
                            body += "," + "\"" + element.key + "\"" + ":" + result
                        }
                    }
                }
                
                
                if let code = element.value as? Decimal {
                   let doubleValue = Double(truncating: code as? NSNumber ?? 0.0)
                   let result = String(format: "%0.3f", doubleValue)
//                   LXFLog("======================\(result)")
//                            if index == 0 {
//                                if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
//                                    if result == "1"{
//                                        body +=  "," + "\"" + element.key + "\"" + ":" + "true"
//                                    }else{
//                                        body += "," + "\"" + element.key + "\"" + ":" + "false"
//                                    }
//                                }else{
//                                    body += "{" + "\"" + element.key + "\"" + ":" + result
//                                }
//                            }else{
////                                body += "," + "\"" + element.key + "\"" + ":" + result
//                                if element.key == "freeRefundIn7Days" || element.key == "freightInsure" || element.key == "multiSpec"{
//                                    if result == "1"{
//                                        body += "," + "\"" + element.key + "\"" + ":" + "true"
//                                    }else{
//                                        body += "," + "\"" + element.key + "\"" + ":" + "false"
//                                    }
//                                }else{
                            body += "," + "\"" + element.key + "\"" + ":" + result
//                                }
//                            }
                }
                if let code = element.value as? NSNumber {
                    if !body.contains("price"){
                        if element.key == "price"{
                        let doubleValue = Double(truncating: code ?? 0.0)
                        let result = String(format: "%0.2f", doubleValue)
                        body += "," + "\"" + element.key + "\"" + ":" + result
                      }
                    }
                }
                
                
                
                //productDesc  productId productCode productName
                if let code = element.value as? String{
                    let result = String(code)
                    if index == 0 {
                        
                        if element.key == "productDesc" || element.key == "productId" || element.key == "productCode" || element.key == "productName"{
                            body += "{" + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                        }else{
                            body += "{" + "\"" + element.key + "\"" + ":" + result
                        }
                    }else{
                        if element.key == "productDesc" || element.key == "productId" || element.key == "productCode" || element.key == "productName"{
                            body += "," + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                        }else{
                            body += "," + "\"" + element.key + "\"" + ":" + result
                        }
                    }
                }
            }
            body += "}"
            LXFLog("=========232============\(body)")
        }
     } catch {
         print(error)
         return "".data(using: String.Encoding.utf8)!
      }
    return body.data(using: String.Encoding.utf8)!
//    }
//    return "".data(using: String.Encoding.utf8)!
}



//新建和更新运费模板
public func getArrayJSONStringFromUpdateAndNewTemplateData(obj:Data) -> Data{
    var body:String = ""
    do {
        let items = try? JSONSerialization.jsonObject(with: obj, options: []) as? Dictionary<String, Any>
//        LXFLog("---2323--------\(items)")
        let dictlist = items?.sorted { t1, t2 in
            return t1.key < t2.key ? true : false
        }
        if let dicts = dictlist{
            for (_ ,element) in dicts.enumerated() {
                if let code = element.value as? Int {
                   let result = String(code)
                    if element.key == "freightId" || element.key == "freightType" || element.key == "freightVerId"{
                        body += "," + "\"" + element.key + "\"" + ":" + result
                    }else{
                        body += "{" + "\"" + element.key + "\"" + ":" + result
                    }
                }
                if let code = element.value as? String{
                    let result = String(code)
                    if element.key == "templateName"{
                        body += "," + "\"" + element.key + "\"" + ":" + "\"" + result + "\""
                    }else{
                        body += "," + "\"" + element.key + "\"" + ":" + result
                    }
                }
            }
        }
        body += "}"
     } catch {
         print(error)
         return "".data(using: String.Encoding.utf8)!
    }
    return body.data(using: String.Encoding.utf8)!
}
