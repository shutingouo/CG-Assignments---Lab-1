# Line algorithm
```
CGLine(float x1, float y1, float x2, float y2)
```
## 功能：
繪製由兩點 (x1, y1) 至 (x2, y2) 的直線。


## 操作思路：
計算 x、y 方向的距離差：
```
int dx = abs(int(x2 - x1));
int dy = abs(int(y2 - y1));
```

根據兩點位置決定前進方向（正向或反向）：
```
int sx = (x1 < x2) ? 1 : -1;
int sy = (y1 < y2) ? 1 : -1;
```

使用誤差項 err 控制何時在 y 軸方向移動：
```
int err = dx - dy;
```

反覆繪製像素直到抵達終點：
```
while (true) {
    drawPoint(x, y, color(0));
    if (x == int(x2) && y == int(y2)) break;
    int e2 = 2 * err;
    if (e2 > -dy) { err -= dy; x += sx; }
    if (e2 < dx)  { err += dx; y += sy; }
}
```
<img width="1248" height="1014" alt="image" src="https://github.com/user-attachments/assets/cd538c98-d8a3-4239-bcf2-3623345bc830" />

# Circle Algorithm
```
CGCircle(float x, float y, float r)
```
## 功能：
以 (x, y) 為圓心、半徑 r 繪製圓。


## 操作思路：
初始設定：
```
int xPos = 0, yPos = radius;
int d = 1 - radius;
```

每次以 (xPos, yPos) 為基準，畫出 8 個對稱點：
```
drawPoint(xc + xPos, yc + yPos, color(0));
drawPoint(xc - xPos, yc + yPos, color(0));
drawPoint(xc + xPos, yc - yPos, color(0));
drawPoint(xc - xPos, yc - yPos, color(0));
drawPoint(xc + yPos, yc + xPos, color(0));
drawPoint(xc - yPos, yc + xPos, color(0));
drawPoint(xc + yPos, yc - xPos, color(0));
drawPoint(xc - yPos, yc - xPos, color(0));
```

根據決策變數 d 更新圓弧：
```
if (d < 0) d += 2 * xPos + 3;
else { d += 2 * (xPos - yPos) + 5; yPos--; }
xPos++;
```
<img width="1241" height="1002" alt="image" src="https://github.com/user-attachments/assets/89ef6ae5-c328-4487-9e17-2f3de5a9d6be" />

# Ellipse Algorithm
```
CGEllipse(float x, float y,float r1, float r2) 
```
## 功能：
以 (x, y) 為中心，長軸半徑 r1、短軸半徑 r2 繪製橢圓。


## 操作思路：
計算半徑平方：
```
float rxSq = rx * rx;
float rySq = ry * ry;
```

在第一區域更新 x 為主：
```
float p1 = rySq - (rxSq * ry) + (0.25f * rxSq);
while (2 * rySq * xPos < 2 * rxSq * yPos) {
    draw four symmetric points...
    if (p1 < 0) p1 += 2 * rySq * xPos + rySq;
    else { yPos--; p1 += 2 * rySq * xPos - 2 * rxSq * yPos + rySq; }
    xPos++;
}
```

在第二區域更新 y 為主：
```
float p2 = rySq*(xPos+0.5f)*(xPos+0.5f) + rxSq*(yPos-1)*(yPos-1) - rxSq*rySq;
while (yPos >= 0) {
    draw four symmetric points...
    if (p2 > 0) p2 -= 2 * rxSq * yPos + rxSq;
    else { yPos--; xPos++; p2 += 2 * rySq * xPos - 2 * rxSq * yPos + rxSq; }
}
```
<img width="1236" height="1003" alt="image" src="https://github.com/user-attachments/assets/3d32737a-f62b-4ba5-b9c8-5c6575ba7576" />

# Bézier Curve Algorithm
```
CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector4 p4)
```
## 功能：
繪製由四個控制點形成的 三次 Bézier 曲線。


## 操作思路：
設定取樣步長：
```
float step = 0.001f;
```

迴圈取樣計算每個 t 值對應的 (x, y)：
```
for (float t = 0; t <= 1.0; t += step) {
    float u = 1 - t;
    float x = u*u*u*p1.x + 3*u*u*t*p2.x + 3*u*t*t*p3.x + t*t*t*p4.x;
    float y = u*u*u*p1.y + 3*u*u*t*p2.y + 3*u*t*t*p3.y + t*t*t*p4.y;
    drawPoint(x, y, color(0));
}
```
<img width="1239" height="1002" alt="image" src="https://github.com/user-attachments/assets/40a38e11-01a5-47f4-a77c-b2ea75366d31" />

# Eraser
```
CGEraser(Vector3 p1, Vector3 p2)
```
## 功能：
擦除矩形範圍內的像素。


## 操作思路：
計算矩形邊界：
```
int x1 = int(min(p1.x, p2.x));
int x2 = int(max(p1.x, p2.x));
int y1 = int(min(p1.y, p2.y));
int y2 = int(max(p1.y, p2.y));
color bg = color(250);
```

使用雙層迴圈將區域內像素重新填上背景色：
```
for (int y = y1; y <= y2; y++) {
    for (int x = x1; x <= x2; x++) {
        point(x, y);
    }
}
```
<img width="1238" height="999" alt="image" src="https://github.com/user-attachments/assets/61334de3-07d8-490e-a7a9-b2b4d72f2498" />
