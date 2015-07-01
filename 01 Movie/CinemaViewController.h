//
//  CinemaViewController.h
//  01 Movie
//
//  Created by lyb on 14-10-8.
//  Copyright (c) 2014年 imac. All rights reserved.
//

#import "BaseViewController.h"

@interface CinemaViewController : UITableViewController {

    
    /*
     最后的数据形式
     {
     "区ID": [model1,model2,model3];
     "区ID": [model1,model2,model3];
     "区ID": [model1,model2,model3];
     }
     */
    NSMutableDictionary *_cinemaDictionary;
    
    
    /*
     [
     {name:东城区， id ： 123},
    {name:东城区， id ： 123},
     ]
     */
    NSArray *_districtArrary;
    
    BOOL close[20]; //no  收起  yes展开
    
}

@end
