/// @description Insert description here
// You can write your code in this editor
// Get Player Input
keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
keyRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
keyUp = keyboard_check(vk_up) || keyboard_check(ord("W"));
keyDown = keyboard_check(vk_down) || keyboard_check(ord("S"));
keyActivate = keyboard_check_pressed(vk_space)
keyAttack = keyboard_check_pressed(vk_shift)
keyItem = keyboard_check_pressed(vk_control)

inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp !=0);

//Movement
hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

x += hSpeed;
y += vSpeed;

// Update sprite based on direction
if (keyUp) {
    sprite_index = sPlayer; // Ensure the sprite is set to sPlayer
    image_index = 3; // Frame for facing up
}
else if (keyDown) {
    sprite_index = sPlayer; // Ensure the sprite is set to sPlayer
    image_index = 0; // Frame for facing down
}
else if (keyLeft) {
    sprite_index = sPlayer; // Ensure the sprite is set to sPlayer
    image_index = 1; // Frame for facing left
}
else if (keyRight) {
    sprite_index = sPlayer; // Ensure the sprite is set to sPlayer
    image_index = 2; // Frame for facing right
}


// Define key for shooting (replace with your actual key for shooting)
keyShoot = keyboard_check_pressed(vk_space); // Example: Using space key to shoot

// Check if player shoots
if (keyShoot) {
    // Create hook instance at player's position
    var hook = instance_create_layer(x, y, "Instances", oHook);

    // Set hook's direction, speed, and angle based on player's facing direction
    var hookSpeed = 5; // Adjust the speed as needed
    switch (image_index) {
        case 0: // Facing Down
            hook.direction = 270;
            hook.image_angle = 180; // Set hook's angle to face downwards
            break;
        case 1: // Facing Left
            hook.direction = 180;
            hook.image_angle = 90; // Set hook's angle to face left
            break;
        case 2: // Facing Right
            hook.direction = 0;
            hook.image_angle = 270; // Set hook's angle to face right
            break;
        case 3: // Facing Up
            hook.direction = 90;
            hook.image_angle = 0; // Set hook's angle to face upwards
            break;
    }
    hook.speed = hookSpeed;
}

// Player Step Event
if (isHooked) {
    // Calculate direction towards the hook target
    var dir = point_direction(x, y, hookTargetX, hookTargetY);
    
    // Move towards the hook target
    x += lengthdir_x(grappleSpeed, dir);
    y += lengthdir_y(grappleSpeed, dir);

    // Optional: Stop moving when close enough to the target
    if (point_distance(x, y, hookTargetX, hookTargetY) < grappleSpeed) {
        x = hookTargetX;
        y = hookTargetY;
        isHooked = false; // Reset hook state
    }
} else {
    // Existing movement logic
    // Your current code for handling movement goes here
}
