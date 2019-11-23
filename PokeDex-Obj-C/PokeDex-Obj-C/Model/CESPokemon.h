//
//  CESPokemon.h
//  PokeDex-Obj-C
//
//  Created by Seschwan on 11/22/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon)
@interface CESPokemon : NSObject

@property (nonatomic, nullable, copy)NSString *name;
@property (nonatomic, nullable, copy)NSString *pokemonURL;
@property (nonatomic, nullable)UIImage *pokemonImage;
@property (nonatomic, nullable, copy)NSString *id;
@property (nonatomic, nullable, copy)NSArray *pokemonAbilites;

- (instancetype)initWithName:(NSString *)name pokemonURL:(NSString *)pokemonURL;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
