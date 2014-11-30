//
//  SlotLogic.swift
//  SlotsGameNew
//
//  Created by Chris Shaughnessy on 11/29/14.
//  Copyright (c) 2014 Webified Design. All rights reserved.
//

import Foundation
import UIKit

class SlotLogic {
    
    class func invertSlotColumnsAndRows (slotsArray: [[Slot]]) -> [[Slot]] {
        
        var slotsInRows: [[Slot]] = []
        
        for (columnIndex, slotsColumn) in enumerate(slotsArray) {
            for (slotIndex, slot) in enumerate(slotsColumn) {
                if columnIndex == 0 {
                    let slotsRow = [slot]
                    slotsInRows.append(slotsRow)
                }
                else {
                    slotsInRows[slotIndex].append(slot)
                }
            }
        }
        return slotsInRows
    }
    
    class func computeWinnings (slotsArray: [[Slot]]) -> Int {
        var slotsInRows = invertSlotColumnsAndRows(slotsArray)
        var winnings = 0
        
        var flushWinCount = 0
        var fourOfAKindWinCount = 0
        var threeOfAKindWinCount = 0
        var twoPairWinCount = 0
        var straitWinCount = 0
        
        for slotRow in slotsInRows {
            
            if checkFlush(slotRow) == true {
                print("flush")
                winnings += 1
                flushWinCount += 1
            }
            else if checkFlush(slotRow) == true {
                print("straight")
                winnings += 1
                straitWinCount += 1
            }
            
        }
        
        return winnings
        }
    }
    
    class func checkFlush (slotRow: [Slot]) -> Bool {
        
        var clubsCount = 0, spadesCount = 0, heartsCount = 0, diamondsCount = 0
        
        for slot in slotRow {
            if slot.isClub {
                clubsCount++
            }
            else if slot.isSpade {
                spadesCount++
            }
            else if slot.isHeart {
                heartsCount++
            } else {
                diamondsCount++
            }
        }
        
        if clubsCount == 5 || spadesCount == 5 || heartsCount == 5 || diamondsCount == 5 {
            return true
        } else {
            return false
        }
    }
    
    class func checkStraight (slotsRow: [Slot]) -> Bool {
        let slot1 = slotsRow[0]
        let slot2 = slotsRow[1]
        let slot3 = slotsRow[2]
        let slot4 = slotsRow[3]
        let slot5 = slotsRow[4]
        
            // Needs check to prevent straight from cycling back to ace
            if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 && slot1.value == slot4.value - 3 && slot1.value == slot4.value - 4 {
                return true
            }
            else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 && slot1.value == slot4.value + 3 && slot1.value == slot4.value + 4 {
                return true
            }
            else {
                return false
            }
        
        }
    
//    class func checkFourOfAKind (slotsRow: [Slot]) -> Bool {
//        
//        
//    }
}