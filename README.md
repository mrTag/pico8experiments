# pico8experiments
sourcecode to all my little [pico8](http://www.lexaloffle.com/pico-8.php) experiments

## rectcollision
the basis for most platformers: axis aligned rectangular collision. the central function is _rectcollide(r1,r2)_ and it will calculate if the two rectangles overlap and what the collision normal is.
both rectangles can be moved (rect1 by player1, rect2 by player2). rect1 can be pushed around by rect2...