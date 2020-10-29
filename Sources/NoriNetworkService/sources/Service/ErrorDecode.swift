//
//  ErrorDecode.swift
//  NetworkService
//
//  Created by IDAP Developer on 12/3/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import Foundation
import RxSwift

public let UnavailableError = PublishSubject<ResponseError>()

@dynamicMemberLookup
public struct FieldsError {
    public let errors: Dictionary<String, String>?
    
    public init(errors: Dictionary<String, String>?) {
        self.errors = errors
    }
    
    public var isEmapty: Bool {
        return self.errors?.isEmpty ?? true
    }
    
    public subscript(dynamicMember member: String) -> String? {
        return self.errors?[member]
    }
    
    public var errorsString: String? {
        return self.errors?.reduce("", { (result, kV) -> String in
            result + " " + kV.value
        })
    }
}

public struct ResponseError: Error {
    
    public enum Code: String, Equatable {
        case `default` = "DEFAULT"
        case accountSignConflict = "ACCOUNT_SIGN_CONFLICT"
        case parkingClosed = "PARKING_CLOSED"
        case invalidBarcode = "DATA_NOT_FOUND"
        case invalidPaymentData = "APP_PAYMENT_PORTMONE"
        case parkingModuleUnavailable = "PARKING_MODULE_UNAVAILABLE"
        case moduleUnavailable = "MODULE_UNAVAILABLE"
        case appMainTenanceWork = "APP_MAINTENANCE_WORK"
        case mapsTechWork = "NAVIGATION_MODULE_UNAVAILABLE"
        case pageNotFound
        case dataNotFound
        case invalidToken
        case tooManyRequestsSms
        case invalidCode
        case accountIsBlocked
        case accountIsDeleted
        case serverInternalError
        case tokenWasntGenerated
        case accessDenied
        case methodNotAllowed
        case unprocessableEntity
    }
    
    public let code: Code
    public let statusCode: Int
    public let message: String
    public let errors: FieldsError
    public let headers: [AnyHashable: Any]
}

extension ResponseError {
    static func error(statusCode: Int, message: String? = nil, headers: [AnyHashable : Any]) -> ResponseError {
        let m = message ?? (statusCode < 100
            ? "Undefined error"
            : HTTPURLResponse.localizedString(forStatusCode: statusCode)
        )
        
        return ResponseError(
            code: .default,
            statusCode: statusCode,
            message: m,
            errors: FieldsError(errors: nil),
            headers: headers
        )
    }
}

func decodeResponseError(statusCode: Int, data: Data, headers: [AnyHashable : Any]) -> ResponseError {
    let decoder = JSONDecoder()
    do {
        let value = try decoder.decode(ResponseErrorInternal.self, from: data)
        let error = transform(responseErrorInternal: value, statusCode: statusCode, headers: headers)
        
        if ResponseError.Code.appMainTenanceWork == error.code {
            UnavailableError.onNext(error)
        }
        
        return error
    } catch {
        let error = ResponseError.error(statusCode: statusCode, headers: headers)
        
        if ResponseError.Code.appMainTenanceWork == error.code {
            UnavailableError.onNext(error)
        }
        
        return error
    }
}

struct ResponseErrorInternal: Decodable {
    
    let code: String
    let message: String
    let errors: Dictionary<String, String>?
}

func transform(responseErrorInternal: ResponseErrorInternal, statusCode: Int, headers: [AnyHashable : Any]) -> ResponseError {
    return ResponseError(code: ResponseError.Code.init(rawValue: responseErrorInternal.code) ?? .default,
                         statusCode: statusCode,
                         message: responseErrorInternal.message,
                         errors: FieldsError(errors: responseErrorInternal.errors),
                         headers: headers)
}
