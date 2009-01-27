//
//  TPScheduleMaskController.m
//  ZVVTransport
//
//  Created by Marc Ammann on 1/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TPScheduleMaskController.h"

#define kMaskHeight 250.0f
#define kScreenWidth 320.0f

#define kAreaHeight 75.0f
#define kLeftOffset 60.0f
#define kLeftLabelOffset 10.0f
#define kInputFieldHeight 35.0f
#define kVerticalSpace 6.0f

#define kImageSize 19.0f
#define kButtonWidth 40.0f
#define kButtonHeight 37.0f

#define kContentHeight 35.0f

#define kPaddingLeft 10.0f
#define kPaddingTop 4.0f

#define kSpaceHorizontal 10.0f
#define kSmallSpaceHorizontal 5.0f

#define kLabelWidth 40.0f

#define kContentFieldWidth (kScreenWidth - kPaddingLeft - kSpaceHorizontal - kSmallSpaceHorizontal - kAccessorySizeWdith)
#define kInputFieldWidth (kContentFieldWidth - kLabelWidth - kSmallSpaceHorizontal)

#define kAccessorySizeWdith 35.0f
#define kAccessorySizeHeight 35.0f
#define kAccessoryPaddingLeft (kScreenWidth - kSpaceHorizontal - kAccessorySizeWdith)

@implementation TPScheduleMaskController

UIView *fromOverlay, *toOverlay;

- (id)initWithViewController:(UIViewController *)aController {
    if (self = [super init]) {
        parentController = [aController retain];
        
        currentTrip = [[TPTrip alloc] init];
        autocompleteController = [[TPAutocompleteController alloc] init];
        autocompleteController.delegate = self;
        
        maskTable = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kMaskHeight) style:UITableViewStylePlain];
        maskTable.separatorColor = [UIColor clearColor];
        maskTable.backgroundColor = [UIColor clearColor];
        maskTable.scrollEnabled = NO;
        maskTable.rowHeight = 40.0f;
        maskTable.delegate = self;
        maskTable.dataSource = self;
        
        fromTextField = [[self setupFieldWithTitle:NSLocalizedString(@"From:", nil)] retain];
        toTextField = [[self setupFieldWithTitle:NSLocalizedString(@"To:", nil)] retain];
    }
    
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    // Base View
    [super loadView];
    self.view.frame = CGRectMake(0.0f, 0.0f, kScreenWidth, 460.0f);
    
    // Silver Background
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kMaskHeight + 10.0f)];
    bgView.image = [UIImage imageNamed:@"maskBg.png"];
    [self.view addSubview:bgView];
    
    // Table with Input Fields
    [self.view addSubview:maskTable];
    
    // Autocompleter
    [self.view addSubview:autocompleteController.view];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [maskTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row < 3) {
        switch (indexPath.row) {
            case 0:
                [self setupField:fromTextField withInput:currentTrip.from];
                [cell addSubview:fromTextField];
                break;
            case 1:
                [self setupField:toTextField withInput:currentTrip.to];
                [cell addSubview:toTextField];
                break;
            case 2:
                ;
                // Label
                UITextField *dateInputField;
                if (currentTrip.travelDateDeparture) {
                    dateInputField = [self setupFieldWithTitle:NSLocalizedString(@"Dep.:", nil)];
                } else {
                    dateInputField = [self setupFieldWithTitle:NSLocalizedString(@"Arr.:", nil)];
                }
                
                // Content
                if (currentTrip.userEditDate) {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
                    dateInputField.text = [dateFormatter stringFromDate:currentTrip.travelDate];
                } else {
                    UIImageView *view = [self createHighlightWithText:NSLocalizedString(@"Now", nil)];
                    view.frame = CGRectMake(dateInputField.leftView.frame.size.width + 11.0f, 5.0f, view.frame.size.width, view.frame.size.height);
                    [dateInputField addSubview:view];
                }
                dateInputField.userInteractionEnabled = NO;
                [cell addSubview:dateInputField];
                break;
        }
        
        return cell; 
    } else if (indexPath.row == 3) {
        UIButton *switchDirectionsButton = [self createSmallButtonWithTitle:NSLocalizedString(@"Switch Directions", nil) xoffset:10.0f yoffset:15.0f];
        UIButton *transportMeansButton = [self createSmallButtonWithTitle:NSLocalizedString(@"Means of Transport", nil) xoffset:165.0f yoffset:15.0f];
        
        [cell addSubview:switchDirectionsButton];
        [cell addSubview:transportMeansButton];
    } else if (indexPath.row == 4) {
        UIImage *bgImage = [[UIImage imageNamed:@"mainGrayButtonBg.png"] stretchableImageWithLeftCapWidth:14.0 topCapHeight:18.0];
        
        UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchButton setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
        [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [searchButton setBackgroundImage:bgImage forState:UIControlStateNormal];
        searchButton.font = [UIFont boldSystemFontOfSize:18.0];
        searchButton.frame = CGRectMake(10, 7, 300, 46);
        
        [cell addSubview:searchButton];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 2) {
        return 60;
    } else {
        return 40;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        TPTravelDateSelectorController *travelDateController = [[TPTravelDateSelectorController alloc] initWithTrip:currentTrip];
        [parentController.navigationController pushViewController:travelDateController animated:YES];
        [travelDateController release];
    }
}

