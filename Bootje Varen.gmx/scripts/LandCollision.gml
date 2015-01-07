
if (bounce_speed = 0)
{
    bounce_speed = abs(speed);
    bounce_direction = direction + 180;
    if (bounce_direction > 360)
        bounce_direction -= 180;
}
   
player_speed = 0;
player_selected_speed = 0;
x = xprevious;
y = yprevious;
