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

//strikes
//    .ignoreElements()
//    .subscribe { _ in
//        print("[Subsciption is called]")
//    }.disposed(by: disposeBag)
//
//strikes.onNext("A")
//strikes.onNext("B")
//strikes.onNext("C")
//strikes.onCompleted()

//strikes
//    .elementAt(2)
//    .subscribe(onNext: { _ in
//        print("You are out!")
//    }).disposed(by: disposeBag)
//
//strikes.onNext("X")
//strikes.onNext("X")
//strikes.onNext("X")
//
//strikes
//    .filter { (value) -> Bool in
//        value == "X"
//    }.subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//strikes.onNext("a")
//strikes.onNext("x")
//strikes.onNext("X")
//
//Observable.of(1, 2, 3, 4, 5, 6, 7)
//    .filter { $0 % 2 == 0 }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//Observable.of("A", "B", "C", "D", "E", "F")
//    .skip(3)
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//Observable.of("A", "B", "C", "D", "E", "F")


//Observable.of(0, 0, 2, 3, 4, 4)
//    .skipWhile{ $0 % 2 == 0 }
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)

//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject
//    .skipUntil(trigger)
//    .subscribe {
//        print($0)
//    }.disposed(by: disposeBag)
//
//subject.onNext("A")
//trigger.onNext("Trigger")
//subject.onNext("B")
//subject.onNext("C")
//subject.onNext("D")

//Observable.of(1, 2, 3, 4, 5, 6)
//    .take(3)
//    .subscribe {
//        print($0)
//    }

//Observable.of(2, 4, 6, 7, 8, 10)
//    .takeWhile { $0 % 2 == 0 }
//    .subscribe { print($0) }
//    .disposed(by: disposeBag)

//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject
//    .takeUntil(trigger)
//    .subscribe(onNext: { print($0) })
//    .disposed(by: disposeBag)
//
//subject.onNext("1")
//subject.onNext("2")
//trigger.onNext("X")
//subject.onNext("3")
//subject.onNext("4")

// MARK: - Transforming Operators
//Observable.of(1, 2, 3, 4, 5)
//    .toArray()
//    .subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
//
//Observable.of(1, 2, 3, 4 ,5)
//    .map {
//        return $0 * 2
//    }
//    .subscribe(onNext: {
//        print($0)
//    })

struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay(value: 75))
let mary = Student(score: BehaviorRelay(value: 95))

let student = PublishSubject<Student>()
student.asObserver()
    .flatMapLatest { return $0.score.asObservable() }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

student.onNext(john)
john.score.accept(100)

student.onNext(mary)

john.score.accept(43)
mary.score.accept(80)
