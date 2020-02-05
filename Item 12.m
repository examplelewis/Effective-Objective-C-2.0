#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface EOCMessageForwarding : NSObject

@property (copy) NSString *string;
@property (strong) NSNumber *number;
@property (strong) NSDate *date;
@property (strong) id respObject;
@property (copy) NSMutableDictionary *allInDict;

@end

@implementation EOCMessageForwarding

id allInDictGetter(id self, SEL _cmd);
void allInDictSetter(id self, SEL _cmd, id value);

@dynamic string, number, date, respObject;

- (instancetype)init {
	self = [super init];
	if (self) {
		_allInDict = [NSMutableDictionary dictionaryWithDictionary:@{@"string": @"gnirts", @"number": @(1000), @"date": [NSDate date], @"respObject": @[@"12345"]}];
	}
	
	return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
	NSString *selString = NSStringFromSelector(sel);
	NSLog(@"resolveInstanceMethod selString: %@", selString);
	
	if ([selString hasPrefix:@"set"]) {
		class_addMethod(self, sel, (IMP)allInDictSetter, "v@:@");
	} else {
		class_addMethod(self, sel, (IMP)allInDictGetter, "@@:");		
	}
	
	return YES;
}

id allInDictGetter(id self, SEL _cmd) {
	EOCMessageForwarding *typedSelf = (EOCMessageForwarding *)self;
	
	NSString *selString = NSStringFromSelector(_cmd);
//	NSLog(@"allInDictGetter selString: %@", selString);
	
	return typedSelf.allInDict[selString];
}

void allInDictSetter(id self, SEL _cmd, id value) {
	EOCMessageForwarding *typedSelf = (EOCMessageForwarding *)self;
	
	NSString *selString = NSStringFromSelector(_cmd);
//	NSLog(@"allInDictSetter selString: %@", selString);
//	NSLog(@"allInDictSetter value: %@", value);
	
	selString = [selString stringByReplacingOccurrencesOfString:@":" withString:@""];
	selString = [selString stringByReplacingOccurrencesOfString:@"set" withString:@""];
	NSString *firstLowerCaseString = [[selString substringWithRange:NSMakeRange(0, 1)] lowercaseString];
	selString = [selString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstLowerCaseString];
//	NSLog(@"allInDictSetter lowerSelString: %@", selString);
	
	if (value) {
		typedSelf.allInDict[selString] = value;
	} else {
		[typedSelf.allInDict removeObjectForKey:selString];
	}
}

@end

int main(int argc, char *argv[]) {
	@autoreleasepool {
		EOCMessageForwarding *forwarding = [EOCMessageForwarding new];
		
		NSLog(@"main string: %@", forwarding.string);
		NSLog(@"main number: %@", forwarding.number);
		NSLog(@"main date: %@", forwarding.date);
		NSLog(@"main respObject: %@", forwarding.respObject);
		
		forwarding.string = @"asdfg";
		forwarding.number = @(98765);
		forwarding.date = [NSDate dateWithTimeIntervalSince1970:1563201200];
		forwarding.respObject = @[@"zxcvb"];
		
		NSLog(@"main string: %@", forwarding.string);
		NSLog(@"main number: %@", forwarding.number);
		NSLog(@"main date: %@", forwarding.date);
		NSLog(@"main respObject: %@", forwarding.respObject);
		
		forwarding.respObject = nil;
		NSLog(@"main respObject: %@", forwarding.respObject);
	}
}
