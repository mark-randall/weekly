//
//  XCTest+Combine.swift
//
//  Created by Mark Randall on 6/23/21.
//

import Combine
import XCTest

extension XCTestCase {

    func AwaitPublisher<T: Publisher>(
        publisher: T,
        timeout: TimeInterval = 3,
        count: Int,
        when: (() -> Void)? = nil
    ) throws -> [T.Output] {
        var values: [T.Output] = []
        let expectation = self.expectation(description: "Combine publisher")
        
        let cancellable = publisher.prefix(count).sink(receiveCompletion: { _ in
            expectation.fulfill()
        }, receiveValue: {
            values.append($0)
        })
        
        when?()
        
        waitForExpectations(timeout: timeout)
        cancellable.cancel()
        
        return values
    }
    
    func AwaitPublisherFirst<T: Publisher>(
        publisher: T,
        timeout: TimeInterval = 3,
        file: StaticString = #file,
        line: UInt = #line,
        when: (() -> Void)? = nil
    ) throws -> T.Output {

        return try XCTUnwrap(
            AwaitPublisher(publisher: publisher, timeout: timeout, count: 1, when: when).first,
            "Publisher did not emit",
            file: file,
            line: line
        )
    }
}
