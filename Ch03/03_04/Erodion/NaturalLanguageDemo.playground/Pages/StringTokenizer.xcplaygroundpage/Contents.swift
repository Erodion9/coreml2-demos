import NaturalLanguage

let text = "Knowledge will give you power, but character respect"

let tagger = NLTagger(tagSchemes: [.tokenType])
tagger.string = text

tagger.enumerateTags(in: text.startIndex..<text.endIndex,
                     unit: .word,
                     scheme: .tokenType,
                     options: [.omitPunctuation, .omitWhitespace]) { (tag, range) -> Bool in
    print(text[range])
    return true
}
