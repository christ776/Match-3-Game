//
//  PlayLayer.h
//  PlayLayer
//
//  Created by MajorTom on 9/7/10.
//  Copyright iphonegametutorials.com 2010. All rights reserved.
//

#import "cocos2d.h"

#import "Box.h"

@interface PlayLayer : CCLayer
{
	Box *box;
	Tile *selectedTile;
	Tile *firstOne;
}

-(void) changeWithTileA: (Tile *) a TileB: (Tile *) b sel : (SEL) sel;
-(void) check: (id) sender data: (id) data;
@end
