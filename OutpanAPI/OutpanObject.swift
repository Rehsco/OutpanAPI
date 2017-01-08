//
//  OutpanObject.swift
//  OutpanAPI
//
//  Created by Martin Rehder on 07.01.2017.
/*
 * Copyright 2017-present Martin Jacob Rehder.
 * http://www.rehsco.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import Foundation

open class OutpanObject: NSObject {
    public var name: String?
    public let gtin: String
    open var outpanUrl: String?

    public var attributes: Dictionary<String, String> = [:]
    public var images: Array<String> = []
    public var videos: Array<String> = []
    
    public init(gtin: String) {
        self.gtin = gtin
    }
    
    public init(from json: Any, gtin: String) {
        if let jsonDict = json as? NSDictionary {
            self.gtin = jsonDict["gtin"] as? String ?? gtin
            self.outpanUrl = jsonDict["outpan_url"] as? String
            self.name = jsonDict["name"] as? String

            if let adict = jsonDict["attributes"] as? NSDictionary {
                for aEntry in adict {
                    if let key = aEntry.key as? String, let value = aEntry.value as? String {
                        self.attributes[key] = value
                    }
                }
            }

            if let idict = jsonDict["images"] as? NSArray {
                for iEntry in idict {
                    if let imageRef = iEntry as? String {
                        self.images.append(imageRef)
                    }
                }
            }

            if let vdict = jsonDict["videos"] as? NSArray {
                for vEntry in vdict {
                    if let videoRef = vEntry as? String {
                        self.videos.append(videoRef)
                    }
                }
            }
        }
        else {
            self.gtin = gtin
        }
    }
}
