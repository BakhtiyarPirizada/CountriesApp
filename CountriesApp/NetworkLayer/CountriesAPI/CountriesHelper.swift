//
//  CountriesHelper.swift
//  CountriesApp
//
//  Created by Bakhtiyar Pirizada on 12.12.24.
//

import Foundation
enum CountryHelper {
    case all
    
    var endPoint:String {
        switch self {
        case .all : ""
        }
    }
    var mainPath: String {
        "all/"
    }
    var path : URL? {
        CoreAPIHelper.instance.makeURL(path: mainPath+endPoint)
    }
}
