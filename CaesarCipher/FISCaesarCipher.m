//
//  FISCaesarCipher.m
//  CaesarCipher
//
//  Created by Chris Gonzales on 5/29/14.
//  Copyright (c) 2014 FIS. All rights reserved.
//

#import "FISCaesarCipher.h"

@implementation FISCaesarCipher

-(NSArray *)charactersArrayForMessage:(NSString *)message {
    NSMutableArray *characters = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < [message length]; i++) {
        NSString *character = [NSString stringWithFormat:@"%C", [message characterAtIndex:i]];
        [characters addObject:character];
    }
    return characters;
}

-(NSString *)encodeMessage:(NSString *)message withOffset:(NSInteger)key {
    NSString *encodedMessage = @"";
    // Derive the offset from the key using modulo. This assumes that alphabet has 26 characters.
    NSInteger offset = key % 26;
    // Transform string into an array of characters.
    NSMutableArray *messageCharacters = [[self charactersArrayForMessage:message] mutableCopy];
    // Turn the characters into their corresponding ASCII integers, skipping the spaces and punctuation. Note uppercase letters are represented by integers 65-90 and lowercase letters are represented by integers 97-122.
    for (NSUInteger i = 0; i < [messageCharacters count]; i++) {
        NSString *currentCharacter = messageCharacters[i];
        unichar asciiCode = [currentCharacter characterAtIndex:0];
        
        // Shift uppercase integers by the offset. Add the offset so that the new code still lies within the range for uppercase letters, meaning that it will loop back around to A if it exceeds the code for Z.
        if (65 <= asciiCode && asciiCode <= 90) {
            unichar newAsciiCode = asciiCode + offset;

            if (65 <= newAsciiCode && newAsciiCode <= 90) {
                // Put next two lines in their own method in order to avoid so much repetition. Want to avoid copy pasting more than a couple times!
                NSString *newCharacter = [NSString stringWithFormat:@"%C", newAsciiCode];
                [messageCharacters replaceObjectAtIndex:i withObject:newCharacter];
            } else if (newAsciiCode > 90) {
                newAsciiCode = 64 + (newAsciiCode - 90);
                NSString *newCharacter = [NSString stringWithFormat:@"%C", newAsciiCode];
                [messageCharacters replaceObjectAtIndex:i withObject:newCharacter];
            }
        
        // Shift lowercase integers by the offset.
        } else if (97 <= asciiCode && asciiCode <= 122) {
            unichar newAsciiCode = asciiCode + offset;
         
            if (97 <= newAsciiCode && newAsciiCode <= 122) {
                NSString *newCharacter = [NSString stringWithFormat:@"%C", newAsciiCode];
                [messageCharacters replaceObjectAtIndex:i withObject:newCharacter];
            } else if (newAsciiCode > 122) {
                newAsciiCode = 96 + (newAsciiCode - 122);
                NSString *newCharacter = [NSString stringWithFormat:@"%C", newAsciiCode];
                [messageCharacters replaceObjectAtIndex:i withObject:newCharacter];
            }
        }
        NSLog(@"This should be array of encrypted characters for string: %@", messageCharacters);
        encodedMessage = [encodedMessage stringByAppendingString:messageCharacters[i]];
    }
    return encodedMessage;
}

-(NSString *)decodeMessage:(NSString *)message withOffset:(NSInteger)key {
    NSString *decodedMessage = @"";
    // Derive the offset from the key using modulo. This assumes that alphabet has 26 characters.
    NSInteger offset = key % 26;
    // Transform string into an array of characters.
    NSMutableArray *messageCharacters = [[self charactersArrayForMessage:message] mutableCopy];
    // Turn the characters into their corresponding ASCII integers, skipping the spaces and punctuation. Note uppercase letters are represented by integers 65-90 and lowercase letters are represented by integers 97-122.
    for (NSUInteger i = 0; i < [messageCharacters count]; i++) {
        NSString *currentCharacter = messageCharacters[i];
        unichar asciiCode = [currentCharacter characterAtIndex:0];
        
        // Shift uppercase integers by the offset. Add the offset so that the new code still lies within the range for uppercase letters, meaning that it will loop back around to A if it exceeds the code for Z.
        if (65 <= asciiCode && asciiCode <= 90) {
            unichar newAsciiCode = asciiCode - offset;
            
            if (65 <= newAsciiCode && newAsciiCode <= 90) {
                // Put next two lines in their own method in order to avoid so much repetition. Want to avoid copy pasting more than a couple times!
                NSString *newCharacter = [NSString stringWithFormat:@"%C", newAsciiCode];
                [messageCharacters replaceObjectAtIndex:i withObject:newCharacter];
            } else if (newAsciiCode < 65) {
                newAsciiCode = 91 - (65 - newAsciiCode);
                NSString *newCharacter = [NSString stringWithFormat:@"%C", newAsciiCode];
                [messageCharacters replaceObjectAtIndex:i withObject:newCharacter];
            }
            
            // Shift lowercase integers by the offset.
        } else if (97 <= asciiCode && asciiCode <= 122) {
            unichar newAsciiCode = asciiCode - offset;
            
            if (97 <= newAsciiCode && newAsciiCode <= 122) {
                NSString *newCharacter = [NSString stringWithFormat:@"%C", newAsciiCode];
                [messageCharacters replaceObjectAtIndex:i withObject:newCharacter];
            } else if (newAsciiCode < 97) {
                newAsciiCode = 123 - (97 - newAsciiCode);
                NSString *newCharacter = [NSString stringWithFormat:@"%C", newAsciiCode];
                [messageCharacters replaceObjectAtIndex:i withObject:newCharacter];
            }
        }
        NSLog(@"This should be array of encrypted characters for string: %@", messageCharacters);
        decodedMessage = [decodedMessage stringByAppendingString:messageCharacters[i]];
    }
    return decodedMessage;
}


@end
