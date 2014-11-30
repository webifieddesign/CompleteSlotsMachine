//
//  Factory.swift
//  SlotsGameNew
//
//  Created by Chris Shaughnessy on 11/29/14.
//  Copyright (c) 2014 Webified Design. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    
    class func createSlots() -> [[Slot]] {
        
        let kNumberOfSlotColumns = 5
        let kNumberOfSlotRows = 5
        
        var randomSlots: [[Slot]] = []
        
        for var slotColumn = 0; slotColumn < kNumberOfSlotColumns; ++slotColumn {
            var rowArray: [Slot] = []
            
            for var slotRow = 0 ; slotRow < kNumberOfSlotRows; ++slotRow {
                var columnArray = createSlot(rowArray)
                rowArray.append(columnArray)
            }
            randomSlots.append(rowArray)
        }
        return randomSlots
    }
    
    class func createSlot(currentCards: [Slot]) -> Slot {
        var currentCardValues: [Int] = []
        
        for currentCard in currentCards {
            currentCardValues.append(currentCard.value)
        }
        
        var randomNumber = Int(arc4random_uniform(UInt32(52)))
        while contains(currentCardValues, randomNumber + 1) {
            randomNumber = Int(arc4random_uniform(UInt32(52)))
        }
        
        var slotInstance: Slot
        
        switch randomNumber {
            
            //Spades
        case 0:
            slotInstance = Slot(value: 1, cardRank: 1, image: UIImage(named: "aceSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 1:
            slotInstance = Slot(value: 2, cardRank: 2, image: UIImage(named: "twoSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 2:
            slotInstance = Slot(value: 3, cardRank: 3, image: UIImage(named: "threeSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 3:
            slotInstance = Slot(value: 4, cardRank: 4, image: UIImage(named: "fourSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 4:
            slotInstance = Slot(value: 5, cardRank: 5, image: UIImage(named: "fiveSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 5:
            slotInstance = Slot(value: 6, cardRank: 6, image: UIImage(named: "sixSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 6:
            slotInstance = Slot(value: 7, cardRank: 7, image: UIImage(named: "sevenSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 7:
            slotInstance = Slot(value: 8, cardRank: 8, image: UIImage(named: "eightSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 8:
            slotInstance = Slot(value: 9, cardRank: 9, image: UIImage(named: "nineSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 9:
            slotInstance = Slot(value: 10, cardRank: 10, image: UIImage(named: "tenSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 10:
            slotInstance = Slot(value: 11, cardRank: 11, image: UIImage(named: "jackSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 11:
            slotInstance = Slot(value: 12, cardRank: 12, image: UIImage(named: "queenSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        case 12:
            slotInstance = Slot(value: 13, cardRank: 13, image: UIImage(named: "kingSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
            
            // Clubs
        case 13:
            slotInstance = Slot(value: 14, cardRank: 1, image: UIImage(named: "aceClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 14:
            slotInstance = Slot(value: 15, cardRank: 2, image: UIImage(named: "twoClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 15:
            slotInstance = Slot(value: 16, cardRank: 3, image: UIImage(named: "threeClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 16:
            slotInstance = Slot(value: 17, cardRank: 4, image: UIImage(named: "fourClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 17:
            slotInstance = Slot(value: 18, cardRank: 5, image: UIImage(named: "fiveClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 18:
            slotInstance = Slot(value: 19, cardRank: 6, image: UIImage(named: "sixClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 19:
            slotInstance = Slot(value: 20, cardRank: 7, image: UIImage(named: "sevenClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 20:
            slotInstance = Slot(value: 21, cardRank: 8, image: UIImage(named: "eightClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 21:
            slotInstance = Slot(value: 22, cardRank: 9, image: UIImage(named: "nineClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 22:
            slotInstance = Slot(value: 23, cardRank: 10, image: UIImage(named: "tenClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 23:
            slotInstance = Slot(value: 24, cardRank: 11, image: UIImage(named: "jackClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 24:
            slotInstance = Slot(value: 25, cardRank: 12, image: UIImage(named: "queenClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
        case 25:
            slotInstance = Slot(value: 26, cardRank: 13, image: UIImage(named: "kingClubs"), isHeart: false, isDiamond: false, isSpade: false, isClub: true)
            
            // Hearts
        case 26:
            slotInstance = Slot(value: 27, cardRank: 1, image: UIImage(named: "aceHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 27:
            slotInstance = Slot(value: 28, cardRank: 2, image: UIImage(named: "twoHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 28:
            slotInstance = Slot(value: 29, cardRank: 3, image: UIImage(named: "threeHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 29:
            slotInstance = Slot(value: 30, cardRank: 4, image: UIImage(named: "fourHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 30:
            slotInstance = Slot(value: 31, cardRank: 5, image: UIImage(named: "fiveHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 31:
            slotInstance = Slot(value: 32, cardRank: 6, image: UIImage(named: "sixHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 32:
            slotInstance = Slot(value: 33, cardRank: 7, image: UIImage(named: "sevenHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 33:
            slotInstance = Slot(value: 34, cardRank: 8, image: UIImage(named: "eightHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 34:
            slotInstance = Slot(value: 35, cardRank: 9, image: UIImage(named: "nineHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 35:
            slotInstance = Slot(value: 36, cardRank: 10, image: UIImage(named: "tenHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 36:
            slotInstance = Slot(value: 37, cardRank: 11, image: UIImage(named: "jackHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 37:
            slotInstance = Slot(value: 38, cardRank: 12, image: UIImage(named: "queenHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
        case 38:
            slotInstance = Slot(value: 39, cardRank: 13, image: UIImage(named: "kingHearts"), isHeart: true, isDiamond: false, isSpade: false, isClub: false)
            
            // Diamonds
        case 39:
            slotInstance = Slot(value: 40, cardRank: 1, image: UIImage(named: "aceDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 40:
            slotInstance = Slot(value: 41, cardRank: 2, image: UIImage(named: "twoDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 41:
            slotInstance = Slot(value: 42, cardRank: 3, image: UIImage(named: "threeDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 42:
            slotInstance = Slot(value: 43, cardRank: 4, image: UIImage(named: "fourDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 43:
            slotInstance = Slot(value: 44, cardRank: 5, image: UIImage(named: "fiveDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 44:
            slotInstance = Slot(value: 45, cardRank: 6, image: UIImage(named: "sixDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 45:
            slotInstance = Slot(value: 46, cardRank: 7, image: UIImage(named: "sevenDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 46:
            slotInstance = Slot(value: 47, cardRank: 8, image: UIImage(named: "eightDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 47:
            slotInstance = Slot(value: 48, cardRank: 9, image: UIImage(named: "nineDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 48:
            slotInstance = Slot(value: 49, cardRank: 10, image: UIImage(named: "tenDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 49:
            slotInstance = Slot(value: 50, cardRank: 11, image: UIImage(named: "jackDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 50:
            slotInstance = Slot(value: 51, cardRank: 12, image: UIImage(named: "queenDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
        case 51:
            slotInstance = Slot(value: 52, cardRank: 13, image: UIImage(named: "kingDiamonds"), isHeart: false, isDiamond: true, isSpade: false, isClub: false)
            
            // Default
        default:
            slotInstance = Slot(value: 53, cardRank: 1, image: UIImage(named: "aceSpades"), isHeart: false, isDiamond: false, isSpade: true, isClub: false)
        }
        
        return slotInstance
    }
}