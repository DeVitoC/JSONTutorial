//
//  ModelController.swift
//  JSONExample
//
//  Created by Christopher Devito on 8/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class ModelController {

    var models: [Model] = []
    let fm = FileManager.default
//    let path = Bundle.main.bundlePath.appending("/modelExample.json")
    lazy var path: URL = {
        var path = fm.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("modelExample.json")
        return path
    }()

    func fetchFromJSONFile() {
        let jsonDecoder = JSONDecoder()

        // Get JSON and decode it
        guard let jsonData = NSData(contentsOfFile: path.absoluteString) else { return }
        print(path)

        do {
            let data = Data(jsonData)
            models = try jsonDecoder.decode([Model].self, from: data)
        } catch {
            NSLog("\(error)")
        }
    }

    func appendToJSONFile(model: Model) {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let appendData = Data(base64Encoded: (",\n".data(using: .utf8)?.base64EncodedString())!)!
        let closeData = Data(base64Encoded: ("\n]".data(using: .utf8)?.base64EncodedString())!)!
        let startData = Data(base64Encoded: ("[\n...".data(using: .utf8)?.base64EncodedString())!)!

        do {
            if !fm.fileExists(atPath: path.absoluteString) {
//                fm.createFile(atPath: path, contents: startData, attributes: nil)
                try startData.write(to: path)
            }
            let fileHandle = try FileHandle(forWritingTo: path)
            let data = try jsonEncoder.encode(model)
            let attr = try fm.attributesOfItem(atPath: path.absoluteString)
            let fileSize = attr[FileAttributeKey.size] as! UInt64
            let offset = fileSize - 3
            try fileHandle.seek(toOffset: offset)
            fileHandle.write(appendData)
            fileHandle.write(data)
            fileHandle.write(closeData)
            fileHandle.closeFile()
        } catch let error {
            NSLog("\(error)")
        }
    }
}
