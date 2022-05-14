//
//  LoginViewModel.swift
//  FlashChat2
//
//  Created by Đỗ Trung Hoài on 15/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let txtEmailPublishSubject = PublishSubject<String>()
    let txtPasswordPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        Observable.combineLatest(txtEmailPublishSubject.asObservable().startWith(""),
                                 txtPasswordPublishSubject.asObservable().startWith(""))
            .map { email, password in
                return email.count > 0 && password.count > 0
            }
    }
}
