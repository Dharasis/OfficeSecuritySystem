//
//  MFCircularQueue.h
//  MediaFireSDK
//
//  Created by Ken Hartness on 8/2/13.
//  Copyright (c) 2013 MediaFire. All rights reserved.
//

/**
 @brief A queue mechanism for any NSObject descendant.  Not thread-safe!
 */
#import <Foundation/Foundation.h>

typedef void (^QueueEnumerateBlock)(id object, BOOL *done);

@interface MFCircularQueue : NSObject

/**
 @brief Creates a queue with a limited number of slots
 
 @param maxSize The maximum number of simultaneous items allowed in the queue.
 @param replaceOlderObjects Setting to true will override the queue's ability
 to expand when it reaches capacity.  In this mode, when the queue reaches 
 capacity, the items in the queue will begin to wrap and replace older items.  
 The oldest items in the queue are lost when items are queued past the queue's
 capacity.
*/
- (id)initWithCapacity:(NSUInteger)maxSize overwrite:(BOOL)replaceOlderObjects;

/**
 @brief Purges all items from the queue.
 */
- (void)clear;

/**
 @brief Returns the number of objects currently in the queue.
 */
- (NSUInteger)count;

/**
 @brief Purges the object currently at the head of the queue and returns true
 if such an object exists, returns false otherwise.  The removed object is lost
 during this operation.
 */
- (BOOL)dequeue;

/**
 @brief Removes the object currently at the head of the queue and returns it to
 the client.
 */
- (id)dequeueObject;

/** 
 @brief Adds a client-supplied object to the back of the queue.  The queue does 
 not enforce uniqueness in the objects enqueued, so it is possible to enqueue 
 multiple copies of the same object.
 
 @param object The object to be added to the queue.  Can be any descendant of 
 NSObject.
 */
- (BOOL)enqueue:(id)object;

/**
 @brief Returns a reference (id) to the object currently at the head of the queue.
 */
- (id)head;

/**
 @brief Indicates whether the queue contains no objects.
 */
- (BOOL)isEmpty;

/**
 @brief Iterates over all items in the queue and processes them with a client
 supplied callback.
 
 @param block The operation that will be executed against each item in the queue.
 */
- (void)enumerateObjects:(QueueEnumerateBlock)block;
@end
