# OutpanAPI
An Outpan API wrapper written in Swift

# Usage

Here is a simple example of how to make a lookup
```swift
	let content = “<some GTIN code to search for>”
        let outpanAPI = OutpanAPI(apiKey: “<your Outpan API key>”)
        let _ = outpanAPI.lookup(for: content) { result in
            if let cRes = result.value as? OutpanObject {
                // use the cRes
            }
        }

```

The ```OutpanObject``` contains the retrieved entries, such as ‘name’, ‘attributes’ dictionary and ‘images’/‘videos’ reference arrays.

The ‘result’ in the example above may also contain an error in ```result.error```.

# Installation

## CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your Podfile and add _OutpanAPI_:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘10.0’

use_frameworks!
pod ‘OutpanAPI’
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file):

``` bash
$ open MyProject.xcworkspace
```

You can now `import OutpanAPI` framework into your files.

## Manually

[Download](https://github.com/Rehsco/OutpanAPI/archive/master.zip) the project and copy the `OutpanAPI` folder into your project to use it in.

# License (MIT)

Copyright (c) 2017-present - Martin Jacob Rehder, Rehsco

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
