//
//  BusinessTypeModel.swift
//  Util
//
//  Created by mac on 2022/5/16.
//

import Foundation
//import HandyJSON
/**
 
 
 let parameters = ["categoryName":categoryName]
 NetWorkResultRequest(StoreAppleApi.getCategoryInfoList(parameters: parameters), needShowFailAlert: true) {[weak self] result, data in
//            do{
         self?.firstArray.removeAll()
//                let json = try JSON(data: data)
//                guard let models = JSONDeserializer<BusinessTypeModel>.deserializeModelArrayFrom(json: json["data"].description) else{
//                  return
//                }
//                for i in 0..<models.count{
//                    guard let model = JSONDeserializer<BussinessSecondTypeModel>.deserializeModelArrayFrom(json: json["data"][i]["subCategorys"].description) else{
//                        return
//                    }
//                    let businessTypeModel = models[i]
////                    LXFLog("---------\(model)")
//                    businessTypeModel!.subCategorys! = model as! [BussinessSecondTypeModel]
//                    LXFLog(businessTypeModel?.subCategorys)
//                    self?.firstArray.append(businessTypeModel!)
//                }
//                let jsonString = String(data: data, encoding: .utf8)
         guard let models = try? JSONDecoder().decode(GenericResponse<[BusinessTypeModel]>.self, from: data) else{
             return
         }
         self?.firstArray = models.data!
     
//                LXFLog(models)
//            }catch{}
     self?.openList.removeAll()
     for _ in 0..<(self?.firstArray.count ?? 0){
         self?.openList.append(false)
     }
     self?.tableview.reloadData()
     
     self?.tableview.mj_header?.endRefreshing()
     
 } failureCallback: {[weak self] error,code in
     code.loginOut()
     self?.tableview.mj_header?.endRefreshing()
 }
 
 
 
 
 
 
 
 
 
 网络请求去获取数据的时候
 guard let models = try? JSONDecoder().decode(GenericResponse<[BusinessTypeModel]>.self, from: data) else{
     return
 }
 self?.firstArray = models.data!
 */


public struct BusinessTypeModel: Codable {
    public var categoryId: Int32?
    public var categoryName: String?
    public var subCategorys:[BussinessSecondTypeModel]?
    
    enum CodingKeys:String,CodingKey {
       case categoryId = "categoryId"
        case categoryName = "categoryName"
        case subCategorys = "subCategorys"
    }


    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try? values.decodeIfPresent(Int32.self, forKey: .categoryId)
        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
        subCategorys = try? values.decodeIfPresent([BussinessSecondTypeModel].self, forKey: .subCategorys)
    }
    
   
}


public struct BussinessSecondTypeModel: Codable {
    
   public var categoryId: Int32?
   public var categoryName: String?
    
  
    enum Codingkeys:String,CodingKey {
       case categoryId = "categoryId"
        case categoryName = "categoryName"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try? values.decodeIfPresent(Int32.self, forKey: .categoryId)
        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
    }

}


//public class BusinessTypeModel: HandyJSON {
//    public var categoryId: Int32?
//    public var categoryName: String?
//    public var subCategorys:[BussinessSecondTypeModel]?
//
////    enum CodingKeys:String,CodingKey {
////       case categoryId = "categoryId"
////        case categoryName = "categoryName"
////        case subCategorys = "subCategorys"
////    }
////
////
////    public init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        categoryId = try? values.decodeIfPresent(Int.self, forKey: .categoryId)
////        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
////        subCategorys = try? values.decodeIfPresent([BusinessTypeModel].self, forKey: .subCategorys)
////    }
//
//    public required init() {
//     }
//}
//
//
//public class BussinessSecondTypeModel: HandyJSON {
//
//   public var categoryId: Int32?
//   public var categoryName: String?
//
//   public required init() {
//    }
//
////    enum Codingkeys:String,CodingKey {
////       case categoryId = "categoryId"
////        case categoryName = "categoryName"
////    }
////
////    public init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        categoryId = try? values.decodeIfPresent(Int.self, forKey: .categoryId)
////        categoryName = try? values.decodeIfPresent(String.self, forKey: .categoryName)
////    }
////
//}
