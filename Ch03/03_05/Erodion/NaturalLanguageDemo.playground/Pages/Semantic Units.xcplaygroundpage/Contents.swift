import NaturalLanguage

let text = "Steve Jobs, Steve Wozniak, and Ronald Wayne founded Apple Computer in the garage of Steve Jobs's Los Altos home."

let tagger = NLTagger(tagSchemes: [.nameTypeOrLexicalClass])
tagger.string = text

tagger.enumerateTags(in: text.startIndex..<text.endIndex,
                     unit: .word,
                     scheme: .nameTypeOrLexicalClass,
                     options: [.omitPunctuation, .omitWhitespace, .joinNames]) { (tag, range) -> Bool in
    let word = text[range]
    let tagValue = tag?.rawValue ?? "Unknown"
    print("\(word) : \(tagValue)")
    return true
}
