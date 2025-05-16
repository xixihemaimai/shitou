//
//  NetworkManager.swift
//  GHMoyaNetWorkTest
//
//  Created by Guanghui Liao on 4/2/18.
//  Copyright © 2018 liaoworking. All rights reserved.
//

import Alamofire
import Foundation
//import ObjectMapper
import Moya
import SwiftyJSON
import JFPopup
import UIKit
import SwiftUI


/// 超时时长
public var requestTimeOut: Double = 30
// 单个模型的成功回调 包括： 模型，网络请求的模型(code,message,data等，具体根据业务来定)
public typealias RequestModelSuccessCallback = ((_ result:Any?, _ data:Data) -> Void)

// 数组模型的成功回调 包括： 模型数组， 网络请求的模型(code,message,data等，具体根据业务来定)
public typealias RequestModelsSuccessCallback = ((_ result:Any?,_ data:Data) -> Void)

// 网络请求的回调 包括：网络请求的模型(code,message,data等，具体根据业务来定)
public typealias RequestCallback = ((_ result:Any?,_ data:Data) -> Void)
/// 网络错误的回调
public typealias errorCallback = ((_ error:String,_ code:Int) -> Void)


/// dataKey一般是 "data"  这里用的知乎daily 的接口 为stories
let responseDataKey = "data"
let responseMessageKey = "msg"
let responseCodeKey = "status"
let successCode: Int = 200

/// 网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
public let myEndpointClosure = { (target: TargetType) -> Endpoint in
    /// 这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
    let url = target.baseURL.absoluteString + target.path
    var task = target.task

    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
     */
//    let additionalParameters = ["token":"888888"]
//    let defaultEncoding = URLEncoding.default
//    switch target.task {
//        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
//    case .requestPlain:
//        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
//    case .requestParameters(var parameters, let encoding):
//        additionalParameters.forEach { parameters[$0.key] = $0.value }
//        task = .requestParameters(parameters: parameters, encoding: encoding)
//    default:
//        break
//    }
    
    
//    if let apiTarget = target as? MultiTarget,
//       let target = apiTarget.target as? LoginApi {
//        switch target{
//        case .phonelogin(parameters: let parameters):
//            LXFLog("8")
//        case .phoneCode(parameters: let parameters):
//            LXFLog("9")
//        case .passwordLogin(parameters: let parameters):
//            LXFLog("10")
//        }
//    }
//
//    if let apiTarget = target as? MultiTarget,
//       let target = apiTarget.target as? StoreAppleApi {
//        switch target{
//        case .shopAuth(parameters: let parameters):
//
//            (parameters["shopAvatar"] as! NSString).replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: (parameters["shopAvatar"] as! NSString).length)) as String
//            LXFLog("====3232========\(parameters)")
//            task = .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
//
//        case .getCategoryInfoList(parameters: let parameters):
//            break
//        case .getEntInfo:
//            break
//        case .uploadFile(parameters: let parameters, imageDate: let imageDate):
//            break
//        case .entCert(parameters: let parameters):
//            break
//        }
//    }
//
//    if let apiTarget = target as? MultiTarget,
//       let target = apiTarget.target as? StoreAppleApi {
//        switch target{
//        case .entCert(parameters: let parameters):
//            LXFLog("6")
//        case .getCategoryInfoList(parameters: let parameters):
//            LXFLog("7")
//        }
//    }
    
    /*
     👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
     如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
     */

    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 30 // 每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
    // 针对于某个具体的业务模块来做接口配置
    if let apiTarget = target as? MultiTarget,
       let target = apiTarget.target as? LoginApi {
        switch target {
//        case .easyRequset:
//            return endpoint
//        case .register:
//            requestTimeOut = 5
//            return endpoint
        default:
            return endpoint
        }
    }
    
    return endpoint
}

