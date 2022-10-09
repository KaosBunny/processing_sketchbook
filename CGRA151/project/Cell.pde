class Cell implements GamePart {
    private String cellID;
    private ChessPiece contains;
    private Vector2D position;
    private color cellBackground;
    private boolean selected = false;
    private boolean active   = false;

    public boolean isActive()      { return active;    }
    
    public boolean isSelected()    { return selected;  }
    public void    setSelected()   { selected = true;  }
    public void    setUnselected() { selected = false; }
    
    public String  getID()         { return cellID;    }
    public Vector2D getPosition()  { return new Vector2D(position); }


    public void acceptPiece(Cell c) {
        contains = c.contains;
        contains.changeLocation(cellID);
        c.clearContents();
    }

    public boolean occupiedBy() {
        return contains.getColour();
    }
    
    public void setContents(ChessPiece piece) {
        contains = piece;
    }

    public void clearContents() {
        contains = new ChessPiece();
    }


    public boolean isFree() {
        return contains.isEmpty();
    }

    public boolean in(ArrayList<String> cells) {
        return true;
    }


    public void printContents() {
        if (!isFree()) print("[VALUE] CELL CONTENTS: [" + cellID + "] contains [" + contains.getType() + "]\n");
    }
    
    public void update() {
        boolean xBound = mouseX > position.x() + BOARDOFFSET && mouseX < position.x() + CELLSIZE + BOARDOFFSET;
        boolean yBound = mouseY > position.y() + BOARDOFFSET && mouseY < position.y() + CELLSIZE + BOARDOFFSET;
        active = xBound && yBound;
    }

    public void draw() {
        fill(isSelected() ? color(150, 0, 0) : isActive() ? color(150, 150, 0) : cellBackground);
        noStroke();
        rect(position.x(), position.y(), CELLSIZE, CELLSIZE);
        // pushMatrix();
            // translate(position.x + CELLSIZE / 2, position.y + CELLSIZE / 2);
            if(!isFree()) contains.draw();
        // popMatrix();
        fill(0, 255, 0);
        text(cellID, position.x(), position.y());
    }

    public Cell(String cellID, Vector2D position, color cellBackground) {
        this.cellID = cellID;
        this.position = position;
        this.cellBackground = cellBackground;
        contains = new ChessPiece();
        active = false;
    }
}