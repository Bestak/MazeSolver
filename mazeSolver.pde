import java.util.*;

int xSize = 9;
int ySize = 6;
int tileSize = 80;

PImage tileEmpty;
PImage tilePoint;
PImage tileBlock;
PImage tileStart;
PImage tileFinish;
PImage tilePlayerU;
PImage tilePlayerD;
PImage tilePlayerR;
PImage tilePlayerL;
PImage tileUnknown;

int[][] boardInt;
int[][] boardTask;
int[][] boardWave;

int[][] boardRobot;

int stage = 0;


Robot robot;
int stepTime = 400;
int turnTime = 400;
boolean showWhatRobotSees = true;


void setup() {
  size(720,480);
  
  background(0,0,0);
  
  tileEmpty = loadImage("free_space.png");
  tilePoint = loadImage("point_space.png");
  tileBlock = loadImage("block.png");
  tileStart = loadImage("start.png");
  tilePlayerU = loadImage("player_up.png");
  tilePlayerD = loadImage("player_down.png");
  tilePlayerR = loadImage("player_right.png");
  tilePlayerL = loadImage("player_left.png");
  tileFinish = loadImage("finish.png");
  tileUnknown = loadImage("unknown.png");
  
  tileEmpty.resize(tileSize,tileSize);
  tilePoint.resize(tileSize,tileSize);
  tileBlock.resize(tileSize,tileSize);
  tileStart.resize(tileSize,tileSize);
  tilePlayerU.resize(tileSize,tileSize);
  tilePlayerD.resize(tileSize,tileSize);
  tilePlayerR.resize(tileSize,tileSize);
  tilePlayerL.resize(tileSize,tileSize);
  tileFinish.resize(tileSize,tileSize);
  tileUnknown.resize(tileSize,tileSize);
  
  boardInt = new int[xSize][ySize];
  for (int i = 0; i < xSize; i++) {
       for (int j = 0; j < ySize; j++) {
           boardInt[i][j] = 0;
             
       }
          
  } 
  boardTask = new int[xSize][ySize];
  for (int i = 0; i < xSize; i++) {
       for (int j = 0; j < ySize; j++) {
           boardTask[i][j] = -1;
             
       }
          
  }
  
  boardWave = new int[xSize][ySize];
  for (int i = 0; i < xSize; i++) {
       for (int j = 0; j < ySize; j++) {
           boardWave[i][j] = 0;
             
       }
          
  }
  boardRobot = new int[xSize][ySize];
  for (int i = 0; i < xSize; i++) {
       for (int j = 0; j < ySize; j++) {
           boardRobot[i][j] = -1;
             
       }
          
  }
  
  boardRobot[3][3] = 1;
  boardRobot[5][3] = 1;
  boardRobot[4][2] = 0;
  
  boardInt[3][3] = 1;
  boardInt[5][3] = 1;
  boardInt[4][3] = 2;
  
  robot = new Robot(4,3);
}


void draw() {
  if (showWhatRobotSees) {
    
    
      if (stage == 0) {
        for (int i = 0; i < xSize; i++) {
            for (int j = 0; j < ySize; j++) {
                image(getImage(boardInt[i][j]),i * tileSize, j * tileSize);
                boardTask[i][j] = -1;
                boardTask[robot.getX()][robot.getY()] = 3;
              
            }
         }
      } else {
        for (int i = 0; i < xSize; i++) {
            for (int j = 0; j < ySize; j++) {
                image(getImage(Integer.parseInt(String.valueOf(boardRobot[i][j]).replace("3","5").replace("-1","6"))),i * tileSize, j * tileSize);
                boardTask[i][j] = -1;
                boardTask[robot.getX()][robot.getY()] = 3;
                if (stage != 0) {
                  image(getImage(boardTask[i][j]),i * tileSize, j * tileSize);  
                }
                
              
            }
         }
      }
  
  } else {
     for (int i = 0; i < xSize; i++) {
            for (int j = 0; j < ySize; j++) {
                image(getImage(boardInt[i][j]),i * tileSize, j * tileSize);
                boardTask[i][j] = -1;
                boardTask[robot.getX()][robot.getY()] = 3;
                if (stage != 0) {
                  image(getImage(boardTask[i][j]),i * tileSize, j * tileSize);  
                }
              
            }
         } 
  }
  
  
}

