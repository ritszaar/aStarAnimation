import java.util.*;

int state;
AStar astar;
PVector start, end;

void setup() {
    size(960, 720);
    background(0);
    
    state = 0;
    astar = new AStar(5);
    start = new PVector( - 10, -10);
    end = new PVector( - 10, -10);
}

void draw() {
    if(state >= 3) {
        astar.display();
        if (state % 2 == 1) {
            astar.step();
        }
    }
}

void mousePressed() {
    if(state == 1) {
        astar.setStart(mouseX, mouseY);
        noStroke();
        fill(0, 255, 0);
        circle(mouseX, mouseY, 10);
        fill(0);
        circle(start.x, start.y, 12);
        start = new PVector(mouseX, mouseY);
    } else if (state == 2) {
        noStroke();
        fill(255, 0, 0);
        astar.setEnd(mouseX, mouseY);
        circle(mouseX, mouseY, 10);
        fill(0);
        circle(end.x, end.y, 12);
        end = new PVector(mouseX, mouseY);
    }   
}

void mouseDragged() {
    if(state == 0) {
        noStroke();
        fill(255);
        circle(mouseX, mouseY, 20);
    }
}


void keyPressed() {
    if(key == ' ') {
        state = state + 1;
    }
    
    if(state == 3) {
        astar.setGrid();
        frameRate(20);
    }
}