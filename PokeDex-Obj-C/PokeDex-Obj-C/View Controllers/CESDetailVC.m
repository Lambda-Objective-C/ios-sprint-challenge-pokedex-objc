//
//  CESDetailVC.m
//  PokeDex-Obj-C
//
//  Created by Seschwan on 11/22/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESDetailVC.h"
#import "CESPokemon.h"
#import "PokeDex_Obj_C-Swift.h"

void *KVOContext = &KVOContext;

@interface CESDetailVC ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *idLbl;
@property (weak, nonatomic) IBOutlet UILabel *abilityLbl;


@end

@implementation CESDetailVC




- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonController.sharedController fillInDetailsWithPokemon:self.pokemon];
}

- (void)updateViews
{
    if (self.pokemon)
    {
        self.nameLbl.text = [NSString stringWithFormat:@"Name: %@", [self.pokemon.name capitalizedString]];
        self.idLbl.text = self.pokemon.id;
        self.abilityLbl.text = [self.pokemon.pokemonAbilites componentsJoinedByString:@", "];
        self.pokemonImageView.image = self.pokemon.pokemonImage;
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPokemon:(CESPokemon *)pokemon
{
    if(pokemon != _pokemon) {
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"pokemonImage" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"pokemonAbilites" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}


@end
