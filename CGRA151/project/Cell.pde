class Cell implements GamePart {
    private String cellID;
    private ChessPiece contains;
    private Vector2D position;
    private color cellBackground;
    private boolean selected = false;
    private boolean highlighted = false;
    private boolean active   = false;
    private boolean inDanger = false;

    private CellTextureHandler textures;

    public boolean isActive()      { return active;    }
    
    public boolean isSelected()    { return selected;  }
    public void    setSelected()   { selected = true;  }
    public void    setUnselected() { selected = false; }
    public void    setHighlighted()   { highlighted = true;  }
    public void    setUnhighlighted() { highlighted = false; }
    public void    setDanger() { inDanger = true; }
    public void    unsetDanger() { inDanger = false; }
    
    public String  getID()         { return cellID;    }
    public Vector2D getPosition()  { return new Vector2D(position); }
    public void setPosition(Vector2D v) {
        position = v;
    }
    public ChessPiece getContents() { return contains; }


    public void acceptPiece(Cell c) {
        contains = c.contains;
        contains.changeLocation(cellID);
        c.clearContents();
    }

    public boolean hasEnemy() {
        if (GAME.board.getSelected() == null) return false;
        return GAME.board.getSelected().contains.getColour() 
            != GAME.board.getCellByID(cellID).contains.getColour() 
            && !GAME.board.getCellByID(cellID).isFree();
    }

    public boolean hasFriendly() {
        if (GAME.board.getSelected() == null) return false;
        return GAME.board.getSelected().contains.getColour() 
            == GAME.board.getCellByID(cellID).contains.getColour() 
            && !GAME.board.getCellByID(cellID).isFree();
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
        for (String c : cells) {
            if (c.equals(cellID)) return true;
        }
        return false;
    }


    public void printContents() {
        if (!isFree()) print("[VALUE] CELL CONTENTS: [" + cellID + "] contains [" + contains.getType() + "]\n");
    }
    
    public void update() {
        boolean xBound = mouseX > position.x() && mouseX < position.x() + CELLSIZE;
        boolean yBound = mouseY > position.y() && mouseY < position.y() + CELLSIZE;
        active = xBound && yBound;
    }

    public void draw() {
        imageMode(CORNER);
        if (isActive() && isSelected()) {
            image(textures.get(CellTexture.HOVER_SELECTED), position.x(), position.y());
        } else if(inDanger && isActive()) {
            image(textures.get(CellTexture.HOVER_DANGER), position.x(), position.y());
        } else if(inDanger) {
            image(textures.get(CellTexture.DANGER), position.x(), position.y());
        } else if(isActive() && highlighted) {
            image(textures.get(CellTexture.HOVER_VIABLE_MOVE), position.x(), position.y());
        } else if (isSelected()) {
            image(textures.get(CellTexture.SELECTED), position.x(), position.y());
        } else if (highlighted) {
            image(textures.get(CellTexture.VIABLE_MOVE), position.x(), position.y());
        } else if (isActive() && EVENTS.currentState() != EventStates.PIECE_SELECTED && contains.getColour() == EVENTS.getCurrentTurn() && !isFree()) {
            image(textures.get(CellTexture.HOVERED), position.x(), position.y());
        } else {
            image(textures.get(CellTexture.DEFAULT), position.x(), position.y());
        }
        
        if(!isFree()) contains.draw();
        if(inDanger && isActive()) image(textures.get(CellTexture.DANGER_CROSS), position.x(), position.y());
    }

    public Cell(String cellID, Vector2D position, CellTextureHandler textures) {
        this.cellID = cellID;
        this.position = position;
        this.textures = textures;
        contains = new ChessPiece();
        active = false;
    }
}