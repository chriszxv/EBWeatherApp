//
//  EBErrors.swift
//  EBWeatherApp
//
//  Created by Chris So on 13/11/2019.
//  Copyright © 2019 Chris So. All rights reserved.
//

enum EBAuthorizationStatusError: Error {
    case denied
    case restricted
    case notDetermined
}
