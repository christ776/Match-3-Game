//
//  PlayLayer.m
//  PlayLayer
//
//  Created by MajorTom on 9/7/10.
//  Copyright iphonegametutorials.com 2010. All rights reserved.
//

#import "PlayLayer.h"

@interface PlayLayer()
-(void)afterTurn: (id) node;
@end

@implementation PlayLayer

-(id) init{
	self = [super init];
	
	CCSprite *bg = [CCSprite spriteWithFile: @"ingame_menu.png"];
	bg.position = ccp(160,240);
	[self addChild: bg z:0];
	
	box = [[Box alloc] initWithSize:CGSizeMake(kBoxWidth,kBoxHeight) factor:6];
	box.layer = self;
	box.lock = YES;
	
	self.isTouchEnabled = YES;
	
	return self;
}

-(void) onEnterTransitionDidFinish{
	[box check];
}

- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
	NSLog(@"ccTouchesBegan");
	
	if ([box lock]) {
		return;
	}
	
	UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInView: touch.view];
	location = [[CCDirector sharedDirector] convertToGL: location];
	
	
	int x = (location.x -kStartX) / kTileSize;
	int y = (location.y -kStartY) / kTileSize;
	
	
	if (selectedTile && selectedTile.x ==x && selectedTile.y == y) {
		return;
	}
	
	Tile *tile = [box objectAtX:x Y:y];
	
	if (selectedTile && [selectedTile nearTile:tile]) {
		[box setLock:YES];
		[self changeWithTileA: selectedTile TileB: tile sel: @selector(check:data:)];
		selectedTile = nil;
	}else {
		selectedTile = tile;
		[self afterTurn:tile.sprite];
	}
}

-(void) changeWithTileA: (Tile *) a TileB: (Tile *) b sel : (SEL) sel{
	CCAction *actionA = [CCSequence actions:
						 [CCMoveTo actionWithDuration:kMoveTileTime position:[b pixPosition]],
						 [CCCallFuncND actionWithTarget:self selector:sel data: a],
						 nil
						 ];
	
	CCAction *actionB = [CCSequence actions:
						 [CCMoveTo actionWithDuration:kMoveTileTime position:[a pixPosition]],
						 [CCCallFuncND actionWithTarget:self selector:sel data: b],
						 nil
						 ];
	[a.sprite runAction:actionA];
	[b.sprite runAction:actionB];
	
	[a trade:b];
}

-(void) backCheck: (id) sender data: (id) data{
	if(nil == firstOne){
		firstOne = data;
		return;
	}
	firstOne = nil;
	[box setLock:NO];
}

-(void) check: (id) sender data: (id) data{
	if(nil == firstOne){
		firstOne = data;
		return;
	}
	BOOL result = [box check];
	if (result) {
		[box setLock:NO];	
	}else {
		[self changeWithTileA:(Tile *)data TileB:firstOne sel:@selector(backCheck:data:)]; 
		[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:kMoveTileTime + 0.03f],
						 [CCCallFunc actionWithTarget:box selector:@selector(unlock)],
						 nil]];
	}

	firstOne = nil;
}


-(void)afterTurn: (id) node{
	if (selectedTile && node == selectedTile.sprite) {
		CCSprite *sprite = (CCSprite *)node;
		CCSequence *someAction = [CCSequence actions: 
								  [CCScaleBy actionWithDuration:kMoveTileTime scale:0.5f],
								  [CCScaleBy actionWithDuration:kMoveTileTime scale:2.0f],
								  [CCCallFuncN actionWithTarget:self selector:@selector(afterTurn:)],
								  nil];
		
		[sprite runAction:someAction];
	}
}
@end
