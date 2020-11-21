import NaturalLanguage

let sentence = "ワタシ ワ デニス デス"

if let language = NLLanguageRecognizer.dominantLanguage(for: sentence) {
    print("Detected \(language.rawValue.uppercased()) as dominant language for: \n\(sentence)")
} else {
    print("Could not recognize language for \(sentence)")
}

let languageRecognizer = NLLanguageRecognizer()

languageRecognizer.processString(sentence)

languageRecognizer.languageConstraints = [.turkish, .english, .spanish, .japanese]

let languageProbabilities = languageRecognizer.languageHypotheses(withMaximum: 3)

for (language, probability) in languageProbabilities {
    print("Detected \(language.rawValue.uppercased()), probability \(probability)")
}

languageRecognizer.reset()
