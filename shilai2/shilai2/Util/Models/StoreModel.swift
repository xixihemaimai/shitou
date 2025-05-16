//
//  StoreModel.swift
//  Util
//
//  Created by mac on 2022/5/18.
//

import Foundation
import RealmSwift


public class StoreModel:Object{
    
    //店铺Token
    @objc public dynamic var accessToken = ""
    //申请状态
    @objc public dynamic var auditStatus = 0
    //经营种类ID
    @objc public dynamic var categoryId = 0
    //经营种类名称
    @objc public dynamic var categoryName = ""
    //身份证号
    @objc public dynamic var certNo = ""
    //国家地区
    @objc public dynamic var countryId = 0
    //信用代码
    @objc public dynamic var creditCode = ""
    //电子邮件
    @objc public dynamic var email = ""
    //entAddress 企业地址
    @objc public dynamic var entAddress = ""
    //企业名称
    @objc public dynamic var entName = ""
    //身份证正面
    @objc public dynamic var frontPic = ""
    //法人姓名
    @objc public dynamic var legalName = ""
    //营业执照
    @objc public dynamic var licencePic = ""
    //手机号
    @objc public dynamic var mobile = ""
    //注册时间（开通时间）
    @objc public dynamic var regTime = ""
    //驳回原因
    @objc public dynamic var rejectReason = ""
    //身份证反面
    @objc public dynamic var reversePic = ""
    //店铺认证（false：未认证、true：已认证）--头像、店铺名称、经营品类
    @objc public dynamic var shopAuth = false
    //店铺头像
    @objc public dynamic var shopAvatar = ""
    //店铺ID
    @objc public dynamic var shopId = 0
    //店铺名称
    @objc public dynamic var shopName = ""
    
    /**
 获取店铺信息

 auditStatus    integer($int32)
 营业执照

 categoryId    integer($int32)
 经营种类Id

 categoryName    string
 经营种类名称

 certNo    string
 身份证号

 countryId    integer($int32)
 国家地区

 creditCode    string
 信用代码

 email    string
 电子邮件

 entAddress    string
 企业地址

 entName    string
 企业名称

 frontPic    string
 身份证正面

 legalName    string
 法人姓名

 licencePic    string
 营业执照

 mobile    string
 手机号

 regTime    string
 注册时间（开通时间）

 rejectReason    string
 驳回原因

 reversePic    string
 身份证反面

 shopAuth    boolean
 example: false
 店铺认证（false：未认证、true：已认证）--头像、店铺名称、经营品类

 shopAvatar    string
 店铺头像

 shopId    integer($int64)
 店铺Id

 shopName    string
 店铺名称
    
     */
    
    
    
    
}


