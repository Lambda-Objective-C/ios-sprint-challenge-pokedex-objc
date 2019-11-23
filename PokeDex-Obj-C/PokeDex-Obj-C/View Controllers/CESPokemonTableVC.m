//
//  CESPokemonTableVC.m
//  PokeDex-Obj-C
//
//  Created by Seschwan on 11/22/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESPokemonTableVC.h"
#import "CESDetailVC.h"
#import "CESPokemon.h"
#import "PokeDex_Obj_C-Swift.h"


@interface CESPokemonTableVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)NSArray<CESPokemon *> *pokemonArray;

@end

@implementation CESPokemonTableVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonController.sharedController fetchPokemonWithCompletion:^(NSArray<CESPokemon *> *pokemonArray, NSError *error ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemonArray = pokemonArray;
            [self.tableView reloadData];
        });
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.pokemonArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CESPokemon *pokemon = [self.pokemonArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = pokemon.name.capitalizedString;
   
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PokeDetails"])
    {
        CESDetailVC *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CESPokemon * pokemon = [self.pokemonArray objectAtIndex:indexPath.row];
        detailVC.pokemon = pokemon;
        [detailVC setPokemon:pokemon];
    }
}

@end