#pragma mark TextFields

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[parentController navigationController] setNavigationBarHidden:YES animated:YES];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [autocompleteController setHidden:NO animated:YES];
    [autocompleteController loadWithSubstring:textField.text];
    [[parentController navigationController] setNavigationBarHidden:YES animated:NO];
    if (textField == fromTextField) {
        if (fromTextField.overlay) {
            currentTrip.from.stringRepresentation = @"";
            [self setupField:fromTextField withInput:currentTrip.from];
        }
    } else if (textField == toTextField) {
        if (toTextField.overlay) {
            currentTrip.to.stringRepresentation = @"";
            [self setupField:toTextField withInput:currentTrip.to];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [autocompleteController setHidden:YES animated:YES];
    [[parentController navigationController] setNavigationBarHidden:NO animated:YES];
    if (textField == fromTextField) {
        currentTrip.from.stringRepresentation = textField.text;
        [self setupField:fromTextField withInput:currentTrip.from];
    } else if (textField == toTextField) {
        currentTrip.to.stringRepresentation = textField.text;
        [self setupField:toTextField withInput:currentTrip.to];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [autocompleteController loadWithSubstring:substring];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [autocompleteController loadWithSubstring:@""];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (UIButton *)createSmallButtonWithTitle:(NSString *)title xoffset:(CGFloat)xoffset yoffset:(CGFloat)yoffset {
    UIImage *bgImage = [[UIImage imageNamed:@"standardGrayButtonBg.png"] stretchableImageWithLeftCapWidth:12.0f topCapHeight:0.0f];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setLineBreakMode:UILineBreakModeWordWrap];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(xoffset, yoffset, 145.0f, 35.0f);
    button.font = [UIFont boldSystemFontOfSize:12.0];
    
    return button;
}

- (UIImageView *)createHighlightWithText:(NSString *)text {
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:16.0]];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"inputHighlightBg.png"] stretchableImageWithLeftCapWidth:14.0f topCapHeight:12.0f]];
    bgImage.frame = CGRectMake(0.0f, 0.0f, size.width + 25.0f, 25.0f);
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 2.0f, size.width + 25.0f, size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    [bgImage addSubview:label];
    
    return bgImage;
}

- (void)setupField:(TPTextFieldOverlay *)field withInput:(TPScheduleInput *)input {
    if ([input.stringRepresentation isEqualToString:@"Current Location"]) {
        UIImageView *view = [self createHighlightWithText:NSLocalizedString(@"Current Location", nil)];
        view.frame = CGRectMake(field.leftView.frame.size.width + 11.0f, 5.0f, view.frame.size.width, view.frame.size.height);
        field.overlay = view;
        [field addSubview:view];
        field.text = @"";
    } else {
        field.overlay = nil;
        field.text = input.stringRepresentation;
    }
}

- (TPTextFieldOverlay *)setupFieldWithTitle:(NSString *)title {
    TPTextFieldOverlay *inputField = [[TPTextFieldOverlay alloc] initWithFrame:CGRectMake(kPaddingLeft, kPaddingTop, kContentFieldWidth, kContentHeight)];
    inputField.borderStyle = UITextBorderStyleRoundedRect;
    inputField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputField.backgroundColor = [UIColor clearColor];
    inputField.font = [UIFont systemFontOfSize:16.0];
    inputField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kPaddingLeft, 0.0f, 40.0f, 14.0f)];
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = UITextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    label.text = title;
    
    
    inputField.leftView = label;
    inputField.leftViewMode = UITextFieldViewModeAlways;
    inputField.clearButtonMode = UITextFieldViewModeAlways;
    inputField.delegate = self;
    
    
    
    return [inputField autorelease];
}

- (void)autocompleteTableView:(id)aTableView didSelectItem:(id)item {
    if (fromTextField.editing) {
        [fromTextField.delegate textFieldShouldReturn:fromTextField];
        [self setupField:fromTextField withInput:item];
        [autocompleteController setHidden:YES animated:YES];
    } else if (toTextField.editing) {
        [toTextField.delegate textFieldShouldReturn:toTextField];
        [self setupField:toTextField withInput:item];
        [autocompleteController setHidden:YES animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
    [currentTrip release];
    [autocompleteController release];
    [maskTable release];
    [fromTextField release];
    [toTextField release];
    [parentController release];
    [super dealloc];
}


@end
