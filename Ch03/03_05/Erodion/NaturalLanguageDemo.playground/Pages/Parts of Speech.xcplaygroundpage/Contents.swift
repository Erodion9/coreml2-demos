import NaturalLanguage

let text = "Knowledge will give you power, but character respect"

let tagger = NLTagger(tagSchemes: [.lexicalClass, .language, .script])
tagger.string = text

tagger.enumerateTags(in: text.startIndex..<text.endIndex,
                     unit: .word,
                     scheme: .lexicalClass,
                     options: [.omitPunctuation, .omitWhitespace]) { (tag, range) -> Bool in
    let word = text[range]
    let tagValue = tag?.rawValue ?? "Unknown"
    print("\(word) : \(tagValue)")
    return true
}
