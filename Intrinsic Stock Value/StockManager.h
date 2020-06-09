//
//  StockManager.h
//  Intrinsic Stock Value
//
//  Created by Bader on 5/24/20.
//  Copyright © 2020 Nebo. All rights reserved.
//

@interface StockManager : NSObject
@property NSMutableArray * stockArray;
@property NSString * tickerName;
@property NSString * tickerFullName;
@property double price;
@property double eps;
@property double pe;
-(id) initAndGet;
-(void)setTicker: (NSString *) ticker;
-(double)getIV: (double) minReturn : (double) estimatedGrowth : (double) pe;
@end
