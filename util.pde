public void CGLine(float x1, float y1, float x2, float y2) {
    
    int x = int(x1);
    int y = int(y1);
    int dx = abs(int(x2 - x1));
    int dy = abs(int(y2 - y1));
    int sx = (x1 < x2) ? 1 : -1;
    int sy = (y1 < y2) ? 1 : -1;
    int err = dx - dy;

    while (true) {
        drawPoint(x, y, color(0)); 
        if (x == int(x2) && y == int(y2)) break;

        int e2 = 2 * err;
        if (e2 > -dy) {
            err -= dy;
            x += sx;
        }
        if (e2 < dx) {
            err += dx;
            y += sy;
        }
    }
}

public void CGCircle(float x, float y, float r) {
    
    int xc = int(x);
    int yc = int(y);
    int radius = int(r);

    int xPos = 0;
    int yPos = radius;
    int d = 1 - radius;  

    
    while (xPos <= yPos) {
        drawPoint(xc + xPos, yc + yPos, color(0));
        drawPoint(xc - xPos, yc + yPos, color(0));
        drawPoint(xc + xPos, yc - yPos, color(0));
        drawPoint(xc - xPos, yc - yPos, color(0));
        drawPoint(xc + yPos, yc + xPos, color(0));
        drawPoint(xc - yPos, yc + xPos, color(0));
        drawPoint(xc + yPos, yc - xPos, color(0));
        drawPoint(xc - yPos, yc - xPos, color(0));

        
        if (d < 0) {
            d += 2 * xPos + 3;
        } else {
            d += 2 * (xPos - yPos) + 5;
            yPos--;
        }
        xPos++;
    }
}

public void CGEllipse(float x, float y, float r1, float r2) {
    
    int xc = int(x);
    int yc = int(y);
    int rx = int(r1);
    int ry = int(r2);

    int xPos = 0;
    int yPos = ry;

    
    float rxSq = rx * rx;
    float rySq = ry * ry;

    
    float p1 = rySq - (rxSq * ry) + (0.25f * rxSq);

    
    while (2 * rySq * xPos < 2 * rxSq * yPos) {
        
        drawPoint(xc + xPos, yc + yPos, color(0));
        drawPoint(xc - xPos, yc + yPos, color(0));
        drawPoint(xc + xPos, yc - yPos, color(0));
        drawPoint(xc - xPos, yc - yPos, color(0));

        if (p1 < 0) {
            xPos++;
            p1 += 2 * rySq * xPos + rySq;
        } else {
            xPos++;
            yPos--;
            p1 += 2 * rySq * xPos - 2 * rxSq * yPos + rySq;
        }
    }

    float p2 = (rySq) * (xPos + 0.5f) * (xPos + 0.5f)
             + (rxSq) * (yPos - 1) * (yPos - 1)
             - (rxSq * rySq);

    while (yPos >= 0) {
        drawPoint(xc + xPos, yc + yPos, color(0));
        drawPoint(xc - xPos, yc + yPos, color(0));
        drawPoint(xc + xPos, yc - yPos, color(0));
        drawPoint(xc - xPos, yc - yPos, color(0));

        if (p2 > 0) {
            yPos--;
            p2 -= 2 * rxSq * yPos + rxSq;
        } else {
            yPos--;
            xPos++;
            p2 += 2 * rySq * xPos - 2 * rxSq * yPos + rxSq;
        }
    }

}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    
    float step = 0.001f; 
    for (float t = 0; t <= 1.0; t += step) {
       
        float u = 1 - t;
        float x = u * u * u * p1.x
                + 3 * u * u * t * p2.x
                + 3 * u * t * t * p3.x
                + t * t * t * p4.x;

        float y = u * u * u * p1.y
                + 3 * u * u * t * p2.y
                + 3 * u * t * t * p3.y
                + t * t * t * p4.y;

        drawPoint(x, y, color(0));
    }
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    
    color bg = color(250);

    int x1 = int(min(p1.x, p2.x));
    int x2 = int(max(p1.x, p2.x));
    int y1 = int(min(p1.y, p2.y));
    int y2 = int(max(p1.y, p2.y));

    stroke(bg);

    for (int y = y1; y <= y2; y++) {
        for (int x = x1; x <= x2; x++) {
            point(x, y);
        }
    }

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
