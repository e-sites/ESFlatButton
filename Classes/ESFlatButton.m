//
//  ESFlatButton.m
//  ios.library
//
//  Created by Bas van Kuijck on 11-09-14.

#import "ESFlatButton.h"
@interface ESFlatButton()
{
    BOOL _secondDraw;
    __strong UIColor *_backgroundColor;
}
UIColor *_ESFlatButtontint(UIColor *clr, UIColor *tintColor);
void _ESFlatButtonCGContextAddRoundRect(CGContextRef context, CGRect rect, float radius);
@end

@implementation ESFlatButton
@synthesize innerBevelHeight=_innerBevelHeight,outerBevelColor=_outerBevelColor,cornerRadius=_cornerRadius,innerBevelColor=_innerBevelColor,outerBevelHeight=_outerBevelHeight,highlightColor=_highlightColor,selectedColor=_selectedColor,pressedWhenSelected=_pressedWhenSelected;

#pragma mark - Properties
// ____________________________________________________________________________________________________________________

- (void)setPressedWhenSelected:(BOOL)aPressedWhenSelected
{
    _pressedWhenSelected = aPressedWhenSelected;
    [self setNeedsDisplay];
}

- (void)setBackgroundColor:(UIColor *)aBackgroundColor
{
    _backgroundColor = aBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setHighlightColor:(UIColor *)anHighlightColor
{
    _highlightColor = anHighlightColor;
    [self setNeedsDisplay];
}

- (void)setSelectedColor:(UIColor *)aSelectedColor
{
    _selectedColor = aSelectedColor;
    [self setNeedsDisplay];
}

- (UIColor *)backgroundColor
{
    return _backgroundColor;
}

- (void)setInnerBevelHeight:(CGFloat)anInnerBevelHeight
{
    _innerBevelHeight = anInnerBevelHeight;
    [self setNeedsDisplay];
}

- (void)setOuterBevelColor:(UIColor *)anOuterBevelColor
{
    _outerBevelColor = anOuterBevelColor;
    [self setNeedsDisplay];
}

- (void)setInnerBevelColor:(UIColor *)anInnerBevelColor
{
    _innerBevelColor = anInnerBevelColor;
    [self setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)aCornerRadius
{
    _cornerRadius = aCornerRadius;
    [self setNeedsDisplay];
}

- (void)setOuterBevelHeight:(CGFloat)anOuterBevelHeight
{
    _outerBevelHeight = anOuterBevelHeight;
    [self _correctInsets];
    [self setNeedsDisplay];
}

- (void)_correctInsets
{
   if (self.isHighlighted) {
        [self setContentEdgeInsets:UIEdgeInsetsMake(self.outerBevelHeight, 0, 0, 0)];
    } else {
        [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, self.outerBevelHeight, 0)];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self _correctInsets];
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self _correctInsets];
    [self setNeedsDisplay];
}

#pragma mark - Drawing
// ____________________________________________________________________________________________________________________

- (void)drawRect:(CGRect)rect
{
    // First draw?
    if (!_secondDraw) {
        if (self.outerBevelHeight == 0) {
            self.outerBevelHeight = 3.0f;
        }
        if (_backgroundColor == nil) {
            _backgroundColor = [UIColor whiteColor];
        }
        _secondDraw = YES;
    }
    
    // Figure out what background color the button should have
    UIColor *bgColor = _backgroundColor;
    if (self.isHighlighted && self.highlightColor != nil) {
        bgColor = self.highlightColor;
        
    } else if (self.isSelected && self.selectedColor != nil) {
        bgColor = self.selectedColor;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect r = rect;
    CGFloat bh = self.outerBevelHeight;
    UIColor *bevelColor;
    // Figure out what (inner or outer) bevel color should be used
    if (self.isHighlighted || (self.isSelected && self.pressedWhenSelected)) {
        if (self.innerBevelColor == nil) {
            bevelColor = _ESFlatButtontint(bgColor, [UIColor colorWithRed:1 green:1 blue:1 alpha:.15]);
        } else {
            bevelColor = self.innerBevelColor;
        }
        bh = self.innerBevelHeight;
    } else {
        if (self.outerBevelColor == nil) {
            bevelColor = _ESFlatButtontint(bgColor, [UIColor colorWithRed:0 green:0 blue:0 alpha:.35]);
        } else {
            bevelColor = self.outerBevelColor;
        }
    }
    
    // Draw the bevel
    CGContextSetFillColorWithColor(context, bevelColor.CGColor);
    r.origin.y = 10;
    r.size.height = rect.size.height - r.origin.y;
    _ESFlatButtonCGContextAddRoundRect(context, r, self.cornerRadius);
    CGContextFillPath(context);
    
    // Draw the actual button
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    r.origin.y = self.outerBevelHeight - bh;
    r.size.height = rect.size.height - (r.origin.y + bh);
    _ESFlatButtonCGContextAddRoundRect(context, r, self.cornerRadius);
    CGContextFillPath(context);
}

#pragma mark - Helpers
// ____________________________________________________________________________________________________________________

void _ESFlatButtonCGContextAddRoundRect(CGContextRef context, CGRect rect, float radius)
{
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI / 4, M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, 0.0f, -M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius, -M_PI / 2, M_PI, 1);
}

UIColor *_ESFlatButtontint(UIColor *clr, UIColor *tintColor)
{
    CGFloat r, g, b, alpha;
    [tintColor getRed:&r green:&g blue:&b alpha:&alpha];
    
    alpha = MIN(1.0, MAX(0.0, alpha));
    CGFloat beta = 1.0 - alpha;
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [clr getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [tintColor getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat red     = r1 * beta + r2 * alpha;
    CGFloat green   = g1 * beta + g2 * alpha;
    CGFloat blue    = b1 * beta + b2 * alpha;
    alpha   = a1 + (a2 * alpha);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
