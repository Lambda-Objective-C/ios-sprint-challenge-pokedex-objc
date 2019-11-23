//
//  CESPokemon.m
//  PokeDex-Obj-C
//
//  Created by Seschwan on 11/22/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESPokemon.h"

@implementation CESPokemon

- (instancetype)initWithName:(NSString *)name pokemonURL:(NSString *)pokemonURL
{
    if (self = [super init])
    {
        _name = name.copy;
        _pokemonURL = pokemonURL.copy;
    }
    return self;
    
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *pokemonURL = dictionary[@"url"];
    // Pokemon URL?
    
    return [self initWithName:name pokemonURL:pokemonURL];
}

@end
