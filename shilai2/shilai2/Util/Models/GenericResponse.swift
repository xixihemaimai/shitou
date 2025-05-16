//
//  GenericResponse.swift
//  Utils
//
//  Created by ZhouJialei on 2021/5/23.
//

public struct GenericResponse<T: Codable>: Codable {

    public var data: T?
    public var status: Int?
    public var msg: String?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
        case msg = "msg"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try? values.decodeIfPresent(Int.self, forKey: .status)
        msg = try? values.decodeIfPresent(String.self, forKey: .msg)
        data = try? values.decodeIfPresent(T.self, forKey: .data)
    }
}
