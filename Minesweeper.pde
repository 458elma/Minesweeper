

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private int ding = 0;
private int bomby = 25;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS]; 
    for(int rows = 0; rows<NUM_ROWS; rows++) {
        for(int col = 0; col<NUM_COLS; col++) {
            buttons[rows][col] = new MSButton(rows,col);
        }
    }
    for(int i = 0; i<bomby; i++)
      setBombs();
}
public void setBombs()
{
    //your code
    int rowey = (int)(Math.random()*20);
    int coley = (int)(Math.random()*20);
    if(!bombs.contains(buttons[rowey][coley])) {
        bombs.add(buttons[rowey][coley]);
    }
    
}

public void draw ()
{
    background( 0 );
    
    
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    
    for(int rows = 0; rows<NUM_ROWS; rows++) {
      for(int col = 0; col<NUM_COLS; col++) {
           if(bombs.contains(buttons[rows][col]) && buttons[rows][col].isMarked() == true && bomby == 0 && ding == 0)  
              return true;   
      }
    }
    
    return false;
}
public void displayLosingMessage()
{
    //your code here
    buttons[10][5].setLabel("Y");
    buttons[10][6].setLabel("O");
    buttons[10][7].setLabel("U");
    buttons[10][9].setLabel("L");
    buttons[10][10].setLabel("O");
    buttons[10][11].setLabel("S");
    buttons[10][12].setLabel("E");
    noLoop();
}
public void displayWinningMessage()
{
    //your code here
    buttons[10][5].setLabel("Y");
    buttons[10][6].setLabel("O");
    buttons[10][7].setLabel("U");
    buttons[10][9].setLabel("W");
    buttons[10][10].setLabel("I");
    buttons[10][11].setLabel("N");
    
    noLoop();
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked, blank;
    private String label;
     
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
       
        //your code here
        if((marked == true)&&(mouseButton == RIGHT)) {
            marked = false;
            clicked = false;
            if(bombs.contains(this)) {
               bomby++;     
            }  else {
              ding--;
            }
        } else if(mouseButton == RIGHT&&blank == false){
            
            marked = true;
            if(bombs.contains(this)) {
               bomby--;               
            } else {
              ding++;
            }
        } else if(bombs.contains(this)&&marked == false){
          for(int rows = 0; rows<NUM_ROWS; rows++) {
            for(int col = 0; col<NUM_COLS; col++) {
              buttons[rows][col].clicked = true;
            }
          }
          blank = true;
            displayLosingMessage();
        } else if(countBombs(r,c) > 0) {
            label = "" + countBombs(r,c);
        } else {
            if(isValid(r-1,c)&&buttons[r-1][c].isClicked()==false) 
              buttons[r-1][c].mousePressed();
              blank = true;
            if(isValid(r+1,c)&&buttons[r+1][c].isClicked()==false) 
              buttons[r+1][c].mousePressed();
              blank = true;
            if(isValid(r,c-1)&&buttons[r][c-1].isClicked()==false) 
              buttons[r][c-1].mousePressed();
              blank = true;
            if(isValid(r,c+1)&&buttons[r][c+1].isClicked()==false) 
              buttons[r][c+1].mousePressed();
              blank = true;
            if(isValid(r-1,c-1)&&buttons[r-1][c-1].isClicked()==false) 
              buttons[r-1][c-1].mousePressed();
              blank = true;
            if(isValid(r-1,c+1)&&buttons[r-1][c+1].isClicked()==false) 
              buttons[r-1][c+1].mousePressed();
              blank = true;
            if(isValid(r+1,c-1)&&buttons[r+1][c-1].isClicked()==false) 
              buttons[r+1][c-1].mousePressed();
              blank = true;
            if(isValid(r+1,c+1)&&buttons[r+1][c+1].isClicked()==false) 
              buttons[r+1][c+1].mousePressed();
              blank = true;
        }

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(255,255,0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if((r<0)||(c<0)||(r>NUM_ROWS-1)||(c>NUM_COLS-1))
            return false;
        else 
            return true;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col])) 
            numBombs++;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col])) 
            numBombs++;
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1])) 
            numBombs++;
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1])) 
            numBombs++;
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1])) 
            numBombs++;
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1])) 
            numBombs++;
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1])) 
            numBombs++;
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1])) 
            numBombs++;
        return numBombs;
    }
}



