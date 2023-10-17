import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct RefreshableScrollView: UIViewRepresentable {
    public typealias UIViewType = UIView
    
    let action: () async -> Void
    
    public init(action: @escaping () async -> Void) {
        self.action = action
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView.init(frame: .zero)
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard let view = uiView.superview?.superview else {
                return
            }
            guard let scrollView = getScrollView(view) else {
                return
            }
            if scrollView.refreshControl == nil {
                let refreshControl = UIRefreshControl()
                refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl(_ :)), for: .valueChanged)
                scrollView.refreshControl = refreshControl
            }
        }
    }
    
    public static func dismantleUIView(_ uiView: UIView, coordinator: Coordinator) {
        coordinator.cancelTask()
    }
    
    private func getScrollView(_ root: UIView) -> UIScrollView? {
        for subview in root.subviews {
            if subview is UIScrollView {
                return subview as? UIScrollView
            } else if let scrollView = getScrollView(subview) {
                return scrollView
            }
        }
        return nil
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    public class Coordinator: NSObject, UIScrollViewDelegate {
        private var task: Task<Void, Never>?
        var action: () async -> Void
        init(action: @escaping () async -> Void) {
            self.action = action
        }

        @objc fileprivate func handleRefreshControl(_ control: UIRefreshControl) {
            control.beginRefreshing()
            task?.cancel()
            task = Task {
                await action()
                control.endRefreshing()
            }
        }
        
        func cancelTask() {
            task?.cancel()
            task = nil
        }
    }
}
