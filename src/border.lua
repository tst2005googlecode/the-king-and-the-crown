
-- BORDER_SPRITES contains the Quads for each part of the border/button side (four corners and four sides)
-- PANEL_BORDER_SIZE is how thick the borders or button sides are
--
-- rect: Table with (x, y) coordinates, width, and height of main panel (excluding borders)
-- batch: SpriteBatch for drawing panel or button
-- recColour: Table with (r, g, b) value of colour for interior rectangle
local function drawBorderedRect(rect, batch, recColour)
    batch:clear()

    batch:addq(BORDER_SPRITES[UP_LEFT],
      rect.x - PANEL_BORDER_SIZE, rect.y - PANEL_BORDER_SIZE)
    batch:addq(BORDER_SPRITES[UP_RIGHT],
      rectNextX(rect), rect.y - PANEL_BORDER_SIZE)
    batch:addq(BORDER_SPRITES[DOWN_LEFT],
      rect.x - PANEL_BORDER_SIZE, rectNextY(rect))
    batch:addq(BORDER_SPRITES[DOWN_RIGHT],
      rectNextX(rect), rectNextY(rect))

    for px = rect.x, rectEndX(rect)
    do
        batch:addq(BORDER_SPRITES[UP], px,
          rect.y - PANEL_BORDER_SIZE)
        batch:addq(BORDER_SPRITES[DOWN], px, rectNextY(rect))
    end

    for py = rect.y, rectEndY(rect)
    do
        batch:addq(BORDER_SPRITES[LEFT],
          rect.x - PANEL_BORDER_SIZE, py)
        batch:addq(BORDER_SPRITES[RIGHT], rectNextX(rect), py)
    end

    love.graphics.draw(batch)

    love.graphics.setColor(recColour.r, recColour.g, recColour.b)
    fillRect(rect)

    --love.graphics.reset()
end


