Actions = Class{}

FACE_LEFT = 'left'
FACE_DOWN = 'down'
FACE_RIGHT = 'right'
FACE_UP = 'up'

F1 = 'F1'
F0 = 'F0'
WALK = 'walk'
CONDITIONAL_GREY = 'greyTile'
CONDITIONAL_BLUE = 'blueTile'
CONDITIONAL_RED = 'redTile'
CONDITIONAL_YELLOW = 'yellowTile'
PAINT_GREY = 'paint grey'
PAINT_RED = 'paint red'
PAINT_BLUE = 'paint blue'
PAINT_YELLOW = 'paint yellow'

function Actions:init()
    self.action = nil
    self.condition = nil

    self.actions = {FACE_LEFT, FACE_RIGHT, WALK, F0, PAINT_GREY}
    self.conditions =  {CONDITIONAL_GREY, CONDITIONAL_BLUE, CONDITIONAL_RED, CONDITIONAL_YELLOW}
end