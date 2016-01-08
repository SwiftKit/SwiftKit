//
//  StyleKitPerformance.swift
//  SwiftKit
//
//  Created by Tadeas Kriz on 06/01/16.
//  Copyright © 2016 Tadeas Kriz. All rights reserved.
//

import XCTest
@testable import SwiftKit

private class StyledView: UIView { }

private class NoncanonicalView: UIView { }

class StyleKitPerformance: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        
        self.measureBlock {
            StyleManager.destroyInstance()
            // Put the code you want to measure the time of here.
            StyleManager.instance.declareStyles { declare in
                for _ in 1...1000 {
                    declare.style(UIWindow.self) {
                        $0.tintColor = UIColor.brownColor()
                    }
                    
                    declare.style(UIView.self) {
                        $0.backgroundColor = UIColor.redColor()
                    }
                    
                    declare.style(UIView.self) {
                        $0.backgroundColor = UIColor.purpleColor()
                    }
                    
                    declare.style(UIButton.self) {
                        $0.backgroundColor = UIColor.whiteColor()
                    }
                    
                    declare.inside(UIView).style(UIButton.self) {
                        $0.backgroundColor = UIColor.blueColor()
                    }
                    
                    declare.inside(StyledView.self, named: "testing").inside(UIView).style(UIButton.self) {
                        $0.backgroundColor = UIColor.greenColor()
                    }
                    
                    declare.style(StyledView.self, named: "hello") {
                        $0.backgroundColor = UIColor.blueColor()
                    }
                    
                    declare.style(StyledView.self, named: "world") {
                        $0.clipsToBounds = false
                    }
                    
                    declare.style(StyledView.self) {
                        $0.backgroundColor = UIColor.redColor()
                        $0.clipsToBounds = true
                    }
                    
                    declare.inside(StyledView.self, named: "testing").inside(UIView).inside(UIView).inside(UIView).inside(UIView).inside(UIView).inside(UIView).inside(UIView).style(UIButton.self) {
                        $0.backgroundColor = UIColor.greenColor()
                    }
                    
                    declare.style(StyledView.self) {
                        $0.backgroundColor = UIColor.redColor()
                        $0.clipsToBounds = true
                    }
                }
            }
            
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.makeKeyAndVisible()
            let v1 = StyledView()
            window.addSubview(v1)
            v1.skt_names = ["testing"]
            let view = UIView()
            let button = UIButton()
            
            v1.addSubview(view)
            view.addSubview(button)
            
            let canonicalView = StyledView()
            canonicalView.skt_names = ["hello", "world"]
            let noncanonicalView = NoncanonicalView()
            
            for _ in 1...100 {
                StyleManager.instance.apply(window)
                StyleManager.instance.apply(canonicalView)
                StyleManager.instance.apply(noncanonicalView)
            }
            
            //print(NSDate().timeIntervalSinceDate(started))
            
            
        }
    }
}
