if (scroll_horizontal = 0 && scroll_vertical = 0 && boat_scroll_horizontal = 0 && boat_scroll_vertical = 0)
{
    if (keyboard_check_released(vk_up))
    {
        if (player_selected_speed < 5)
            player_selected_speed += 1;
    }
    else if (keyboard_check_released(vk_down))
    {
        if (player_selected_speed > -5)
            player_selected_speed -= 1;
    }
    
    if (keyboard_check(vk_left))
    {
        player_selected_heading -= rotation_speed * speed;
        if (player_selected_heading < 0)
            player_selected_heading += 360;
    }
    else if (keyboard_check(vk_right))
    {
        player_selected_heading += rotation_speed * speed;    
        if (player_selected_heading > 360)
            player_selected_heading -= 360;
    }
    
    // movement
    if (player_speed > player_selected_speed * speed_multiplication)
    {
        player_speed -= speed_change_per_second;
    }
    else if (speed < player_selected_speed * speed_multiplication)
    {
        player_speed += speed_change_per_second;
    }
    else 
    {
        player_speed = player_selected_speed * speed_multiplication;
    }

    speed = player_speed;
    direction = player_selected_heading;
    image_angle = direction;
}
else
{
    speed = 0;
}

if (bounce_speed > 0)
{
    speed += bounce_speed;
    bounce_speed -= speed_change_per_second;
    direction = bounce_direction;
    if (bounce_speed < 0)
        bounce_speed = 0;
}

// if not currently scrolling
if (scroll_horizontal = 0 && scroll_vertical = 0 && boat_scroll_horizontal = 0 && boat_scroll_vertical = 0)
{
    with (PlayerBoat)
    {
        // check boundaries
        
        //left
        if collision_line(current_tile_x * 1024, current_tile_y * 768, 
                          current_tile_x * 1024, (current_tile_y + 1) * 768, id, false, false) 
        {
            scroll_horizontal = -1024;
            boat_scroll_horizontal = -sprite_get_width(PlayerBoat.sprite_index) - 1;
        }
        // right
        else if collision_line((current_tile_x + 1) * 1024, current_tile_y * 768, 
                               (current_tile_x + 1) * 1024, (current_tile_y + 1) * 768, id, false, false) 
        {
            scroll_horizontal = 1024;
            boat_scroll_horizontal = sprite_get_width(PlayerBoat.sprite_index) + 1;
        }
        // top
        else if collision_line(current_tile_x * 1024, current_tile_y * 768, 
                               (current_tile_x + 1) * 1024, current_tile_y * 768, id, false, false) 
        {
            scroll_vertical = -768;
            boat_scroll_vertical = -sprite_get_width(PlayerBoat.sprite_index) - 1;
        }
        // bottom
        else if collision_line(current_tile_x * 1024, (current_tile_y + 1) * 768, 
                                (current_tile_x + 1) * 1024, (current_tile_y + 1) * 768, id, false, false) 
        {
            scroll_vertical = 768;
            boat_scroll_vertical = sprite_get_width(PlayerBoat.sprite_index) + 1;
        }
    }
}

if (scroll_horizontal > 0)
{
    scroll_horizontal -= scroll_per_second;
    if (scroll_horizontal <= 0)
    {
        view_xview[0] += (scroll_per_second + scroll_horizontal);
        scroll_horizontal = 0;
        current_tile_x += 1;
    }
    else
    {
        view_xview[0] += scroll_per_second;
    }
}
else if (scroll_horizontal < 0)
{
    scroll_horizontal += scroll_per_second;    
    if (scroll_horizontal >= 0)
    {
        view_xview[0] -= (scroll_per_second - scroll_horizontal);
        scroll_horizontal = 0;
        current_tile_x -= 1;
    }
    else
    {
        view_xview[0] -= scroll_per_second;
    }
}
else if (scroll_vertical > 0)
{
    scroll_vertical -= scroll_per_second;
    if (scroll_vertical <= 0)
    {
        view_yview[0] += (scroll_per_second + scroll_vertical);
        scroll_vertical = 0;
        current_tile_y += 1;
    }
    else
    {
        view_yview[0] += scroll_per_second;
    }
}
else if (scroll_vertical < 0)
{
    scroll_vertical += scroll_per_second;    
    if (scroll_vertical >= 0)
    {
        view_yview[0] -= (scroll_per_second - scroll_vertical);
        scroll_vertical = 0;
        current_tile_y -= 1;
    }
    else
    {
        view_yview[0] -= scroll_per_second;
    }
}


if (boat_scroll_horizontal > 0 && scroll_horizontal = 0)
{
    boat_scroll_horizontal -= abs(player_speed);
    speed = player_speed;
    if (boat_scroll_horizontal < 0)
        boat_scroll_horizontal = 0;
}
else if (boat_scroll_horizontal < 0 && scroll_horizontal = 0)
{
    boat_scroll_horizontal += abs(player_speed);
    speed = player_speed;
    if (boat_scroll_horizontal > 0)
        boat_scroll_horizontal = 0;
}
else if (boat_scroll_vertical > 0 && scroll_vertical = 0)
{
    boat_scroll_vertical -= abs(player_speed);
    speed = player_speed;
    if (boat_scroll_vertical < 0)
        boat_scroll_vertical = 0;
}
else if (boat_scroll_vertical < 0 && scroll_vertical = 0)
{
    boat_scroll_vertical += abs(player_speed);
    speed = player_speed;
    if (boat_scroll_vertical > 0)
        boat_scroll_vertical = 0;
}

