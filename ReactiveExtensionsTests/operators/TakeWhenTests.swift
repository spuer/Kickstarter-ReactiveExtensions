import XCTest
import ReactiveCocoa
@testable import ReactiveExtensions

final class TakeWhenTests : XCTestCase {

  func testStandard() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let takePairWhen = source.takePairWhen(sample).map { [$0.0, $0.1] }
    let test = takePairWhen.testObserve()

    sourceObserver.sendNext(1)
    XCTAssertEqual(test.nextValues, [])

    sourceObserver.sendNext(2)
    XCTAssertEqual(test.nextValues, [])

    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[2, 3]])

    sampleObserver.sendNext(4)
    XCTAssertEqual(test.nextValues, [[2, 3], [2, 4]])

    sampleObserver.sendCompleted()
    XCTAssert(!test.didComplete)

    sourceObserver.sendCompleted()
    XCTAssert(test.didComplete)
  }

  func testWithSourceCompleting() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let takePairWhen = source.takePairWhen(sample).map { [$0.0, $0.1] }
    let test = takePairWhen.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[1, 3]])

    sourceObserver.sendCompleted()
    XCTAssert(test.didComplete)
  }

  func testWithSourceErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let takePairWhen = source.takePairWhen(sample).map { [$0.0, $0.1] }
    let test = takePairWhen.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[1, 3]])

    sourceObserver.sendFailed(SomeError())
    XCTAssert(test.didFail)
  }

  func testWithSourceInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let takePairWhen = source.takePairWhen(sample).map { [$0.0, $0.1] }
    let test = takePairWhen.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[1, 3]])

    sourceObserver.sendInterrupted()
    XCTAssert(test.didInterrupt)
  }

  func testWithSampleErroring() {
    let (source, sourceObserver) = Signal<Int, SomeError>.pipe()
    let (sample, sampleObserver) = Signal<Int, SomeError>.pipe()
    let takePairWhen = source.takePairWhen(sample).map { [$0.0, $0.1] }
    let test = takePairWhen.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[1, 3]])

    sampleObserver.sendFailed(SomeError())
    XCTAssert(!test.didFail)
  }

  func testWithSampleInterrupted() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let takePairWhen = source.takePairWhen(sample).map { [$0.0, $0.1] }
    let test = takePairWhen.testObserve()

    sourceObserver.sendNext(1)
    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [[1, 3]])

    sampleObserver.sendInterrupted()
    XCTAssert(!test.didInterrupt)
  }

  func testTakeWhen() {
    let (source, sourceObserver) = Signal<Int, NoError>.pipe()
    let (sample, sampleObserver) = Signal<Int, NoError>.pipe()
    let takeWhen = source.takeWhen(sample)
    let test = takeWhen.testObserve()

    sourceObserver.sendNext(1)
    XCTAssertEqual(test.nextValues, [])

    sourceObserver.sendNext(2)
    XCTAssertEqual(test.nextValues, [])

    sampleObserver.sendNext(3)
    XCTAssertEqual(test.nextValues, [2])

    sourceObserver.sendNext(4)
    sampleObserver.sendNext(5)
    XCTAssertEqual(test.nextValues, [2, 4])

    sampleObserver.sendCompleted()
    XCTAssert(!test.didComplete)

    sourceObserver.sendCompleted()
    XCTAssert(test.didComplete)
  }
}