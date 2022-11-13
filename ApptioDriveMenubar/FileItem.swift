//
//  FileItems.swift
//  ApptioDriveMenubar
//
//  Created by Pushkar Sharma on 13/11/22.
//

import Foundation

struct FileItem: Codable {
    
    var name: String
    var status: String

}

extension FileItem {
    
    static func all() -> [FileItem] {
        
        let data = FileStatusLoader().fileItems
        print(data)
        
        return data
    }
}
