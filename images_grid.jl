using ImageView, TestImages, Gtk.ShortNames

grid, frames, canvases = canvasgrid((1,2))  # 1 row, 2 columns
imshow(canvases[1,1], testimage("lighthouse"))
imshow(canvases[1,2], testimage("mandrill"))
win = Window(grid)
Gtk.showall(win)
