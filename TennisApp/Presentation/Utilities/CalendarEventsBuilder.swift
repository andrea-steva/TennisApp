//
//  CalendarEventsBuilder.swift
//  TennisApp
//
//  Created by Andrea Stevanato on 11/02/16.
//  Copyright © 2016 Andrea Stevanato. All rights reserved.
//

import EventKit

final class CalendarEventsBuilder {


    func addEvent(_ eventDate: Date, title: String, notes: String, completion : @escaping (Bool) -> Void) {
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event) { (granted, error) -> Void in
            if error == nil {

                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.notes = notes
                event.startDate = eventDate
                event.endDate = eventDate.addingTimeInterval(30 * 60)
                event.calendar = eventStore.defaultCalendarForNewEvents

                do {
                    try eventStore.save(event, span: EKSpan.thisEvent)
                } catch {
                    completion(false)
                }
                completion(true)
            }
            completion(false)
        }
    }
}
