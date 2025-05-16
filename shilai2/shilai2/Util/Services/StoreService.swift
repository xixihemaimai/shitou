//
//  StoreService.swift
//  Util
//
//  Created by mac on 2022/5/18.
//

import Foundation
import RealmSwift

//用户信息请求
public class StoreService{
    
    public static let shared = StoreService()
    public func isLogin() -> Bool {
        guard let realm = try? Realm() else { return false }
        return !realm.objects(StoreModel.self).isEmpty
    }
    
   
    //获取accessToken
    public var accessToken: String? {
        get {
            guard let realm = try? Realm() else { return nil }
            guard let user = realm.objects(StoreModel.self).first else { return nil }
            return user.accessToken
        }
    }
    
    //获取当前店铺id(shopId)
    public var shopId: UInt64 {
        get {
            guard let realm = try? Realm() else { return 0 }
            guard let user = realm.objects(StoreModel.self).first else { return 0 }
            return UInt64(user.shopId)
        }
    }
    
    //获取当前店铺id(shopId)字符串
    public var shopIdStr: String {
        get {
            guard let realm = try? Realm() else { return "" }
            guard let user = realm.objects(StoreModel.self).first else { return "" }
            return "\(user.shopId)"
        }
    }
    
    
    
    //获取当前的店铺
    public var currentUser: StoreModel? {
        get {
            guard let realm = try? Realm() else { return nil }
            guard let user = realm.objects(StoreModel.self).first else { return nil }
            return user
        }
    }
    
    //获取经营种类的ID
    public var categoryId:Int32{
        get{
            guard let realm = try? Realm() else {return 0}
            guard let user = realm.objects(StoreModel.self).first else{return 0}
            return Int32(user.categoryId)
        }
    }

    //添加
    public func addShopInfo(_ model:StoreInfoModel){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
    }
    
    
    //更新token
    public func updateToken(_ accessToken: String) {
        guard let realm = try? Realm() else {
            debugPrint("create realm instance fail")
            return
        }
        var user: StoreModel
        if let u = realm.objects(StoreModel.self).first {
            user = u
        } else {
            user = StoreModel()
            try! realm.write {
                realm.add(user)
            }
        }
        try! realm.write({
            user.accessToken = accessToken
        })
    }
    
    
    //更新店铺名称
    public func updateShopName(_ shopName:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.shopName = shopName
        })
    }
    
    
    
    //更新店铺头像
    public func updateShopAvatar(_ shopAvatar:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.shopAvatar = shopAvatar
            LXFLog(storeModel.shopAvatar)
        })
    }
    
    //更新经营种类
    public func updateCategoryName(_ categoryName:String,_ categoryId:Int32){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.categoryName = categoryName
            storeModel.categoryId = Int(categoryId)
        })
    }

    //更新企业名称
    public func updateEntName(_ entName:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.entName = entName
        })
    }
    
    
    
    
    //更新企业地址
    public func updateEntAddress(_ entAddress:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.entAddress = entAddress
        })
    }
    
    //更新信用代码
    public func updateCreditCode(_ creditCode:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.creditCode = creditCode
        })
    }
    
    //更新法人姓名
    public func updateLegalName(_ legalName:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.legalName = legalName
        })
    }
    
    //更新身份证号
    public func updateCertNo(_ certNo:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.certNo = certNo
        })
    }
    
    //更新身份证正面
    public func updateFrontPic(_ frontPic:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.frontPic = frontPic
            LXFLog(storeModel.frontPic)
        })
    }
    
    //更新身份证反面
    public func updateReversePic(_ reversePic:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.reversePic = reversePic
            LXFLog(storeModel.reversePic)
        })
    }
    
    //更新营业执照
    public func updateLicencePic(_ licencePic:String){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            storeModel.licencePic = licencePic
            LXFLog(storeModel.licencePic)
        })
    }
    
    
    
    
    //更新店铺信息--所有的信息
    public func updateShopInfo(_ model:StoreInfoModel){
        guard let realm = try? Realm() else {return}
        var storeModel :StoreModel
        if let u = realm.objects(StoreModel.self).first{
            storeModel = u
        }else{
            storeModel = StoreModel()
            try! realm.write({
                realm.add(storeModel)
            })
        }
        try! realm.write({
            if let accessToken = model.accessToken,!accessToken.isEmpty{
                storeModel.accessToken = accessToken
            }
            
            if let auditStatus = model.auditStatus{
                storeModel.auditStatus = Int(auditStatus)
            }
            
            if let categoryId = model.categoryId{
                storeModel.categoryId = Int(categoryId)
            }
            
            if let categoryName = model.categoryName,!categoryName.isEmpty{
                storeModel.categoryName = categoryName
            }
            
            if let certNo = model.certNo,!certNo.isEmpty{
                storeModel.certNo = certNo
            }
            
            if let countryId = model.countryId{
                storeModel.countryId = Int(countryId)
            }
            
            if let creditCode = model.creditCode,!creditCode.isEmpty{
                storeModel.creditCode = creditCode
            }
            
            if let email = model.email,!email.isEmpty{
                storeModel.email = email
            }
            
            if let entAddress = model.entAddress,!entAddress.isEmpty{
                storeModel.entAddress = entAddress
            }
            
            if let entName = model.entName,!entName.isEmpty{
                storeModel.entName = entName
            }
            
            
            if let frontPic = model.frontPic,!frontPic.isEmpty{
                storeModel.frontPic = frontPic
            }
            
            if let legalName = model.legalName,!legalName.isEmpty{
                storeModel.legalName = legalName
            }
            
            if let licencePic = model.licencePic,!licencePic.isEmpty{
                storeModel.licencePic = licencePic
            }
            
            if let mobile = model.mobile,!mobile.isEmpty{
                storeModel.mobile = mobile
            }
            
            if let regTime = model.regTime,!regTime.isEmpty{
                storeModel.regTime = regTime
            }
            
            if let rejectReason = model.rejectReason,!rejectReason.isEmpty{
                storeModel.rejectReason = rejectReason
            }
            
            if let reversePic = model.reversePic,!reversePic.isEmpty{
                storeModel.reversePic = reversePic
            }
            
            if let shopAuth = model.shopAuth{
                storeModel.shopAuth = shopAuth
            }
            
            if let shopAvatar = model.shopAvatar,!shopAvatar.isEmpty{
                storeModel.shopAvatar = shopAvatar
            }
            
            
            if let shopId = model.shopId{
                storeModel.shopId = Int(shopId)
            }
            
            if let shopName = model.shopName,!shopName.isEmpty{
                storeModel.shopName = shopName
            }
        })
    }
    
    //删除
    public func delete(){
        guard let realm = try? Realm() else{return}
        try! realm.write({
            realm.deleteAll()
        })
    }
    
    
    
    
    
    
    
    
    
}
