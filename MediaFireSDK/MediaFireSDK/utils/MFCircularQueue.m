//
//  MFCircularQueue.m
//  MediaFireSDK
//
//  Created by Ken Hartness on 8/2/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

#import "MFCircularQueue.h"

@interface MFCircularQueue() {
    NSUInteger head, tail, numItems, maxItems;
    id __strong * contents;
    BOOL enlargeAsNeeded;
}
@end

@implementation MFCircularQueue

//------------------------------------------------------------------------------
- (id)init {
    self = [super init];
    if ( self == nil ) {
        return nil;
    }
    
    head = tail = numItems = 0;
    maxItems = 10;
    contents = (id __strong *)calloc(maxItems, sizeof(id));
    enlargeAsNeeded = YES;
    return self;
}

//------------------------------------------------------------------------------
- (id)initWithCapacity:(NSUInteger)maxSize overwrite:(BOOL)replaceOlderObjects {
    self = [super init];
    
    if ( self == nil || maxSize < 2 ) {
        return nil;
    }
    
    head = tail = numItems = 0;
    maxItems = maxSize;
    contents = (id __strong *)calloc(maxItems, sizeof(id));
    enlargeAsNeeded = ! replaceOlderObjects;
    return self;
}

//------------------------------------------------------------------------------
- (void)dealloc {
    [self clear];
    free(contents);
}

//------------------------------------------------------------------------------
- (void)clear {
    while ( numItems > 0 ) {
        [self dequeue];
    }
}

//------------------------------------------------------------------------------
- (NSUInteger)count {
    return numItems;
}

//------------------------------------------------------------------------------
- (BOOL)dequeue {
    if ( numItems == 0 ) {
        return NO;
    }
    contents[head] = nil;
    head = (head + 1) % maxItems;
    --numItems;
    return YES;
}

//------------------------------------------------------------------------------
-(id)dequeueObject {
    id object = nil;
    if ( numItems > 0 ) {
        object = contents[head];
        [self dequeue];
    }
    return object;
}

//------------------------------------------------------------------------------
- (BOOL)enqueue:(id) object {
    if ( object == nil ) {
        return NO;
    }
    
    if ( numItems == maxItems && enlargeAsNeeded ) {
        NSUInteger newMaxSize = maxItems * 2;
        id __strong * newItems = (id __strong *)calloc(newMaxSize, sizeof(id));
        NSUInteger pos = 0;
        while ( numItems > 0 ) {
            newItems[pos] = [self dequeueObject];
            ++pos;
        }
        free(contents);
        contents = newItems;
        head = 0;
        tail = numItems = pos;
        maxItems = newMaxSize;
    }
    
    contents[tail] = object;
    tail = (tail + 1) % maxItems;
    if ( numItems == maxItems ) {
        head = tail;
    } else {
        numItems++;
    }
    return YES;
}

//------------------------------------------------------------------------------
- (id)head {
    if ( numItems == 0 ) {
        return nil;
    } else {
        return contents[head];
    }
}

//------------------------------------------------------------------------------
- (BOOL)isEmpty {
    return numItems == 0;
}

//------------------------------------------------------------------------------
- (void)enumerateObjects:(QueueEnumerateBlock)block {
    NSUInteger count = numItems;
    NSUInteger pos = head;
    BOOL terminate = NO;

    while ( count > 0 && ! terminate ) {
        block(contents[pos], &terminate);
        pos = (pos + 1) % maxItems;
        --count;
    }
}
@end
