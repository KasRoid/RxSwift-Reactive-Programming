import UIKit
import RxSwift

let disposeBag = DisposeBag()

Observable.of("A", "B", "C").subscribe {
    print($0)
}.disposed(by: disposeBag)

Observable<String>.create { (observer) -> Disposable in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?")
    return Disposables.create()
}.subscribe(onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
).disposed(by: disposeBag)

let observable = Observable.just(1)
let observable2 = Observable.of(1, 2, 3)
let observable3 = Observable.of([1, 2, 3])
let observable4 = Observable.from([1, 2, 3, 4, 5])

observable4.subscribe { event in
    if let element = event.element {
        print(element)
    }
}

observable3.subscribe { event in
    if let element = event.element {
        print(element)
    }
}

let subscription4 = observable4.subscribe(onNext: { element in
    print(element)
})

subscription4.dispose()
