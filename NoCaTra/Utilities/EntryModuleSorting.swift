import Foundation

extension Array where Element == EntryModule {
    /// Sort `EntryModule` objects by category (food, exercise, mindfulness) and content type (diary, plan, rating).
    func sortedByCategoryAndContent() -> [EntryModule] {
        let categoryIndex: [EntryCategory: Int] = [
            .food: 0,
            .exercise: 1,
            .mindfulness: 2
        ]
        let contentIndex: [EntryContentType: Int] = [
            .diary: 0,
            .plan: 1,
            .rating: 2
        ]

        return self.sorted { lhs, rhs in
            let lhsCat = categoryIndex[lhs.category] ?? 0
            let rhsCat = categoryIndex[rhs.category] ?? 0
            if lhsCat != rhsCat {
                return lhsCat < rhsCat
            }
            let lhsContent = contentIndex[lhs.contentType] ?? 0
            let rhsContent = contentIndex[rhs.contentType] ?? 0
            return lhsContent < rhsContent
        }
    }
}