/// 网络请求的设置
public let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        // 设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            /**
             if endpoint.url == "http://27.154.225.198:8996/sqshop/api/shop/shopAuth"
             */
            if endpoint.url.contains("shop/shopAuth") || endpoint.url.contains("ent/entCert"){
                //解决图片链接有转义字符的问题
                request.httpBody = getObjFromDataToData(obj: requestData, isEscape: true)
            }else if endpoint.url.contains("login/mobileLogin") || endpoint.url.contains("login/passLogin") || endpoint.url.contains("captcha/getCaptchaCode") || endpoint.url.contains("category/getCategoryInfoList") || endpoint.url.contains("shop/forgetPass") || endpoint.url.contains("shop/changePass") || endpoint.url.contains("shop/regAccount") || endpoint.url.contains("prod/manage/getProductInfoList") || endpoint.url.contains("category/getProductCategoryList") || endpoint.url.contains("brand/getProductBrandList") || endpoint.url.contains("spec/getProductSpecList") || endpoint.url.contains("spu/getProductSpuList") || endpoint.url.contains("region/getFreightRegionList") || endpoint.url.contains("region/getRegionInfoList")   || endpoint.url.contains("freight/defFreightTemplate") || endpoint.url.contains("order/manage/closeOrder") || endpoint.url.contains("order/manage/getOrderProductList") || endpoint.url.contains("order/manage/modifyPrice") || endpoint.url.contains("logistics/modifyLogistics") || endpoint.url.contains("order/manage/confirmShipment") || endpoint.url.contains("ret/updateRetAddress") || endpoint.url.contains("order/consignee/updateConsignee"){
                //手机号登录 密码登录 发送验证码 经营种类 忘记密码 修改密码 注册账号  获取商品列表 获取商品类目 获取品牌列表 获取商品规格列表  获取商品参数列表 获取行政区域 获取行政地区列表
                //默认运费模板  关闭订单 获取商品订单列表 确定修改价格 修改物流 确认发货  添加和更新退货地址信息  更新订单收货地址
                request.httpBody = getObjFromDataToData(obj: requestData, isEscape: false)
            }else if endpoint.url.contains("product/publish") || endpoint.url.contains("product/draft"){
                //发布商品，存为草稿
                request.httpBody = getJSONStringFromPushblishData(obj: requestData, isEscape: true)
            }else if endpoint.url.contains("spec/addSpecGroup") || endpoint.url.contains("prod/manage/repairStock") || endpoint.url.contains("region/getNoDeliveryRegionList"){
                //添加商品规格组,补库存,获取不配送区域列表
                request.httpBody = getJSONStringFromAddSpec(obj: requestData)
            }else if endpoint.url.contains("freight/freightTemplate"){
                //更新/新建运费模板
                request.httpBody = getArrayJSONStringFromUpdateAndNewTemplateData(obj: requestData)
            }
            print("请求的url：\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        } else {
            print("请求的url：\(request.url!)" + "\(String(describing: request.httpMethod))")
        }

        if let header = request.allHTTPHeaderFields {
            print("请求头内容\(header)")
        }

        print(request)
        
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

/*   设置ssl
 let policies: [String: ServerTrustPolicy] = [
 "example.com": .pinPublicKeys(
     publicKeys: ServerTrustPolicy.publicKeysInBundle(),
     validateCertificateChain: true,
     validateHost: true
 )
 ]
 */

// 用Moya默认的Manager还是Alamofire的Session看实际需求。HTTPS就要手动实现Session了
// private func defaultAlamofireSession() -> Session {
//
////     let configuration = Alamofire.Session.default
//
//     let configuration = URLSessionConfiguration.default
//     configuration.headers = .default
//
//     let policies: [String: ServerTrustEvaluating] = ["demo.mXXme.com": DisabledTrustEvaluator()]
//
//     let session = Session(configuration: configuration,
//                           startRequestsImmediately: false,
//                           serverTrustManager: ServerTrustManager(evaluators: policies))
//
//    return session
// }

/// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
/// 但这里我没怎么用这个。。。 loading的逻辑直接放在网络处理里面了
public let networkPlugin = NetworkActivityPlugin.init { changeType, target in
    print("networkPlugin \(changeType)")
    // targetType 是当前请求的基本信息
    
    
//    var task = target.task
//    if let apiTarget = target as? MultiTarget,
//       let target = apiTarget.target as? StoreAppleApi {
//        switch target{
//        case .shopAuth(parameters: let parameters):
////            (parameters["shopAvatar"] as! NSString).replacingOccurrences(of: "\\", with: "", options: .literal, range: NSRange(location: 0, length: (parameters["shopAvatar"] as! NSString).length)) as String
//
//            let _ = (parameters["shopAvatar"] as? String ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
//            task = .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
////            LXFLog("====3232========\(task)")
//        case .getCategoryInfoList(parameters: let parameters):
//            break
//        case .getEntInfo:
//            break
//        case .uploadFile(parameters: let parameters, imageDate: let imageDate):
//            break
//        case .entCert(parameters: let parameters):
//            let _ = (parameters["frontPic"] as? String ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
//            let _ = (parameters["reversePic"] as? String ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
//            let _ = (parameters["licencePic"] as? String ?? "").replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
//
//            task = .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
////            LXFLog("====3232========\(task)")
//        }
//    }
    switch changeType {
    case .began:
        print("开始请求网络")
        
    case .ended:
        print("结束")
    }
}

/// https://github.com/Moya/Moya/blob/master/docs/Providers.md  参数使用说明
/// 网络请求发送的核心初始化方法，创建网络请求对象
public let Provider = MoyaProvider<MultiTarget>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

