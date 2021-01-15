//
//  +Date.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation

// MARK: - Date to String
extension Date {
    
    ///Get UTC TimeString from Date. Default format: '1969-07-21T02:56:15Z'.
    public func toUTCString(format: String = Defaults.defaults().dateFormatInput) -> String {
        
        return toString(format: format, locale: Locale(identifier: "en_US_POSIX"), calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(abbreviation: "UTC")!)
    }
    
    ///Get TimeString from Date. Default format: '1969-07-21T02:56:15Z'.
    public func toString(format: String = Defaults.defaults().dateFormatInput, locale: Locale = Defaults.defaults().locale, calendar: Calendar = Defaults.defaults().calendar, timeZone: TimeZone = Defaults.defaults().timeZone) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        
        return formatter.string(from: self)
    }
    
    ///Get TimeString with Relative Time from date. Default format: 'Monday, 21 July 1969 02:56:15'.
    public func toStringWithRelativeTime(andDefaultFormat: String = Defaults.defaults().dateFormatOutput) -> String {
        
        //Time
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        
        //Components
        let seconds = Int(now - time)
        let minutes = Int(seconds / 60)
        let hours = Int(minutes / 60)
        
        let days = Int(hours / 24)
        let weeks = Int(days / 7)
        
        //If different month
        if weeks > 4 {
            return self.toString(format: andDefaultFormat)
        }
        
        //Calculate
        if seconds < 60 {
            if seconds < 10 {
                return "a moment ago"
            }
            else {
                return "\(seconds) seconds ago"
            }
        }
        
        if minutes < 60 {
            if minutes == 1 {
                return "1 minute ago"
            }
            else {
                return "\(minutes) minutes ago"
            }
        }
        
        if hours < 24 {
            if hours == 1 {
                return "1 hour ago"
            }
            else {
                return "\(hours) hours ago"
            }
        }
        
        if days < 7 {
            if days == 1 {
                return "yesterday"
            }
            else {
                return "\(days) days ago"
            }
        }
        
        if days < 28 {
            if weeks == 1 {
                return "last week"
            } else {
                return "\(weeks) weeks ago"
            }
        }
        
        return ""
    }
    
    ///Get TimeString with Short Relative Time from date.
    public func toStringWithShortRelativeTime() -> String {
        
        //Time
        let time = self.timeIntervalSince1970
        let now = Date().timeIntervalSince1970
        
        //Components
        let seconds = Int(now - time)
        let minutes = Int(seconds / 60)
        let hours = Int(minutes / 60)
        
        let days = Int(hours / 24)
        let weeks = Int(days / 7)
        
        //Calculate
        if seconds < 60 {
            return "\(seconds)s"
        }
        
        if minutes < 60 {
            return "\(minutes)m"
        }
        
        if hours < 24 {
            return "\(hours)h"
        }
        
        if days < 7 {
            return "\(days)d"
        }
        
        return "\(weeks)w"
    }
}

// MARK: - Date Components
extension Date {
    
    ///Get Date's components.
    public func component(_ component: Calendar.Component) -> Int? {
        
        return Defaults.defaults().calendar.component(component, from: self)
    }
}
