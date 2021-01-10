import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

//Observable.of("A", "B", "C").subscribe {
//    print($0)
//}.disposed(by: disposeBag)
//
//Observable<String>.create { (observer) -> Disposable in
//    observer.onNext("A")
//    observer.onCompleted()
//    observer.onNext("?")
//    return Disposables.create()
//}.subscribe(onNext: { print($0) },
//            onError: { print($0) },
//            onCompleted: { print("Completed") },
//            onDisposed: { print("Disposed") }
//).disposed(by: disposeBag)
//
//let observable = Observable.just(1)
//let observable2 = Observable.of(1, 2, 3)
//let observable3 = Observable.of([1, 2, 3])
//let observable4 = Observable.from([1, 2, 3, 4, 5])
//
//observable4.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
//
//observable3.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
//
//let subscription4 = observable4.subscribe(onNext: { element in
//    print(element)
//})
//
//subscription4.dispose()
//
//let subject = PublishSubject<String>()
//subject.onNext("Issue 1")
//subject.subscribe { event in
//    print(event)
//}
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//subject.onNext("Issue 4")
//subject.onCompleted()
//subject.onNext("Issue 5")
//subject.dispose()
//
//let subject2 = BehaviorSubject(value: "Initial Value")
//subject2.onNext("Last issue")
//subject2.subscribe { event in
//    print(event)
//}
//subject2.onNext("Issue 1")
//
//let subject3 = ReplaySubject<String>.create(bufferSize: 2)
//subject3.onNext("Issue 1")
//subject3.onNext("Issue 2")
//subject3.onNext("Issue 3")
//subject3.subscribe { event in
//    print(event)
//}
//
//subject3.onNext("Issue 4")
//subject3.onNext("Issue 5")
//subject3.onNext("Issue 6")
//
//subject3.subscribe {
//    print($0)
//}
//
//let variable = Variable([String]())
//variable.value.append("Item 1")
//variable.asObservable()
//    .subscribe {
//        print($0)
//}
//
//variable.value.append("Item 2")
//
//let relay = BehaviorRelay(value: ["Item 0"])
//relay.accept(relay.value + ["Item 1"])
//var value = relay.value
//value.append("Item 2")
//relay.accept(value)
//
//relay.asObservable()
//    .subscribe() {
//        print($0)
//    }

// MARK: - Filtering Operators
let strikes = PublishSubject<String>()
strikes
    .ignoreElements()
    .subscribe { _ in
        print("[Subsciption is called]")
    }.disposed(by: disposeBag)

strikes.onNext("A")
strikes.onNext("B")
strikes.onNext("C")
strikes.onCompleted()
