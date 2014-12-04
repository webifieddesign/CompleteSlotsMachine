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
    
    class func computeWinnings (slotsArray: [[Slot]]) -> (winnings: Int, winLabelArray: [String]) {
        var slotsInRows = invertSlotColumnsAndRows(slotsArray)
        var winnings = 0
        
        var flushWinCount = 0
        var fourOfAKindWinCount = 0
        var threeOfAKindWinCount = 0
        var twoPairWinCount = 0
        var straightWinCount = 0
        var straightFlushWinCount = 0
        
        var winLabelsArray:[String] = []
        
        for slotRow in slotsInRows {
            
            if checkFlush(slotRow) == true {
                println("flush" )
                winnings += 25
                flushWinCount += 1
                winLabelsArray.append("Flush!")
            }
            else if checkStraight(slotRow) == true {
                println("straight")
                winnings += 1000
                straightWinCount += 1
                winLabelsArray.append("Straight!")
            }
            else if checkFourOfAKind(slotRow) == true {
                println("four of a kind")
                winnings += 5
                fourOfAKindWinCount += 1
                winLabelsArray.append("Four of a Kind!")
            }
            else if checkThreeOfAKind(slotRow) == true {
                println("three of a kind")
                winnings += 3
                threeOfAKindWinCount += 1
                winLabelsArray.append("Three of a Kind!")
            }
            else if checkTwoPair(slotRow) == true {
                println("two pair")
                winnings += 1
                twoPairWinCount += 1
                winLabelsArray.append("Two Pair!")
            }
            else if checkFlush(slotRow) == true && checkStraight(slotRow) == true {
                print("Straing flush")
                winnings += 10000
                straightFlushWinCount += 1
                winLabelsArray.append("Royal Flush!")
            }
            else {
                winLabelsArray.append("")
            }
        }
        println("end of turn")
        println("\(winLabelsArray)")
        return (winnings, winLabelsArray)
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
        
        if slot1.cardRank == slot2.cardRank - 1 && slot1.cardRank == slot3.cardRank - 2 && slot1.cardRank == slot4.cardRank - 3 && slot1.cardRank == slot4.cardRank - 4 {
            return true
        }
        else if slot1.cardRank == slot2.cardRank + 1 && slot1.cardRank == slot3.cardRank + 2 && slot1.cardRank == slot4.cardRank + 3 && slot1.cardRank == slot4.cardRank + 4 {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkFourOfAKind (slotsRow: [Slot]) -> Bool {
        let slot1 = slotsRow[0]
        let slot2 = slotsRow[1]
        let slot3 = slotsRow[2]
        let slot4 = slotsRow[3]
        let slot5 = slotsRow[4]
        
        if slot1.cardRank == slot2.cardRank && slot1.cardRank == slot3.cardRank && slot1.cardRank == slot4.cardRank {
            return true
        }
        else if slot1.cardRank == slot2.cardRank && slot1.cardRank == slot3.cardRank && slot1.cardRank == slot5.cardRank {
            return true
        }
        else if slot1.cardRank == slot2.cardRank && slot1.cardRank == slot4.cardRank && slot1.cardRank == slot5.cardRank {
            return true
        }
        else if slot1.cardRank == slot3.cardRank && slot1.cardRank == slot4.cardRank && slot1.cardRank == slot5.cardRank {
            return true
        }
        else if slot2.cardRank == slot3.cardRank && slot2.cardRank == slot4.cardRank && slot2.cardRank == slot5.cardRank {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkThreeOfAKind (slotsRow: [Slot]) -> Bool {
        let slot1 = slotsRow[0]
        let slot2 = slotsRow[1]
        let slot3 = slotsRow[2]
        let slot4 = slotsRow[3]
        let slot5 = slotsRow[4]
        
        if slot1.cardRank == slot2.cardRank && slot1.cardRank == slot3.cardRank {
            return true
        }
        else if slot1.cardRank == slot2.cardRank && slot1.cardRank == slot4.cardRank {
            return true
        }
        else if slot1.cardRank == slot2.cardRank && slot1.cardRank == slot5.cardRank {
            return true
        }
        else if slot1.cardRank == slot3.cardRank && slot1.cardRank == slot4.cardRank {
            return true
        }
        else if slot2.cardRank == slot3.cardRank && slot2.cardRank == slot4.cardRank {
            return true
        }
        else if slot2.cardRank == slot3.cardRank && slot2.cardRank == slot5.cardRank {
            return true
        }
        else if slot3.cardRank == slot4.cardRank && slot3.cardRank == slot5.cardRank {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkTwoPair (slotsRow: [Slot]) -> Bool {
        var cardsArray: [Int] = []
        var pairCount = 0
        
        for slot in slotsRow {
            cardsArray.append(slot.cardRank)
        }
        
        cardsArray.sort( {$0 < $1} )
        
        for var i = 0; i < 4; ++i {
            if cardsArray[i] == cardsArray[i+1] {
                pairCount++
            }
        }
        
        if pairCount == 2 {
            return true
        }
        else {
            return false
        }
    }
    
}