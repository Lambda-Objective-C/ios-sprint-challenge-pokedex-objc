//
//  CESDetailVC.h
//  PokeDex-Obj-C
//
//  Created by Seschwan on 11/22/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CESPokemon;

NS_ASSUME_NONNULL_BEGIN

@interface CESDetailVC : UIViewController

- (void)updateViews;

@property (nonatomic)CESPokemon *pokemon;

@end

NS_ASSUME_NONNULL_END
