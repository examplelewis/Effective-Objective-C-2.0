#import <Foundation/Foundation.h>

@interface EOCRectangle : NSObject

@property (assign, readonly) float width;
@property (assign, readonly) float height;

- (instancetype)initWithWidth:(float)width height:(float)height;

@end

@implementation EOCRectangle

- (instancetype)init {
	return [self initWithWidth:5.0f height:10.0f];
}
//- (instancetype)init {
//	@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initWithWidth:height method" userInfo:nil];
//}
- (instancetype)initWithWidth:(float)width height:(float)height {
	self = [super init];
	if (self) {
		_width = width;
		_height = height;
	}
	
	return self;
}

@end

@interface EOCSquare: EOCRectangle

- (instancetype)initWithDimension:(float)dimension;

@end

@implementation EOCSquare

- (instancetype)init {
	return [self initWithDimension:5.0f];
}
- (instancetype)initWithWidth:(float)width height:(float)height {
	float dimension = MAX(width, height);
	return [self initWithDimension:dimension];
}
//- (instancetype)initWithWidth:(float)width height:(float)height {
//	@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Must use initWithDimension: method" userInfo:nil];
//}
- (instancetype)initWithDimension:(float)dimension {
	return [super initWithWidth:dimension height:dimension];
}

@end

int main(int argc, char *argv[]) {
	@autoreleasepool {
		
	}
}