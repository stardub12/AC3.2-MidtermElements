//
//  Post.swift
//  AC3.2-MidtermElements
//
//  Created by Simone on 12/8/16.
//  Copyright © 2016 Simone. All rights reserved.
//

import Foundation

class Post {
    let myName: String
    let favElement: String
    init(myName: String, favElement: String) {
        self.myName = myName
        self.favElement = favElement
    }
    
    convenience init?(dict: [String:Any]) {
        guard let myName = dict["my_name"] as? String else {
            print("Could not post name")
            return nil
        }
        guard let favElement = dict["favorite_element"] as? String else {
            print("Could not post element")
            return nil
        }
        self.init(myName: myName, favElement: favElement)
    }
    
    static func addPost(data: Data) -> [Post]? {
        var returnedPosts = [Post]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options:[])
            
            guard let validJSON = json as? [[String:Any]] else {
                print("Error casting json")
                return nil
            }
            for dicts in validJSON {
                if let newDict = Post(dict: dicts) {
                    returnedPosts.append(newDict)
                    print(newDict)
                }
            }
        }
        catch {
            print(error)
        }
        return returnedPosts
    }
}
