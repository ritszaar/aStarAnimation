class AStar {
    float res;
    int rows, cols;
    int[][] grid;
    Cell[][] parent;
    Cell start, end, current;
    ArrayList<Cell> dirs;
    float[][] g, f;
    boolean[][] visited;
    PriorityQueue<Dinfo> pq;
    boolean done;
    
    
    AStar(float res_) {
        res = res_;
        rows= floor(height / res);
        cols= floor(width / res);
        
        //start = new Cell(0, 0);
        //end = new Cell(rows - 1, cols - 1);
        
        grid= new int[rows][cols];
        parent = new Cell[rows][cols];
        g = new float[rows][cols];
        f = new float[rows][cols];
        visited = new boolean[rows][cols];
        
        //current = start;
        //parent[start.i][start.j] = start;
        //g[start.i][start.j] = 0;
        //f[start.i][start.j] = g[start.i][start.j] + h(start.i, start.j);
        //visited[start.i][start.j] = false;
        
        dirs= new ArrayList<Cell>();
        dirs.add(new Cell( - 1, 0));
        dirs.add(new Cell(0, 1));
        dirs.add(new Cell(1, 1));
        dirs.add(new Cell(0, -1));
        dirs.add(new Cell(1, 0));
        dirs.add(new Cell( - 1, 1));
        dirs.add(new Cell(1, -1));
        dirs.add(new Cell( - 1, -1));
        
        done= false;
    }
    
    void setStart(float x, float y) {
        start = new Cell(floor(y / res), floor(x / res));
    }
    
    void setEnd(float x, float y) {
        end = new Cell(floor(y / res), floor(x / res));
        
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                grid[i][j] = 0;
                parent[i][j] = new Cell( - 1, -1);
                g[i][j] = rows + cols + 10;
                f[i][j] = g[i][j] + h(i, j);
                visited[i][j] = false;
            }
        }
        
        current = start;
        parent[start.i][start.j] = start;
        g[start.i][start.j] = 0;
        f[start.i][start.j] = g[start.i][start.j] + h(start.i, start.j);
        visited[start.i][start.j] = false;
        
        pq =new PriorityQueue<Dinfo>(5, new DinfoComparator());
        pq.add(new Dinfo(start.i, start.j, 0));
    }
    
    void setGrid() {
        loadPixels();
        for (int x = 0; x < width; x++) {
            for (int y = 0; y < height; y++) {
               int j =floor(x / res);
               int i =floor(y / res);
                if (pixels[x + y * width] == color(255)) {
                    grid[i][j] = 1;
                } else {
                    grid[i][j] = 0;  
                }
            }
        }
    }
    
    void drawPath()  {
        stroke(173, 239, 209);
        strokeWeight(2);
        Cellcell = current;
        Cellcparent = parent[current.i][current.j];
        while(cell != start) {
            float x = cell.j * res + res / 2;
            float y = cell.i * res + res / 2;
            float xp = cparent.j * res + res / 2;
            float yp = cparent.i * res + res / 2;
            line(x, y, xp, yp);
            cell= cparent;
            cparent = parent[cell.i][cell.j];
        }
    }
    
    boolean inside(int i, int j) {
        return(i >= 0 && i < rows && j >= 0 && j < cols);
    }
    
    void step() {
        if (!done && !pq.isEmpty()) {
            Dinfo cur = pq.poll();
            visited[cur.i][cur.j] = true;
            current = new Cell(cur.i, cur.j);
            if (cur.i == end.i && cur.j == end.j) {
               done = true;
                return;
            }
            for (Cell dir : dirs) {
                int neighI = cur.i + dir.i;
                int neighJ = cur.j + dir.j;
                float cost = (abs(dir.i) + abs(dir.j)) == 1 ? 1 : sqrt(2);
                if (inside(neighI, neighJ) && grid[neighI][neighJ] == 0 && !visited[neighI][neighJ]) {
                   if (g[neighI][neighJ] > g[cur.i][cur.j] + cost) {
                        g[neighI][neighJ] = g[cur.i][cur.j] + 1;
                        f[neighI][neighJ] = g[neighI][neighJ] + h(neighI, neighJ);
                        parent[neighI][neighJ] = current;
                        pq.add(new Dinfo(neighI, neighJ, f[neighI][neighJ]));
                    }     
                }
            } 
        }
    }
    
    float h(int i, int j) {
        //return 0;
        //return abs(i - end.i) + abs(j - end.j);
        return sqrt(sq(i - end.i) + sq(j - end.j));
    }
    
    void display() {
        showGrid();
        drawPath();
        noStroke();
        fill(0, 255, 0);
        circle(start.j * res + res / 2, start.i * res + res / 2, 10);
        fill(255, 0, 0);
        circle(end.j * res + res / 2, end.i * res + res / 2, 10);
    }
    
    void showGrid() {
        background(0);
        noStroke();
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {       
                if (grid[i][j] == 1) {
                    fill(255);
                } else {
                    fill(0);
                }
                rect(j *res, i * res, res, res);
            }
        }
    }   
}