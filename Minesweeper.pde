

import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
public int randomRow;
public int randomColumn;
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );
  buttons=new MSButton [NUM_ROWS][NUM_COLS];
  for (int i=0; i<20; i++)//rows
  {
    for (int j=0; j<20; j++)//columns
    {
      buttons[i][j]=new MSButton(i, j);
    }
  }
  bombs=new ArrayList <MSButton>();
  setBombs();
}
public void setBombs()
{
  int i=0;
  while (i<20)
  {
    randomRow=(int)(Math.random()*NUM_ROWS);
    randomColumn=(int)(Math.random()*NUM_COLS);
    if (!(bombs.contains(buttons[randomRow][randomColumn])))
    {
      bombs.add(buttons[randomRow][randomColumn]);
    }
    i++;
  }
}

public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  for (int b=0; b<bombs.size (); b++)
  {
    if (bombs.get(b).isMarked()==false)
    {
      return false;
    }
  }
  return true;
}
public void displayLosingMessage()
{
  buttons[9][5].setLabel("G");
  buttons[9][6].setLabel("A");
  buttons[9][7].setLabel("M");
  buttons[9][8].setLabel("E");
  buttons[9][10].setLabel("O");
  buttons[9][11].setLabel("V");
  buttons[9][12].setLabel("E");
  buttons[9][13].setLabel("R");
  for(int b=0;b<bombs.size(); b++)
  {
    bombs.get(b).marked=false;
    bombs.get(b).clicked=true;
  }
  stop();
}
public void displayWinningMessage()
{
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][10].setLabel("W");
  buttons[9][11].setLabel("I");
  buttons[9][12].setLabel("N");
  buttons[9][13].setLabel("!");
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
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
    clicked = true;
    if (mouseButton==RIGHT)
    {
      marked=!marked;
      if(marked==false)
      {
        clicked=false;
      }
    } else if (bombs.contains(this))
    {
      displayLosingMessage();
    } else if (countBombs(r, c)>0)
    {
      setLabel(str(countBombs(r, c)));
    }
    //recursive
    else {
      if (isValid(r-1, c) && buttons[r-1][c].isClicked()==false)
      {
        buttons[r-1][c].mousePressed();
      }
      if (isValid (r-1, c-1) && buttons[r-1][c-1].isClicked()==false)
      {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid (r-1, c+1) && buttons[r-1][c+1].isClicked()==false)
      {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r, c-1) && buttons[r][c-1].isClicked()==false)
      {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1) && buttons[r][c+1].isClicked()==false)
      {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r+1, c) && buttons[r+1][c].isClicked()==false)
      {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked()==false)
      {
        buttons[r+1][c-1].mousePressed();
      }
      if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked()==false)
      {
        buttons[r+1][c+1].mousePressed();
      }
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill(130);
    else 
      fill( 200 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    return (r>=0 && r<NUM_ROWS) && ( c>=0 && c<NUM_COLS);
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if (isValid(r-1, c) && bombs.contains(buttons[r-1][c]))
    {
      numBombs++;
    }
    if (isValid (r-1, c-1) && bombs.contains(buttons[r-1][c-1]))
    {
      numBombs++;
    }
    if (isValid (r-1, c+1) && bombs.contains(buttons[r-1][c+1]))
    {
      numBombs++;
    }
    if (isValid(r, c-1) && bombs.contains(buttons[r][c-1]))
    {
      numBombs++;
    }
    if (isValid(r, c+1) && bombs.contains(buttons[r][c+1]))
    {
      numBombs++;
    }
    if (isValid(r+1, c) && bombs.contains(buttons[r+1][c]))
    {
      numBombs++;
    }
    if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1]))
    {
      numBombs++;
    }
    if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1]))
    {
      numBombs++;
    }
    return numBombs;
  }
}


