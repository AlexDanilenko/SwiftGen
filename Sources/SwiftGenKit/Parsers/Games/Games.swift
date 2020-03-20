//
// SwiftGenKit
// Copyright © 2019 SwiftGen
// MIT Licence
//
import Foundation
import PathKit
import SwiftGenKit

public enum Game {
  public final class Parser: SwiftGenKit.Parser {
    
    var entries: Set<String> = []
    public var warningHandler: Parser.MessageHandler?
    
    public init(options: [String: Any] = [:], warningHandler: Parser.MessageHandler? = nil) {
      self.warningHandler = warningHandler
    }
    
    public static let defaultFilter = "[^/]\\.(?i:zip)$"
    
    public func parse(path: Path, relativeTo parent: Path) throws {
      let name = path.lastComponentWithoutExtension
      
      addGame(name)
    }
    
    private func addGame(_ game: String) {
      entries.insert(game)
    }
    
    public func stencilContext() -> [String : Any] {
      let games = entries
        .map { (name: String) -> [String: Any] in
          // Family
          return [
            "name": name,
          ]
      }
      
      return [
        "games": games
      ]
    }
  }
}
