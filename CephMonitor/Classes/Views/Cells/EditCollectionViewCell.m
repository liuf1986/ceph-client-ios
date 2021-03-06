//
//  EditCollectionViewCell.m
//  CephMonitor
//
//  Created by Wu~ on 2015/6/3.
//  Copyright (c) 2015年 Wu~. All rights reserved.
//

#import "EditCollectionViewCell.h"

#define SPACE 5
#define TITLE_HEIGHT 30
#define CELL_SPACE 2
#define CELL_HEIGHT 55
#define LEFT_WIDTH 7
#define EDIT_SIZE 30

@implementation EditCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        /**
         *  Title Background
         */
        self.titleBackground = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), TITLE_HEIGHT)];
        self.titleBackground.backgroundColor = [UIColor customBlueColor];
        [self addSubview:self.titleBackground];
        /**
         *  Title Label
         */
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, 0, CGRectGetWidth(self.titleBackground.frame) - (SPACE * 2), CGRectGetHeight(self.titleBackground.frame))];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont fontHelveticaNeueBoldSize:18];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)createCellWithKeys:(NSArray *)keys values:(NSArray *)values {
    if (!self.keyObjects) {
        self.keyObjects = [NSMutableArray array];
        self.valueObjects = [NSMutableArray array];
        
        CGFloat yOrigin = CGRectGetMaxY(self.titleLabel.frame) + CELL_SPACE;
        int index = 0;
        for (int i = 0 ; i < keys.count ; i++) {
            UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, yOrigin, LEFT_WIDTH, CELL_HEIGHT - (CELL_SPACE * 2))];
            leftView.backgroundColor = [UIColor customGreenColor];
            [self addSubview:leftView];
            
            UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) + SPACE, CGRectGetMinY(leftView.frame), (CGRectGetWidth(self.frame) - CGRectGetMaxX(leftView.frame) - SPACE) * 0.5, CGRectGetHeight(leftView.frame))];
            keyLabel.textColor = [UIColor customBlueColor];
            keyLabel.text = keys[i];
            keyLabel.adjustsFontSizeToFitWidth = YES;
            [self addSubview:keyLabel];
            [self.keyObjects addObject:keyLabel];
            
            UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
            editButton.frame = CGRectMake(CGRectGetWidth(self.frame) - EDIT_SIZE - SPACE, CGRectGetMidY(keyLabel.frame) - (EDIT_SIZE / 2), EDIT_SIZE, EDIT_SIZE);
            editButton.backgroundColor = [UIColor customRedColor];
            [editButton setImage:[UIImage imageNamed:@"Edit_logo"] forState:UIControlStateNormal];
            editButton.layer.cornerRadius = 3;
            editButton.tag = index;
            [self addSubview:editButton];
            
            UITextField *valueTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(keyLabel.frame) + SPACE, CGRectGetMinY(editButton.frame), CGRectGetMinX(editButton.frame) - CGRectGetMaxX(keyLabel.frame) - (SPACE * 2), CGRectGetHeight(editButton.frame))];
            valueTextField.textColor = [UIColor blackColor];
            valueTextField.text = values[i];
            valueTextField.layer.borderWidth = 1;
            valueTextField.layer.borderColor = [UIColor customGrayColor].CGColor;
            valueTextField.layer.cornerRadius = 3;
            UIView *spaceView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 10, 10)];
            valueTextField.leftViewMode = UITextFieldViewModeAlways;
            valueTextField.leftView = spaceView;
            valueTextField.keyboardType = UIKeyboardTypeASCIICapable;
            valueTextField.tag = index;
            [self addSubview:valueTextField];
            [self.valueObjects addObject:valueTextField];
            
            UIView *separateLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(keyLabel.frame), CGRectGetMaxY(leftView.frame) + CELL_SPACE, CGRectGetWidth(self.frame) - CGRectGetMinX(keyLabel.frame), 1)];
            separateLine.backgroundColor = [UIColor customShadowColor];
            [self addSubview:separateLine];
            
            index ++;
            yOrigin += CELL_HEIGHT;
        }
    }
    else {
        for (int i = 0; i < self.keyObjects.count; i++) {
            ((UILabel *)self.keyObjects[i]).text = keys[i];
            ((UITextField *)self.valueObjects[i]).text = values[i];
        }
    }
}

@end
