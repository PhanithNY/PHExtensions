//
//  BackgroundTimer.swift
//  Xplore
//
//  Created by Phanith Ny on 3/29/20.
//  Copyright © 2020 Phanith Ny. All rights reserved.
//

import Foundation

public final class BackgroundTimer {
  
  public var eventHandler: (() -> Swift.Void)?
  
  // MARK: - Properties
  
  private enum TimerState {
    case suspended
    case resumed
  }
  
  private let timeInterval: TimeInterval
  
  private var state: TimerState = .suspended
  
  private lazy var timer: DispatchSourceTimer = {
    let t = DispatchSource.makeTimerSource()
    t.schedule(deadline: .now() + self.timeInterval, repeating: self.timeInterval)
    t.setEventHandler(handler: { [weak self] in
      self?.eventHandler?()
    })
    return t
  }()
  
  // MARK: - Init / Deinit
  
  public init(timeInterval: TimeInterval) {
    self.timeInterval = timeInterval
  }
  
  deinit {
    timer.setEventHandler {}
    timer.cancel()
    /*
     If the timer is suspended, calling cancel without resuming
     triggers a crash. This is documented here https://forums.developer.apple.com/thread/15902
     */
    resume()
    eventHandler = nil
  }
  
  // MARK: - Actions
  
  public final func resume() {
    if state == .resumed {
      return
    }
    state = .resumed
    timer.resume()
  }
  
  public final func suspend() {
    if state == .suspended {
      return
    }
    state = .suspended
    timer.suspend()
  }
  
}
