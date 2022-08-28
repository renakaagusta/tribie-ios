//
//  ConstantURL.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import UIKit

enum AppEnvironment: String {
    case debugStaging = "Staging Debug"
    case releaseStaging = "Staging Release"
    
    case debugProduction = "Prod Debug"
    case releaseProduction = "Prod Release"
}

enum ApiServicesEndpoint {
    case block
    case listReportReason
    case doReportTalent
    case emergencyList
    case submitEmergency
    case getClientProfile
    case getManagerProfile
    case getTalentProfile
    case getInvoice
    case accountBank
    case updateNewsStatus
    case getMerchByVerifNoLogin
    case getMerchByVerifLogin
    case getAllOfficialMerchandise
    case getDetailOfficialMerchandise
    case getDetailMerchandise
    case postShipping
    case postCreateTransactionMerchandise
    case getListDetailMerchTrans
    case postTrackingShipping
    case getListDiburstment
    case getDetailTiketAcara
    case postCreateTransactionTiketAcara
    case getListPromo
    case getFollowing
}

class ConstantURL {
    lazy var shared = ConstantURL()
    var environment: AppEnvironment
    
    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
        environment = AppEnvironment(rawValue: currentConfiguration)!
    }
    
    var baseUrl: String {
        switch environment {
        case .debugStaging, .releaseStaging:
            return "https://api-staging.serbaseleb.com/"
        case .debugProduction, .releaseProduction:
            return "https://api.serbaseleb.com/"
        }
    }
    
    
    /* Notes: instead of using static variable or lazy variable, endpoint url can be defined as enum class but have to change all network call related (High effort but low impact for current condition) */
    lazy var register = baseUrl + "v2/registration"
    lazy var login = baseUrl + "login"
    
    
}