PImage getImage(int nmb) {
    PImage currentImage = new PImage();  
    
    switch(nmb) {
        case 0:
          currentImage = tilePoint;
          break;
        case 1:
          currentImage = tileBlock;
          break;
        case 2:
          currentImage = tileStart;
          break;
        case 3:
          switch(robot.getRotation()) {
               case 0:
                   currentImage = tilePlayerU;
                   break;
               case 1:
                   currentImage = tilePlayerR;
                   break;
               case 2:
                   currentImage = tilePlayerD;
                   break;
               case 3:
                   currentImage = tilePlayerL;
                   break;
          }
          break;
        case 4:
          currentImage = tileFinish;
          break;
        case 5:
          currentImage = tileEmpty;
          break;
        case 6:
          currentImage = tileUnknown; 
       
        
    }
    
    return currentImage;
    
  
}

void mouseClicked() {
  
  if (mouseButton == LEFT) {
        if (stage == 0) {
          
              
            int x = mouseX / tileSize;
            int y = mouseY / tileSize;
            
            if (boardInt[x][y] == 0) {
                boardInt[x][y] = 1;
            } else if (boardInt[x][y] == 1) {
                boardInt[x][y] = 0; 
            }
            
            printArray(boardInt);
            
        } else if (stage == 1) {
            
            
        }
        
  }
    
}

void keyPressed() {
 
//reset
  if (keyCode == ENTER) {
      stage++;
      //boardTask[robotX][robotY] = 3;
      
      LoopThread loopThread = new LoopThread();
      loopThread.start();
    
  }
  
}


class Robot {
  int x;
  int y;
  int rotation;
  // 0 - up
  // 1 - right
  // 2 - down
  // 3 - left
  
  Robot(int x, int y) {
      this.x = x;
      this.y = y;
      rotation = 0;
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }
  
  void setX(int x) {
     this.x = x;
  }
  void setY(int y) {
     this.y = y;
  }
  
  int getRotation() {
    return rotation;
  }
  
  void rotateTo(int rot) {
     int rozdil = rotation - rot;
     if (rozdil == 1) {
       robot.rotateL();
       delay(turnTime);
     } else if (rozdil == -1) {
       robot.rotateR();
       delay(turnTime);
       
     } else if (rozdil == 3) {
       robot.rotateR();
       delay(turnTime);
     } else if (rozdil == -3) {
       robot.rotateL();
       delay(turnTime);
       
     } else if (abs(rozdil) == 2) {
       robot.rotateL();
       delay(turnTime/2);
       robot.rotateL();
       delay(turnTime/2);
     }
     
  }
  
  void rotateR() {
     rotation++; 
     if (rotation > 3) {
        rotation = 0; 
     }
  }
  
  void rotateL() {
    rotation--;
    if (rotation < 0) {
        rotation = 3; 
     }
  }
    
  
  void moveUp() {
    if (y-1 >= 0) {
        y--;
        rotation = 0;
    }
  }
  
  void moveDown() {
    if (y+1 < ySize) {
        y++;
        rotation = 2;
    }
  }
  
  void moveRight() {
    if (x+1 < xSize) {
        x++;
        rotation = 1;
    }
  }
  
  void moveLeft() {
    if (x-1 >= 0) {
        x--;
        rotation = 3;
    }
  }
  
}




