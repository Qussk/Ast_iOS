//
//  CalendarRepresentable.swift
//  Ast
//
//  Created by 변윤나 on 2/23/25.
//

import SwiftUI
import FSCalendar
import ComposableArchitecture

struct CalendarRepresentable: UIViewRepresentable {
    let viewStore: ViewStoreOf<CalendarFeature>?
    let defaultSelectedDate = Calendar.current.startOfDay(for: Date())
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        
        calendar.locale = .ko_KR
        calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        calendar.appearance.titleFont = .h4
        calendar.appearance.titleDefaultColor = .b2
        calendar.appearance.weekdayTextColor = .b3
        calendar.appearance.weekdayFont = .h8
        calendar.appearance.selectionColor = .green
        calendar.appearance.titleSelectionColor = .w1
        calendar.appearance.titleTodayColor = .green
        calendar.appearance.todayColor = .clear
        calendar.appearance.eventDefaultColor = .clear
        calendar.appearance.eventSelectionColor = .clear
        calendar.headerHeight = 0
        calendar.placeholderType = .none
        calendar.scrollEnabled = false
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        
        viewStore?.send(.calendarDidSelected(isSelectedByUser: false, toDate: defaultSelectedDate))
        
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        guard let currentDate = viewStore?.currentDate else { return }
        uiView.setCurrentPage(currentDate, animated: true)
        if isNeedToUpdate() {
            viewStore?.send(.settingUpdateFlag)
            uiView.reloadData()
        }
    }
    
    func isNeedToUpdate() -> Bool {
        guard let isNeedToUpdate = viewStore?.isNeedToUpdate else { return false}
        viewStore?.send(.settingUpdateFlag)
        return isNeedToUpdate
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, today: defaultSelectedDate)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: CalendarRepresentable
        var today: Date
        
        init(parent: CalendarRepresentable, today: Date) {
            self.parent = parent
            self.today = today
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.viewStore?.send(.calendarDidSelected(toDate: date))
        }
        
        func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
            return isDateInAllowedRange(date) 
        }
        
        func calendar(_ calendar: FSCalendar, shouldDeselect date: Date) -> Bool {
            return isDateInAllowedRange(date)
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            return .b2
        }
        
        func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
            let eventScaleFactor: CGFloat = 1.5
            cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
        }
        
        func isDateInAllowedRange(_ date: Date) -> Bool {
            guard let twoWeeksLater = Calendar.current.date(byAdding: .day, value: 14, to: today) else { return false }
            let targetDate = Calendar.current.startOfDay(for: date)
            return targetDate >= today && targetDate <= twoWeeksLater
        }
        
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            return 0
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            return nil
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
            return nil
        }
        
    }
}
