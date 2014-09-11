//
//  ESFlatButton.h
//  ios.library
//
//  Created by Bas van Kuijck on 11-09-14.

#import <UIKit/UIKit.h>

@interface ESFlatButton : UIButton

/**
 * The corner radius of the button
 * @discussion Default = 0.0f
 */
@property (nonatomic, readwrite) CGFloat cornerRadius;

/**
 * The outer bevel color
 * @discussion Default = background color, tinted with black alpha 0.35
 */
@property (nonatomic, strong) UIColor *outerBevelColor;

/**
 * The inner bevel color
 * @discussion Default = background color, tinted with white alpha 0.15
 */
@property (nonatomic, strong) UIColor *innerBevelColor;

/**
 * The background color when the button is highlighted (pressed)
 * @discussion Default = background color
 */
@property (nonatomic, strong) UIColor *highlightColor;

/**
 * The background color when the button is selected
 * @discussion Default = background color
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 * Should the button be 'pressed' when it's selected
 * @discussion Should it have the same state as 'highligted'
 */
@property (nonatomic, readwrite, getter=isPressedWhenSelected) BOOL pressedWhenSelected;

/**
 * The outer bevel height
 * @discussion Default = 3.0f
 */
@property (nonatomic, readwrite) CGFloat outerBevelHeight;

/**
 * The inner bevel height
 * @discussion Default = 1.0f
 * @discussion To disable the inner bevel effect, set this value to '0.0f'
 */
@property (nonatomic, readwrite) CGFloat innerBevelHeight;
@end