/// 网络请求，当模型为dict类型
/// - Parameters:
///   - target: 接口
///   - showFailAlert: 是否显示网络请求失败的弹框
///   - modelType: 模型
///   - successCallback: 成功的回调
///   - failureCallback: 失败的回调
/// - Returns: 取消当前网络请求Cancellable实例
@discardableResult
public func NetWorkRequest(_ target: TargetType, needShowFailAlert: Bool = true, successCallback:@escaping RequestModelSuccessCallback, failureCallback: errorCallback? = nil) -> Cancellable? {
    
    return NetWorkResultRequest(target, needShowFailAlert: needShowFailAlert, successCallback: { result, data in
        successCallback(result,data)
    }, failureCallback: failureCallback)

    
    
//    return NetWorkResultRequest(target, needShowFailAlert: needShowFailAlert, successCallback: { (data) in
        
//        if let model = [T](JSONString: responseModel.dataString) {
////            successCallback(model, responseModel)
//
//
//        } else {
//            errorHandler(code: responseModel.code , message: "解析失败", needShowFailAlert: needShowFailAlert, failure: failureCallback)
//        }
        
//    }, failureCallback: errorCallback)
}

/// 网络请求，当模型为dict类型
/// - Parameters:
///   - target: 接口
///   - showFailAlert: 是否显示网络请求失败的弹框
///   - modelType: 模型
///   - successCallback: 成功的回调
///   - failureCallback: 失败的回调
/// - Returns: 取消当前网络请求Cancellable实例
@discardableResult
public func NetWorkSRequest(_ target: TargetType, needShowFailAlert: Bool = true,successCallback:@escaping RequestModelsSuccessCallback, failureCallback: errorCallback? = nil) -> Cancellable? {
    
//    return NetWorkResultRequest(target, needShowFailAlert: needShowFailAlert, successCallback: { (data) in
        
//        if let model = [T](JSONString: responseModel.dataString) {
////            successCallback(model, responseModel)
//
//
//        } else {
//            errorHandler(code: responseModel.code , message: "解析失败", needShowFailAlert: needShowFailAlert, failure: failureCallback)
//        }
        
//    }, failureCallback: errorCallback)
    
//    return NetWorkResultRequest(target, needShowFailAlert: true, successCallback: { data in
//        successCallback(data)
//    }, failureCallback: failureCallback)
    
    return NetWorkResultRequest(target, needShowFailAlert: needShowFailAlert, successCallback: { result, data in
        successCallback(result,data)
    }, failureCallback: failureCallback)
    
    
}


/// 网络请求的基础方法
/// - Parameters:
///   - target: 接口
///   - showFailAlert: 是否显示网络请求失败的弹框
///   - successCallback: 成功的回调
///   - failureCallback: 失败的回调
/// - Returns: 取消当前网络请求Cancellable实例
@discardableResult
public func NetWorkResultRequest(_ target: TargetType, needShowFailAlert: Bool = true, successCallback:@escaping RequestCallback, failureCallback: errorCallback? = nil) -> Cancellable? {
    // 先判断网络是否有链接 没有的话直接返回--代码略
    if !UIDevice.isNetworkConnect {
        // code = 9999 代表无网络  这里根据具体业务来自定义
        errorHandler(code: 9999, message: "网络似乎出现了问题", needShowFailAlert: needShowFailAlert, failure: failureCallback)
        return nil
    }
    return Provider.request(MultiTarget(target)) { result in
        switch result {
        case let .success(response):
            do {
                let jsonData = try JSON(data: response.data)
                print("返回结果是：\(jsonData)")
                if !validateRepsonse(response: jsonData.dictionary, needShowFailAlert: needShowFailAlert, failure: failureCallback) { return }
                let respModel = ResponseModel()
                /// 这里的 -999的code码 需要根据具体业务来设置
                respModel.code = jsonData[responseCodeKey].int ?? 200
                respModel.message = jsonData[responseMessageKey].stringValue
                if respModel.code == 200{
//                    respModel.dataString = jsonData[responseDataKey].rawString() ?? ""
//                    successCallback(respModel)
                    successCallback(response,response.data as Data)
                }else if respModel.code == 201{
                   //token失效
                    errorHandler(code: respModel.code , message: respModel.message , needShowFailAlert: needShowFailAlert, failure: failureCallback)
                    return
                }else {
                    errorHandler(code: respModel.code , message: respModel.message , needShowFailAlert: needShowFailAlert, failure: failureCallback)
                    return
                }

            } catch {
                // code = 1000000 代表JSON解析失败  这里根据具体业务来自定义
                errorHandler(code: 1000000, message: String(data: response.data, encoding: String.Encoding.utf8)!, needShowFailAlert: needShowFailAlert, failure: failureCallback)
            }
        case let .failure(error as NSError):
            errorHandler(code: error.code, message: "网络异常，请检查网络连接", needShowFailAlert: needShowFailAlert, failure: failureCallback)
        }
    }
    
}