int[][] generatePath(int targetX, int targetY) {
  int[][] path;
  int[] pathX;
  int[] pathY;
  
  boardWave = new int[xSize][ySize];
  for (int i = 0; i < xSize; i++) {
       for (int j = 0; j < ySize; j++) {
           boardWave[i][j] = 0;
             
       }
          
  }
  
  for (int i = 0; i < xSize; i++) {
       for (int j = 0; j < ySize; j++) {
           if (boardRobot[i][j] == 1) {
               boardWave[i][j] = -1;
           }
             
       }
          
  }
  
  boardWave[robot.getX()][robot.getY()] = 1;
  boardTask[targetX][targetY] = 4;
  

  boolean searchingFinish = true;
  int currentNmb = 1;

  //making wave
  do {
        for (int i = 0; i < xSize; i++) {
           for (int j = 0; j < ySize; j++) {
             
             if (searchingFinish) {
             
                 if (boardWave[i][j] == currentNmb) {
                   
                     if (i == targetX && j == targetY && boardTask[i][j] == 4) {
                 
                        searchingFinish = false; 
                         
                     } else {
                      
                       if (i -1 >= 0) {
                             if (boardWave[i-1][j] == 0) {
                                 boardWave[i-1][j] = boardWave[i][j] + 1;
                             }
                         }
                         if (j -1 >= 0) {
                             if (boardWave[i][j-1] == 0) {
                                 boardWave[i][j-1] = boardWave[i][j] + 1;
                             }
                         }
                         if (i +1 < xSize) {
                             if (boardWave[i+1][j] == 0) {
                                 boardWave[i+1][j] = boardWave[i][j] + 1;
                             }
                         }
                         if (j +1 < ySize) {
                             if (boardWave[i][j+1] == 0) {
                                 boardWave[i][j+1] = boardWave[i][j] + 1;
                             }
                         }
                     }
                   
                 }
             }
                 
           }
              
      }
      currentNmb++;
      /*
      for (int i = 0; i < ySize; i++) {
            for (int j = 0; j < xSize; j++) {
                 print(abs(boardWave[j][i]));
                 if (j < xSize -1) {
                     print(" "); 
                 } else {
                     print("\n");
                 }
    
            }
         }
         print("\n");
      */

  } while(searchingFinish);

  currentNmb--;
  
  //finding path
  searchingFinish = true;
  int currentX = targetX;
  int currentY = targetY;
  
  pathX = new int[currentNmb];
  pathY = new int[currentNmb];
  
  pathX[currentNmb - 1] = currentX;
  pathY[currentNmb - 1] = currentY;
  
  //currentNmb = 0;

  //making wave
  do {
        for (int i = 0; i < xSize; i++) {
           for (int j = 0; j < ySize; j++) {
             
               if (searchingFinish) {
                 
                   if (i == currentX && j == currentY) {
                     //println("x: " + i);
                     //println("y: " + j);
                     
                     
                       
                         if (i == robot.getX() && j == robot.getY() && boardTask[i][j] == 3) {
                           
                           searchingFinish = false; 
                           
                         } else {
                 
                           if (i -1 >= 0) {
                                 if (boardWave[i-1][j] == boardWave[i][j] - 1) {
                                     pathX[boardWave[i][j]-2] = i-1;
                                     pathY[boardWave[i][j]-2] = j;
                                     currentX = i-1;
                                     currentY = j;
                                 }
                             }
                             if (j -1 >= 0) {
                                 if (boardWave[i][j-1] == boardWave[i][j] - 1) {
                                     pathX[boardWave[i][j]-2] = i;
                                     pathY[boardWave[i][j]-2] = j-1;
                                     currentX = i;
                                     currentY = j-1;
                                 }
                             }
                             if (i +1 < xSize) {
                                 if (boardWave[i+1][j] == boardWave[i][j] - 1) {
                                     pathX[boardWave[i][j]-2] = i+1;
                                     pathY[boardWave[i][j]-2] = j;
                                     currentX = i+1;
                                     currentY = j;
                                 }
                             }
                             if (j +1 < ySize) {
                                 if (boardWave[i][j+1] == boardWave[i][j] - 1) {
                                     pathX[boardWave[i][j]-2] = i;
                                     pathY[boardWave[i][j]-2] = j+1;
                                     currentX = i;
                                     currentY = j+1;
                                 }
                             }
                             
                         }
                   }
             }
                         
             
                 
           }
              
      }
      
      currentNmb++;

  } while(searchingFinish);
  
  println(" ");
  for (int i = 0; i < pathX.length; i++) {
     print(pathX[i] + " "); 
  }
  println(" ");
  for (int i = 0; i < pathY.length; i++) {
     print(pathY[i] + " "); 
  }
  print("\n\n");
  
  path = new int[][] {pathX, pathY};
  
  return path;
  
}


class LoopThread extends Thread {
    boolean running;
    
    LoopThread() {
       running = false; 
    }
    
