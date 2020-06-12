//
//  StockManager.h
//  Intrinsic Stock Value
//
//  Created by Bader on 5/24/20.
//  Copyright © 2020 Nebo. All rights reserved.
//
#import "../DataIO/DataIO.h"

@interface StockManager : NSObject
@property NSDictionary* stockData;
-(id) initAndGet;
-(void)setTicker: (NSString *) ticker;
-(double)getIV: (double) minReturn : (double) estimatedGrowth : (double) pe;
@end
