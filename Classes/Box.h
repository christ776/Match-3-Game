#import "cocos2d.h"

#import "constants.h"
#import "Tile.h"

@interface Box : NSObject {
	id first, second;
	CGSize size;
	NSMutableArray *content;
	NSMutableSet *readyToRemoveTiles;
	BOOL lock;
	CCLayer *layer;
	Tile *OutBorderTile;
}
@property(nonatomic, retain) CCLayer *layer;
@property(nonatomic, readonly) CGSize size;
@property(nonatomic) BOOL lock;
-(id) initWithSize: (CGSize) size factor: (int) factor;
-(Tile *) objectAtX: (int) posX Y: (int) posY;
-(BOOL) check;
-(void) unlock;
-(void) removeSprite: (id) sender;
-(void) afterAllMoveDone;
-(BOOL) haveMore;
@end
