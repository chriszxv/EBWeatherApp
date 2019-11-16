//
//  ViewModelType.swift
//  AA
//
//  Created by Chris So on 5/6/2018.
//  Copyright © 2018 Chris So. All rights reserved.
//

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}