    void start() {
       running = true; 
       super.start();
    }
    
    void run() {
      
      delay(500);
      robot.moveUp();
      boardRobot[4][3] = 1;
      boardInt[4][2] = 5;
      
      while(true) {
        delay(stepTime);
        
        //i was there
        boardRobot[robot.getX()][robot.getY()] = 3;
        
        boolean robotCanMove = false;
        
        //scan surroundings
        if (robot.getX() - 1 >= 0 && boardRobot[robot.getX() - 1][robot.getY()] != 3 && boardRobot[robot.getX() - 1][robot.getY()] != 1) {
            boardRobot[robot.getX() - 1][robot.getY()] = Integer.parseInt(String.valueOf(boardInt[robot.getX() - 1][robot.getY()]).replace("2","1"));
            robotCanMove = true;
        }
        if (robot.getY() - 1 >= 0 && boardRobot[robot.getX()][robot.getY() - 1] != 3 && boardRobot[robot.getX()][robot.getY() - 1] != 1) {
            boardRobot[robot.getX()][robot.getY() - 1] = Integer.parseInt(String.valueOf(boardInt[robot.getX()][robot.getY() - 1]).replace("2","1"));
            robotCanMove = true;
        }
        if (robot.getX() + 1 < xSize && boardRobot[robot.getX() + 1][robot.getY()] != 3 && boardRobot[robot.getX() + 1][robot.getY()] != 1) {
            boardRobot[robot.getX() + 1][robot.getY()] = Integer.parseInt(String.valueOf(boardInt[robot.getX() + 1][robot.getY()]).replace("2","1"));
            robotCanMove = true;
        }
        if (robot.getY() + 1 < ySize && boardRobot[robot.getX()][robot.getY() + 1] != 3 && boardRobot[robot.getX()][robot.getY() + 1] != 1) {
            boardRobot[robot.getX()][robot.getY() + 1] = Integer.parseInt(String.valueOf(boardInt[robot.getX()][robot.getY() + 1]).replace("2","1"));
            robotCanMove = true;
        }
        
        printArray(boardRobot);
        
        if(robotCanMove) {
            boolean moveDone = false;
            
            switch(robot.getRotation()) {
                case 0:
                    if (!moveDone) {
                        if (robot.getX() + 1 < xSize && boardRobot[robot.getX() + 1][robot.getY()] == 0) {
                            robot.rotateR();
                            delay(turnTime);
                            robot.moveRight();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getY() - 1 >= 0 && boardRobot[robot.getX()][robot.getY() - 1] == 0) {
                            robot.moveUp();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getX() - 1 >= 0 && boardRobot[robot.getX() - 1][robot.getY()] == 0) {
                            robot.rotateL();
                            delay(turnTime);
                            robot.moveLeft();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getY() + 1 < ySize && boardRobot[robot.getX()][robot.getY() + 1] == 0) {
                            robot.rotateL();
                            delay(turnTime/2);
                            robot.rotateL();
                            delay(turnTime/2);
                            robot.moveDown();
                            moveDone = true;
                        }
                    }
                    break;
                case 1:
                    if (!moveDone) {
                        if (robot.getY() + 1 < ySize && boardRobot[robot.getX()][robot.getY() + 1] == 0) {
                            robot.rotateR();
                            delay(turnTime);
                            robot.moveDown();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getX() + 1 < xSize && boardRobot[robot.getX() + 1][robot.getY()] == 0) {
                            robot.moveRight();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getY() - 1 >= 0 && boardRobot[robot.getX()][robot.getY() - 1] == 0) {
                            robot.rotateL();
                            delay(turnTime);
                            robot.moveUp();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getX() - 1 >= 0 && boardRobot[robot.getX() - 1][robot.getY()] == 0) {
                            robot.rotateL();
                            delay(turnTime/2);
                            robot.rotateL();
                            delay(turnTime/2);
                            robot.moveLeft();
                            moveDone = true;
                        }
                    }
                    break;
                case 2:
                    if (!moveDone) {
                        if (robot.getX() - 1 >= 0 && boardRobot[robot.getX() - 1][robot.getY()] == 0) {
                            robot.rotateR();
                            delay(turnTime);
                            robot.moveLeft();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getY() + 1 < ySize && boardRobot[robot.getX()][robot.getY() + 1] == 0) {
                            robot.moveDown();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getX() + 1 < xSize && boardRobot[robot.getX() + 1][robot.getY()] == 0) {
                            robot.rotateL();
                            delay(turnTime);
                            robot.moveRight();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getY() - 1 >= 0 && boardRobot[robot.getX()][robot.getY() - 1] == 0) {
                            robot.rotateL();
                            delay(turnTime/2);
                            robot.rotateL();
                            delay(turnTime/2);
                            robot.moveUp();
                            moveDone = true;
                        }
                    }
                    break;
                case 3:
                    if (!moveDone) {
                        if (robot.getY() - 1 >= 0 && boardRobot[robot.getX()][robot.getY() - 1] == 0) {
                            robot.rotateR();
                            delay(turnTime);
                            robot.moveUp();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getX() - 1 >= 0 && boardRobot[robot.getX() - 1][robot.getY()] == 0) {
                            robot.moveLeft();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getY() + 1 < ySize && boardRobot[robot.getX()][robot.getY() + 1] == 0) {
                            robot.rotateL();
                            delay(turnTime);
                            robot.moveDown();
                            moveDone = true;
                        }
                    }
                    if (!moveDone) {
                        if (robot.getX() + 1 < xSize && boardRobot[robot.getX() + 1][robot.getY()] == 0) {
                            robot.rotateL();
                            delay(turnTime/2);
                            robot.rotateL();
                            delay(turnTime/2);
                            robot.moveRight();
                            moveDone = true;
                        }
                    }
                    break;
                
            }
            
            boardInt[robot.getX()][robot.getY()] = 5;
            
        } else {
           //find nearest 0 
           println("");
           
           ArrayList<Integer> zeroPositionsX = new ArrayList<Integer>();
           ArrayList<Integer> zeroPositionsY = new ArrayList<Integer>();
           
           ArrayList<Integer> distances = new ArrayList<Integer>();
           
           //scan for 0
           for (int i = 0; i < xSize; i++) {
                 for (int j = 0; j < ySize; j++) {
                     if(boardRobot[i][j] == 0) {
                        zeroPositionsX.add(i);
                        zeroPositionsY.add(j);
                        
                        distances.add(generatePath(i,j)[0].length);
                     }
                       
                 }
                    
            }
            
            try {
            
            int shortestDistanceIndex = distances.indexOf(Collections.min(distances));
            println(shortestDistanceIndex);
            
            int[][] path = generatePath(zeroPositionsX.get(shortestDistanceIndex),zeroPositionsY.get(shortestDistanceIndex));
            
            printArray(boardTask);
            boardTask[robot.getX()][robot.getY()] = -1; 
            for(int i = 0; i < path[0].length; i++) {
              
                 delay(stepTime);
              
                 println(path[0][i] + " - " + path[1][i]);
                 if (i != path[0].length -1) {

                     if (path[0][i+1] - path[0][i] > 0) {
                       //went right
                       robot.rotateTo(1);
                       robot.moveRight();
                       
                     }
                     if (path[0][i+1] - path[0][i] < 0) {
                       //went left
                       robot.rotateTo(3);
                       robot.moveLeft();
                       
                     }
                     if (path[1][i+1] - path[1][i] > 0) {
                       //went down
                       robot.rotateTo(2);
                       robot.moveDown();
                       
                     }
                     if (path[1][i+1] - path[1][i] < 0) {
                       //went up
                       robot.rotateTo(0);
                       robot.moveUp();
                       
                     }
                 
                 }

                 
                 printArray(boardTask);
                 boardInt[robot.getX()][robot.getY()] = 5;
               
                 
             }
             
             
            } catch(Exception e) {
                println("maze completed");
                running = false;
            }
           
        }
        
        
      }
    }
  
}


void printArray(int[][] array) {
  for (int i = 0; i < ySize; i++) {
            for (int j = 0; j < xSize; j++) {
                 print(array[j][i]);
                 if (j < xSize -1) {
                     print(" "); 
                 } else {
                     print("\n");
                 }
    
            }
         }
         print("\n");
}
