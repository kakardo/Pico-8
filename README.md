# [kakardo game carts](https://kakardo.github.io/Pico-8/)
  Experimenting with this cute game engine.<br/>

## Cart 1 - Gröne Orm (a snake clone)
[< PLAY/VIEW >](https://kakardo.github.io/Pico-8/game%20carts/01%20grone%20orm%20(snake%20clone)/grone_orm_html/index.html) [< SOURCE CODE>](https://github.com/kakardo/Pico-8/tree/d1e07f148a84d7badf800f8da36a230d0deb0404/game%20carts/01%20grone%20orm%20(snake%20clone)) (60 % done)<br/>
  Made this game mainly to learn Lua and to have fun along the way. I didn't aim for the most efficient or polished solutions, and some of the code shows that. I have never tried to animate something with sprites before, and it has been really enjoyable to try things out for myself. Seeing the project like more of a puzzle game than task to complete. In the future I'll be less experimental and use references when needed, but not this time.

## Cart 2 - Platonic Solids Viewer
<a href="https://kakardo.github.io/Pico-8/game%20carts/02%20platonic%20solids%20viewer/platonic_solids_viewer_html/index.html">
  <img src="https://github.com/kakardo/Pico-8/blob/main/game%20carts/02%20platonic%20solids%20viewer/platonic_solids_viewer.gif?raw=true"
       alt="Platonic Solids Viewer GIF"
       align="right" width="220">
</a>

[< PLAY/VIEW >](https://kakardo.github.io/Pico-8/game%20carts/02%20platonic%20solids%20viewer/platonic_solids_viewer_html/index.html)
[< SOURCE CODE >](https://github.com/kakardo/Pico-8/tree/d1e07f148a84d7badf800f8da36a230d0deb0404/game%20carts/02%20platonic%20solids%20viewer)
(1.0)<br/>

  I wanted to draw something generated and animated by calculations, and my dices from my TTRPG-days came to mind. When I had decided on how I wanted to structure the program, the D4, D6 and D8 was not so hard to implement. The D12 and D20 was a little bit unexpected and became quite complex for me in the beginning of this project.

  The D12 I made came out stretched. I learned that I needed to use the golden ratio (φ) to make regular pentagons. With this I can make all angles 108° and all edges the same length. It's not just aesthetically pleasing, but one of the requirements according to the definition of what makes a platonic solid.

  The D20's made up of equal triangles with 60° angles. The edges run in different direction in 3D, and I could use phi in the coordinate to make sure all the edges were the same length no matter what direction.

  Last problem was that the shapes were not the same size in relation to each other. Their corners were different distances from the center. The biggest difference was the octahedron with 1 in length, while for example the cube had √3. This made the D8 seem a lot smaller. My solution was to limit the distance to corners, so the furthest distance a corner can be is 1.

  I was almost done with the project when I tried some encapsulation. I believe my next project will be written with OOP.