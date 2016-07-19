import ReactiveCocoa
import Result
import UIKit

private enum Associations {
  private static var accessibilityElementsHidden = 0
  private static var accessibilityHint = 1
  private static var accessibilityLabel = 2
  private static var accessibilityValue = 3
  private static var isAccessibilityElement = 4
}

public extension Rac where Object: NSObject {
  public var accessibilityElementsHidden: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.accessibilityElementsHidden,
        setter: { [weak object] in object?.accessibilityElementsHidden = $0 },
        getter: { [weak object] in object?.accessibilityElementsHidden ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var accessibilityHint: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &Associations.accessibilityHint,
        setter: { [weak object] in object?.accessibilityHint = $0 },
        getter: { [weak object] in object?.accessibilityHint ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var accessibilityLabel: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &Associations.accessibilityLabel,
        setter: { [weak object] in object?.accessibilityLabel = $0 },
        getter: { [weak object] in object?.accessibilityLabel ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var accessibilityValue: Signal<String, NoError> {
    nonmutating set {
      let prop: MutableProperty<String> = lazyMutableProperty(
        object,
        key: &Associations.accessibilityValue,
        setter: { [weak object] in object?.accessibilityValue = $0 },
        getter: { [weak object] in object?.accessibilityValue ?? "" })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }

  public var isAccessibilityElement: Signal<Bool, NoError> {
    nonmutating set {
      let prop: MutableProperty<Bool> = lazyMutableProperty(
        object,
        key: &Associations.isAccessibilityElement,
        setter: { [weak object] in object?.isAccessibilityElement = $0 },
        getter: { [weak object] in object?.isAccessibilityElement ?? false })

      prop <~ newValue.observeForUI()
    }

    get {
      return .empty
    }
  }
}