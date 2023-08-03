//
//  Subject+init.swift
//  
//
//  Created by James on 03/08/2023.
//

import Foundation
import WaniKani

public extension Radical {
    convenience init() {
        self.init(
            amalgamationSubjectIDs: [1, 2],
            auxiliaryMeanings: [
                AuxiliaryMeaning(
                    meaning: "ground",
                    type: .allowlist
                )
            ],
            characters: "上",
            characterImages: [
                CharacterImage(
                    url: URL(),
                    metadata: .png(
                        .init(
                            color: "#000000",
                            dimensions: .init(width: 101, height: 101),
                            styleName: "ground"
                        )
                    )
                )
            ],
            created: .testing,
            documentURL: URL(),
            id: 0,
            lessonPosition: 0,
            level: 1,
            meaningMnemonic: "ground",
            meanings: [
                Meaning(
                    meaning: "ground",
                    isPrimary: true,
                    isAcceptedAnswer: true
                )
            ],
            slug: "ground",
            spacedRepetitionSystemID: 0,
            url: URL()
        )
    }
}

public extension Kanji {
    convenience init() {
        self.init(
            amalgamationSubjectIDs: [1, 2],
            auxiliaryMeanings: [
                AuxiliaryMeaning(
                    meaning: "ground",
                    type: .allowlist
                )
            ],
            characters: "上",
            componentSubjectIDs: [1, 2, 3],
            created: .testing,
            documentURL: URL(),
            id: 0,
            lessonPosition: 0,
            level: 1,
            meaningHint: "ground",
            meaningMnemonic: "ground",
            meanings: [
                Meaning(
                    meaning: "ground",
                    isPrimary: true,
                    isAcceptedAnswer: true
                )
            ],
            readingHint: "ground",
            readingMnemonic: "ground",
            readings: [
                Reading(
                    reading: "ground",
                    isPrimary: true,
                    isAcceptedAnswer: true,
                    type: .kunyomi
                )
            ],
            slug: "ground",
            spacedRepetitionSystemID: 0,
            visuallySimilarSubjectIDs: [1],
            url: URL()
        )
    }
}

public extension Vocabulary {
    convenience init() {
        self.init(
            auxiliaryMeanings: [
                AuxiliaryMeaning(
                    meaning: "ground",
                    type: .allowlist
                )
            ],
            characters: "上",
            componentSubjectIDs: [0, 1],
            contextSentences: [
                ContextSentence(
                    english: "ground",
                    japanese: "上"
                )
            ],
            created: .testing,
            documentURL: URL(),
            id: 0,
            lessonPosition: 0,
            level: 1,
            meaningMnemonic: "ground",
            meanings: [
                Meaning(
                    meaning: "ground",
                    isPrimary: true,
                    isAcceptedAnswer: true
                )
            ],
            partsOfSpeech: ["noun"],
            pronunciationAudios: [
                PronunciationAudio(
                    url: URL(),
                    contentType: "audio/ogg",
                    metadata: PronunciationAudio.Metadata(
                        gender: "female",
                        sourceID: 0,
                        pronunciation: "ground",
                        voiceActorID: 0,
                        voiceActorName: "Haruko",
                        voiceDescription: "Someone who has friends."
                    )
                )
            ],
            readings: [
                Reading(
                    reading: "ground",
                    isPrimary: true,
                    isAcceptedAnswer: true
                )
            ],
            readingMnemonic: "ground",
            slug: "ground",
            spacedRepetitionSystemID: 0,
            url: URL()
        )
    }
}

public extension KanaVocabulary {
    convenience init() {
        self.init(
            auxiliaryMeanings: [
                AuxiliaryMeaning(
                    meaning: "Hi",
                    type: .allowlist
                )
            ],
            characters: "こんにちは",
            contextSentences: [
                ContextSentence(
                    english: "Hello",
                    japanese: "こんにちは"
                )
            ],
            created: .testing,
            documentURL: URL(),
            id: 0,
            lessonPosition: 0,
            level: 1,
            meaningMnemonic: "Hello",
            meanings: [
                Meaning(
                    meaning: "Hello",
                    isPrimary: true,
                    isAcceptedAnswer: true
                )
            ],
            partsOfSpeech: ["expression"],
            pronunciationAudios: [
                PronunciationAudio(
                    url: URL(),
                    contentType: "audio/ogg",
                    metadata: PronunciationAudio.Metadata(
                        gender: "female",
                        sourceID: 0,
                        pronunciation: "ground",
                        voiceActorID: 0,
                        voiceActorName: "Haruko",
                        voiceDescription: "Someone who has friends."
                    )
                )
            ],
            slug: "Hello", spacedRepetitionSystemID: 0, url: URL()
        )
    }
}
