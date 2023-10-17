
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    @ViewBuilder
    func makeRefreshable(action: @escaping @Sendable () async -> Void) -> some View {
        if #available(iOS 15.0, *) {
            refreshable(action: action)
        } else {
            self.background(
                RefreshableScrollView(action: action)
                    .background(Color.clear)
            )
        }
    }
}


