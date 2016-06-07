//
//  BgData.swift
//  scoutwatch
//
//  Created by Dirk Hermanns on 23.01.16.
//  Copyright © 2016 private. All rights reserved.
//

import Foundation

/* 
 * Class to hold the blood glucose data to be displayed.
 * The singleton can be used to set test data during UITests.
 */
class BgDataHolder {
    static let singleton = BgDataHolder()
    
    private var historicBgData : [BloodSugar] = []
    private var currentNightscoutData = NightscoutData()
    private var testNightscoutData = NightscoutData()
    
    func setTestBgData(testBgData : NightscoutData) {
        self.testNightscoutData = testBgData
    }
    
    func setHistoricBgData(historicBgData : [BloodSugar]) {
        self.historicBgData = historicBgData
    }
    
    func getHistoricBgData() -> [BloodSugar] {
        return historicBgData
    }
    
    func setCurrentBgData(currentNightscoutData : NightscoutData) {
        self.currentNightscoutData = currentNightscoutData
    }
    
    func getCurrentBgData() -> NightscoutData {
        if inTestMode() {
            return generateHighBgTestData()
        } else {
            return currentNightscoutData
        }
    }
    
    func inTestMode() -> Bool {
        let dic = NSProcessInfo.processInfo().environment
        return dic["TEST"] != nil
    }
    
    private func generateHighBgTestData() -> NightscoutData {
        let bgData = NightscoutData()
        bgData.sgv = "200"
        bgData.bgdelta = 0
        bgData.time = NSDate.init().timeIntervalSince1970
        
        return bgData
    }
}