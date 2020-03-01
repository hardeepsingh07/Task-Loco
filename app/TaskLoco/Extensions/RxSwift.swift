//
//  RxSwift.swift
//  TaskLoco
//
//  Created by Hardeep Singh on 3/1/20.
//  Copyright © 2020 Hardeep Singh. All rights reserved.
//

import RxSwift

extension Observable where Element: Response {
	
	func mapToHandleResponse() -> Observable<Element.CodableType> {
		return map { return try self.handleResonse($0)}
	}
	
	private func handleResonse<T: Response>(_ response: T) throws -> T.CodableType {
		guard let data = response.data else { throw response.error ?? ErrorConstants.defaultError()}
		return data
	}
}
