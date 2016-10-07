// Stripped grid
// keys : 
// - : decrease stroke weight
// + : increase stroke weight
// 1-9 : change background and stroke color
// q : active / unactive squares strokes

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import processing.svg.*;
// import java.util.Calendar;

int 	tileCount;
float 	tilewidth;
float 	x1, x2, x3, x4, y1, y2, y3, y4;
float[] prev_x3, prev_x4, prev_y3, prev_y4;
float 	randomRange;
int 	actRandomSeed;
boolean save;
float 	line_nb;
float 	bottom_space, top_space, bottom_b, top_b;
color 	red, green, blue, white, black, yellow, bg, stroke_c;
float 	stroke_w;
int 	draw_quad;

void setup(){
	size(800, 800);
	save = false;
	randomRange = 0.05;
	actRandomSeed = 0;
	tileCount = 10;
	tilewidth = (width * 0.8) / tileCount;
	prev_x3 = new float[tileCount];
	prev_x4 = new float[tileCount];
	prev_y3 = new float[tileCount];
	prev_y4 = new float[tileCount];
	red = color(255, 0, 0);
	green = color(0, 255, 0);
	blue = color(0, 0, 255);
	white = color(255, 255, 255);
	black = color(0, 0, 0);
	yellow = color(255, 255, 0);
	bg = blue;
	stroke_c = red;
	stroke_w = 0.1;
	draw_quad = 1;
}

void draw(){
	if (save)
		beginRecord(SVG, "export/" + str(stroke_w) + '/' + str(month()) + str(day()) + str(hour()) + str(minute()) + str(second()) + ".svg");
	translate(0.1 * width, 0.1 * height);
	background(bg);
	stroke(stroke_c);
	
	strokeWeight(stroke_w);
	randomSeed(actRandomSeed);
	for (int y = 0; y < tileCount; y++){
		x2 = random(mouseY * -randomRange, mouseY * randomRange);
		x3 = random(mouseY * -randomRange, mouseY * randomRange);
		y2 = random(mouseY * -randomRange, mouseY * randomRange);
		for (int x = 0; x < tileCount; x++){
			line_nb = random(10, 100);
			if (y == 0){
				x1 = x2;
				x2 += tilewidth + random(mouseX * -randomRange, mouseX * randomRange);
				y1 = y2;
				y2 = random(mouseY * -randomRange, mouseY * randomRange);
			}else{
				x1 = prev_x4[x];
				x2 = prev_x3[x];
				y1 = prev_y4[x];	
				y2 = prev_y3[x];	
			}
			x4 = x3;
			x3 += tilewidth + random(mouseX * -randomRange, mouseX * randomRange);
			// x3 += tilewidth + random(-10, 10);
			if (x == 0)
				y4 = tilewidth * (y + 1) + random(mouseY * -randomRange, mouseY * randomRange);
			else{
				y4 = y3;
			}
			y3 = tilewidth * (y + 1) + random(mouseY * -randomRange, mouseY * randomRange);
			prev_x3[x] = x3;
			prev_x4[x] = x4;
			prev_y3[x] = y3;
			prev_y4[x] = y4;
			// stroke(random(255));
			// noStroke();
			// fill(random(255));
			noFill();
			if (draw_quad > 0)
				quad(x1, y1, x2, y2, x3, y3, x4, y4);
			top_space = (x2 - x1) / line_nb;
			bottom_space = (x3 - x4) / line_nb;
			top_b = (y2 - y1) / line_nb;
			bottom_b = (y3 - y4) / line_nb;
			for (int i = 0; i < line_nb; i++){
				line(x1 + top_space * i, y1 + (top_b * i), x4 + bottom_space * i, y4 + (bottom_b * i));
			}
		}
	}
	if (save){
		endRecord();
		save = false;
	}

}

void mouseClicked(){
	actRandomSeed++;
}

void keyReleased(){
	if (key == 's' || key == 'S')
		save = true;
	if (key == '1'){
		bg = blue;
		stroke_c = red;
	}
	if (key == '2'){
		bg = blue;
		stroke_c = green;
	}
	if (key == '3'){
		bg = red;
		stroke_c = blue;
	}
	if (key == '4'){
		bg = red;
		stroke_c = green;
	}
	if (key == '5'){
		bg = green;
		stroke_c = blue;
	}
	if (key == '6'){
		bg = green;
		stroke_c = red;
	}
	if (key == '7'){
		bg = black;
		stroke_c = white;
	}
	if (key == '8'){
		bg = white;
		stroke_c = black;
	}
	if (key == '9'){
		bg = blue;
		stroke_c = yellow;
	}
	if (key == '+')
		if (stroke_w < 0.5)
			stroke_w += 0.05;
	if (key == '-')
		if (stroke_w > 0.05)
			stroke_w -= 0.05;
	if (key == 'q')
		draw_quad *= -1;
	if (key == 'p')
		print(stroke_w);
}