//
//  Elements.swift
//  AC3.2-MidtermElements
//
//  Created by Simone on 12/8/16.
//  Copyright © 2016 Simone. All rights reserved.
//

import Foundation

class Elements {
    let id: Int
    let number: Int
    let weight: Int
    let name: String
    let symbol: String
    let meltingC: Int
    let boilingC: Int
    let density: Int
    let discoveryYear: String
    let group: Int
    let electrons: String
    let ions: Int
    init(id: Int, number: Int, weight: Int, name: String, symbol: String, meltingC: Int, boilingC: Int, density: Int, discoveryYear: String, group: Int, electrons: String, ions: Int) {
        self.id = id
        self.number = number
        self.weight = weight
        self.name = name
        self.symbol = symbol
        self.meltingC = meltingC
        self.boilingC = boilingC
        self.density = density
        self.discoveryYear = discoveryYear
        self.group = group
        self.electrons = electrons
        self.ions = ions
    }
    
    convenience init?(dict: [String:Any]) {
        guard let id = dict["id"] as? Int,
        let number = dict["number"] as? Int,
        let weight = dict["weight"] as? Int,
        let name = dict["name"] as? String,
        let symbol = dict["symbol"] as? String,
        let meltingC = dict["melting_c"] as? Int,
        let boilingC = dict["boiling_c"] as? Int else {
            print("Could not get details")
            return nil
        }
        guard let density = dict["density"] as? Int else {
            print("Could not get density")
            return nil
        }
        guard let discoveryYear = dict["discovery_year"] as? String else {
            print("Could not get discoveryYear")
            return nil
        }
        guard let group = dict["group"] as? Int else {
            print("Could not get group")
            return nil
        }
        guard let electrons = dict["electrons"] as? String else {
            print("Could not get electrons")
            return nil
        }
        guard let ions = dict["ion_energy"] as? Int else {
            print("Could not get ions")
            return nil
        }
        self.init(id: id, number: number, weight: weight, name: name, symbol: symbol, meltingC: meltingC, boilingC: boilingC, density: density,  discoveryYear: discoveryYear, group: group, electrons: electrons, ions: ions) 
    }
    
    static func getElements(data: Data) -> [Elements]? {
        var elements = [Elements]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let validJSON = json as? [[String:AnyObject]] else { return nil }
//            dump(validJSON)
            for dicts in validJSON {
                if let newDict = Elements(dict: dicts) {
                    elements.append(newDict)
                    print(newDict)
                }
            }
        }
        catch {
            print(error)
        }
        return elements
    }
}
