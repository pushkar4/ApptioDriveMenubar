//
//  FileStatusLoader.swift
//  ApptioDriveMenubar
//
//  Created by Pushkar Sharma on 13/11/22.
//

import Foundation

public class FileStatusLoader {

    @Published var fileItems = [FileItem]()
    
    init() {
        load()
    }
    
    func load() {
        
        if let fileLocation = Bundle.main.url(forResource: "filestatus", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                
                let dataFromJson = try jsonDecoder.decode([FileItem].self, from: data)
                self.fileItems = dataFromJson
                
            } catch {
                print(error)
            }
        }
    }
}