/// 预判断后台返回的数据有效性 如通过Code码来确定数据完整性等  根据具体的业务情况来判断  有需要自己可以打开注释
/// - Parameters:
///   - response: 后台返回的数据
///   - showFailAlet: 是否显示失败的弹框
///   - failure: 失败的回调
/// - Returns: 数据是否有效
public func validateRepsonse(response: [String: JSON]?, needShowFailAlert: Bool, failure: errorCallback?) -> Bool {
    /**
    var errorMessage: String = ""
    if response != nil {
        if !response!.keys.contains(codeKey) {
            errorMessage = "返回值不匹配：缺少状态码"
        } else if response![codeKey]!.int == 500 {
            errorMessage = "服务器开小差了"
        }
    } else {
        errorMessage = "服务器数据开小差了"
    }
     
    if errorMessage.count > 0 {
        var code: Int = 999
        if let codeNum = response?[codeKey]?.int {
            code = codeNum
        }
        if let msg = response?[messageKey]?.stringValue {
            errorMessage = msg
        }
        errorHandler(code: code, message: errorMessage, showFailAlet: showFailAlet, failure: failure)
        return false
    }
     */

    return true
}

/// 错误处理
/// - Parameters:
///   - code: code码
///   - message: 错误消息
///   - needShowFailAlert: 是否显示网络请求失败的弹框
///   - failure: 网络请求失败的回调
public func errorHandler(code: Int, message: String, needShowFailAlert: Bool, failure: errorCallback?) {
    print("发生错误：\(code)--\(message)")
    let model = ResponseModel()
    model.code = code
    model.message = message
    if needShowFailAlert {
        // 弹框
//        print("弹出错误信息弹框\(message)")
        if message == "未找到企业认证信息." || message == "该手机号不存在."{
        }else{
            if message.count > 0{
                JFPopup.toast(hit: "\(message)", icon: .fail)
            }else{
                JFPopup.toast(hit: "请求失败", icon: .fail)
            }
        }
    }
    failure?(message,model.code)
}

public func judgeCondition(_ flag: String?) {
    switch flag {
    case "401", "402": break // token失效
    default:
        return
    }
}

class ResponseModel {
    var code: Int = 200
    var message: String = ""
    // 这里的data用String类型 保存response.data
    var dataString: String = ""
    /// 分页的游标 根据具体的业务选择是否添加这个属性
    var cursor: String = ""
}


/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用计算型属性是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
extension UIDevice {
    static var isNetworkConnect: Bool {
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true // 无返回就默认网络已连接
    }
    
    //获取UUID
    static func currentUUID()->String{
        let currentDvice = self.current
        return currentDvice.identifierForVendor?.uuidString ?? ""
    }
}


/**
 下面的三个方法是对于 Swift5.5 Concurrency的支持  目前(2022.02.18)一般项目中还用不到。 可自行删除
 */
//@available(iOS 13.0, *)
//@discardableResult
//func NetWorkRequest(_ target: TargetType, needShowFailAlert: Bool = true) async -> (response: ResponseModel) {
//    await withCheckedContinuation({ continuation in
////        NetWorkRequest(target, needShowFailAlert: needShowFailAlert, modelType: modelType) { model, responseModel in
////            continuation.resume(returning: (model,responseModel))
////        } failureCallback: { responseModel in
////            continuation.resume(returning: (nil,responseModel))
////        }
//    })
//}
//
//@available(iOS 13.0, *)
//@discardableResult
//func NetWorkRequest(_ target: TargetType, needShowFailAlert: Bool = true) async -> (response: ResponseModel) {
//    await withCheckedContinuation({ continuation in
////        NetWorkRequest(target, needShowFailAlert: needShowFailAlert, modelType: modelType) { model, responseModel in
////            continuation.resume(returning: (model,responseModel))
////        } failureCallback: { responseModel in
////            continuation.resume(returning: (nil,responseModel))
////        }
//    })
//}
//
//@available(iOS 13.0, *)
//@discardableResult
//func NetWorkRequest(_ target: TargetType, needShowFailAlert: Bool = true) async -> ResponseModel {
//    await withCheckedContinuation({ continuation in
//        NetWorkRequest(target, needShowFailAlert: needShowFailAlert, successCallback: {(responseModel) in
////            continuation.resume(returning: responseModel)
//            continuation.resume(returning: responseModel)
//        }, failureCallback:{(responseModel) in
////            continuation.resume(returning: responseModel)
//            continuation.resume(returning: responseModel)
//        })
//    })
//}
