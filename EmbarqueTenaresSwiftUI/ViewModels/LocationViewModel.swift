import Foundation

class LocationViewModel : ObservableObject {
    var nyFirstSlot : String
    var nyFirstSlotHours : String
    var nySecondSlot : String
    var nySecondSlotHours : String
    
    var drFirstSlot : String
    var drFirstSlotHours : String
    var drSecondSlot : String
    var drSecondSlotHours : String
    var drThirdSlot : String
    var drThirdSlotHours : String
    
    var isNyClosed : Bool
    var isDrClosed : Bool
    var isDrClosedForLunch : Bool
    
    init(){
        let weekday = Calendar.current.component(.weekday, from: Date())
        let hour = Calendar.current.component(.hour, from: Date())
        if(weekday == 1){
            nyFirstSlot = "sunday"
            nyFirstSlotHours = "sunClosed"
            nySecondSlot = "monToSat"
            nySecondSlotHours = "8to6"
            
            drFirstSlot = "sunday"
            drFirstSlotHours = "sunClosed"
            drSecondSlot = "monToFri"
            drSecondSlotHours = "8to5"
            drThirdSlot = "saturday"
            drThirdSlotHours = "8to12"
            isNyClosed = true
            isDrClosed = true
            isDrClosedForLunch = false
        } else {
            nyFirstSlot = "monToSat"
            nyFirstSlotHours = "8to6"
            nySecondSlot = "sunday"
            nySecondSlotHours = "sunClosed"
            
            // if saturday
            if(weekday == 7){
                drFirstSlot = "saturday"
                drFirstSlotHours = "8to12"
                drSecondSlot = "sunday"
                drSecondSlotHours = "sunClosed"
                drThirdSlot = "monToFri"
                drThirdSlotHours = "8to5"
                
                // if later than 6 or before 8
                if(hour >= 18 || hour < 8) {
                    // both closed
                    isNyClosed = true
                    isDrClosed = true
                } else {
                    // if its between 8 and 6
                    isNyClosed = false //then ny is open
                    if(hour >= 12) {
                        // if its later
                        isDrClosed = true // then 12 dr is closed
                    } else {
                        isDrClosed = false
                    }
                }
                
                isDrClosedForLunch = false
            } else {
                // mon thru fri
                drFirstSlot = "monToFri"
                drFirstSlotHours = "8to5"
                drSecondSlot = "saturday"
                drSecondSlotHours = "8to12"
                drThirdSlot = "sunday"
                drThirdSlotHours = "sunClosed"
                
                // if later than 6 or before 8
                if(hour >= 18 || hour < 8) {
                    // both closed
                    isNyClosed = true
                    isDrClosed = true
                    isDrClosedForLunch = false
                } else {
                    // if its between 8 and 6
                    
                    isNyClosed = false //then ny is open
                    if(hour >= 12 && hour < 14) {
                        // if its later than 12 but before 2 then dr is closed
                        isDrClosed = true
                        isDrClosedForLunch = true
                    } else {
                        if(hour >= 17){
                            isDrClosed = true
                        } else {
                            isDrClosed = false
                        }
                        isDrClosedForLunch = false
                    }
                }
            }
        }
    }
}
