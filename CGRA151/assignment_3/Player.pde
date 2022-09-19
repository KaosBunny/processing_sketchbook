class Player implements GamePart {
    Vector2D position;
    Vector2D velocity;

    float playerWidth;
    float playerHeight;
    
    public float x() { return position.x(); }
    public float y() { return position.y(); }

    // On Creation of Player.
    public Player() {
        playerWidth = 24;
        playerHeight = 52;
        position = new Vector2D(width / 2, height / 2);
        velocity = new Vector2D(0.0f, 0.0f);
    }

    public void moveLeft() {
        velocity = new Vector2D(-MAXVELOCITY, velocity.y());
    }

    public void moveRight() {
        velocity = new Vector2D(MAXVELOCITY, velocity.y());
    }

    // On update of Player.
    public void update() {
        position = position.add(velocity);

        if (!keyPressed) { 
            velocity.zeroX();
        }
    }

    // On draw of Player.
    public void draw() {
        fill(0);
        rect(position.x() - CAMERA.x(), position.y() - CAMERA.y(), playerWidth, playerHeight);
    }
}