import UIKit

protocol Bird: CustomStringConvertible {
  var name: String { get }
  var canFly: Bool { get }
}

extension CustomStringConvertible where Self: Bird {
  var description: String {
    canFly ? "I can fly" : "I can't fly :("
  }
}

protocol Flyable {
  var airspeedVelocity: Double { get }
}

struct FlappyBird: Bird, Flyable {

  //Properties of Bird
  let name: String

  let flappyAmplitude: Double
  let flappyFrequency: Double

  var airspeedVelocity: Double { // This is computed property
    3 * flappyAmplitude * flappyFrequency
  }
}

struct Penguin: Bird {

  //Properties of Bird
  let name: String
}

struct SwiftBird: Bird, Flyable {

  //Properties of Bird
  var name: String { "Swift \(version)"}

  let version: Double
  private var speedFactor = 1000.0

  init(version: Double) {
    self.version = version
  }

  var airspeedVelocity: Double {
    version * speedFactor
  }
}

extension Bird {

  /**
   This code defines an extension on Bird. It sets the default behavior for canFly to return true whenever the type conforms to the Flyable protocol. In other words, any Flyable bird no longer needs to explicitly declare it canFly. It will simply fly, as most birds do.
   */

  var canFly: Bool { self is FlappyBird }
}

enum UnladenSwallow: Bird, Flyable {
  case african
  case european
  case unknown

  var name: String {

    switch self {
    case .african:
      return "African"
    case .european:
      return "European"
    case .unknown:
      return "Unknown"
    }
  }

  var airspeedVelocity: Double {
    switch self {
    case .african:
      return 10.0
    case .european:
      return 9.0
    case .unknown:
      fatalError("You are thrown from the bridge of death!")
    }
  }
}

extension UnladenSwallow {

  var canFly: Bool {
    self != .unknown
  }
}

UnladenSwallow.unknown.canFly
UnladenSwallow.european.canFly
Penguin(name: "King Pengien").canFly

UnladenSwallow.african

protocol Racer {
  var speed: Double { get }  // speed is the only thing racers care about
}

extension FlappyBird: Racer {
  var speed: Double {
    airspeedVelocity
  }
}

extension Penguin: Racer {
  var speed: Double {
    42
  }
}

extension UnladenSwallow: Racer {
  var speed: Double {
    canFly ? airspeedVelocity : 0.0
  }
}

extension Motorcycle: Racer {}

extension SwiftBird: Racer {
  var speed: Double {
    airspeedVelocity
  }
}

let racers: [Racer] =
  [UnladenSwallow.african,
   UnladenSwallow.european,
   UnladenSwallow.unknown,
   Penguin(name: "King Penguin"),
   SwiftBird(version: 5.1),
   FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
   Motorcycle(name: "Giacomo")]


class Motorcycle {

  var name: String
  var speed: Double

  init(name: String) {
    self.name = name
    speed = 200.0
  }
}

func topSpeed(of racers: [Racer]) -> Double {
  return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0.0
}

topSpeed(of: racers)

extension Sequence where Element == Racer {
  func topSpeed() -> Double {
    self.max(by: { $0.speed < $1.speed })?.speed ?? 0.0
  }
}

racers.topSpeed()
racers[1...3].topSpeed()

protocol Score: Comparable {
  var value: Int { get }
}

struct RacingScore: Score {
  let value: Int

  static func <(lhs: RacingScore, rhs: RacingScore) -> Bool {
    lhs.value < rhs.value
  }
}

RacingScore(value: 150) >= RacingScore(value: 130) // true


protocol Cheat {
  mutating func boost(_ power: Double)
}

extension SwiftBird: Cheat {
  mutating func boost(_ power: Double) {
    speedFactor += power
  }
}

var swiftBird = SwiftBird(version: 5.0)
swiftBird.boost(3.0)
swiftBird.airspeedVelocity // 5015
swiftBird.boost(3.0)
swiftBird.airspeedVelocity // 5030






