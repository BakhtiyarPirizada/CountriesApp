//
//  HomeViewModel.swift
//  CountriesApp
//
//  Created by Bakhtiyar Pirizada on 10.12.24.
//

import Foundation

final class HomeViewModel {
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    var listener: ((ViewState) -> Void)?
    
    private(set) var list: CountryList?
    private(set) var searchedList: CountryList?
    
    func countryListRequest() {
        listener?(.loading)
        CountryAPIService.instance.getCountry { [weak self]  data, error in
            guard let self = self else {return}
            listener?(.loaded)
            if let data = data {
                list = data
                searchedList = data
                listener?(.success)
            } else if let error = error {
                listener?(.error(error.localizedDescription))
            }
            
        }
    }
    func getList(index:Int) -> TitleSubtitleProtocol? {
        return searchedList?[index]
    }
    func getItems() -> Int {
        searchedList?.count ?? 0
    }
    func sortAtoZ(text:String) {
        if text.isEmpty {
            searchedList = list
        } else {
            searchedList = list?.filter({ $0.title.lowercased().contains(text.lowercased())})
            listener?(.success)
        }
    }
    
}
