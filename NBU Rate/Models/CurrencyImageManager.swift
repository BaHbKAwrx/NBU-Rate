//
//  CurrencyImageManager.swift
//  NBU Rate
//
//  Created by Shmygovskii Ivan on 6/14/19.
//  Copyright © 2019 Shmygovskii Ivan. All rights reserved.
//

import Foundation

// enum for transforming currency code to image name
enum CurrencyImageManager: String {
    
    case EU
    case GB
    case JP
    case RU
    case US
    case AT
    case CA
    case CN
    case HR
    case CZ
    case DK
    case HK
    case HU
    case IN
    case ID
    case IR
    case IL
    case KZ
    case KR
    case MX
    case MD
    case NZ
    case NO
    case SA
    case SG
    case ZA
    case SE
    case CH
    case EG
    case BY
    case AZ
    case RO
    case TR
    case BG
    case PL
    case DZ
    case BD
    case AM
    case IQ
    case KG
    case LB
    case LY
    case MY
    case MA
    case PK
    case VN
    case TH
    case AE
    case TN
    case UZ
    case TW
    case TM
    case GH
    case RS
    case TJ
    case GE
    case WW
    case METAL
    
    init(code: String) {
        switch code {
        case "EUR": self = .EU
        case "GBP": self = .GB
        case "JPY": self = .JP
        case "RUB": self = .RU
        case "USD": self = .US
        case "AUD": self = .AT
        case "CAD": self = .CA
        case "CNY": self = .CN
        case "HRK": self = .HR
        case "CZK": self = .CZ
        case "DKK": self = .DK
        case "HKD": self = .HK
        case "HUF": self = .HU
        case "INR": self = .IN
        case "IDR": self = .ID
        case "IRR": self = .IR
        case "ILS": self = .IL
        case "KZT": self = .KZ
        case "KRW": self = .KR
        case "MXN": self = .MX
        case "MDL": self = .MD
        case "NZD": self = .NZ
        case "NOK": self = .NO
        case "SAR": self = .SA
        case "SGD": self = .SG
        case "ZAR": self = .ZA
        case "SEK": self = .SE
        case "CHF": self = .CH
        case "EGP": self = .EG
        case "BYN": self = .BY
        case "AZN": self = .AZ
        case "RON": self = .RO
        case "TRY": self = .TR
        case "XDR": self = .WW
        case "BGN": self = .BG
        case "PLN": self = .PL
        case "DZD": self = .DZ
        case "BDT": self = .BD
        case "AMD": self = .AM
        case "IQD": self = .IQ
        case "KGS": self = .KG
        case "LBP": self = .LB
        case "LYD": self = .LY
        case "MYR": self = .MY
        case "MAD": self = .MA
        case "PKR": self = .PK
        case "VND": self = .VN
        case "THB": self = .TH
        case "AED": self = .AE
        case "TND": self = .TN
        case "UZS": self = .UZ
        case "TWD": self = .TW
        case "TMT": self = .TM
        case "GHS": self = .GH
        case "RSD": self = .RS
        case "TJS": self = .TJ
        case "GEL": self = .GE
        case "XAU": self = .METAL
        case "XAG": self = .METAL
        case "XPT": self = .METAL
        case "XPD": self = .METAL
        default: self = .WW
        }
    }
}
