import de.bezier.guido.*;



import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private int NUM_ROWS = 20, NUM_COLS=20;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    bombs = new ArrayList<MSButton>();
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int i = 0; i<NUM_ROWS; i++){
    	for (int j = 0; j<NUM_COLS; j++){
		buttons[i][j] = new MSButton(i, j);
		}
		}

    
    setBombs();
}
public void setBombs()
{
    for (int i = 0; i<10; i++){
      int r = (int)(Math.random()*NUM_ROWS);
      int c = (int)(Math.random()*NUM_COLS);
      if (!bombs.contains(new MSButton(r, c)))
      bombs.add(new MSButton(r, c));
      else {
        i--;
      }
      System.out.println(r + " " + c);
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
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
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
      System.out.println("Click" + r + " " + c);
        clicked = true;
        if (keyPressed && marked){
          marked=false;
          clicked = false;
        }
        if (keyPressed & !marked){
          marked = true;
          clicked = false;
        }
        if (bombs.contains(this)) displayLosingMessage();
        System.out.println("Bombs " + countBombs(r, c));
        if (countBombs(r, c) > 0){
          setLabel(String.valueOf(countBombs(r, c)));
        }
        else
        for (int i = -1; i<=1; i++){
          for (int j = -1; j<=1; j++){
            if (isValid(r + i, c + j) && (i!= 0 || j!=0) && !(buttons[r+i][c+j].isClicked())){
              buttons[r+i][c+j].mousePressed();
            }
          }
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
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        return (r>=0 && c>=0 && r<NUM_ROWS && c <NUM_COLS);
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for (int i = -1; i<=1; i++){
          for (int j = -1; j<=1; j++){
            if (isValid(row+i, col+j) && (i!= 0 || j!=0)){
              if (bombs.contains(new MSButton(row+i, col+j))){
                numBombs++;
              }
            }
          }
        }
        return numBombs;
    }
}