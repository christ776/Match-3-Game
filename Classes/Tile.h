//
//  Tile.h
//  Tile
//
//  Created by MajorTom on 9/7/10.
//  Copyright iphonegametutorials.com 2010. All rights reserved.
//

#import "cocos2d.h"

#import "constants.h";

@interface Tile : NSObject {
	int x, y, value;
	CCSprite *sprite;
}

-(id) initWithX: (int) posX Y: (int) posY;
@property (nonatomic, readonly) int x, y;
@property (nonatomic) int value;
@property (nonatomic, retain) CCSprite *sprite;
-(BOOL) nearTile: (Tile *)othertile;
-(void) trade:(Tile *)otherTile;
-(CGPoint) pixPosition;
@end
